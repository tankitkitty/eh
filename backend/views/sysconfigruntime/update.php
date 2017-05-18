<?php

use yii\helpers\Html;
use backend\models\SysMenuGroup;
use backend\models\SysReport;

/* @var $this yii\web\View */
/* @var $model backend\models\Sysconfigruntime */
if($model->run_rid && $model->run_gid){
$model_g = SysReport::find()
	->where('report_id = :report_id', [':report_id' => $model->run_rid])
	->one();
$con_name='รายงาน '.$model_g['report_name'];
}else if($model->run_gid){
$model_g = SysMenuGroup::find()
	->where('mucode = :mucode', [':mucode' => $model->run_gid])
	->one();
	$con_name='กลุ่มรายงาน '.$model_g['muname'];
}else if($model->run_rid){
$model_g = SysReport::find()
	->where('report_id = :report_id', [':report_id' => $model->run_rid])
	->one();
	$con_name='รายงาน '.$model_g['report_name'];
}
$this->title = 'ตั้งค่าการประมวลผล '.': '.$con_name;
$this->params['breadcrumbs'][] = ['label' => 'Sysconfigruntimes', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->run_id, 'url' => ['view', 'id' => $model->run_id]];
$this->params['breadcrumbs'][] = 'Update';
#var_dump($model);
?>
<div class="sysconfigruntime-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
