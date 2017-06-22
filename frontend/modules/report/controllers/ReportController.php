<?php
namespace frontend\modules\report\controllers;
use Yii;
use yii\data\ArrayDataProvider;
use yii\web\Controller;
use frontend\modules\report\model\SysReport;
use yii\db\Query;
use yii\db\Command;
use yii\db\Connection;
use yii\helpers\Html;
use yii\helpers\BaseUrl;
use yii\helpers\Url;
use  yii\web\Session;
use frontend\modules\report\model\SysConfig;
use frontend\modules\report\model\SysMenuGroup;
use frontend\modules\report\model\Cmastercup;
//use mdm\admin\components\AccessControl;
//use yii\filters\AccessControl;
//use yii\filters\VerbFilter;

class ReportController extends \yii\web\Controller
{
    //   public function behaviors()
    // {
    //     return [
    //         // 'access' => [
    //         //     'class' => AccessControl::className(),
    //         //     'only' => ['logout', 'signup'],
    //         //     'rules' => [
    //         //         [
    //         //             'actions' => ['signup'],
    //         //             'allow' => true,
    //         //             'roles' => ['?'],
    //         //         ],
    //         //         [
    //         //             'actions' => ['logout'],
    //         //             'allow' => true,
    //         //             'roles' => ['@'],
    //         //         ],
    //         //     ],
    //         // ],
    //         'access' => [
    //             'class' => AccessControl::className(),
    //         ],

