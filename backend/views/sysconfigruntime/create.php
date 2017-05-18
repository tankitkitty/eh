<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model backend\models\Sysconfigruntime */

$this->title = 'ตั้งค่าการประมวลผล';
$this->params['breadcrumbs'][] = ['label' => 'รายการประมวลผลในระบบ', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="sysconfigruntime-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
