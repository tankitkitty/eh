<?php

namespace backend\models;

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
            [['mucode'], 'string', 'max' => 15],
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
            'mucode' => 'รหัสกลุ่มรายงาน',
            'muname' => 'ชื่อกลุ่มรายงาน',
        ];
    }
    public static function getname($code){
       $model=SysMenuGroup::find()
        ->where('mucode = :mucode', [':mucode' => $code])
        ->one();
        $name=$model['muname'];
        return $name;
    }
}
