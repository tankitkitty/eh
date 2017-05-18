<?php

/*
 * This file is part of the Dektrium project.
 *
 * (c) Dektrium project <http://github.com/dektrium/>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace frontend\models;

use dektrium\user\models\LoginForm as BaseUser;
use Yii;

class LoginForm extends BaseUser
{

    /** @inheritdoc */
    public function attributeLabels()
    {
        return [
            'login'      => Yii::t('user', 'ชื่อผู้ใช้งาน'),
            'password'   => Yii::t('user', 'Password'),
            'rememberMe' => Yii::t('user', 'Remember me next time'),
        ];
    }

}
