<?php

namespace backend\controllers;

use Yii;
use backend\models\SysReport;
use backend\models\SysReportSearch;

use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

use yii\helpers\Url;
use yii\helpers\html;
use yii\web\UploadedFile;
use yii\helpers\BaseFileHelper;
use yii\helpers\Json;
use yii\helpers\ArrayHelper;

/**
 * SysreportController implements the CRUD actions for SysReport model.
 */
class SysreportController extends Controller
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
     * Lists all SysReport models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new SysReportSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single SysReport model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }
    // private function mgroup($id){
    //     $menu_group_list=null;
    //     #$model = new SysMenuGroup();
    //  if($id=='all'){
    //  $model_group = SysMenuGroup::find()->all();
    //  }else{
    //     $model_group = SysMenuGroup::find()
    //     ->where('mucode = :mucode', [':mucode' => $id])
    //     ->one();
    //  }//
    //  return $model_group;
    // } 

    /**
     * Creates a new SysReport model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
   
     public function actionCreate()
    {
        $model = new SysReport();
        $request = Yii::$app->request;
        $post_docs = $request->post('docs');
         if ($model->load(Yii::$app->request->post()) ) {
          
            $UploadedFiles = UploadedFile::getInstances($model,'docs');
             if($UploadedFiles!=null){
            $this->CreateDir($model->ref);
            $model->docs = $this->uploadMultipleFile($model);
             }else{
                $model->ref='';
                $model->docs='';
             }
            if($model->save()){
                 return $this->redirect(['view', 'id' => $model->report_id]);
            }

        } else {
             $model->ref = substr(Yii::$app->getSecurity()->generateRandomString(),10);
        }

       # $model_group = $this->mgroup('all');
       
            return $this->render('create', [
                'model' => $model,
                #'model_group' =>$model_group,
                ]);
        
    }

    /**
     * Updates an existing SysReport model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    // public function actionUpdate($id)
    // {
    //     $model = $this->findModel($id);

    //     if ($model->load(Yii::$app->request->post()) && $model->save()) {
    //         return $this->redirect(['view', 'id' => $model->report_id]);
    //     } else {
    //         return $this->render('update', [
    //             'model' => $model,
    //         ]);
    //     }
    // }
     public function actionUpdate($id)
    {
        $model = $this->findModel($id);

       # $tempCovenant = $model->covenant;
        $tempDocs     = $model->docs;
        if ($model->load(Yii::$app->request->post())) {
            if($model->ref==NULL){
            $model->ref = substr(Yii::$app->getSecurity()->generateRandomString(),10);
             $this->CreateDir($model->ref);
            }
            //$this->CreateDir($model->ref);
           # $model->covenant = $this->uploadSingleFile($model,$tempCovenant);
            $model->docs = $this->uploadMultipleFile($model,$tempDocs);

            if($model->save()){
                return $this->redirect(['view', 'id' => $model->report_id]);
            }
        }///

         return $this->render('update', [
            'model' => $model
        ]);

       
    }

    /**
     * Deletes an existing SysReport model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
 
    public function actionDelete($id)
    {   
        //$ref=$this->findModel($ref);
        //$this->findModel($id)->delete();
         // unlink("path/to/filetest.txt");
         // rmdir("c:dd"); //ลบไดเรกทอรีบน Windows
        $delete=false;
        $model = $this->findModel($id);
        $filePath = SysReport::getUploadPath().$model->ref.'/';
        $files =  Json::decode($model->{'docs'});
       if(!empty($files)){
        foreach(array_keys($files) as $key){
                @unlink($filePath.$key);
                @rmdir($filePath.'/thumbnail');
                @rmdir($filePath);
            }
            
        if(!file_exists($filePath)){
             $this->findModel($id)->delete();
        }
        }else{//nofile
             $this->findModel($id)->delete();
        }
        return $this->redirect(['index']);
    }

    /**
     * Finds the SysReport model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return SysReport the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = SysReport::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
     private function CreateDir($folderName){
        if($folderName != NULL){
            $basePath = SysReport::getUploadPath();
            
            if(BaseFileHelper::createDirectory($basePath.$folderName,0777)){
                chmod($basePath.$folderName, 0777);
                BaseFileHelper::createDirectory($basePath.$folderName.'/thumbnail',0777);
                chmod($basePath.$folderName.'/thumbnail', 0777);
            }
            
        }
        return;
    }

    private function removeUploadDir($dir){
        BaseFileHelper::removeDirectory(SysReport::getUploadPath().$dir);
    }
     private function uploadMultipleFile($model,$tempFile=null){
             $files = [];
             $json = '';
             $tempFile = Json::decode($tempFile);
             $UploadedFiles = UploadedFile::getInstances($model,'docs');
             if($UploadedFiles!==null){
                foreach ($UploadedFiles as $file) {
                    try {   $oldFileName = $file->basename.'.'.$file->extension;
                            $newFileName = md5($file->basename.time()).'.'.$file->extension;
                            $file->saveAs(Yii::getAlias('@backend').'/web/'.SysReport::UPLOAD_FOLDER.'/'.$model->ref.'/'.$newFileName);
                            $files[$newFileName] = $oldFileName ;
                    } catch (Exception $e) {
                       
                    }
                }
                $json = json::encode(ArrayHelper::merge($tempFile,$files));
             }else{
                $json = $tempFile;
             }          
            return $json;
    }
     public function actionDownload($id,$file,$file_name){
        $model = $this->findModel($id);
         if(!empty($model->ref) ){
                Yii::$app->response->sendFile($model->getUploadPath().'/'.$model->ref.'/'.$file,$file_name);
        }else{
            $this->redirect(['/sysreport/view','id'=>$id]);
        }
    }
     public function actionDeletefile($id,$field,$fileName){
        $status = ['success'=>false];
        if(in_array($field, ['docs','covenant'])){
            $model = $this->findModel($id);
            $files =  Json::decode($model->{$field});
            if(array_key_exists($fileName, $files)){
                if($this->deleteFile('file',$model->ref,$fileName)){
                    $status = ['success'=>true];
                    unset($files[$fileName]);
                    $model->{$field} = Json::encode($files);
                    $model->save();
                }
            }
        }
        echo json_encode($status);
    }

    private function deleteFile($type='file',$ref,$fileName){
        if(in_array($type, ['file','thumbnail'])){
            if($type==='file'){
               $filePath = SysReport::getUploadPath().$ref.'/'.$fileName;
            } else {
               $filePath = SysReport::getUploadPath().$ref.'/thumbnail/'.$fileName;
            }
            @unlink($filePath);
            return true;
        }
        else{
            return false;
        }
    }
}
