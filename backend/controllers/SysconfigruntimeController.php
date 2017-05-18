<?php

namespace backend\controllers;

use Yii;
use backend\models\Sysconfigruntime;
use backend\models\SysconfigruntimeSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * SysconfigruntimeController implements the CRUD actions for Sysconfigruntime model.
 */
class SysconfigruntimeController extends Controller
{
    public function behaviors()
    {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['post'],
                ],
            ],
        ];
    }

    /**
     * Lists all Sysconfigruntime models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new SysconfigruntimeSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Sysconfigruntime model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Sysconfigruntime model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionSysruntime(){
        $request = Yii::$app->request;
        if($request->post('Sysconfigruntime')){
            $Sysconfigruntime_arr=$request->post('Sysconfigruntime');
            $s_time=$Sysconfigruntime_arr['s_runtime'];
            $e_time=$Sysconfigruntime_arr['e_runtime'];
        }
        $model = new Sysconfigruntime();
         $sys=$model->find()
                    ->where(['run_gid' => 'root'])
                    ->one();
       if($model->load(Yii::$app->request->post())){
         if(count($sys)>0){
           // $model->e_runtime = 'yii2@framework.com';
             Yii::$app->db->createCommand()
             ->update('sys_config_runtime', [
                's_runtime' => $s_time,
                'e_runtime' => $e_time,
                ], 'run_gid =\'root\' ')
             ->execute();
             }else{
            $model->run_gid = 'root';
             $model->save();
             }
        }//post
       
        return $this->render('sysruntime', [
                'model' => $model,
                'sys'=>$sys
            ]);
    }
    public function actionCreate()
    {
        $model = new Sysconfigruntime();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->run_id]);
        } else {
            return $this->render('create', [
                'model' => $model,
            ]);
        }
         
    }

    /**
     * Updates an existing Sysconfigruntime model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        if($model->run_gid=='root'){
             return $this->redirect(['sysconfigruntime/sysruntime', 'id' => $model->run_id]);
        }

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->run_id]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing Sysconfigruntime model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the Sysconfigruntime model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Sysconfigruntime the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Sysconfigruntime::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
