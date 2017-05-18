<?php

namespace backend\models;

use Yii;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\helpers\Json;

/**
 * This is the model class for table "sys_report".
 *
 * @property integer $report_id
 * @property string $report_name
 * @property string $a_table
 * @property string $s_table
 * @property string $t_table
 * @property string $t_sql
 * @property string $s_sql
 * @property string $a_sql
 * @property integer $active
 * @property string $aname
 * @property string $bname
 * @property string $notice
 * @property string $report_procedure
 * @property string $menu_group
 * @property integer $pageview
 * @property string $defination
 * @property string $docs
 * @property string $ref
 */
class SysReport extends \yii\db\ActiveRecord
{
     const UPLOAD_FOLDER = 'documents';
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
            [['report_name', 't_sql', 's_sql', 'a_sql', 'notice', 'defination', 'docs'], 'string'],
           # [['active', 'pageview'], 'integer'],
            [['pageview'], 'default','value'=>25],
            [['active'],'default','value'=>1],
            [['a_table', 's_table', 't_table', 'ref'], 'string', 'max' => 50],
            [['aname', 'bname'], 'string', 'max' => 255],
            [['report_procedure'], 'string', 'max' => 100],
            [['menu_group'], 'required']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'report_id' => 'รหัสรายงาน',
            'report_name' => 'รายงาน',
            'a_table' => 'A_Table',
            's_table' => 'S_Table',
            't_table' => 'T_Table',
            't_sql' => 'T_Sql',
            's_sql' => 'S_Sql',
            'a_sql' => 'A_Sql',
            'active' => 'เปิด/ปิด การทำงาน',
            'aname' => 'ตัวตั้ง (A)',
            'bname' => 'ตัวหาร (B)',
            'notice' => 'Notice',
            'report_procedure' => 'ReportProcedure',
            'menu_group' => 'กลุ่มรายงาน',
            'pageview' => 'Pageview',
            'defination' => 'นิยาม',
            'docs' => 'Docs',
            'ref' => 'Ref',
        ];
    }
      public static function getUploadPath(){
        return Yii::getAlias('@backend').'/web/'.self::UPLOAD_FOLDER.'/';
    }

    public static function getUploadUrl(){
        return Url::base(true).'/'.self::UPLOAD_FOLDER.'/';
    }

    public function listDownloadFiles($type){
     $docs_file = '';
     if(in_array($type, ['docs','covenant'])){         
             $data = $type==='docs'?$this->docs:$this->covenant;
             $files = Json::decode($data);
            if(is_array($files)){
                 $docs_file ='<ul>';
                 foreach ($files as $key => $value) {
                    $docs_file .= '<li>'.Html::a($value,['/sysreport/download','id'=>$this->report_id,'file'=>$key,'file_name'=>$value]).'</li>';
                 }
                 $docs_file .='</ul>';
            }
     }
     
     return $docs_file;
    }
     public function initialPreview($data,$field,$type='file'){
            $initial = [];
            $files = Json::decode($data);
            if(is_array($files)){
                 foreach ($files as $key => $value) {
                    if($type=='file'){
                        $initial[] = "<div class='file-preview-other'><h2><i class='glyphicon glyphicon-file'></i></h2></div>";
                    }elseif($type=='config'){
                        $initial[] = [
                            'caption'=> $value,
                            'width'  => '120px',
                            'url'    => Url::to(['/sysreport/deletefile','id'=>$this->report_id,'fileName'=>$key,'field'=>$field]),
                            'key'    => $key
                        ];
                    }
                    else{
                        $initial[] = Html::img(self::getUploadUrl().$this->ref.'/'.$value,['class'=>'file-preview-image', 'alt'=>$model->file_name, 'title'=>$model->file_name]);
                    }
                 }
         }
        return $initial;
    }
    public static function getname($rid){
        $model=SysReport::find()
        ->where('report_id = :report_id', [':report_id' => $rid])
        ->one();
        $name=$model['report_name'];
        return $name;
    }
}
