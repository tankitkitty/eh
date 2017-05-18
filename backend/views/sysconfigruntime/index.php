<?php

use yii\helpers\Html;
use yii\grid\GridView;
use backend\models\SysMenuGroup;
use backend\models\SysReport;

/* @var $this yii\web\View */
/* @var $searchModel backend\models\SysconfigruntimeSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'รายการประมวลผลในระบบ';
$this->params['breadcrumbs'][] = $this->title;
// if($model->run_rid && $model->run_gid){
// $model_g = SysReport::find()
//     ->where('report_id = :report_id', [':report_id' => $model->run_rid])
//     ->one();
// $con_name='รายงาน '.$model_g['report_name'];
// }else if($model->run_gid){
// $model_g = SysMenuGroup::find()
//     ->where('mucode = :mucode', [':mucode' => $model->run_gid])
//     ->one();
//     $con_name='กลุ่มรายงาน '.$model_g['muname'];
// }else if($model->run_rid){
// $model_g = SysReport::find()
//     ->where('report_id = :report_id', [':report_id' => $model->run_rid])
//     ->one();
//     $con_name='รายงาน '.$model_g['report_name'];
// }
?>
<div class="sysconfigruntime-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('ตั้งค่าการประมวลผล', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            'run_id',
                [
                  'attribute' => 'run_gid',
                  'value'=>function($value) use ($dataProvider){
                    if($value->run_gid=='root'){
                        return 'ระบบหลัก';
                    }else if(!IS_NULL($value->run_gid)&&!IS_NULL($value->run_rid)){
                        return 'รายงาน '.SysReport::getname($value->run_rid);
                    }else if(IS_NULL($value->run_gid)){
                        if(!IS_NULL($value->run_rid)){
                            return 'รายงาน '.SysReport::getname($value->run_rid);
                        }
                        return '';
                    }else{
                    return  'กลุ่ม '.SysMenuGroup::getname($value->run_gid);
                    }
                  }
                ],
            
            // 'run_gid',
            // 'run_rid',
            's_runtime',
            'e_runtime',
     

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>

</div>
