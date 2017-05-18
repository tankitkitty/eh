<?php
use yii\helpers\Html;
?>

  <h2>ตั้งค่า</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Generate user</div>
    <div class="panel-body">
        ทำการ Generate user 
        <?php
       // var_dump($datatype);
 echo Html::a('ยืนยัน', ['setting/gen'], [
     'data' => [
        'confirm' => 'คุณต้องการ Generate user ใหม่หรือไม่'
        //'method' => 'post',
        // 'params' => [
        //     'lab' => $lab->id,
        //     'kind' => $page->kind,
        // ],
    ],
]);

             $datauser = (new \yii\db\Query())
              ->select('id, level')
              ->from('user')          
               //->addParams([':hostype' => $hostype])
              //->limit(50)
              ->all(\Yii::$app->db);
              //var_dump($datauser);

               $datahos = (new \yii\db\Query())
              ->select('*')
              ->from('chospital')
              ->where('provcode = :province')
              ->andWhere(['IN', 'hostype', ['05','06','07']])
              ->addParams([':province' => '73'])
              ->all(\Yii::$app->dbhdc);
              //var_dump($datatype);
               for($i=0;$i<sizeof($datahos);$i++){    
              if($datahos[$i]['hostype']=='05'||$datahos[$i]['hostype']=='06'||$datahos[$i]['hostype']=='07'){
              $hosuser2[]=$datahos[$i]['hoscode'];
                }
              }

               for($i=0;$i<sizeof($hosuser2);$i++){    
                $hoscode[]=$hosuser2[$i]; 
                }   
               // var_dump($hoscode);

               
?>

    </div>
  </div>


