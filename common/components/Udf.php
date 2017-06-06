<?php
namespace common\components;

use Yii;
use yii\base\Component;

class Udf extends Component {

    public  function RealIP()
    {
        $ip = false;

        $seq = array('HTTP_CLIENT_IP',
                  'HTTP_X_FORWARDED_FOR'
                  , 'HTTP_X_FORWARDED'
                  , 'HTTP_X_CLUSTER_CLIENT_IP'
                  , 'HTTP_FORWARDED_FOR'
                  , 'HTTP_FORWARDED'
                  , 'REMOTE_ADDR');

        foreach ($seq as $key) {
            if (array_key_exists($key, $_SERVER) === true) {
                foreach (explode(',', $_SERVER[$key]) as $ip) {
                    if (filter_var($ip, FILTER_VALIDATE_IP) !== false) {
                        return $ip;
                    }
                }
            }
        }
    }

    public function thDate($date=null)
    {
        $date = $date==""? date("Y-m-d"):$date;
        $Dates = explode('-',$date);
        if ($Dates[0]+0 >2300){
            return ($Dates[2]+0).'/'.$Dates[1].'/'.$Dates[0];
        } else {
            return ($Dates[2]+0).'/'.$Dates[1].'/'.($Dates[0]+543);
        }
    }

    public function thDateFull($date=null)
    {
        $date = $date==""? date("Y-m-d"):$date;
        $Dates = explode('-',$date);
        if ($Dates[0]+0 >2300){
            return ($Dates[2]+0).' '.$this->thMonth($Dates[1]+0).' '.$Dates[0];
        } else {
            return ($Dates[2]+0).' '.$this->thMonth($Dates[1]+0).' '.($Dates[0]+543);
        }
    }

    public function thDateAbbr($date=null)
    {
       # $date = $date==""? date("Y-m-d"):$date;
        if(!is_null($date)){
        $Dates = explode('-',$date);
        if ($Dates[0]+0 >2300){
            return ($Dates[2]+0).' '.$this->thMonthAbbr($date).' '.$Dates[0];
        } else {
            return ($Dates[2]+0).' '.$this->thMonthAbbr($date).' '.($Dates[0]+543);
        }
        }else{
            return $date=null;
        } //isnull
    }

    public function thaiMonth()
    {
        return [1=>'มกราคม',2=>'กุมภาพันธ์',3=>'มีนาคม',4=>'เมษายน',5=>'พฤษภาคม',6=>'มิถุนายน',7=>'กรกฎาคม',8=>'สิงหาคม',9=>'กันยายน',10=>'ตุลาคม',11=>'พฤศจิกายน',12=>'ธันวาคม'];
    }

    public function thaiMonthAbbr()
    {
        return [1=>'ม.ค.',2=>'ก.พ.',3=>'มี.ค.',4=>'เม.ย.',5=>'พ.ค.',6=>'มิ.ย.',7=>'ก.ค.',8=>'ส.ค.',9=>'ก.ย.',10=>'ต.ค.',11=>'พ.ย.',12=>'ธ.ค.'];
    }

    public function thMonth($month=0)
    {
        $cMonth = $this->thaiMonth();
        if (strlen($month)>2){
            $Dates = explode('-',$month);
            $month = $Dates[1];
        }
        return $cMonth[$month+0];
    }

    public function thMonthAbbr($month=0)
    {
        $cMonth = $this->thaiMonthAbbr();
        if (strlen($month)>2){
            $Dates = explode('-',$month);
            $month = $Dates[1];
        }
        return $cMonth[$month+0];
    }

    public function textAddress($addr=null)
    {
        if ($addr==""){
            return '' ;
        }

        $Sql = 'SELECT * FROM lib_address WHERE code="'.$addr.'" ';
        $add = Yii::$app->db_hospdata->createCommand($Sql)->queryOne();
        $txtAdd = $add["name"]==""? '':('ต.'.$add["name"]);

        $Sql = 'SELECT * FROM lib_address WHERE code="'.(substr($addr,0,4)).'00" ';
        $add = Yii::$app->db_hospdata->createCommand($Sql)->queryOne();
        $txtAdd .= $add["name"]==""? '':(' อ.'.$add["name"]);

        $Sql = 'SELECT * FROM lib_address WHERE code="'.(substr($addr,0,2)).'0000" ';
        $add = Yii::$app->db_hospdata->createCommand($Sql)->queryOne();
        $txtAdd .= $add["name"]==""? '':(' จ.'.$add["name"]);

        return $txtAdd;
    }

    public function textHospcode($hospcode=null)
    {
        if ($hospcode==""){
            return '' ;
        }

        $Sql = 'SELECT * FROM lib_hospcode WHERE off_id="'.$hospcode.'" ';
        $getData = Yii::$app->db_hospdata->createCommand($Sql)->queryOne();

        return $getData["name"];
    }

    public function getColumn($tableName=null, $condition=null, $returnColumn=null, $extendCommand=null)
    {
        $tableName = str_replace(['--',';',' '],['','',''],$tableName);
        $returnColumn = str_replace(['--',';'],['',''],$returnColumn);
        $condition = str_replace(['--',';'],['',''],$condition);
        $extendCommand = str_replace(['--',';'],['',''],$extendCommand);

        if ($tableName=="" || $condition=="" || $returnColumn==""){
            return '' ;
        }

        $Sql = "SELECT $tableName.$returnColumn as fld FROM $tableName WHERE $condition $extendCommand ";
        $getData = Yii::$app->db_hospdata->createCommand($Sql)->queryOne();

        return $getData["fld"];
    }

    public function dateDiff($date1=null,$date2=null)
    {
        if ($date1=="" || $date2=="")
            return [];

        $date1 = new DateTime($date1);
        $date2 = new DateTime($date2);
        $interval = $date2->diff($date1);

        return [
            'y'=>$interval->y,
            'm'=>$interval->m,
            'd'=>$interval->d,
            'h'=>$interval->h,
            'i'=>$interval->i,
            's'=>$interval->s,
            'days'=>$interval->days,
        ];
    }

}
