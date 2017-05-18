<?php

namespace frontend\modules\report\model;

use Yii;

/**
 * This is the model class for table "chospital".
 *
 * @property string $hoscode
 * @property string $hosname
 * @property string $hostype
 * @property string $address
 * @property string $road
 * @property string $mu
 * @property string $subdistcode
 * @property string $distcode
 * @property string $provcode
 * @property string $postcode
 * @property string $hoscodenew
 * @property string $bed
 * @property string $level_service
 * @property string $bedhos
 * @property integer $hdc_regist
 * @property string $owner_changwat
 * @property string $owner_ampur
 */
class Chospital extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'chospital';
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
            [['hoscode'], 'required'],
            [['hdc_regist'], 'integer'],
            [['hoscode', 'postcode', 'bed', 'bedhos', 'owner_changwat', 'owner_ampur'], 'string', 'max' => 5],
            [['hosname', 'level_service'], 'string', 'max' => 255],
            [['hostype', 'mu', 'subdistcode', 'distcode', 'provcode'], 'string', 'max' => 2],
            [['address', 'road'], 'string', 'max' => 50],
            [['hoscodenew'], 'string', 'max' => 9]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'hoscode' => 'Hoscode',
            'hosname' => 'Hosname',
            'hostype' => 'Hostype',
            'address' => 'Address',
            'road' => 'Road',
            'mu' => 'Mu',
            'subdistcode' => 'Subdistcode',
            'distcode' => 'Distcode',
            'provcode' => 'Provcode',
            'postcode' => 'Postcode',
            'hoscodenew' => 'Hoscodenew',
            'bed' => 'Bed',
            'level_service' => 'Level Service',
            'bedhos' => 'Bedhos',
            'hdc_regist' => 'Hdc Regist',
            'owner_changwat' => 'Owner Changwat',
            'owner_ampur' => 'Owner Ampur',
        ];
    }
}
