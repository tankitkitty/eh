<?php
$params = array_merge(
    require(__DIR__ . '/../../common/config/params.php'),
    require(__DIR__ . '/../../common/config/params-local.php'),
    require(__DIR__ . '/params.php'),
    require(__DIR__ . '/params-local.php')
);

return [
    'id' => 'app-frontend',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'controllerNamespace' => 'frontend\controllers',
    'defaultRoute' => 'report/report/index',
        

    'components' => [
        'urlManagerBackend' => [
                'class' => 'yii\web\urlManager',
                'baseUrl' => '/eh/backend/web',
                'scriptUrl'=>'/eh/backend/web/index.php',
                'enablePrettyUrl' => false,
                'showScriptName' => true,
         ],
         'request' => [

            'enableCookieValidation' => true,
            'cookieValidationKey' => 'your-validation-key',
        ],
     // 'urlManager'=>[
     //    'class'=> 'yii\web\UrlManager',
     //    'enablePrettyUrl' => true,
     //    'showScriptName' => false,
     // ],
     'user' => [
            //'identityClass' => 'app\models\User',
            'identityClass' => 'dektrium\user\models\User',
            'enableAutoLogin' => true,
            
                ],
     'view' => [
             'theme' => [
                 'pathMap' => [
                    '@app/views' => '@frontend/themes/lte/views'
                 ],
             ],
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
            

         'authManager' => [
            'class' => 'yii\rbac\DbManager',
             //'defaultRoles'   =>   [ 'guest' ]
        ],    

    ],
    'as access' => [
                'class' => 'mdm\admin\components\AccessControl',
                'allowActions' => [
                    //module, controller, action ที่อนุญาตให้ทำงานโดยไม่ต้องผ่านการตรวจสอบสิทธิ์
                    // 'site/*',
                    //'*',
                    //'@frontend/web/index.php',
                   // 'admin/*',
                   // 'user/*',
                    
                    // 'report/report/*',
                     'report/report/index',
                     'report/report/chk',
                     'report/cchangwat/loadhospital',
                     'report/report/runreport4',
                     'report/report/notifyall',
                     'user/security/logout',
                     'user/settings/account'
                    // 'some-controller/some-action',
                ]
            ],
     'modules' => [
         
        'report' => [
            'class' => 'frontend\modules\report\Module',
            //'allowedIPs' => ['203.157.151.20'],
        ],
       
       
         'user' => [
        'class' => 'dektrium\user\Module',
        // 'db'=>'..',
        'modelMap' => [
            'LoginForm' => 'frontend\models\LoginForm',
                    ],
        'enableUnconfirmedLogin' => false,
        'confirmWithin' => 21600,
        'cost' => 12,
        'admins' => ['admin', 'test']
             ],
             
        //      'admin' => [
        //     'class' => 'mdm\admin\Module',
        //     'layout' => 'left-menu',
        //     'controllerMap' => [
        //          'assignment' => [
        //             'class' => 'mdm\admin\controllers\AssignmentController',
        //             'userClassName' => 'dektrium\user\models\User', 
        //             //เรียกใช้โมเดล user ของ dektrium
        //         ]
        //     ],
        // ],
       
    ],
    'params' => $params,
];
