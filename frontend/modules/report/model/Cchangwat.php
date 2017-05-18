<?php

namespace frontend\modules\report\model;
//namespace app\models;
use Yii;

/**
 * This is the model class for table "cchangwat".
 *
 * @property string $changwatcode
 * @property string $changwatname
 * @property string $zonecode
 */
class Cchangwat extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'dbhdc.cchangwat';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['changwatcode'], 'required'],
            [['changwatcode', 'zonecode'], 'string', 'max' => 2],
            [['changwatname'], 'string', 'max' => 255]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'changwatcode' => 'Changwatcode',
            'changwatname' => 'Changwatname',
            'zonecode' => 'Zonecode',
        ];
    }
     public static function get_province(){
        $model = SysConfig::find()->select('province_config')->one();
        return $model['province_config'];
    }
}
