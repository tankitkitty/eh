<?php
use backend\models\Chospital;
use yii\helpers\ArrayHelper;
use yii\widgets\ActiveForm;
use yii\helpers\Url;
use kartik\helpers\Html;


 $prov_list = ArrayHelper::map(Chospital::find()
            ->where('hostype=:type', [':type'=>'01'])
            ->all(), 'provcode', 'hosname');



    $form = ActiveForm::begin([
    'method'=>'post',
    'action' => Url::to(['setting/setconfig']),
    ]);
    ?>




  <div class="panel panel-default">
    <div class="panel-heading">ตั้งค่าหน่วยงาน</div>
    <div class="panel-body">
    	
    	<div class="form-grop">
      <?= Html::label('หน่วยงาน','prov');?>
        <?= Html::dropDownList('prov',[],$prov_list,[
            'class'=>'form-control',
            'id'=>'prov',
            'prompt'=>'-เลือกหน่วยงาน-',

        ]);
        echo '<br>'.Html::submitButton('ตกลง', ['class'=>'btn btn-info']); 
        ?>
            </div>
    	</div>
    </div>



<?php 

        ActiveForm::end();
    ?>