<?php
namespace frontend\themes\lte\assets;

use yii\web\AssetBundle;


class LteAsset extends AssetBundle
{
    public $sourcePath = '@frontend/themes/lte/cssjs';
    public $css = [
        'bootstrap/css/bootstrap.min.css',
        '//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css',
        '//code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css',
        'dist/css/AdminLTE.css',
        'dist/css/skins/skin-blue.min.css',
       
       
    ];

    public $js = [
       //'plugins/jQuery/jQuery-2.1.4.min.js',
        //'jquery.js',
        //'@frontend/web/assets/74fcd3bd/jquery.js',
        //'bootstrap/js/bootstrap.min.js',
        'dist/js/app.min.js',
        
        
    ];

    public $depends = [
        'yii\web\YiiAsset',

       // 'yii\bootstrap\BootstrapAsset',
       // 'agency\assets\FontAwesomeAsset'
    ];
}