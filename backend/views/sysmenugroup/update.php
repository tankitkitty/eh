<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model backend\models\SysMenuGroup */

$this->title = 'แก้ไขกลุ่มรายงาน: ' . ' ' . $model->muname;
$this->params['breadcrumbs'][] = ['label' => 'จัดการกลุ่มรายงาน', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->muname, 'url' => ['view', 'id' => $model->muid]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="sys-menu-group-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
