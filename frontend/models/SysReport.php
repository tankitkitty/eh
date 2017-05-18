<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "sys_report".
 *
 * @property integer $report_id
 * @property string $id
 * @property string $report_name
 * @property string $source_table
 * @property string $t_sql
 * @property string $s_sql
 * @property string $weight
 * @property integer $active
 * @property string $version
 * @property string $aname
 * @property string $bname
 * @property string $query_hospcode
 * @property string $query_date
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
            [['id', 'report_name', 'version'], 'required'],
            [['report_name', 't_sql', 's_sql', 'query_hospcode', 'query_date', 'notice'], 'string'],
            [['weight'], 'number'],
            [['active', 'pageview'], 'integer'],
            [['id'], 'string', 'max' => 32],
            [['source_table', 'report_procedure'], 'string', 'max' => 100],
            [['version'], 'string', 'max' => 14],
            [['aname', 'bname'], 'string', 'max' => 255],
            [['menu_group'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'report_id' => 'Report ID',
            'id' => 'ID',
            'report_name' => 'Report Name',
            'source_table' => 'Source Table',
            't_sql' => 'T Sql',
            's_sql' => 'S Sql',
            'weight' => 'Weight',
            'active' => 'Active',
            'version' => 'Version',
            'aname' => 'Aname',
            'bname' => 'Bname',
            'query_hospcode' => 'Query Hospcode',
            'query_date' => 'Query Date',
            'notice' => 'Notice',
            'report_procedure' => 'Report Procedure',
            'menu_group' => 'Menu Group',
            'pageview' => 'Pageview',
        ];
    }
}
