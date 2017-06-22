<style type="text/css">


/* Important part */
.modal-dialog{
    overflow-y: initial !important
}
.modal-body{
    height: 350px;
    overflow-y: auto;
}

</style>
<?php
use miloschuman\highcharts\Highcharts;
//use yii\helpers\Html;
use yii\helpers\BaseUrl;
use yii\helpers\Url;
//use kartik\date\DatePicker;
use yii\widgets\ActiveForm;
use kartik\grid\GridView;
use frontend\modules\runreport\model\Sys_report;
use frontend\modules\report\model\Cchangwat;
use frontend\modules\report\model\Campur;
use frontend\modules\report\model\Chospital;
use frontend\modules\report\model\Cmastercup;
use yii\helpers\ArrayHelper;
use kartik\export\ExportMenu;
use kartik\helpers\Html;
use yii\helpers\Json;
// use frontend\themes\lte\assets\LteAsset;
// LteAsset::register($this);

$this->title = $reportname;
$this->params['breadcrumbs'][] = ['label' => 'รายงาน', 'url' => ['report/notifyall']];
$this->params['breadcrumbs'][] = $this->title;

if(!empty($_GET['ctambon'])){
  $ctambon = $_GET['ctambon'];
}else{
$ctambon='';
  }
      if($mastertype=='02'){
     $campur = $mastercode;
    // $ctambon = $_GET['ctambon'];
      $ctambon_list = ArrayHelper::map(Chospital::find()
            ->where('CONCAT(provcode,distcode)=:pcu', [':pcu'=>$campur])
            ->andWhere([
            'hostype' => ['03','04','05','06','07','08','12','13','15','18'],
            ])->all(), 'hoscode', 'hosname');
    }else{
       $campur = $mastercode;
       
         //  $ctambon = $_GET['ctambon'];
         
 $subhos_list= Cmastercup::find()->select('hsub')->where('hmain=:mastercode', [':mastercode'=>$campur])->all();
 for($i=0;$i<sizeof($subhos_list);$i++){
            $s[]=$subhos_list[$i]['hsub'];            
        }   
  $ctambon_list = ArrayHelper::map(Chospital::find()
             ->where(['IN', 'hoscode', $s])
              ->andWhere([
              'hostype' => ['03','04','05','06','07','08','12','13','15','18'],])
              ->all(), 'hoscode', 'hosname');
    }//endif
   

?>
<?php
$files_g = Json::decode($report_docs);
                              if(empty($files_g)){
                                $docs_file_g=null;
                              }else{
                              if(is_array($files_g)){
                                  # $docs_file_g ='เอกสาร : |';
                                   foreach ($files_g as $keyfile_g => $vfile_g) {
                                // $docs_file_g .= 
                                //   'file'.$keyfile_g.'|file_name'.$vfile_g.'|';
                                   $docs_file_g[]=[
                                   'id'=>$keyfile_g,
                                   'name'=>$vfile_g
                                   ];
                                   }
                                   #$docs_file .='|';
                                  # echo $docs_file_g;
                                }//if is_array
                              }//if empty

    $form = ActiveForm::begin([
    'method'=>'get',
    'action' => Url::to(['report/runreport2', 'r_table'=>$r_table]),
    ]);
    ?>

       

   
    <div class="form-grop">
      <?= Html::label('หน่วยบริการ','ctambon');?>
        <?= Html::dropDownList('ctambon',$ctambon,$ctambon_list,[
            'class'=>'form-control',
            'id'=>'ctambon',
            'prompt'=>'-เลือกหน่วยบริการ-',

        ]);?>
            </div><br>
 <?php echo Html::submitButton('ตกลง', ['class'=>'btn btn-info']); 

        ActiveForm::end();
    ?>
    <br><div class="alert alert-success" role="alert">คำนิยาม:: <?=$defination;?></div>
<?php
  

echo '<h2>รายงาน::'.$reportname.'</h2>';

 
            foreach ($columns as $index => $value) {  
              if($index>0){
             $gridcolumns[]=[
             'attribute'=>$value['Field'],
              'value'=>function($data) use ($value) {
                $fieldDate=['DATE_SERV','date_serv','BIRTH','birth','ddeath','ddeath2'
                ,'bdate','BDATE','newborn_bdate','ppcare','edc','bcare'];
                if($value['Field']=='hosname'){
                  return  Html::a($data['hosname'],['runreport2','ctambon'=>$data['hospcode'],'r_table'=>$_GET['r_table']]);
               } if($value['Field']=='y_cases'){
                  return  Html::a($data['y_cases'],['runreport2','ctambon'=>$data['hospcode'],'r_table'=>$_GET['r_table']]);
               }else if(in_array($value['Field'],$fieldDate)){
                return Yii::$app->Udf->thDateAbbr($data[$value['Field']]);
               }else{
                  return  $data[$value['Field']];
                }
             },
             #กำหนดการแสดงผล ถ้าเลือกหน่วยบริการแล้ว ไม่ต้องแสดง Hoscode 
             'visible'=> (strlen($ctambon) == 5 && $value['Field'] == 'hosname'
              ||$value['Field'] == 'distcode' ? false : true ),
             
             
             #กรณีเป็นวันที่ ระบบจะแสดงเป็น format วันที่
           #  'format'=>($value['Field'] == 'date_serv' ? 'date' : 'raw' ),
             'format'=>'raw',
             'label'=>$value['Comment']
                       ];             
               }  //endif index   
         }  




