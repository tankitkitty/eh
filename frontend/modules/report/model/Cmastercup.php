<?php

namespace frontend\modules\report\model;

use Yii;

/**
 * This is the model class for table "cmastercup".
 *
 * @property integer $oid
 * @property string $province_id
 * @property string $hospcode5
 * @property string $hmain
 * @property string $hsub
 * @property string $hmainname
 * @property string $hmaintype
 * @property string $d_update
 * @property string $changwatcode
 * @property string $changwatname
 * @property string $ampurcode
 * @property string $ampurname
 * @property string $tamboncode
 * @property string $tambonname
 * @property string $villagecode
 * @property string $village
 * @property string $address
 * @property string $postcode
 * @property string $catma
 * @property string $catm
 * @property string $datecancelcode
 * @property string $edit_time
 * @property string $hospcode9
 * @property string $is_pcu
 * @property string $area_code
 */
class Cmastercup extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cmastercup';
    }

    /**
     * @return \yii\db\Connection the database connection used by this AR class.
     */
    public static function getDb()
    {
        return Yii::$app->get('dbhdc');
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['oid', 'hsub'], 'required'],
            [['oid'], 'integer'],
            [['edit_time'], 'safe'],
            [['province_id'], 'string', 'max' => 9],
            [['hospcode5', 'hmain', 'hsub', 'hmaintype', 'changwatcode', 'ampurcode', 'tamboncode', 'villagecode', 'address', 'postcode', 'hospcode9'], 'string', 'max' => 13],
            [['hmainname', 'changwatname', 'ampurname', 'tambonname', 'village', 'catma'], 'string', 'max' => 255],
            [['d_update', 'catm', 'datecancelcode'], 'string', 'max' => 18],
            [['is_pcu'], 'string', 'max' => 1],
            [['area_code'], 'string', 'max' => 12]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'oid' => 'Oid',
            'province_id' => 'Province ID',
            'hospcode5' => 'Hospcode5',
            'hmain' => 'Hmain',
            'hsub' => 'Hsub',
            'hmainname' => 'Hmainname',
            'hmaintype' => 'Hmaintype',
            'd_update' => 'D Update',
            'changwatcode' => 'Changwatcode',
            'changwatname' => 'Changwatname',
            'ampurcode' => 'Ampurcode',
            'ampurname' => 'Ampurname',
            'tamboncode' => 'Tamboncode',
            'tambonname' => 'Tambonname',
            'villagecode' => 'Villagecode',
            'village' => 'Village',
            'address' => 'Address',
            'postcode' => 'Postcode',
            'catma' => 'Catma',
            'catm' => 'Catm',
            'datecancelcode' => 'Datecancelcode',
            'edit_time' => 'Edit Time',
            'hospcode9' => 'Hospcode9',
            'is_pcu' => 'Is Pcu',
            'area_code' => 'Area Code',
        ];
    }
}