    //         'verbs' => [
    //             'class' => VerbFilter::className(),
    //             'actions' => [
    //                 'logout' => ['post'],
    //             ],
    //         ],
    //     ];
    // }
  public function operators(){

     $data_notify = (new \yii\db\Query())
              ->select('n.snt_id,n.hospcode,n.distcode,n.hmain,n.report_id,r.report_name,n.report_group,
                        SUM(y_cases)AS y_cases, (SUM(y_cases)/SUM(total))*100 AS percent ')
              ->from('sys_Notifications n')
              ->leftJoin('sys_report r', 'n.report_id=r.report_id')
              ->where($office)
              //->andWhere(['active' => 1])
              ->addParams([':h' => $hospcode])
              
              ->groupBy('report_id')
              ->orderBy(['percent' => SORT_DESC,])
              ->limit(20)
              ->all(\Yii::$app->db);
  }
  public  function actionDev(){
   
    return $this->render('dev',[
     
      ]);
  }
  public  function actionCalldocs(){
    $request = Yii::$app->request;
    if ($request->isPost) {

$docs_ref = $request->post('docs_ref');
$docs_id = $request->post('docs_id');

    }else{
      $docs_ref=null;
      $docs_id=null;
    }
    \yii::setAlias('@pathdocs', 'http://203.157.151.20/eh/backend/web/documents');
    $html_div="
  <iframe class='embed-responsive-item'".
          "src='http://docs.google.com/gview?".
          "url=".Yii::getAlias('@pathdocs').'/'.$docs_ref.'/'.$docs_id."&embedded=true'".
     "frameborder='0'></iframe>";
   return $html_div;
     
      
  }
    public static function chkcup(){
     $listmaincup='';
      $pmodel=SysConfig::find()->select('province_config')->one();
      $provcup=$pmodel['province_config'].'00';
        $datacup=  Yii::$app->dbhdc->createCommand("SELECT * FROM(
                    SELECT hmain,count(hsub)AS hsub,hmainname,hmaintype 
                    FROM cmastercup
                    WHERE province_id = '".$provcup."'
                    GROUP BY hmain
                    )AS cup
                    WHERE cup.hsub > 1;")->queryAll();
            for($i=0;$i<sizeof($datacup);$i++){    
              $listmaincup[]=$datacup[$i]['hmain'];
             } 


        return $listmaincup;
    }
    public function actionIndex()
    {
      $connection = \Yii::$app->db;
      $transaction = $connection->beginTransaction();
try {
      try{

        
        $data_notify=null;$ridnot=null;$notify_topten=null;
        $list_cup=$this->chkcup();
        $chkdata_notify = (new \yii\db\Query())
              ->select('*')
              ->from('sys_Notifications')
              ->all(\Yii::$app->db);
        $chkdata_notify=count($chkdata_notify);
        if($data_notify==null && $chkdata_notify==0){//isguest
              $data_notify = (new \yii\db\Query())
              ->select("report_id,report_name")
              ->from('sys_report')
              ->where(['active' => 1])
              ->limit(20)
              ->all(\Yii::$app->db);
               for($i=0;$i<sizeof($data_notify);$i++){
                $data_notify[$i]['y_cases']=0;
                $data_notify[$i]['percent']=0;
               }//endfor

            }else{
       // $level3=['h05','h07','03','04','08','12','13','15'];
        if(!Yii::$app->user->isGuest){ #'04','08','12','13','15'
         if(Yii::$app->user->identity->level==1){ //admin
           $hospcode=Yii::$app->user->identity->hospcode;
          $s='n.snt_id,n.hospcode,n.distcode,n.hmain,SUM(n.y_cases)AS y_cases,r.report_id, r.report_name, r.s_table';
          $office=' r.active=1';
          $g='report_id';
        }else if(Yii::$app->user->identity->level=='02'){ //ampur
          $hospcode=Yii::$app->user->identity->hospcode;
          $office=' distcode =:h AND r.active=1';
          $s='n.snt_id,n.hospcode,n.distcode,n.hmain,SUM(n.y_cases)AS y_cases,r.report_id, r.report_name, r.s_table';
          $g='report_id';
        }else if(in_array(Yii::$app->user->identity->hospcode, $list_cup, FALSE)||Yii::$app->user->identity->level!='02'
                  ||Yii::$app->user->identity->level!='01'||Yii::$app->user->identity->level!=1){ //hos
        $hospcode=Yii::$app->user->identity->hospcode;
        $s='n.*, r.report_id, r.report_name, r.t_table';
        $office=' hospcode =:h AND r.active=1';
        }else if(in_array(Yii::$app->user->identity->hospcode, $list_cup, TRUE)){ //cup
          $hospcode=Yii::$app->user->identity->hospcode;
          $s='n.snt_id,n.hospcode,n.distcode,n.hmain,SUM(n.y_cases)AS y_cases,r.report_id, r.report_name, r.s_table';
          $office=' hmain =:h AND r.active=1';
          $g='report_id';
        }//endif level  
    	    
       $data_notify = (new \yii\db\Query())
              ->select('n.snt_id,n.hospcode,n.distcode,n.hmain,n.report_id,r.report_name,n.report_group,
                        SUM(y_cases)AS y_cases, (SUM(y_cases)/SUM(total))*100 AS percent ')
              ->from('sys_Notifications n')
              ->leftJoin('sys_report r', 'n.report_id=r.report_id')
              ->where($office)
              //->andWhere(['active' => 1])
              ->addParams([':h' => $hospcode])
              
              ->groupBy('report_id')
              ->orderBy(['percent' => SORT_DESC,])
              ->limit(20)
              ->all(\Yii::$app->db);

             
        

               
       
            
        $num_notify=count($data_notify);
        if($num_notify<=0){
          $data_notify = (new \yii\db\Query())
              ->select('n.snt_id,n.hospcode,n.distcode,n.hmain,n.report_id,r.report_name,n.report_group,
                        SUM(y_cases)AS y_cases, (SUM(y_cases)/SUM(total))*100 AS percent ')
              ->from('sys_Notifications n')
              ->leftJoin('sys_report r', 'n.report_id=r.report_id')
              ->where(['active' => 1])
              //->where($office)
              //->addParams([':h' => $hospcode])
              ->groupBy('report_id')
              ->orderBy(['percent' => SORT_DESC,])
              ->limit(20)
              ->all(\Yii::$app->db);
        }
        if($num_notify<20){
          $limit_report=20-$num_notify;
           for($i=0;$i<sizeof($data_notify);$i++){
               $ridnot[]= $data_notify[$i]['report_id'];
            }   
          $data_notify_push = (new \yii\db\Query())
              ->select('*')
              ->from('sys_report')
               ->where(['NOT IN', 'report_id', $ridnot])
               ->andwhere(['active' => 1])
              // ->addParams([':office' => '08436'])
              // ->groupBy('report_id')
              // ->orderBy(['y_cases' => SORT_DESC,])
              ->limit($limit_report)
              ->all(\Yii::$app->db);
             $ii=1;$num=0;
          for ($i = $num_notify; $i < 20; $i++) {
            //$i_push[]=($num_notify+count($data_notify_push))-19;
            //if($i==18){$ii=$ii+1;}if($ii==2){$num=$num+2;}else{$num=$i;}
            $num=20-$i-1;
              array_push($data_notify, $data_notify[$i]=[
                'snt_id' =>  99, 
                'hospcode' =>  $hospcode, 
                'distcode' =>  '', 
                'hmain' =>  '', 
                'report_id' => $data_notify_push[19-$i]['report_id'], 
                'report_name'=>$data_notify_push[19-$i]['report_name'], 
                'report_group' =>  'test', 
                'y_cases' =>  '0',
                'percent'=>'0' 
                ]);
              }
            }//endif num_notify


            
      }else{//isguest
      if($data_notify==null){
        $sql="SELECT 
            n.snt_id,n.hospcode,n.distcode,n.hmain,r.report_id,r.report_name,r.menu_group,
            SUM(y_cases)AS y_cases, (SUM(y_cases)/SUM(total))*100 AS percent 
            FROM(
            SELECT * FROM sys_report 

            )AS r LEFT JOIN(
            SELECT * FROM sys_Notifications
            )AS n ON r.report_id=n.report_id
            GROUP BY r.report_id
            ORDER BY percent DESC
            LIMIT 20";
          $data_notify=\Yii::$app->db->createCommand($sql)->queryAll();               
            }
                         

            }//endif isguest

     }//endif chkdata_notify


if(!Yii::$app->user->isGuest){ 
   $toptenwhere=null;
              if(!empty($office)){
                $toptenwhere .=' AND '.$office;

            }
     $sql = " SELECT *
                  FROM sys_report r 
                  WHERE r.report_id IN(10014, 24, 26, 10042, 10018, 10039, 23, 10020, 10012, 10016)
                   
                  GROUP BY r.report_id";
              $rname_topten = \Yii::$app->db->createCommand($sql)->queryAll();  
              for($i=0;$i<sizeof($rname_topten);$i++){
                 $sql = "SELECT n.snt_id,n.hospcode,n.distcode,n.hmain,n.report_id,r.report_name,n.report_group,
                        SUM(y_cases)AS y_cases, (SUM(y_cases)/SUM(total))*100 AS percent
                      FROM sys_Notifications n LEFT JOIN sys_report r ON n.report_id=r.report_id
                      WHERE  n.report_id='".$rname_topten[$i]['report_id']."'   
                       $toptenwhere;"; 
                       if(!empty($hospcode)){
              $notify_topten[$i] = \Yii::$app->db->createCommand($sql)->bindValue(':h', $hospcode)->queryAll();  
              $count_topten =count($notify_topten[$i][0]['snt_id']);
                  }else{
                    $count_topten=0;
                    $hospcode=null;
                  }
              if($count_topten==0){
                   array_push($notify_topten, $notify_topten[$i][0]=[
                'snt_id' =>  $i, 
                'hospcode' =>  $hospcode, 
                'distcode' =>  '', 
                'hmain' =>  '', 
                'report_id' => $rname_topten[$i]['report_id'], 
                'report_name'=>$rname_topten[$i]['report_name'], 
                'report_group' =>  'test', 
                'y_cases' =>  0,
                'percent'=>0 
                ]);
                }//end if
              }//end for
             // var_dump($notify_topten);
            }else{
               $sql = " SELECT *
                  FROM sys_report r 
                  WHERE r.report_id IN(10014, 24, 26, 10042, 10018, 10039, 23, 10020, 10012, 10016)
                   
                  GROUP BY r.report_id";
              $rname_topten = \Yii::$app->db->createCommand($sql)->queryAll();  
              for($i=0;$i<sizeof($rname_topten);$i++){
                 $sql = "SELECT n.snt_id,n.hospcode,n.distcode,n.hmain,n.report_id,r.report_name,n.report_group,
                        SUM(y_cases)AS y_cases, (SUM(y_cases)/SUM(total))*100 AS percent
                      FROM sys_Notifications n RIGHT JOIN sys_report r ON n.report_id=r.report_id
                      WHERE  n.report_id='".$rname_topten[$i]['report_id']."'   
                      ;"; 
              $notify_topten[$i] = \Yii::$app->db->createCommand($sql)->queryAll();  
              if(empty($notify_topten[$i][0]['report_id'])){
                   array_push($notify_topten, $notify_topten[$i][0]=[
                'snt_id' =>  $i, 
                'hospcode' =>  99, 
                'distcode' =>  '', 
                'hmain' =>  '', 
                'report_id' => $rname_topten[$i]['report_id'], 
                'report_name'=>$rname_topten[$i]['report_name'], 
                'report_group' =>  'test', 
                'y_cases' =>  0,
                'percent'=>0 
                ]);
                }//end if
              }//end for

            }//ifisGuest2
            //color&icon

            $cg=null;$cgt=null;
            for($i=0;$i<sizeof($data_notify);$i++){
              if($data_notify[$i]['percent']==0){
               $cg[$i]['level_color']='bg-aqua';
               $cg[$i]['level_icon']='ion ion-ios-heart-outline';
                 }else if($data_notify[$i]['percent']<=1){
                  $cg[$i]['level_color']='bg-green';
                  $cg[$i]['level_icon']='fa fa-database';
                 }else if($data_notify[$i]['percent']<=20){
                   $cg[$i]['level_color']='bg-yellow';
                   $cg[$i]['level_icon']='ion-ios-chatbubble-outline';
                 }else if($data_notify[$i]['percent']>20){
                  $cg[$i]['level_color']='bg-red';
                  $cg[$i]['level_icon']='fa fa-exclamation';
                 }
              }//endfor
            //end color&icon
              
                for($ig=0;$ig<10;$ig++){
              if($notify_topten[$ig][0]['percent']==0){
               $cgt[$ig]['level_color']='aqua';
                 }else if($notify_topten[$ig][0]['percent']<=1){
                  $cgt[$ig]['level_color']='green';
                 }else if($notify_topten[$ig][0]['percent']<=20){
                   $cgt[$ig]['level_color']='yellow';
                 }else if($notify_topten[$ig][0]['percent']>20){
                  $cgt[$ig]['level_color']='red';
                 }
              }//endfor


           } catch(\yii\db\Exception $e){ 
              throw new \yii\web\HttpException(405, 'ยังไม่มีการประมวลผลข้อมูล หรือ การตั้งค่าหน่วยงาน'); 
        } 


          $transaction->commit();
} catch(Exception $e) {
   
    $transaction->rollback();
}


       return $this->render('index2',[
        'data_notify'=>$data_notify,
        'cg'=>$cg,
        'cgt'=>$cgt,
        'notify_topten'=>$notify_topten,
        //'ridnot'=>$i_push,
        //'data_notify_push'=>$data_notify_push,
        //'i'=>$ii
        ]);
       
    }

/*
    public function xx(){

      $q = \Yii::$app->request->get();
      $q['r_table'];

      $sql = "SELECT * FROM xxx";
      $result = \Yii::$app->db->createCommand($sql)->queryAll();
    }
    */
  

     public function actionNotifyall()
    {
      try{
        $list_cup=$this->chkcup();
        $data_notify=null;
        $list_cup=$this->chkcup();
           if(Yii::$app->user->isGuest){
             $data_notify = (new \yii\db\Query())
              ->select('n.snt_id,n.hospcode,n.distcode,n.hmain,r.report_id,r.report_name,n.report_group,
                        SUM(y_cases) AS y_cases, (SUM(y_cases)/SUM(total))*100 AS percent  ')
              ->from('sys_report r')
              ->where(['r.active' => 1])
              ->andWhere('menu_group != :g', [':g' => 'qof'])
              ->leftJoin('sys_Notifications n', 'n.report_id=r.report_id')
              ->groupBy('r.report_id')
              ->orderBy(['percent' => SORT_DESC,])
              //->limit(20)
              ->all(\Yii::$app->db);

         }else{
      // if(Yii::$app->user->identity->level==1){
      //      $hospcode=Yii::$app->user->identity->hospcode;
      //    // $s='n.snt_id,n.hospcode,n.distcode,n.hmain,SUM(n.y_cases)AS y_cases,r.report_id, r.report_name, r.s_table';
      //     $office=' r.active=1';
      //    # $g='report_id';
      //   }else if(Yii::$app->user->identity->level=='02'){
      //     $hospcode=Yii::$app->user->identity->hospcode;
      //     $office=' distcode =:h ';
      //    // $s='n.snt_id,n.hospcode,n.distcode,n.hmain,SUM(n.y_cases)AS y_cases,r.report_id, r.report_name, r.s_table';
      //    # $g='report_id';
      //    }else if(in_array(Yii::$app->user->identity->hospcode, $list_cup, FALSE)||Yii::$app->user->identity->level!='02'
      //             ||Yii::$app->user->identity->level!='01'||Yii::$app->user->identity->level!=1){ //hos
      //   $hospcode=Yii::$app->user->identity->hospcode;
      //  // $s='n.*, r.report_id, r.report_name, r.t_table';
      //   $office=' hospcode =:h ';
      //   }else if(in_array(Yii::$app->user->identity->hospcode, $list_cup, TRUE)){ //cup
      //     $hospcode=Yii::$app->user->identity->hospcode;
      //     //$s='n.snt_id,n.hospcode,n.distcode,n.hmain,SUM(n.y_cases)AS y_cases,r.report_id, r.report_name, r.s_table';
      //     $office=' n.hmain =:h AND r.active=1';
      //     #$g='r.report_id';
      //   }//endif level  

        
          
      //  $data_notify = (new \yii\db\Query())
      //         ->select('n.snt_id,n.hospcode,n.distcode,n.hmain,r.report_id,r.report_name,n.report_group,
      //                   SUM(y_cases)AS y_cases, (SUM(y_cases)/SUM(total))*100 AS percent ')
      //         ->from('sys_report r')
      //         ->leftJoin('sys_Notifications n', 'n.report_id=r.report_id')
      //         ->where($office)
      //         //->andWhere('r.active = :active', [':active' => 1])
      //         ->addParams([':h' => $hospcode])
      //        // ->addParams([':a' => 1])
             
      //         ->groupBy('r.report_id')
      //         ->orderBy(['percent' => SORT_DESC,])
      //         //->limit(20)
      //         ->all(\Yii::$app->db);

    if(Yii::$app->user->identity->level==1){
           $hospcode=Yii::$app->user->identity->hospcode;
           $offname='ผู้ดูแล';
           $office=null;
        }else if(Yii::$app->user->identity->level=='02'){
          $hospcode=Yii::$app->user->identity->hospcode;
          $office='where distcode = '.$hospcode;
         }else if(in_array(Yii::$app->user->identity->hospcode, $list_cup, TRUE)&&
          substr(Yii::$app->user->identity->level,0,1)!='h'){ //cup
          $hospcode=Yii::$app->user->identity->hospcode;
          $office='where hmain = '.$hospcode;
        }else if(in_array(Yii::$app->user->identity->hospcode, $list_cup, FALSE)||Yii::$app->user->identity->level!='02'
                  ||Yii::$app->user->identity->level!='01'||Yii::$app->user->identity->level!=1){ //hos
        $hospcode=Yii::$app->user->identity->hospcode;       
        $office='where hospcode = '.$hospcode;
        }//endif level
        
        $sql="SELECT 
              n.snt_id,n.hospcode,n.distcode,n.hmain,r.report_id,r.report_name,r.menu_group,
              SUM(y_cases) AS y_cases, (SUM(y_cases)/SUM(total))*100 AS percent
              FROM(SELECT * FROM sys_report)AS r
              LEFT JOIN(
              SELECT * FROM sys_Notifications
               ".$office."
              )AS n 
              ON r.report_id=n.report_id
              WHERE r.active=1 AND menu_group !='qof' 
              GROUP BY r.report_id
              ORDER BY percent DESC";
        $data_notify=\Yii::$app->db->createCommand($sql)->queryAll();  
        
// $data_notify= (new \yii\db\Query())
//               //->select($s)
//           ->select('n.snt_id,n.hospcode,n.distcode,n.hmain,r.report_id,r.report_name,n.report_group,
//                         SUM(y_cases)AS y_cases, (SUM(y_cases)/SUM(total))*100 AS percent ')
//               ->from('sys_Notifications n')
//               ->leftJoin('sys_report r', 'n.report_id=r.report_id')
//               ->where($w)
//               ->addParams([':h' => $hospcode])
            
//               ->groupBy($g)
//               ->orderBy(['percent' => SORT_DESC,])
//               ->all(\Yii::$app->db);


        
      }//endif isgust
            


           } catch(\yii\db\Exception $e){ 
              throw new \yii\web\HttpException(405, 'SQL Error'); 
        } 

       return $this->render('notifyall',[
        'data_notify'=>$data_notify,
        //'ridnot'=>$i_push,
        //'data_notify_push'=>$data_notify_push,
        //'i'=>$ii
        ]);
       
    }
   
     public function chk_province(){
      
        $model = SysConfig::find()->select('province_config')->one();
        $result= $model['province_config'];
        if(count($model)==0){$result='0';}
       
        return $result;
     
    }
    public function actionChk(){
    //    $url=Yii::$app->urlManager->createUrl(['user/security/login']);
    // Yii::$app->getResponse()->redirect($url);
     $list_cup=$this->chkcup();
       $rid= $_GET['r_table'];
        if(Yii::$app->user->isGuest){
         // $url=Yii::$app->urlManager->createUrl(['user/security/login']);
         // Yii::$app->getResponse()->redirect($url);
            $url=Yii::$app->urlManager->createUrl(['report/report/runreport4', 'r_table'=>$rid]);
           Yii::$app->getResponse()->redirect($url);
        }else{
        if(Yii::$app->user->identity->level==1){
           $url=Yii::$app->urlManager->createUrl(['report/report/runreport1', 'r_table'=>$rid]);
           Yii::$app->getResponse()->redirect($url);
         }else if(in_array(Yii::$app->user->identity->hospcode, $list_cup, TRUE)&&
          substr(Yii::$app->user->identity->level,0,1)!='h'
          
         ||Yii::$app->user->identity->level=='02'){ //cup 
           $url=Yii::$app->urlManager->createUrl(['report/report/runreport2', 'r_table'=>$rid]);
           Yii::$app->getResponse()->redirect($url);
         }else if(//in_array(Yii::$app->user->identity->hospcode, $list_cup, FALSE)
          substr(Yii::$app->user->identity->level,0,1)=='h'||Yii::$app->user->identity->level!='02'
                  ||Yii::$app->user->identity->level!='01'){ //hos
           $url=Yii::$app->urlManager->createUrl(['report/report/runreport3', 'r_table'=>$rid]);
           Yii::$app->getResponse()->redirect($url);
         }
      return $this->render('chk');
      }
    }
    public function actionRunreport4(){
     
         $para='';
         $aum='';
         $chartwhere='';
         $hosname='';
         $cases='';
         $table=null;
          if (isset($_GET['r_table'])) {
              $tableid=$_GET['r_table'];
              $connection2 = Yii::$app->db;        
           $findreport = SysReport::find()->where(['report_id' => $tableid])->one();
           $reportname=$findreport['report_name'];
            $defination=$findreport['defination'];    
            $provincecode=$this->chk_province();
         if (!empty($_GET['ctambon']) ) {
              if(Yii::$app->user->isGuest){
             $url=Yii::$app->urlManager->createUrl(['user/security/login']);
             Yii::$app->getResponse()->redirect($url);
           }
          }
      
            if (!empty($_GET['campur'])) {
              $aum=$_GET['campur'];
              $table=$findreport['s_table'];
              $para=$_GET['campur'];
              $chart=$findreport['s_table'];
              $chartwhere=$_GET['campur'];
              $chartname='hosname';
           try{
           $datachart = (new \yii\db\Query())
              ->select('*')
              ->from($chart)
              ->where('distcode = :chartwhere')
             ->addParams([':chartwhere' => $chartwhere])
              ->orderBy(['distcode' => SORT_ASC,])
              ->all(\Yii::$app->db);
       
            $rows = (new \yii\db\Query())
                      ->select('*')
                      ->from($table)
                      //->limit(10)
                      ->where('distcode = :distcode')
                      ->addParams([':distcode' => $para])
                      ->orderBy(['distcode' => SORT_ASC,])
                      ->all(\Yii::$app->db);
              } catch(\yii\db\Exception $e){ 
                 throw new \yii\web\HttpException(405, 'SQL Error'); 
             } 
        } elseif(empty($_GET['campur'])){   
            
           $table=$findreport['a_table'];
           $chart=$findreport['a_table'];
            $chartname='ampurname';
            $para='';
           
            try{
              $datachart = (new \yii\db\Query())
              ->select('*')
              ->from($chart)
              //->where(['distcode'=> $mastercode])
              ->orderBy(['distcode' => SORT_ASC,])
              ->all(\Yii::$app->db);
              $rows = (new \yii\db\Query())
                      ->select('*')
                      ->from($table)
                      ->orderBy(['distcode' => SORT_ASC,])
                      ->all(\Yii::$app->db);
                } catch(\yii\db\Exception $e){ 
                 throw new \yii\web\HttpException(405, 'SQL Error'); 
             } 
           
          }//endif
      //  }//endifctambon
            try{
              $columns= Yii::$app->db->createCommand('SHOW FULL COLUMNS FROM '.$table)->queryAll();  
              $chart_y= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'y%'")->queryAll();
              $namechart_y=$chart_y[0]['Field'];
              $chart_total= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'total%'")->queryAll();
              $namechart_total=$chart_total[0]['Field'];
             $percent='';$cases='';$hosname='';$level_color='';
            for($i=0;$i<sizeof($datachart);$i++){
                $hosname[]=$datachart[$i][$chartname];            
                $cases[]=$datachart[$i][$namechart_y]*1;
                $percent[]=floatval($datachart[$i]['percent']);//($datachart[$i][$namechart_total]*1)-($datachart[$i][$namechart_y]*1);


                   

                      

            }   //end for    
                     
        
                 $data = new ArrayDataProvider ([
                                'allModels'=>$rows, 
                            ]);
                 $a_sql='';$s_sql='';$t_sql='';
                 
                  $a_sql=$findreport['a_sql'];
                  $s_sql=$findreport['s_sql'];
                  $t_sql=$findreport['t_sql'];
                  } catch (ErrorException $e) {

                  }
           
            }
            
        
      
    
       return $this->render('runreport4',[
        'datachart'=>$datachart,
        'data'=>$data,
        // 'rows'=>$rows,
         'columns'=>$columns,
         'reportname'=>$reportname,
        // 'aum'=>$aum,
         'r_table'=>$tableid,
         'provincecode'=>$provincecode,
         'hosname'=>$hosname,
         'cases'=>$cases,
         'percent'=>$percent,
        // 'datachart'=>$datachart,
          'a_sql'=>$a_sql,
          's_sql'=>$s_sql,
          't_sql'=>$t_sql,
          'defination'=>$defination,
          
       
        
        ]);
     
    }
     public function actionRunreport3(){
      $list_cup=$this->chkcup();
      if(in_array(Yii::$app->user->identity->hospcode, $list_cup, FALSE)||Yii::$app->user->identity->level!='02'
                  ||Yii::$app->user->identity->level!='01'){ //hos

         $para='';$s=null;
         $aum='';
         $chospcode=Yii::$app->user->identity->hospcode;
         $hosname='';
         $cases='';
         $tableid=$_GET['r_table'];
          $findreport = SysReport::find()->where(['report_id' => $tableid])->one();
          $report_docs=$findreport['docs'];
          $report_ref=$findreport['ref'];
          $reportname=$findreport['report_name'];  
          $table=$findreport['t_table'];
          $chart=$findreport['s_table'];
          $defination=$findreport['defination']; 
          $chartname='hosname';
          $provincecode=$this->chk_province();
           if(in_array(Yii::$app->user->identity->hospcode, $list_cup, FALSE)||Yii::$app->user->identity->level!='02'
                  ||Yii::$app->user->identity->level!='01'){ //hos
            $datachospital = (new \yii\db\Query())
              ->select('*')
              ->from('chospital')
              ->where('hoscode = :hoscode')
              ->addParams([':hoscode' => $chospcode])
              //->limit(50)
              ->all(\Yii::$app->dbhdc);
              $cuphos=$provincecode.$datachospital[0]['distcode'];
               $datachart = (new \yii\db\Query())
              ->select('*')
              ->from($chart)
              //->limit(10)
             ->where('distcode = :cuphos')
             ->addParams([':cuphos' => $cuphos])
             ->orderBy(['hospcode' => SORT_ASC,])
              ->all(\Yii::$app->db);
            }else{
        $subhos_list= Cmastercup::find()->select('hsub')->where('hmain=:mastercode', [':mastercode'=>$chospcode])->all();
         for($i=0;$i<sizeof($subhos_list);$i++){
                    $s[]=$subhos_list[$i]['hsub'];            
                }
                $parachart=$s; 
                 $datachart = (new \yii\db\Query())
                      ->select('*')
                      ->from($chart)
                      ->where(['hospcode'=> $parachart])
                      ->orderBy(['hospcode' => SORT_ASC,])
                      ->all(\Yii::$app->db);
            }


          try{
          
          $chart_y= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'y%'")->queryAll();
          $namechart_y=$chart_y[0]['Field'];
          $chart_total= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'total%'")->queryAll();
          $namechart_total=$chart_total[0]['Field'];
         $percent='';$cases='';$hosname='';
        for($i=0;$i<sizeof($datachart);$i++){
            $hosname[]=$datachart[$i][$chartname];            
            $cases[]=$datachart[$i][$namechart_y]*1;
            //$percent[]=$datachart[$i][$namechart_total]*1;
            $percent[]=floatval($datachart[$i]['percent']);
        }       
         
       
      $rows = (new \yii\db\Query())
              ->select('*')
              ->from($table)
              //->limit(10)
              ->where('hospcode = :chospcode')
              ->addParams([':chospcode' => $chospcode])
              ->all(\Yii::$app->db);

             } catch(\Exception $e){ 
                 throw new \yii\web\HttpException(405, 'SQL Error'); 
             } 

      $columns= Yii::$app->db->createCommand('SHOW FULL COLUMNS FROM '.$table)->queryAll();  
         $data = new ArrayDataProvider ([
                        'allModels'=>$rows,
                    ]);
          $a_sql='';$s_sql='';$t_sql='';
         try{
          $a_sql=$findreport['a_sql'];
          $s_sql=$findreport['s_sql'];
          $t_sql=$findreport['t_sql'];
          } catch (ErrorException $e) {

          }

         return $this->render('runreport3', [
          'data'=>$data,
        'rows'=>$rows,
        'columns'=>$columns,
        'reportname'=>$reportname,
        'aum'=>$aum,
        'r_table'=>$tableid,
        //'provincecode'=>$provincecode,
        'hosname'=>$hosname,
        'cases'=>$cases,
        'percent'=>$percent,
        'datachart'=>$datachart,
         'a_sql'=>$a_sql,
         's_sql'=>$s_sql,
         't_sql'=>$t_sql,
         'defination'=>$defination,
         'report_docs'=>$report_docs,
         'report_ref'=>$report_ref,
          ]);
       }//end ifhos

    }

     public function actionRunreport2()
    { 
      $list_cup=$this->chkcup();
       if(in_array(Yii::$app->user->identity->hospcode, $list_cup, TRUE)||Yii::$app->user->identity->level=='02'){ //cup
         $para='';
         $aum='';
         $chartwhere='';
         $hosname='';
         $cases='';
        
         $mastercode=Yii::$app->user->identity->hospcode;
         $mastertype=Yii::$app->user->identity->level;
        if (isset($_GET['r_table'])) {
        $tableid=$_GET['r_table'];
     $connection2 = Yii::$app->db;    
     $findreport = SysReport::find()->where(['report_id' => $tableid])->one();    
     $report_docs=$findreport['docs'];
      $report_ref=$findreport['ref'];
      }
      $reportname=$findreport['report_name'];
       $chartname='hosname';
      $defination=$findreport['defination'];
      $chart=$findreport['s_table'];    
      //$provincecode=$this->chk_province();
         if(!empty($_GET['ctambon'])){
           $s=$_GET['ctambon'];
           $table=$findreport['t_table'];
        }else{
           $table=$findreport['s_table'];
        }  
       if(Yii::$app->user->identity->level=='02'){
              $datachart = (new \yii\db\Query())
              ->select('*')
              ->from($chart)
              ->where(['distcode'=> $mastercode])
              ->orderBy(['hospcode' => SORT_ASC,])
              ->all(\Yii::$app->db);
              if(!empty($_GET['ctambon'])){
               $rows = (new \yii\db\Query())
                ->select('*')
                ->from($table)
                //->limit(10)            
                ->where(['hospcode'=> $s])
                ->orderBy(['hospcode' => SORT_ASC,])
                ->all(\Yii::$app->db);
              }else{
              $rows = (new \yii\db\Query())
              ->select('*')
              ->from($table)
              //->limit(10)            
              ->where(['distcode'=> $mastercode])
              ->orderBy(['hospcode' => SORT_ASC,])
              ->all(\Yii::$app->db);
             }
       }else{

         $subhos_list= Cmastercup::find()->select('hsub')->where('hmain=:mastercode', [':mastercode'=>$mastercode])->all();
         for($i=0;$i<sizeof($subhos_list);$i++){
                    $parachart[]=$subhos_list[$i]['hsub'];            
                }
             
           if(!empty($_GET['ctambon'])){$paratable=$_GET['ctambon']; }else{$paratable=$parachart;}
        
         $datachart = (new \yii\db\Query())
              ->select('*')
              ->from($chart)
              ->where(['hospcode'=> $parachart])
              ->orderBy(['hospcode' => SORT_ASC,])
              ->all(\Yii::$app->db);

              $rows = (new \yii\db\Query())
              ->select('*')
              ->from($table)
              //->limit(10)            
              ->where(['hospcode'=> $paratable])
              ->orderBy(['hospcode' => SORT_ASC,])
              ->all(\Yii::$app->db);
            }//endiftype
      
     
       $chart_y= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'y%'")->queryAll();
       $namechart_y=$chart_y[0]['Field'];
       $chart_total= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'total%'")->queryAll();
       $namechart_total=$chart_total[0]['Field'];
         $percent='';$cases='';$hosname='';
        for($i=0;$i<sizeof($datachart);$i++){
            $hosname[]=$datachart[$i][$chartname];            
            $cases[]=$datachart[$i][$namechart_y]*1;
            //$percent[]=$datachart[$i][$namechart_total]*1;
            $percent[]=floatval($datachart[$i]['percent']);
        }  

     

      $columns= Yii::$app->db->createCommand('SHOW FULL COLUMNS FROM '.$table)->queryAll();  
        
         $data = new ArrayDataProvider ([
                        'allModels'=>$rows,
                    ]);
         $a_sql='';$s_sql='';$t_sql='';
         try{
          $a_sql=$findreport['a_sql'];
          $s_sql=$findreport['s_sql'];
          $t_sql=$findreport['t_sql'];
          } catch (ErrorException $e) {

          }
    
       return $this->render('runreport2',[
        'datachart'=>$datachart,
        'data'=>$data,
        // 'rows'=>$rows,
         'columns'=>$columns,
         'reportname'=>$reportname,
        // 'aum'=>$aum,
         'r_table'=>$tableid,
        // 'provincecode'=>$provincecode,
         'hosname'=>$hosname,
         'cases'=>$cases,
         'percent'=>$percent,
        // 'datachart'=>$datachart,
          'a_sql'=>$a_sql,
          's_sql'=>$s_sql,
          't_sql'=>$t_sql,
          'defination'=>$defination,
          'mastercode'=>$mastercode,
          'mastertype'=>$mastertype,
          'report_docs'=>$report_docs,
         'report_ref'=>$report_ref,
        
        ]);
      }else{
         $url=Yii::$app->urlManager->createUrl(['report/report/index']);
           Yii::$app->getResponse()->redirect($url);
      }
    }
  
    public function actionRunreport1()
    { 
       if(Yii::$app->user->identity->level==1 || Yii::$app->user->identity->level==2){
         $para='';
         $aum='';
         $chartwhere='';
         $hosname='';
         $cases='';

        if (isset($_GET['r_table'])) {
        $tableid=$_GET['r_table'];
     $connection2 = Yii::$app->db;
    
     $findreport = SysReport::find()->where(['report_id' => $tableid])->one();
     
      }
      $report_docs=$findreport['docs'];
      $report_ref=$findreport['ref'];
      $reportname=$findreport['report_name'];
      $defination=$findreport['defination'];    
      $provincecode=$this->chk_province();
      if(empty($_GET['campur'])&& empty($_GET['ctambon'])){
        $aum='ยังไม่เลือกทั้งสอง';
        $table=$findreport['a_table'];
        $chart=$findreport['a_table'];
        $chartname='ampurname';
         try{
           $datachart = (new \yii\db\Query())
              ->select('*')
              ->from($chart)
              ->orderBy(['distcode' => SORT_ASC,])
              ->all(\Yii::$app->db);
          $chart_y= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'y%'")->queryAll();
          $namechart_y=$chart_y[0]['Field'];
          $chart_total= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'total%'")->queryAll();
          $namechart_total=$chart_total[0]['Field'];
         $percent='';$cases='';$hosname='';
        for($i=0;$i<sizeof($datachart);$i++){
            $hosname[]=$datachart[$i][$chartname];            
            $cases[]=$datachart[$i][$namechart_y]*1;
            //$percent[]=$datachart[$i][$namechart_total]*1;
            $percent[]=floatval($datachart[$i]['percent']);
        }       
         
       
      $rows = (new \yii\db\Query())
              ->select('*')
              ->from($table)
              ->orderBy(['distcode' => SORT_ASC,])
              ->all(\Yii::$app->db);

             } catch(\Exception $e){ 
                 throw new \yii\web\HttpException(405, 'SQL Error'); 
             } 
      }elseif (!empty($_GET['campur'])&& !empty($_GET['ctambon'])) {
        $aum=$_GET['campur'].' | '.$_GET['ctambon'];
        $table=$findreport['t_table'];
        $para=$_GET['ctambon'];
        $chart=$findreport['s_table'];
        $chartwhere=$_GET['campur'];
        $chartname='hosname';
         try{
           $datachart = (new \yii\db\Query())
              ->select('*')
              ->from($chart)
              //->limit(10)
             
              ->where('distcode = :chartwhere')
              ->orderBy(['hospcode' => SORT_ASC,])
             ->addParams([':chartwhere' => $chartwhere])
              ->all(\Yii::$app->db);
          $chart_y= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'y%'")->queryAll();
          $namechart_y=$chart_y[0]['Field'];
          $chart_total= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'total%'")->queryAll();
          $namechart_total=$chart_total[0]['Field'];
         $percent='';$cases='';$hosname='';
        for($i=0;$i<sizeof($datachart);$i++){
            $hosname[]=$datachart[$i][$chartname];            
            $cases[]=$datachart[$i][$namechart_y]*1;
            //$percent[]=$datachart[$i][$namechart_total]*1;
            $percent[]=floatval($datachart[$i]['percent']);
        }       
         
       
      $rows = (new \yii\db\Query())
              ->select('*')
              ->from($table)
              //->limit(10)            
              ->where('hospcode = :para')
             ->addParams([':para' => $para])
             ->orderBy(['hospcode' => SORT_ASC,])
              ->all(\Yii::$app->db);

             } catch(\Exception $e){ 
                 throw new \yii\web\HttpException(405, 'SQL Error'); 
             } 
      } elseif (!empty($_GET['campur'])) {
        $aum=$_GET['campur'];
        $table=$findreport['s_table'];
        $para=$_GET['campur'];
        $chart=$findreport['s_table'];
        $chartwhere=$_GET['campur'];
        $chartname='hosname';
           try{
           $datachart = (new \yii\db\Query())
              ->select('*')
              ->from($chart)
              ->where('distcode = :chartwhere')
              ->orderBy(['hospcode' => SORT_ASC,])
             ->addParams([':chartwhere' => $chartwhere])
              ->all(\Yii::$app->db);
          $chart_y= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'y%'")->queryAll();
          $namechart_y=$chart_y[0]['Field'];
          $chart_total= Yii::$app->db->createCommand('SHOW COLUMNS FROM '.$chart." WHERE Field LIKE 'total%'")->queryAll();
          $namechart_total=$chart_total[0]['Field'];
         $percent='';$cases='';$hosname='';
        for($i=0;$i<sizeof($datachart);$i++){
            $hosname[]=$datachart[$i][$chartname];            
            $cases[]=$datachart[$i][$namechart_y]*1;
            //$percent[]=$datachart[$i][$namechart_total]*1;
            $percent[]=floatval($datachart[$i]['percent']);
        }       
         
       
      $rows = (new \yii\db\Query())
              ->select('*')
              ->from($table)
              //->limit(10)            
              ->where('distcode = :para')
             ->addParams([':para' => $para])
             ->orderBy(['hospcode' => SORT_ASC,])
              ->all(\Yii::$app->db);

             } catch(\Exception $e){ 
                 throw new \yii\web\HttpException(405, 'SQL Error'); 
             } 
      }else{
        $aum='';
      } 

     

      $columns= Yii::$app->db->createCommand('SHOW FULL COLUMNS FROM '.$table)->queryAll();  
      $test_r=null;
      $case=['hospcode','pid','cid','hn','distcode','hmain'];
        foreach ($columns as  $f) {
          $sort[] =  $f['Field'];
         //  foreach ($rows as  $ff) {
         //   # if(in_array($ff[$f['Field']],$case)==0){
         //      if(is_numeric ($ff[$f['Field']])){
         //        $test_r[] = intval($ff[$f['Field']]);
         //      }else{
         //        $test_r[] = $ff[$f['Field']];
         //      }//end is_numeric
         // #   }//endin_array
            
         //  }
        }


         $data = new ArrayDataProvider ([
                        'allModels'=>$rows,
                        'sort' => [
                          'attributes' => $sort,
                        ],
                    ]);
         $a_sql='';$s_sql='';$t_sql='';
         try{
          $a_sql=$findreport['a_sql'];
          $s_sql=$findreport['s_sql'];
          $t_sql=$findreport['t_sql'];
          } catch (ErrorException $e) {

          }
    
       return $this->render('runreport',[
       # 'test_r'=>$test_r,
        'data'=>$data,
        'rows'=>$rows,
        'columns'=>$columns,
        'reportname'=>$reportname,
        'aum'=>$aum,
        'r_table'=>$tableid,
        'provincecode'=>$provincecode,
        'hosname'=>$hosname,
        'cases'=>$cases,
        'percent'=>$percent,
        'datachart'=>$datachart,
         'a_sql'=>$a_sql,
         's_sql'=>$s_sql,
         't_sql'=>$t_sql,
         'defination'=>$defination,
         'report_docs'=>$report_docs,
         'report_ref'=>$report_ref,
        
        ]);
      }
    }

  






}
