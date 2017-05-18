<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model backend\models\SysReportSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="sys-report-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'report_id') ?>

    <?= $form->field($model, 'report_name') ?>

    <?= $form->field($model, 'a_table') ?>

    <?= $form->field($model, 's_table') ?>

    <?= $form->field($model, 't_table') ?>

    <?php // echo $form->field($model, 't_sql') ?>

    <?php // echo $form->field($model, 's_sql') ?>

    <?php // echo $form->field($model, 'a_sql') ?>

    <?php // echo $form->field($model, 'active') ?>

    <?php // echo $form->field($model, 'aname') ?>

    <?php // echo $form->field($model, 'bname') ?>

    <?php // echo $form->field($model, 'notice') ?>

    <?php // echo $form->field($model, 'report_procedure') ?>

    <?php // echo $form->field($model, 'menu_group') ?>

    <?php // echo $form->field($model, 'pageview') ?>

    <?php // echo $form->field($model, 'defination') ?>

    <?php // echo $form->field($model, 'docs') ?>

    <?php // echo $form->field($model, 'ref') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
