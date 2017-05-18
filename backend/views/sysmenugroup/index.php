<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel backend\models\SysMenuGroupSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'จัดการกลุ่มรายงาน';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="sys-menu-group-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('สร้างกลุ่มรายงาน', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'muid',
            'mucode',
            'muname',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>

</div>
