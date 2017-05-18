<?php
use yii\helpers\Url;
/* @var $this yii\web\View */

$this->title = 'EH!!';
?>
<div class="site-index">

    <div class="jumbotron">
        <h1>EH!!</h1>

        <p class="lead">ระบบประมวลผลเมื่อ</p>
        <p><?=$process_sys_notify['create_time'];?></p>
        <p><a class="btn btn-lg btn-success" href="<?=Url::toRoute(['sysconfigruntime/index']);?>">
            ตั้งค่าระบบ</a></p>
    </div>

    <div class="body-content">

        <div class="row">
            <div class="col-lg-4">
                <h2></h2>

                <p></p>

                <!-- <p><a class="btn btn-default" href="http://www.yiiframework.com/doc/">  &raquo;</a></p> -->
            </div>
             <div class="col-lg-4">
                <h2></h2>

                <p></p>

                <!-- <p><a class="btn btn-default" href="http://www.yiiframework.com/doc/">  &raquo;</a></p> -->
            </div>
             <div class="col-lg-4">
                <h2></h2>

                <p></p>

                <!-- <p><a class="btn btn-default" href="http://www.yiiframework.com/doc/">  &raquo;</a></p> -->
            </div>
          
        </div>

    </div>
</div>
