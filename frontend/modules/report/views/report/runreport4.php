<?php
use miloschuman\highcharts\Highcharts;
//use yii\helpers\Html;
use yii\helpers\BaseUrl;
use yii\helpers\Url;
//use kartik\date\DatePicker;
use yii\widgets\ActiveForm;
use kartik\grid\GridView;
use frontend\modules\runreport\model\Sys_report;
use frontend\modules\report\model\Cchangwat;
use frontend\modules\report\model\Campur;
use frontend\modules\report\model\Chospital;
use frontend\modules\report\model\Cmastercup;
use frontend\modules\report\controllers\ReportController;
use yii\helpers\ArrayHelper;
use kartik\export\ExportMenu;
use kartik\helpers\Html;




#var_dump($configruntime);
//var_dump($percent);
//var_dump($datachart);
// use frontend\themes\lte\assets\LteAsset;
// LteAsset::register($this);

$this->title = $reportname;
$this->params['breadcrumbs'][] = ['label' => 'รายงาน', 'url' => ['report/notifyall']];
$this->params['breadcrumbs'][] = $this->title;


    try {
     $campur = $_GET['campur'];
     $ctambon = $_GET['ctambon'];
      $ctambon_list = ArrayHelper::map(Chospital::find()
            ->where('CONCAT(provcode,distcode)=:pcu', [':pcu'=>$campur])
            ->andWhere([
            'hostype' => ['03','04','05','06','07','08','12','13','15','18'],
            ])->all(), 'hoscode', 'hosname');
      } catch (ErrorException $e) {
         // $province = [];
        $cchangwat = [];
      $campur= [];
      $campur_list= [];
      $ctambon= null;
      $ctambon_list= [];
      }

   

?>
<?php





    $form = ActiveForm::begin([
    'method'=>'get',
    'action' => Url::to(['report/runreport4', 'r_table'=>$r_table]),
    ]);
    ?>

       

   
      <div class="form-group">
        <?= Html::label('อำเภอ','campur');?>
        <?= Html::dropDownList('campur',$campur,
            ArrayHelper::map(Campur::find()
                ->where('changwatcode='.$provincecode)
                ->orderBy('ampurcodefull ASC')
                ->all(),'ampurcodefull','ampurname'),
            [
                'class'=>'form-control',
                'id'=>'campur',
                'prompt'=>'-เลือกอำเภอ-',
                'onchange'=>'
                       $.get("'.Url::toRoute('cchangwat/loadhospital').'",
                        {id:$(this).val()})
                        .done(function(data){
                            $("select#ctambon").html(data);
                       });
                    '
            ]
        );?>
    </div>
      <div class="form-grop">
      <?= Html::label('หน่วยบริการ','ctambon');?>
        <?= Html::dropDownList('ctambon',$ctambon,$ctambon_list,[
            'class'=>'form-control',
            'id'=>'ctambon',
            'prompt'=>'-เลือกหน่วยบริการ-',

        ]);?>
            </div><br>
 <?php echo Html::submitButton('ตกลง', ['class'=>'btn btn-info']); 

        ActiveForm::end();
    ?>
    <br><div class="alert alert-success" role="alert">- คำนิยาม:: <?=$defination;?>
    <br>- ช่วงเวลาประมวลผลของรายงานนี้ :: 
     <?=$configruntime['s_runtime'].' ถึง '.$configruntime['e_runtime'];?>
    </div>
<?php
  

echo '<h2>รายงาน::'.$reportname.'</h2>';


 
            foreach ($columns as $index => $value) {  
              if($index>0){
             $gridcolumns[]=[
             'attribute'=>$value['Field'],
              'value'=>function($data) use ($value) {
                $fieldDate=['DATE_SERV','date_serv','BIRTH','birth','ddeath','ddeath2'
                ,'bdate','BDATE','newborn_bdate','ppcare','edc','bcare'];
                if($value['Field']=='hosname'){
                  return  Html::a($data['hosname']);
               }else 
                if($value['Field']=='ampurname'){
                  return  Html::a($data['ampurname'],['runreport4', 'r_table'=>$_GET['r_table'],'campur'=>$data['distcode']]);
               }else if(in_array($value['Field'],$fieldDate)){
                return Yii::$app->Udf->thDateAbbr($data[$value['Field']]);
               }else{
                  return  $data[$value['Field']];
                }
             },
             #กำหนดการแสดงผล ถ้าเลือกหน่วยบริการแล้ว ไม่ต้องแสดง Hoscode 
             'visible'=> (strlen($ctambon) == 5 && $value['Field'] == 'hosname' ? false : true ),
             #กรณีเป็นวันที่ ระบบจะแสดงเป็น format วันที่
            # 'format'=>($value['Field'] == 'date_serv' ? 'date' : 'raw' ),
             'format'=>'raw',
             'label'=>$value['Comment']
                       ];             
               }  //endif index   
         }  



