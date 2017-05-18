<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel backend\models\SysReportSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'รายงานในระบบ';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="sys-report-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('เพิ่มรายงานในระบบ', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'report_id',
            'report_name:ntext',
             'menu_group',
            'a_table',
            's_table',
            't_table',
            // 't_sql:ntext',
            // 's_sql:ntext',
            // 'a_sql:ntext',
            // 'active',
            // 'aname',
            // 'bname',
            // 'notice:ntext',
            // 'report_procedure',
            
            // 'pageview',
             'defination:ntext',
            // 'docs:ntext',
            // 'ref',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>

</div>
