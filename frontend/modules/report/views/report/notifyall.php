
<style type="text/css">
a:link    {color:#FFF; background-color:transparent; text-decoration:none}
a:visited {color:#FFF; background-color:transparent; text-decoration:none}
a:hover   {color:#FFF; background-color:transparent; text-decoration:none}
/*a:active  {color:yellow; background-color:transparent; text-decoration:none}*/
</style>

<div class="pad margin no-print">
          <div class="callout callout-info" style="margin-bottom: 0!important;">
            <h4><i class="fa fa-info"></i> Note:</h4>
            รายงานที่มีข้อผิดพลาดเกิดขึ้นทั้งหมด
          </div>
        </div>

<div class="row">
		<!--startbox-->
		<?php


   # var_dump($data_notify);
			  for($i=0;$i<sizeof($data_notify);$i++){
          if($data_notify[$i]['percent']==0){
			  	$level_color='bg-aqua';
          $level_icon='ion ion-ios-heart-outline';
            }else if($data_notify[$i]['percent']<=1){
              $level_color='bg-green';
              $level_icon='fa fa-database';
            }else if($data_notify[$i]['percent']<=20){
              $level_color='bg-yellow';
              $level_icon='ion-ios-chatbubble-outline';
            }else if($data_notify[$i]['percent']>20){
              $level_color='bg-red';
              $level_icon='fa fa-exclamation';
            }
			
		?>
		<div class="col-md-4">
 			<div class="info-box <?=$level_color;?>">
                <a href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[$i]['report_id']; ?>">
                <span class="info-box-icon"><i class="<?=$level_icon;?>"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text"><?=$data_notify[$i]['report_name'];?></span>
                  <span class="info-box-number"><?=number_format($data_notify[$i]['y_cases']);?></span>
                  <div class="progress">
                    <div class="progress-bar" style="width: <?=$data_notify[$i]['percent'];?>%"></div>
                  </div>
                  <span class="info-box-number">
                 <?php echo number_format($data_notify[$i]['percent'],2);?>%
                  </span>
                </a>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
         </div>
         <!--endbox-->
         <?php } ?>

     </div>


<script src="/eh/frontend/themes/lte/cssjs/plugins/knob/jquery.knob.js" type="text/javascript"></script>
  <script src="/eh/frontend/themes/lte/cssjs/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
                 <?php
          $this->registerJsFile('/eh/frontend/themes/lte/cssjs/bootstrap/js/bootstrap.min.js');
           $this->registerJsFile('/eh/frontend/themes/lte/cssjs/plugins/knob/jquery.knob.js');

          ?>
     


