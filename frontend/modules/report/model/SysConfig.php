<?php

namespace frontend\modules\report\model;

use Yii;

/**
 * This is the model class for table "sys_config".
 *
 * @property string $province_config
 * @property string $process
 * @property string $yearprocess
 * @property string $prov_name
 */
class SysConfig extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sys_config';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['yearprocess'], 'safe'],
            [['province_config'], 'string', 'max' => 2],
            [['process'], 'string', 'max' => 1],
            [['prov_name'], 'string', 'max' => 255]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'province_config' => 'Province Config',
            'process' => 'Process',
            'yearprocess' => 'Yearprocess',
            'prov_name' => 'Prov Name',
        ];
    }
}
