<?php

namespace backend\controllers;
use Yii;
use yii\web\Controller;
use yii\db\Query;
use yii\db\Command;
use frontend\modules\report\model\SysConfig;
use yii\base\ErrorException;
use mdm\admin\components\AccessControl;
use yii\filters\VerbFilter;
use frontend\modules\setting\model\Chospital;


class SettingController extends Controller
{
  public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
            ],

            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }
    public function actionIndex()
    {
       

        return $this->render('index');
    }
    public function actionGen(){
    	try{
    		ini_set('max_execution_time', 600); 
    	 // ini_set('memory_limit','10240M');
      //     ini_set('memory_limit','2048M');
    	
    	 $model = SysConfig::find()->select('province_config')->one();       
        $province = $model['province_config'];
        $provcup=$province.'00';
        $connection = Yii::$app->db;
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
         $datatype = (new \yii\db\Query())
              ->select('*')
              ->from('chostype')
              //->limit(50)
              ->all(\Yii::$app->dbhdc);
           for($i=0;$i<sizeof($datatype);$i++){    
             $hostype[]=$datatype[$i]['hostypecode']; 
                }    
          $datahos = (new \yii\db\Query())
              ->select('*')
              ->from('chospital')          
              ->where('provcode = :province')
              ->andWhere(['IN', 'hostype', $hostype])
              ->addParams([':province' => $province])
               //->addParams([':hostype' => $hostype])
              //->limit(50)
              ->all(\Yii::$app->dbhdc);

                for($i=0;$i<sizeof($datahos);$i++){
              if($datahos[$i]['hostype']=='02'){
                		$hoscode[]=$datahos[$i]['provcode'].$datahos[$i]['distcode'];  
                	}else{
            $hoscode[]=$datahos[$i]['hoscode']; 
            		}
          if(in_array($datahos[$i]['hoscode'], $listmaincup, TRUE)){ //คัฟโรงพยาบาล
              $hosuser2[]=$datahos[$i]['hoscode'];
              $hostypeuser2[]=$datahos[$i]['hostype'];
                }
            $user[]='u'.$datahos[$i]['hoscode'];
            $pass[]='p'.$datahos[$i]['hoscode'];
            $passhas[]= Yii::$app->getSecurity()->generatePasswordHash($pass[$i]);
           
            $connection->createCommand()
    					->insert('user', [
    							'username' => $user[$i],
    							'email'=>'u'.$hoscode[$i].'@moph.com',
    							'password_hash' => $passhas[$i],
    							'auth_key'=>'CvQIwgoCxDVegOUcraIe8zqQZ1tPu8l8',
    							'confirmed_at'=>'1452153072',
    							'created_at'=>'1452153072',
    							'updated_at'=>'1452153072',
    							'level'=>$datahos[$i]['hostype'],
    							'hospcode'=>$hoscode[$i],
    							])
    					->execute();

       		 } //endfor
           
           //createhospital user2 preview in hospital

            for($i=0;$i<sizeof($hosuser2);$i++){   
              $connection->createCommand()
                ->insert('user', [
                    'username' => 'uh'.$hosuser2[$i],
                    'email'=>'uh'.$hosuser2[$i].'@moph.com',
                    'password_hash' => Yii::$app->getSecurity()->generatePasswordHash('ph'.$hosuser2[$i]),
                    'auth_key'=>'CvQIwgoCxDVegOUcraIe8zqQZ1tPu8l8',
                    'confirmed_at'=>'1452153072',
                    'created_at'=>'1452153072',
                    'updated_at'=>'1452153072',
                    'level'=>'h'.$hostypeuser2[$i],
                    'hospcode'=>$hosuser2[$i],
                    ])
                ->execute();
                }   
                //endcreatehospital user2
         
             //set rbac auth_assignment
              $datauser = (new \yii\db\Query())
              ->select('id, level, hospcode')
              ->from('user')
              ->where('hospcode != 1111')          
               //->addParams([':hostype' => $hostype])
              //->limit(50)
              ->all(\Yii::$app->db);
               for($i=0;$i<sizeof($datauser);$i++){   
                 if((in_array($datauser[$i]['hospcode'], $listmaincup, TRUE)
                  &&substr($datauser[$i]['level'], 0, 1)!='h')||$datauser[$i]['level']=='02'){ 
                   $item_name='ผู้ดูแลระบบระดับ cup';
                   $created_at='1452505250';
                 }else if($datauser[$i]['level']=='01'){
                    $item_name='ผู้ดูแลระบบ';
                    $created_at='1452508482';
                 }else  if(in_array($datauser[$i]['hospcode'], $listmaincup, FALSE)||$datauser[$i]['level']!='02'
                  ||$datauser[$i]['level']!='01'){
                   $item_name='หน่วยบริการ';
                   $created_at='1452506223';
                 }
                  $connection->createCommand()
                    ->insert('auth_assignment', [
                        'item_name' => $item_name,
                        'user_id'=>$datauser[$i]['id'],
                        'created_at' => $created_at,
                        ])
                    ->execute();
                }   

            //end set rbac

	       		} catch (\yii\db\Exception $e) {
				     throw new \yii\web\HttpException(405, 'SQL Error or user duplicate entry'.$e); 
				}     
    	
    	 return $this->render('gen',[
        'listmaincup'=>$listmaincup,
    	 	//'pass'=>$datahos,
    	 	// 'passhas'=>$passhas,
    	 	// 'user'=>$user
    	 	]);
    }

    public function actionSysconfig(){

      return $this->render('sysconfig');
    }
    public function actionSetconfig(){
      $msg='';
      try{
        if(Yii::$app->request->post()){
          $prov=$_POST['prov'];

           $provname = (new \yii\db\Query())
              ->select('*')
              ->from('chospital')
               ->where('hostype=:type', [':type'=>'01'])
             ->andWhere([
            'provcode' => $prov,
            ])
              ->limit(1)
              ->all(\Yii::$app->dbhdc);
          if(!empty($provname)){
          $modelcon = SysConfig::find()->select('*')->one();    
         if(count($modelcon)==0){
          $model = new SysConfig;
      $model->province_config = $prov;
      $model->prov_name = $provname[0]['hosname'];
      $model->save();  // equivalent to $model->insert();
          }else{
            $msg='โปรแกรมถูกตั้งค่าไว้แล้ว';
          }
        }else{
           $msg='กรุณาเลือกหน่วยงาน';         
        }
      }//endif
      
       } catch(\yii\db\Exception $e){ 
              throw new \yii\web\HttpException(405, 'SQL Error'); 

       }
      return $this->render('setconfig',['msg'=>$msg]);
    }

}
