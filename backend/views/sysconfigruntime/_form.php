<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

use yii\helpers\ArrayHelper;
use yii\helpers\BaseUrl;
use yii\helpers\Url;
use backend\models\SysMenuGroup;

use kartik\datecontrol\Module;
use kartik\datecontrol\DateControl;

/* @var $this yii\web\View */
/* @var $model backend\models\Sysconfigruntime */
/* @var $form yii\widgets\ActiveForm */
 try {

     $group = $_GET['group'];
    # $piname = $_GET['piname'];
      $item_list = ArrayHelper::map( SysReport::find()
            ->where(['menu_group'=>$group])
            ->orderBy('report_id')
            ->all(),'report_id','report_name');
      } catch (ErrorException $e) {
      $group= [];
     # $piname= null;
      $item_list= [];
      }
?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
    $("#divreport").hide();
    $("#hide").click(function(){
        $("#divreport").hide();
    });
    $("#show").click(function(){
        $("#divreport").show();
    });
});
</script>

<div class="sysconfigruntime-form">
  <div class="btn-group btn-group-justified">
    <?php if(!Yii::$app->request->get('id')){ ?>
  <a href="<?=Url::to(['sysconfigruntime/sysruntime']);?>" class="btn btn-default">ตั้งค่าระบบหลัก</a>
   <?php } ?>
  <a href="#" id='hide' class="btn btn-default">ตั้งค่าแบบกลุ่มรายงาน</a>
  <a href="#" id='show' class="btn btn-default">ตั้งค่าแบบรายตัวรายงาน</a>
</div>

    <?php $form = ActiveForm::begin(); ?>

    

   
        <?php 
        echo $form->field($model, 'run_gid')
             ->dropDownList(
            ArrayHelper::map(SysMenuGroup::find()
                ->all(),'mucode','muname'),
            [
                'class'=>'form-control',
                'id'=>'group',
                'prompt'=>'-เลือกประเภท-',
                'onchange'=>'
                       $.get("'.Url::toRoute('sysmenugroup/loadgroup').'",
                        {id:$(this).val()})
                        .done(function(data){
                            $("select#report").html(data);
                       });
                    '
            ]
        );
        ?>
        <div id='divreport'>
        <?= $form->field($model, 'run_rid')
             ->dropDownList($item_list,[
            
            'id'=>'report',
            'prompt'=>'-เลือกรายงาน-'

        ]);

              ?>
            </div>


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
        <?= Html::submitButton($model->isNewRecord ? 'บันทึก' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
