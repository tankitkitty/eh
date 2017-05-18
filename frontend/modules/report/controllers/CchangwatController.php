<?php


namespace frontend\modules\report\controllers;
use Yii;
use frontend\modules\report\model\Cchangwat;
use frontend\modules\report\model\CchangwatSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use frontend\modules\report\model\Ctambon;
use frontend\modules\report\model\Campur;
use frontend\modules\report\model\Chospital;
use frontend\modules\report\model\SysConfig;


/**
 * CchangwatController implements the CRUD actions for Cchangwat model.
 */
class CchangwatController extends Controller
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
     * Lists all Cchangwat models.
     * @return mixed
     */

 
    public function actionLoadtambon($id=null){
        //$id คือ รหัส pk ของอำเภอ
        $tambons = Ctambon::find()
            ->where(['ampurcode'=>$id,'flag_status'=>'0'])
            ->orderBy('tambonname')
            ->all();
        $option = '<option value="">-กรุณาเลือกหน่วยบริการ-</option>';
        foreach($tambons as $d){
            $option .= '<option value="'.$d->tamboncode.'">'
                .$d->tambonname.'</option>';
        }
        echo $option;
    }
    public function actionLoadhospital($id=null){
        //$id คือ รหัส pk ของอำเภอ
        //h.hostype IN('03','07') AND CONCAT(h.provcode,h.distcode)='7307'
        $tambons = Chospital::find()
            ->where('CONCAT(provcode,distcode)=:pcu', [':pcu'=>$id])
            ->andWhere([
            'hostype' => ['03','04','05','06','07','08','12','13','15','18'],
            ])
            //->addParams([':pcu' => $id,':status' => '03'])
            ->orderBy('hoscode')
            ->all();
        $option = '<option value="">-กรุณาเลือกหน่วยบริการ-</option>';
        foreach($tambons as $d){
            $option .= '<option value="'.$d->hoscode.'">'
                .$d->hosname.'</option>';
        }
        echo $option;
    }
    public function actionIndex()
    {
        $searchModel = new CchangwatSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Cchangwat model.
     * @param string $id
     * @return mixed
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Cchangwat model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Cchangwat();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->changwatcode]);
        } else {
            return $this->render('create', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing Cchangwat model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param string $id
     * @return mixed
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->changwatcode]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing Cchangwat model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param string $id
     * @return mixed
     */
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the Cchangwat model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param string $id
     * @return Cchangwat the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Cchangwat::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
