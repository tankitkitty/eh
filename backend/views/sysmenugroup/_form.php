<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model backend\models\SysMenuGroup */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="sys-menu-group-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'mucode')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'muname')->textInput(['maxlength' => true]) ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'สร้าง' : 'แก้ไข', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
