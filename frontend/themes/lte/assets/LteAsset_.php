<?php
namespace frontend\themes\lte\assets;

use yii\web\AssetBundle;

class LteAsset extends AssetBundle
{
    public $sourcePath = '@frontend/themes/lte/dist';
    public $css = [
        'css/_all-skins.min.css',
        'css/AdminLTE.min.css',
        'css/bootstrap.min.css',
        'css/font-awesome.min.css',
        'css/site.css',
        'css/toolbar.css',
        '//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css',
       
    ];

    public $js = [
        'js/app.min.js',
        'js/bootstrap.min.js',
        'js/jQuery-2.1.4.min.js',
        'js/toolbar.js',
       // 'js/yii.js',
        '//code.jquery.com/ui/1.11.4/jquery-ui.min.js',
        // '//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js',
        // 'plugins/morris/morris.min.js',
        // 'plugins/sparkline/jquery.sparkline.min.js',
        // 'plugins/jvectormap/jquery-jvectormap-1.2.2.min.js',
        // 'plugins/jvectormap/jquery-jvectormap-world-mill-en.js',
        // 'plugins/knob/jquery.knob.js',
        // 'https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js',
        // 'plugins/daterangepicker/daterangepicker.js',
        // 'plugins/datepicker/bootstrap-datepicker.js',
        // 'plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js',
        // 'plugins/slimScroll/jquery.slimscroll.min.js',
        // 'plugins/fastclick/fastclick.min.js',
        // 'js/pages/dashboard.js',
        // 'js/demo.js',
    ];

    public $depends = [
        'yii\web\YiiAsset',
        'yii\bootstrap\BootstrapAsset',
       // 'agency\assets\FontAwesomeAsset'
    ];
}