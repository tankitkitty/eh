<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model backend\models\SysReport */

$this->title = $model->report_name;
$this->params['breadcrumbs'][] = ['label' => 'รายงานในระบบ', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="sys-report-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->report_id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->report_id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'report_id',
            'report_name:ntext',
            'a_table',
            's_table',
            't_table',
            't_sql:ntext',
            's_sql:ntext',
            'a_sql:ntext',
            #'active',
            [  
                'label' => 'active',
                'value' => $model->active==1?'เปิดการทำงาน':'ปิดการทำงาน',
            ],
            'aname',
            'bname',
            'notice:ntext',
            'report_procedure',
            'menu_group',
            'pageview',
            'defination:ntext',
            'docs:ntext',
            'ref',
        ],
    ]) ?>

</div>
