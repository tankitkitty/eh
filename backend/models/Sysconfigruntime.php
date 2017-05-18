<?php

namespace backend\models;

use Yii;

/**
 * This is the model class for table "sys_config_runtime".
 *
 * @property integer $run_id
 * @property string $run_gid
 * @property integer $run_rid
 * @property string $s_runtime
 * @property string $e_runtime
 * @property string $fiscal_year
 */
class Sysconfigruntime extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sys_config_runtime';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['run_rid'], 'integer'],
            [['s_runtime', 'e_runtime'], 'safe'],
            [['run_gid'], 'string', 'max' => 15],
           
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'run_id' => 'id',
            'run_gid' => 'ระบบ/กลุ่มรายงาน',
            'run_rid' => 'รายงาน',
            's_runtime' => 'เริ่มวันที่',
            'e_runtime' => 'สิ้นสุดวันที่',
           
        ];
    }
}
