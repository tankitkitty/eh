<?php

namespace backend\controllers;

use Yii;
use backend\models\SysReport;
use backend\models\SysReportSearch;

class RunprocessController extends \yii\web\Controller
{
    public function actionIndex()
    {
    	$searchModel = new SysReportSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
        
    }

    public function actionCallprocess(){
    	try{
    	$request = Yii::$app->request;
    	if ($request->isPost) { 
    		$report_procedure = $request->post('id');
    	 }
    	  $sql =  ' CALL sys_runprocess_one (:report_procedure)' ;
            
            $command = Yii::$app->db->createCommand($sql);
            $command->bindParam(":report_procedure", $report_procedure);
            
            $list = $command->execute();
    	
    	#$procedures=
    	# Yii::$app->db->createCommand("CALL sys_runprocess_one('".$report_procedure."');")->queryone();
    	    } catch(\yii\db\Exception $e){ 
              throw new \yii\web\HttpException(405, 'การประมวลผลมีปัญหา กรุณาตรวจสอบที่ databases'); 
        } 
    	   return $this->render('runprocess', [
            'procedures' => $list,
           
        ]);
    }

}
