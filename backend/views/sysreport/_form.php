<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\widgets\FileInput;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
use backend\models\SysMenuGroup;

/* @var $this yii\web\View */
/* @var $model backend\models\SysReport */
/* @var $form yii\widgets\ActiveForm */


// if($_POST){
// var_dump($_POST['SysReport']);
// }
$Menugroup=SysMenuGroup::find()->all();
$menu_group_list=ArrayHelper::map($Menugroup,'mucode','muname');

?>

<div class="sys-report-form">

    <?php $form = ActiveForm::begin(['options' => ['enctype' => 'multipart/form-data']]); ?>
    <?= $form->errorSummary($model); ?>


    <?= $form->field($model, 'ref')->hiddenInput()->label(false); ?>
    <?= $form->field($model, 'menu_group')->dropDownList(
        $menu_group_list, 
            [
             'id'=>'menugroup',
             'prompt'=>'เลือกหัวข้อหลัก']);?>
    
    <?= $form->field($model, 'report_name')->textarea(['rows' => 6]) ?>

    <?= $form->field($model, 'a_table')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 's_table')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 't_table')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 't_sql')->textarea(['rows' => 6]) ?>

    <?= $form->field($model, 's_sql')->textarea(['rows' => 6]) ?>

    <?= $form->field($model, 'a_sql')->textarea(['rows' => 6]) ?>

    
     <?= $form->field($model, 'active')
        ->dropDownList(
            [1=>'เปิดการทำงาน',2=>'ปิดการทำงาน'],           // Flat array ('id'=>'label')
            ['prompt'=>'เลือก']    // options
        );?>

 <!--    <?= $form->field($model, 'aname')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'bname')->textInput(['maxlength' => true]) ?> -->

    <?= $form->field($model, 'notice')->textarea(['rows' => 6]) ?>

    <?= $form->field($model, 'report_procedure')->textInput(['maxlength' => true]) ?>

    

    <?= $form->field($model, 'pageview')->textInput() ?>

    <?= $form->field($model, 'defination')->textarea(['rows' => 6]) ?>
     <?= $form->field($model, 'docs[]')->widget(FileInput::classname(), [
    'name' => 'filename',
    'options' => [
        //'accept' => 'image/*',
        'multiple' => true
    ],
    'pluginOptions' => [
        'initialPreview'=>$model->initialPreview($model->docs,'docs','file'),
        'initialPreviewConfig'=>$model->initialPreview($model->docs,'docs','config'),
        'allowedFileExtensions'=>['pdf','doc','docx','xls','xlsx'],
        'showPreview' => true,
        'showCaption' => true,
        'showRemove' => true,
        'showUpload' => false,
        'overwriteInitial'=>false
     ]
    ]); ?>
    

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'Create' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
