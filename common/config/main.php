<?php
ini_set('memory_limit', '4048M');
return [
    'vendorPath' => dirname(dirname(__DIR__)) . '/vendor',
     'timeZone' => 'Asia/Bangkok', //ตั้งเวลา
    'language'=>'th_TH',//ตั้งภาษา
    'components' => [
            'authManager' => [
           // 'class' =>  'yii\rbac\PhpManager',
            'class' =>  'yii\rbac\DbManager',
        ],

        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],
    
    ],
    
    'modules' => [
        'gridview' => [
            'class' => '\kartik\grid\Module'
        ]
        ],
];
