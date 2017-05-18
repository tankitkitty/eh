<?php

/* @var $this \yii\web\View */
/* @var $content string */

use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\widgets\Breadcrumbs;
use yii\db\Query;
//use frontend\assets\AppAsset;
use common\widgets\Alert;
use frontend\themes\lte\assets\LteAsset;
use miloschuman\highcharts\Highcharts;
use frontend\modules\report\model\SysMenuGroup;
use frontend\modules\report\model\SysReport;
use frontend\modules\report\model\SysNotifications;
use frontend\modules\report\controllers\ReportController;
use frontend\modules\report\model\SysConfig;

LteAsset::register($this);
//var_dump($content);
$js = <<< 'SCRIPT'
/* To initialize BS3 tooltips set this below */
$(function () { 
    $("[data-toggle='tooltip']").tooltip(); 
});;
/* To initialize BS3 popovers set this below */
$(function () { 
    $("[data-toggle='popover']").popover(); 
});
SCRIPT;
// Register tooltip/popover initialization javascript
$this->registerJs($js);
?>


<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
<head>
    <meta charset="<?= Yii::$app->charset ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?= Html::csrfMetaTags() ?>
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
</head>
<body>
<?php $this->beginBody() ?>
<?php
$hospcode=null;$tasks_noti=null;$g=null;$s=null;$offname=null;
$modelcon = SysConfig::find()->select('*')->one();   
        $provname=$modelcon['prov_name'];
if(isset(Yii::$app->user->identity->hospcode)){
  $list_cup=ReportController::chkcup();
//$hospcode=Yii::$app->user->identity->hospcode;
   if(Yii::$app->user->identity->level==1){
           $hospcode=Yii::$app->user->identity->hospcode;
           $offname='ผู้ดูแล';
          $s='n.snt_id,n.hospcode,n.distcode,n.hmain,(SUM(y_cases)/SUM(total))*100 AS percent,r.report_id, r.report_name, r.s_table';
          $office=' distcode =:h ';
          $g='report_id';
        }else if(Yii::$app->user->identity->level=='02'){
          $hospcode=Yii::$app->user->identity->hospcode;
          $office=' distcode =:h ';
          $w='n.y_cases<>0 AND r.active=1';
          $s='n.snt_id,n.hospcode,n.distcode,n.hmain,(SUM(y_cases)/SUM(total))*100 AS percent,r.report_id, r.report_name, r.s_table';
          $g='report_id';
         }else if(in_array(Yii::$app->user->identity->hospcode, $list_cup, TRUE)&&
          substr(Yii::$app->user->identity->level,0,1)!='h'){ //cup
          $hospcode=Yii::$app->user->identity->hospcode;
          $s='n.snt_id,n.hospcode,n.distcode,n.hmain,(SUM(y_cases)/SUM(total))*100 AS percent,r.report_id, r.report_name, r.s_table';
          $office=' hmain =:h ';
          $w='n.y_cases<>0 AND r.active=1';
          $g='report_id';
        }else if(in_array(Yii::$app->user->identity->hospcode, $list_cup, FALSE)||Yii::$app->user->identity->level!='02'
                  ||Yii::$app->user->identity->level!='01'||Yii::$app->user->identity->level!=1){ //hos
        $hospcode=Yii::$app->user->identity->hospcode;
        $s='n.*, r.report_id, r.report_name, r.t_table';
        $w='n.y_cases<>0 ';
        $office=' hospcode =:h';
        # $g='report_id';
        }//endif level
        if(Yii::$app->user->identity->level==1){
          $w='n.y_cases<>0 AND r.active=1';
        }else{$w=$office.' AND n.y_cases<>0 AND r.active=1';}
        
$tasks_noti= (new \yii\db\Query())
              ->select($s)
              ->from('sys_Notifications n')
              ->leftJoin('sys_report r', 'n.report_id=r.report_id')
              ->where($w)
              ->addParams([':h' => $hospcode])
              ->groupBy($g)
              ->orderBy(['percent' => SORT_DESC,])
              ->all(\Yii::$app->db);
}
//var_dump($tasks_noti);

