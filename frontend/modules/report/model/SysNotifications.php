<?php

namespace frontend\modules\report\model;

use Yii;

/**
 * This is the model class for table "sys_notifications".
 *
 * @property string $snt_id
 * @property string $hospcode
 * @property string $distcode
 * @property string $hmain
 * @property integer $report_id
 * @property string $report_group
 * @property string $y_cases
 */
class SysNotifications extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sys_Notifications';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['report_id'], 'integer'],
            [['hospcode', 'hmain', 'report_group', 'y_cases'], 'string', 'max' => 5],
            [['distcode'], 'string', 'max' => 4]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'snt_id' => 'Snt ID',
            'hospcode' => 'Hospcode',
            'distcode' => 'Distcode',
            'hmain' => 'Hmain',
            'report_id' => 'Report ID',
            'report_group' => 'Report Group',
            'y_cases' => 'Y Cases',
        ];
    }
}
