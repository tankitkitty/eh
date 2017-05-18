<?php

namespace frontend\modules\report\model;

use Yii;

/**
 * This is the model class for table "sys_menu_group".
 *
 * @property integer $muid
 * @property string $mucode
 * @property string $muname
 */
class SysMenuGroup extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sys_menu_group';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['mucode'], 'required'],
            [['mucode'], 'string', 'max' => 3],
            [['muname'], 'string', 'max' => 100]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'muid' => 'Muid',
            'mucode' => 'Mucode',
            'muname' => 'Muname',
        ];
    }
}
