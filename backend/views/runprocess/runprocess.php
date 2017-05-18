<?php
#var_dump($procedures);
// use yii\helpers\Html;
// use yii\grid\GridView;
// use yii\helpers\Url;
use yii\widgets\Breadcrumbs;

/* @var $this yii\web\View */
/* @var $searchModel backend\models\SysReportSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'รายงานในระบบ';
$this->params['breadcrumbs'][] = $this->title;

echo Breadcrumbs::widget([
    'itemTemplate' => "<li><i>{link}</i></li>\n", // template for all links
    'links' => [
        [
            'label' => 'รายงานในระบบ',
            'url' => ['runprocess/index'],
            'template' => "<li><b>{link}</b></li>\n", // template for this link only
        ],
        
        'ผลการทำงาน',
    ],
]);
?>
<div class="well well-lg">
<?php
if($procedures=1){
echo 'การประมวลผลเสร็จสิ้น';
}else{
echo 'การประมวลผลผิดพลาด';
}

?>
</div>