?>
  <!--
  BODY TAG OPTIONS:
  =================
  Apply one or more of the following classes to get the
  desired effect
  |---------------------------------------------------------|
  | SKINS         | skin-blue                               |
  |               | skin-black                              |
  |               | skin-purple                             |
  |               | skin-yellow                             |
  |               | skin-red                                |
  |               | skin-green                              |
  |---------------------------------------------------------|
  |LAYOUT OPTIONS | fixed                                   |
  |               | layout-boxed                            |
  |               | layout-top-nav                          |
  |               | sidebar-collapse                        |
  |               | sidebar-mini                            |
  |---------------------------------------------------------|
  -->
  <style type="text/css">
.skin-blue .main-header .navbar {
background-color: #5F5F5F;
    }
.skin-blue .main-header .logo {
background-color: #5F5F5F;
    }

    .black-ribbon {
  position: fixed;
  z-index: 9999;
  width: 70px;
}
@media only all and (min-width: 768px) {
  .black-ribbon {
    width: auto;
  }
}

.stick-left { left: 0; }
.stick-right { right: 0; }
.stick-top { top: 0; }
.stick-bottom { bottom: 0; }

  </style>
  <body class="skin-blue sidebar-mini">

<!-- <img src="/eh/frontend/themes/img/black_ribbons/black_ribbon_bottom_left.png" class="black-ribbon stick-bottom stick-left"/> -->
<img src="/eh/frontend/themes/img/black_ribbons/black_ribbon_bottom_right.png" class="black-ribbon stick-bottom stick-right"/>
    <div class="wrapper">

      <!-- Main Header -->
      <header class="main-header">

        <!-- Logo -->
        <a href="/eh/frontend/web/index.php" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b>E</b>h</span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><b>EH</b> <span style=" color: #ffffff;font-size: 60%;">เอ๊ะ</span></span>
        </a>

        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top"  role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
          </a>



          
          <!-- Navbar Right Menu -->
              <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- Messages: style can be found in dropdown.less-->
                 <li onclick="javascript:location.href='/eh/frontend/web/index.php'" class="dropdown user user-menu">
                 
                  <a class="dropdown-toggle" data-toggle="dropdown">
                    <!-- <i class="fa fa-child"> </i> -->
                    <span class="hidden-xs">
                      ระบบตรวจสอบคุณภาพข้อมูล 43 แฟ้ม เขตสุขภาพที่ 5 | <?=$provname;?>  </span>
                  </a>
                </li>

              <!-- Notifications: style can be found in dropdown.less -->
                 <li class="dropdown messages-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i  class="fa fa-exclamation fa-lg"></i>
                   <?php if(isset($tasks_noti)){?><span  class="label label-danger"><?=count($tasks_noti);?></span><?php } ?>
                </a>
                <ul class="dropdown-menu">
                  <li class="header">คุณมีการแจ้งเตือน <?=count($tasks_noti);?> รายการ</li>
                  <li>
                    <!-- inner menu: contains the actual data -->
                    <ul class="menu">
                        <?php
                    for($i=0;$i<sizeof($tasks_noti);$i++){
                      
                      
                    ?>
                      <li><!-- start message -->
                        <a href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$tasks_noti[$i]['report_id']; ?>">

                          <div class="pull-left">
                          <i style="color:#FFA500;" class="fa fa-exclamation-triangle"></i>
                          </div>
                          <h4>
                            จำนวน เอ๊ะ
                            <small style="color:red;"><i class="fa fa-heartbeat"></i> <?=$tasks_noti[$i]['percent']; ?>%</small>
                          </h4>
                          <p><?=$tasks_noti[$i]['report_name']; ?></p>
                        </a>
                      </li><!-- end message -->
                      <?php  } ?>
                    </ul>
                  </li>
                  <li class="footer"><a href="<?=Yii::$app->homeUrl;?>?r=report/report/notifyall">ดูการแจ้งเตือนทั้งหมด</a></li>
                </ul>
              </li>
              <!-- Tasks: style can be found in dropdown.less -->
             

             <li class="dropdown tasks-menu">
             <li class="dropdown user user-menu">
                  <a  class="dropdown-toggle" data-toggle="dropdown">
                    <i class="fa fa-child"> </i>
                    <span class="hidden-xs">
                      <?php if(isset(Yii::$app->user->identity->username))
                      {echo 'ผู้ใช้งาน : '.Yii::$app->user->identity->username;
                        
                        }else{echo 'ผู้ใช้งาน : ผู้มาเยือน';} ?>
                    </span>
                  </a>
               
              </li>

              </li>
              <li class="dropdown tasks-menu"><?php
              

              if(Yii::$app->user->isGuest){ ?><a href="<?=Yii::$app->homeUrl;?>?r=user/security/login"   >
              <?php }else{
               ?>
                  <a href="<?=Yii::$app->homeUrl;?>?r=user/security/logout"  data-method="post" >
              <?php } ?>
                    <i class="fa fa-power-off"><?php echo Yii::$app->user->isGuest?' Login':' Logout'; ?></i></a>
              </li>
             <!--  if(Yii::$app->user->isGuest){echo'Logout';}
              if(Yii::$app->user->isGuest){ 
              <li class="active treeview"><a href="<?=Yii::$app->homeUrl;?>?r=user/security/login"  >
               ?> -->
             



            </ul>
          </div>
        </nav>
      </header>
      <!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">

        <!-- sidebar: style can be found in sidebar.less -->
       
      </aside>

      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header" >
          <h1>
            <?php //var_dump($par);?>
           <!--  <small>Optional description</small> -->
          </h1>
          <!-- <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
            <li class="active">Here</li>
          </ol> -->
        </section>

        <!-- Main content -->
        <section class="content" >

          
                <?= Breadcrumbs::widget([
                    'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
                ]) ?>
                <?= Alert::widget() ?>
                <?= $content ?>
        

        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->

      <!-- Main Footer -->
      <footer class="main-footer">
        <!-- To the right -->
        <div class="pull-right hidden-xs">
          เอ๊ะ
        </div>
        <!-- Default to the left -->
        <?php
        $sql="SELECT create_time FROM INFORMATION_SCHEMA.TABLES
  WHERE table_schema = 'eh'
  AND table_name = 'sys_Notifications';";
        $process_sys_notify=\Yii::$app->db->createCommand($sql)->queryOne(); 
        ?>
        <strong>Copyright &copy; V1.20170515 <a style="color:black;" href="#">เขตสุขภาพที่ 5</a>. 
          ประมวลผลเมื่อ <?=$process_sys_notify['create_time'];?></strong>.
      </footer>

      <!-- Control Sidebar -->
         <!-- Left side column. contains the logo and sidebar -->

      <aside class="main-sidebar" >
        <!-- sidebar: style can be found in sidebar.less -->

        <section class="sidebar" >
        
       
          <!-- sidebar menu: : style can be found in sidebar.less -->
<!-- style="  display: block;
  font-size: 14px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;" -->
          <ul class="sidebar-menu" style=" white-space:normal;">
            <li class="header">
              <img class="img-responsive pad" src="/eh/frontend/themes/img/LogoForEh.png" alt="Photo">
            </li>
            <li class="header" style=" color: #ffffff;font-size: 100%; white-space:normal;">
              <?php 
             
              if(isset(Yii::$app->user->identity->username))
              {
                 echo'<li class="header"style=" color: #ffffff;font-size: 90%; white-space:normal;">
                 <a href='.Yii::$app->homeUrl.'?r=user/settings/account'.'>เปลี่ยนรหัสผ่าน</a></li>';
                } ?>

            </li>
            
          
           

               
               <li class="header">เมนูหลัก</li>
               <?php
              if(!Yii::$app->user->isGuest){
                
              if(Yii::$app->user->identity->level==1&&Yii::$app->user->identity->hospcode=='1111'){ ?>
             
            <li class=" treeview">
            <a href="<?=\Yii::$app->urlManagerBackend->getBaseUrl();?>">
                <i class="fa fa-dashboard"></i> <span>ตั้งค่า</span> <i class="fa fa-angle-left pull-right"></i>
              </a>
            </li>
             <?php }} ?>
             
  <!--           <li class="active treeview">
              <a href="#">
                <i class="fa fa-dashboard"></i> <span>รายงาน</span> <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li class="active"><a href="<?=Yii::$app->homeUrl;?>?r=report/report"><i class="fa fa-circle-o"></i> รายงาน</a></li>
                <li><a href="index2.html"><i class="fa fa-circle-o"></i> Dashboard v2</a></li>
              </ul>
            </li> -->


            <?php
                # $connection = Yii::$app->db;
                    $modelmenu = SysMenuGroup::find()
                                   // ->leftJoin('sys_menu_group m', 'm.mucode = menu_group')
                                    ->orderBy(['muid' => SORT_ASC,])  
                                    ->all();
                                    //var_dump($model);
                                    $im=1;

                     foreach ($modelmenu as &$value) {
                      $modelreport=SysReport::find()
                      ->where('menu_group =:mucode', [':mucode' => $value['mucode']])
                      ->andWhere('active = :active', [':active' => 1])
                      ->all();

                      $mcount = SysReport::find()
                      ->where('menu_group =:mucode', [':mucode' => $value['mucode']])
                      ->andWhere('active = :active', [':active' => 1])
                        
                       ->count();        
                              
                      //var_dump($modelreport);
            ?>

            <li class="treeview" style="  display: block;
  font-size: 14px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;">
              <a href="#">
                <i class="fa fa-folder-o"></i>
                <span ><?=$value['muname'];?></span>
                <?php 
                
                if(!Yii::$app->user->isGuest){
                  $mgroup=$value['mucode'];
                  if(Yii::$app->user->identity->level==1||Yii::$app->user->identity->level=='01'){
                    $noti_group= SysNotifications::find()
                  ->select('count(report_id) AS report_id')
                   ->where(['report_group'=>$mgroup,
                    ])
                  ->andWhere('y_cases <> :y_cases', [':y_cases' => 0])
                  ->one();
                  
                  }else{
                     $noti_group= SysNotifications::find()
                  ->select('count(report_id) AS report_id')      
                   ->where($office)
                  ->addParams([':h' => $hospcode])
                   ->andWhere(['report_group'=>$mgroup])
                  ->andWhere('y_cases <> :y_cases', [':y_cases' => 0])
                  ->one();
                  }//end level1
                    if($noti_group['report_id']>0){
                      
                    echo '<small class="label pull-right "><i style="color:#FFA500;" class="fa fa-exclamation-triangle"></i></small>';
                      }else{echo'';}
                }else{
                echo '<span class="label label-primary pull-right">'.$mcount.'</span>';  
                }
                ?>
              </a>
              <ul class="treeview-menu" >
                <?php  for($i=0;$i<sizeof($modelreport);$i++){ ?>
                <?php 
                
                if(!Yii::$app->user->isGuest){ ////////////////////////ยอดตัวเลขy_casesข้างเมนู
                  $reportid=$modelreport[$i]['report_id'];
                   if(Yii::$app->user->identity->level==1||Yii::$app->user->identity->level=='01'){
                     $noti_group= SysNotifications::find()
                  ->select('SUM(y_cases) AS y_cases')
                  ->where(['report_id'=>$reportid])             
                  ->one();
                   }else{
                  
                  $noti_group= SysNotifications::find()
                  ->select('SUM(y_cases) AS y_cases')
                  ->where($office)
                  ->addParams([':h' => $hospcode])
                  ->andWhere(['report_id'=>$reportid
                    ])             
                  ->one();
                  }//end level1
                 
                }else{
                //echo $mcount;  
                }
                ?>

                <li><a
                    data-toggle="tooltip" title="<?=$modelreport[$i]['report_name'];?>"
                 href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$modelreport[$i]['report_id'];?>">
                  <?php
                     if(!Yii::$app->user->isGuest&&$noti_group['y_cases']>0){
                  echo '<small class="label pull-right bg-red">'.$noti_group['y_cases'].'</small>';
                    }
                  ?>
                  <span
                  style="  display: block;
  font-size: 14px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;"><i class="fa fa-circle-o"></i>
                  <?=$modelreport[$i]['report_name'];?></a></span></li>
               <?php } ?>
              </ul>
            </li>
            <?php $im++;}      
            ?>
          
      <!--      <li class="treeview">
              <a href="#">
                <i class="fa fa-edit"></i> <span>EPI</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li><a href="<?=Yii::$app->homeUrl;?>?r=epi/default/epi1to5_"><i class="fa fa-circle-o"></i> ตรวจสอบวัคซีนในเด็ก 1-5ปี</a></li>
                
              </ul>
            </li> -->

          </ul>
            
        </section>
        <!-- /.sidebar -->
      </aside>
      <!-- /.control-sidebar -->
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->
<script src="/eh/frontend/themes/lte/cssjs/plugins/jQuery/jQuery-2.1.4.min.js"></script>   
   
          <?php $this->endBody() ?>
          <?php
          //$this->registerJsFile('/eh-dev-v1/frontend/themes/lte/cssjs/plugins/jQuery/jQuery-2.1.4.min.js');
          ?>
  </body>
</html>
<?php $this->endPage() ?>


