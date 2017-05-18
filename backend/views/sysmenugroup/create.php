<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model backend\models\SysMenuGroup */

$this->title = 'สร้างกลุ่มรายงาน';
$this->params['breadcrumbs'][] = ['label' => 'จัดการกลุ่มรายงาน', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="sys-menu-group-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
