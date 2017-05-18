<?php
$params = array_merge(
    require(__DIR__ . '/../../common/config/params.php'),
    require(__DIR__ . '/../../common/config/params-local.php'),
    require(__DIR__ . '/params.php'),
    require(__DIR__ . '/params-local.php')
);

return [
    'id' => 'app-backend',
    'layout' => '@backend/views/layouts/main.php',
    'basePath' => dirname(__DIR__),
    'controllerNamespace' => 'backend\controllers',
    'bootstrap' => ['log'],
    #'modules' => [],
    'components' => [
        'urlManagerFrontend' => [
                'class' => 'yii\web\urlManager',
                'baseUrl' => '/eh/frontend/web',
                'scriptUrl'=>'/eh/frontend/web/index.php',
                'enablePrettyUrl' => false,
                'showScriptName' => true,
         ],
               'user' => [
            //'identityClass' => 'common\models\User', //ของเดิม
             'identityClass' => 'dektrium\user\models\User', //ของ yii2-user
            'enableAutoLogin' => true,
        ],

        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'errorHandler' => [
            'errorAction' => 'site/error',
        ],
        //  'view' => [

        //      'theme' => [
        //          'pathMap' => [
        //             '@app/views' => '@frontend/themes/lte/views'
        //          ],
        //      ],
        // ],
    ],
    'as access' => [
                'class' => 'mdm\admin\components\AccessControl',
                'allowActions' => [
                    
                    
                    // 'report/report/*',
                    
                     'user/security/logout',
                     'user/settings/account'
                    // 'some-controller/some-action',
                ]
            ],
    'modules' => [
       
          'user' => [
            'class' => 'dektrium\user\Module',
            'enableUnconfirmedLogin' => true,
            'confirmWithin' => 21600,
            'cost' => 12,
            'admins' => ['admin'] // User ใหญ่
        ],
        'datecontrol' =>  [
        'class' => '\kartik\datecontrol\Module'
        ],
         'admin' => [
            'class' => 'mdm\admin\Module',
            'layout' => 'left-menu',
            'controllerMap' => [
                 'assignment' => [
                    'class' => 'mdm\admin\controllers\AssignmentController',
                    'userClassName' => 'dektrium\user\models\User', 
                    //เรียกใช้โมเดล user ของ dektrium
                ]
            ],
        ],


  ],

    'params' => $params,
];
