<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model backend\models\SysReport */

$this->title = 'เพิ่มรายงาน';
$this->params['breadcrumbs'][] = ['label' => 'รายงานในระบบ', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="sys-report-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
