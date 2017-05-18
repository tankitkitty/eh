<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model backend\models\SysReport */

$this->title = 'แก้ไขรายงาน: ' . ' ' . $model->report_name;
$this->params['breadcrumbs'][] = ['label' => 'รายงานในระบบ', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->report_name, 'url' => ['view', 'id' => $model->report_id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="sys-report-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
