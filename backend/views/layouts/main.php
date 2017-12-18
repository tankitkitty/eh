<?php

/* @var $this \yii\web\View */
/* @var $content string */

use backend\assets\AppAsset;
use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\widgets\Breadcrumbs;
use common\widgets\Alert;

AppAsset::register($this);
?>

<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
<head>
    <meta charset="<?= Yii::$app->charset ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?= Html::csrfMetaTags() ?>
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
</head>
<body>
<?php $this->beginBody() ?>


<div class="wrap">
    <?php
    NavBar::begin([
        'brandLabel' => 'EH!!',
        'brandUrl' => Yii::$app->homeUrl,
        'options' => [
            'class' => 'navbar-inverse navbar-fixed-top',
        ],
    ]);
    $menuItems = [
        ['label' => 'หน้าแสดงผล', 'url' => \Yii::$app->urlManagerFrontend->getBaseUrl()],
       # ['label' => 'sysreport', 'url' => ['/sysreport/index']],
    ];
    if (Yii::$app->user->isGuest) {
        $menuItems[] = ['label' => 'Login', 'url' => ['/user/security/login']];
    } else {
        if(Yii::$app->user->identity->level==1&&Yii::$app->user->identity->hospcode=='1111'){
        $menuItems = [
         ['label' => 'หน้าแสดงผล', 'url' => \Yii::$app->urlManagerFrontend->getBaseUrl()],
        [
            'label' => 'ระบบรายงาน',
            'items' => [
                 
                 '<li class="divider"></li>',
                 '<li class="dropdown-header">จัดการระบบรายงาน</li>',
                 ['label' => 'ตั้งค่าหน่วยงาน', 'url' => ['setting/sysconfig']],
                 ['label' => 'ตั้งค่าประมวลผล', 'url' => ['/sysconfigruntime/index']],
                 ['label' => 'จัดการกลุ่มรายงาน', 'url' => ['/sysmenugroup/index']],
                 ['label' => 'จัดการรายงาน', 'url' => ['/sysreport/index']],
                 ['label' => 'สั่งประมวลผลรายตัว', 'url' => ['/runprocess/index']],

                ],
            ],
             [
                'label' => 'ระบบผู้ใช้งาน',
                'items' => [
                     
                     '<li class="divider"></li>',
                     '<li class="dropdown-header">ระบบผู้ใช้งาน</li>',
                     ['label' => 'จัดการ User', 'url' => ['/user/admin/index']],
                     ['label' => 'กำหนดสิทธิ์การเข้าถึง User', 'url' => ['/admin']],
                     ['label' => 'Generate User', 'url' => ['setting/index']],
                    ],
                ],
             [
                        'label' => 'Logout (' . Yii::$app->user->identity->username . ')',
                        'url' => ['/user/security/logout'],
                        'linkOptions' => ['data-method' => 'post']
                    ],
            ];
             }else{#$menuItems=null;
                $menuItems = [
                    [
                        'label' => 'Logout (' . Yii::$app->user->identity->username . ')',
                        'url' => ['/user/security/logout'],
                        'linkOptions' => ['data-method' => 'post']
                    ],
                     
                    ];
             }//if admin
           
        
         
   
    }
    
    echo Nav::widget([
        'options' => ['class' => 'navbar-nav navbar-right'],
        'items' => $menuItems,
    ]);
    NavBar::end();
    ?>

    <div class="container">
        <?= Breadcrumbs::widget([
            'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
        ]) ?>
        <?= Alert::widget() ?>
        <?= $content ?>
    </div>
</div>

<footer class="footer">
    <div class="container">
        <p class="pull-left">&copy; My Company <?= date('Y') ?></p>

        <p class="pull-right"><?= Yii::powered() ?></p>
    </div>
</footer>

<?php $this->endBody() ?>
</body>
</html>
<?php $this->endPage() ?>