?>
<div class="panel panel-primary">
    <div class="panel-heading"><h3><div class="glyphicon glyphicon-stats"></div> &nbsp;</h3></div>
<br><br>
<?php



echo Highcharts::widget([
   'options' => [
      'credits' => ['enabled' => false],
      'title' => ['text' => ''],
      'xAxis' => [
         'categories' => $hosname
      ],
      'yAxis' => [
         'title' => ['text' => 'ร้อยละ']
      ],
       'legend'=> [
            'reversed'=> true
        ],


      'plotOptions'=> [
      
            'series'=> [
             'zoneAxis'=> 'y',
      'zones'=> [
            [
                'value'=> 0,
                'color'=> '#00C0EF'
            ],
            [
                'value'=> 2,
                'color'=> '#00A65A'
            ],
            [
                'value'=> 21,
                'color'=> '#F39C12'
            ],
            [
               
                'color'=> '#DD4B39'
            ],
            ],

            // 'colors'=> [
            //   '#DD4B39', 
            //   '#F39C12', 
            //   '#00A65A', 
            //   '#00C0EF'

            //   ],


                'stacking'=> 'normal'
            ]
        ],
      'series' => [


        //  [
        // 'type'=>'bar',
        // 'name'=>'ข้อมูลทั้งหมด',
        // 'data'=>$percent,
        // 'color'=> '#FF5722' //$level_color
        // ],
        [
        'type'=>'bar',
        'name'=>'เอ๊ะ %',
        'data'=>$percent,
       
       //'colorByPoint'=> true,
        //'color'=> '#FF5722'
        ],
        
      ]
   ]
]);?>
</div>
<?php
$fullExportMenu = ExportMenu::widget([
    'dataProvider' => $data,
     'formatter' => ['class' => 'yii\i18n\Formatter','nullDisplay' => ''],
    'columns' => $gridcolumns,
    'target' => ExportMenu::TARGET_BLANK,
    'fontAwesome' => true,
    'pjaxContainerId' => 'kv-pjax-container',
    'dropdownOptions' => [
        'label' => 'Full',
        'class' => 'btn btn-default',
        'itemsBefore' => [
            '<li class="dropdown-header">Export All Data</li>',
        ],
    ],
]);
echo GridView::widget([
    'dataProvider' => $data,
     'formatter' => ['class' => 'yii\i18n\Formatter','nullDisplay' => ''],
     
    'columns' => $gridcolumns,
    'pjax' => true,
    'pjaxSettings' => ['options' => ['id' => 'kv-pjax-container']],
    'panel' => [
        'type' => GridView::TYPE_PRIMARY,
        'heading' => '<h3 class="panel-title"><i class="glyphicon glyphicon-book"></i> ข้อมูลต้องสงสัย</h3>',
    ],
    // set a label for default menu
    'export' => [
        'label' => 'Page',
        'fontAwesome' => true,
    ],
    // your toolbar can include the additional full export menu
    'toolbar' => [
        '{export}',
        $fullExportMenu,
        // ['content'=>
        //     Html::button('<i class="glyphicon glyphicon-plus"></i>', [
        //         'type'=>'button', 
        //         'title'=>Yii::t('kvgrid', 'Add Book'), 
        //         'class'=>'btn btn-success'
        //     ]) . ' '.
        //     Html::a('<i class="glyphicon glyphicon-repeat"></i>', ['report/runreport1'], [
        //         'data-pjax'=>0, 
        //         'class' => 'btn btn-default', 
        //         'title'=>Yii::t('kvgrid', 'Reset Grid')
        //     ])
        // ],
    ]
]);                     
?>