?>
<div class="panel panel-primary">
    <div class="panel-heading"><h3><div class="glyphicon glyphicon-stats"></div> &nbsp;</h3></div>
<br><br>
<?php

echo Highcharts::widget([
   'options' => [
      'credits' => ['enabled' => false],
      'title' => ['text' => ''],
      'xAxis' => [
         'categories' => $hosname
      ],
      'yAxis' => [
         'title' => ['text' => 'ร้อยละ']
      ],
       'legend'=> [
            'reversed'=> true
        ],
      'plotOptions'=> [
            'series'=> [
             'zoneAxis'=> 'y',
      'zones'=> [
            [
                'value'=> 0,
                'color'=> '#00C0EF'
            ],
            [
                'value'=> 2,
                'color'=> '#00A65A'
            ],
            [
                'value'=> 21,
                'color'=> '#F39C12'
            ],
            [
               
                'color'=> '#DD4B39'
            ],
            ],
                'stacking'=> 'normal'
            ]
        ],
      'series' => [
      
        [
        'type'=>'bar',
        'name'=>'เอ๊ะ %',
        'data'=>$percent,
        'color'=> '#FF5722'
        ],
        
      ]
   ]
]);?>
</div>
<?php
$fullExportMenu = ExportMenu::widget([
    'dataProvider' => $data,
     'formatter' => ['class' => 'yii\i18n\Formatter','nullDisplay' => ''],
    'columns' => $gridcolumns,
    'target' => ExportMenu::TARGET_BLANK,
    'fontAwesome' => true,
    'pjaxContainerId' => 'kv-pjax-container',
    'dropdownOptions' => [
        'label' => 'Full',
        'class' => 'btn btn-default',
        'itemsBefore' => [
            '<li class="dropdown-header">Export All Data</li>',
        ],
    ],
]);
echo GridView::widget([
    'dataProvider' => $data,
     'formatter' => ['class' => 'yii\i18n\Formatter','nullDisplay' => ''],
    'columns' => $gridcolumns,
    'pjax' => true,
    'pjaxSettings' => ['options' => ['id' => 'kv-pjax-container']],
    'panel' => [
        'type' => GridView::TYPE_PRIMARY,
        'heading' => '<h3 class="panel-title"><i class="glyphicon glyphicon-book"></i> ข้อมูลต้องสงสัย</h3>',
    ],
    // set a label for default menu
    'export' => [
        'label' => 'Page',
        'fontAwesome' => true,
    ],
    // your toolbar can include the additional full export menu
    'toolbar' => [
        '{export}',
        $fullExportMenu,
        // ['content'=>
        //     Html::button('<i class="glyphicon glyphicon-plus"></i>', [
        //         'type'=>'button', 
        //         'title'=>Yii::t('kvgrid', 'Add Book'), 
        //         'class'=>'btn btn-success'
        //     ]) . ' '.
        //     Html::a('<i class="glyphicon glyphicon-repeat"></i>', ['report/runreport1'], [
        //         'data-pjax'=>0, 
        //         'class' => 'btn btn-default', 
        //         'title'=>Yii::t('kvgrid', 'Reset Grid')
        //     ])
        // ],
    ]
]);                     
?>


                      

   <?php if(!Yii::$app->user->isGuest){ ?>
    <section>
<?php  
$sql=[0=>$a_sql,1=>$s_sql,2=>$t_sql];
$sql_name=[0=>'คำสั่งประมวลผลระดับจังหวัด',1=>'คำสั่งประมวลผลระดับอำเภอ',2=>'คำสั่งประมวลผลระดับหน่วยบริการ'];
for ($i=0;$i<3;$i++) {
?>
<button type="button" class="btn btn-danger" data-toggle="modal" 
data-target="#sql<?=$i;?>"><?=$sql_name[$i];?></button>


<!-- Modal -->
  <div class="modal fade" id="sql<?=$i;?>" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"><?=$sql_name[$i];?></h4>
          </div>
        <div class="modal-body"><!-- body -->
           <center><div class="embed-responsive embed-responsive-16by9">
          <div id=''>
            <p><?=$sql[$i];?></p>
            </div>
       </div></center><!-- endcontent -->
        </div><!-- endbody -->
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  <!-- endModal -->


<?php
}
?>
 <button type='button' class='btn btn-warning' data-toggle='modal' 
    data-target='#myModal'>แนวทางแก้ไขเบื้องต้น</button>
  </section>
<?php
}
?>
  


  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"><?=$reportname;?></h4>
          <?php
          for($i=0;$i<sizeof($docs_file_g);$i++){
          
          echo Html::button($docs_file_g[$i]['name'], [ 'class' => 'btn btn-primary', 
  'onclick' => "(function () {
    $.ajax({
       url: '".Url::toRoute('report/calldocs')."',
       type: 'post',
       data: {
                 docs_id: '".$docs_file_g[$i]['id']."'  ,
                 docs_ref: '".$report_ref."'  , 
               
                 _csrf : '".Yii::$app->request->getCsrfToken()."'
             },
       success: function (data) {
          console.log(data.search);
          $('#docs').html(data);
       }
  });

    })();" ]);
        }
         

          ?>
        </div>
        <div class="modal-body"><!-- body -->
           <center><div class="embed-responsive embed-responsive-16by9">
          <div id='docs'>

            </div>
       </div></center><!-- endcontent -->
        </div><!-- endbody -->
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  <!-- endModal -->

   
