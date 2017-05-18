<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\helpers\Url;

/* @var $this yii\web\View */
/* @var $searchModel backend\models\SysReportSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'รายงานในระบบ';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="sys-report-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('เพิ่มรายงานในระบบ', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'report_id',
            'report_name:ntext',
             'menu_group',
              [
                  'attribute' => 'active',
                  'value'=>function($value) use ($dataProvider){
                  	if($value->active==1){
                  		return 'เปิด';
                  	}else{
                  		return 'ปิด';
                  	}
                  }
              ],           
             'report_procedure',            
           

            ['class' => 'yii\grid\ActionColumn',
            'template'=>' {my_button}',
            'header' => 'ประมวลผล',
				'buttons' => [
				    'my_button' => function ($url, $dataProvider, $key) {
				        // return Html::a('<button type="button" class="btn btn-default" aria-label="Left Align">
				        // 	<span class="glyphicon glyphicon-play-circle"></span></button>',
				        //  ['callprocess' 
            //      #,'id'=>$dataProvider->report_procedure
            //      ,'data'=>[
            //           'method' => 'post',
            //           'params'=>['id'=>$dataProvider->report_procedure],
            //       ]
            //      ]
                  
            //      );
              return Html::a('<button type="button" class="btn btn-default" aria-label="Left Align">
                  <span class="glyphicon glyphicon-play-circle"></span></button>'
                  ,  Url::toRoute('runprocess/callprocess'), [
                'data' => [
                   # 'confirm' => 'Are you sure you want to delete the campaign?',
                     'method' => 'post',
                         'params'=>['id'=>$dataProvider->report_procedure],
                ],
              ]);
				    },
				],
            ],
        
        ],
    ]); ?>

</div>
