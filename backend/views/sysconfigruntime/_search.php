<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model backend\models\SysconfigruntimeSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="sysconfigruntime-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'run_id') ?>

    <?= $form->field($model, 'run_gid') ?>

    <?= $form->field($model, 'run_rid') ?>

    <?= $form->field($model, 's_runtime') ?>

    <?= $form->field($model, 'e_runtime') ?>

    <?php // echo $form->field($model, 'fiscal_year') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
