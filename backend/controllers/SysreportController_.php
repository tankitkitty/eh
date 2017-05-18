<?php

namespace backend\controllers;

use Yii;
use backend\models\SysReport;
use backend\models\SysReportSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

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
     * @param integer $report_id
     * @param string $id
     * @return mixed
     */
    public function actionView($report_id, $id)
    {
        return $this->render('view', [
            'model' => $this->findModel($report_id, $id),
        ]);
    }

    /**
     * Creates a new SysReport model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new SysReport();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'report_id' => $model->report_id, 'id' => $model->id]);
        } else {
            return $this->render('create', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing SysReport model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $report_id
     * @param string $id
     * @return mixed
     */
    public function actionUpdate($report_id, $id)
    {
        $model = $this->findModel($report_id, $id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'report_id' => $model->report_id, 'id' => $model->id]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing SysReport model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $report_id
     * @param string $id
     * @return mixed
     */
    public function actionDelete($report_id, $id)
    {
        $this->findModel($report_id, $id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the SysReport model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $report_id
     * @param string $id
     * @return SysReport the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($report_id, $id)
    {
        if (($model = SysReport::findOne(['report_id' => $report_id, 'id' => $id])) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
