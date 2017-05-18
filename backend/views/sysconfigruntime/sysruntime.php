<?php

use yii\helpers\Html;
use yii\helpers\Url;
use kartik\datecontrol\Module;
use kartik\datecontrol\DateControl;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model backend\models\Sysconfigruntime */

$this->title = ' ตั้งค่าการประมวลผล';
$this->params['breadcrumbs'][] = ['label' => 'ตั้งค่าการประมวลผล', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>



    <h1><?= Html::encode($this->title) ?></h1>
<div class="sysconfigruntime-form">
  <div class="btn-group btn-group-justified">
  <a href="<?=Url::to(['sysconfigruntime/sysruntime']);?>" class="btn btn-default active">ตั้งค่าระบบหลัก</a>
  <?php if(!Yii::$app->request->get('id')){ ?>
  <a href="<?=Url::to(['sysconfigruntime/create']);?>" id='hide' class="btn btn-default">ตั้งค่าแบบเฉพาะ</a>
  <?php } ?>
</div>

 <?php 
 $form = ActiveForm::begin();
	//var_dump($sys);

#var_dump(Yii::$app->request->post('Sysconfigruntime'));
  ?>
    <?= 
     $form->field($model, 's_runtime')->widget(DateControl::classname(), [
    'displayFormat' => 'php:d-m-Y',
    'type'=>DateControl::FORMAT_DATE
]);
    ?>
    <?= 
     $form->field($model, 'e_runtime')->widget(DateControl::classname(), [
    'displayFormat' => 'php:d-m-Y',
    'type'=>DateControl::FORMAT_DATE
]);
    ?>    

 <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'บันทึก' : 'บันทึก', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>
<?php ActiveForm::end(); ?>
</div>
