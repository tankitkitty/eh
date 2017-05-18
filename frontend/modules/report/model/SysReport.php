<?php

namespace frontend\modules\report\model;

use Yii;

/**
 * This is the model class for table "sys_report".
 *
 * @property integer $report_id
 * @property string $report_name
 * @property string $s_table
 * @property string $t_table
 * @property string $t_sql
 * @property string $s_sql
 * @property integer $active
 * @property string $aname
 * @property string $bname
 * @property string $notice
 * @property string $report_procedure
 * @property string $menu_group
 * @property integer $pageview
 */
class SysReport extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sys_report';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['report_name'], 'required'],
            [['report_name', 't_sql', 's_sql','a_sql', 'notice'], 'string'],
            [['active', 'pageview'], 'integer'],
            [['a_table', 's_table', 't_table'], 'string', 'max' => 50],
            [['aname', 'bname'], 'string', 'max' => 255],
            [['report_procedure'], 'string', 'max' => 100],
            [['menu_group'], 'string', 'max' => 3]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'report_id' => 'Report ID',
            'report_name' => 'Report Name',
            'a_table' => 'A Table',
            's_table' => 'S Table',
            't_table' => 'T Table',
            't_sql' => 'T Sql',
            's_sql' => 'S Sql',
            'a_sql' => 'A Sql',
            'active' => 'Active',
            'aname' => 'Aname',
            'bname' => 'Bname',
            'notice' => 'Notice',
            'report_procedure' => 'Report Procedure',
            'menu_group' => 'Menu Group',
            'pageview' => 'Pageview',
        ];
    }
}
