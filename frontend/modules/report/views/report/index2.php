<?php
//var_dump($data_notify);
// echo count($data_notify);
//var_dump($ridnot);
// $cg[]['level_color'];
// $cg[]['level_icon'];

//var_dump($cgt);
$this->title = 'EH เอ๊ะ';
?>
<style type="text/css">
a:link    {color:#FFF; background-color:transparent; text-decoration:none}
a:visited {color:#FFF; background-color:transparent; text-decoration:none}
a:hover   {color:#FFF; background-color:transparent; text-decoration:none}
/*a:active  {color:yellow; background-color:transparent; text-decoration:none}*/

</style>
<div class="box box-solid bg-black-gradient">
  <div class="box-header ui-sortable-handle" style="cursor: move;">
                  <i class="fa fa-bookmark"></i>
                  <h3 class="box-title">10 อันดับติดตาม</h3>
                  <!-- tools box -->
                  <div class="pull-right box-tools">
                    <!-- button with a dropdown -->
                   
                  </div><!-- /. tools -->
                </div>
<div class="box-footer text-black">
<div class="row">
                    <div class="col-sm-6">
                      <!-- Progress bars -->
                       <a class='text-black'href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$notify_topten[0][0]['report_id']; ?>">
                      <div class="clearfix">
                        <span class="pull-left"><?=$notify_topten[0][0]['report_name'];?></span>
                        <small class="pull-right"><?=number_format($notify_topten[0][0]['y_cases']);?>/<?=number_format($notify_topten[0][0]['percent'],2);?>%</small>
                      </div>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-<?=$cgt[0]['level_color'];?>" style="width: <?=number_format($notify_topten[0][0]['percent'],2);?>%;"></div>
                      </div>
                    </a>
                       <a class='text-black'href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$notify_topten[1][0]['report_id']; ?>">
                      <div class="clearfix">
                        <span class="pull-left"><?=$notify_topten[1][0]['report_name'];?></span>
                        <small class="pull-right"><?=number_format($notify_topten[1][0]['y_cases']);?>/<?=number_format($notify_topten[1][0]['percent'],2);?>%</small>
                      </div>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-<?=$cgt[1]['level_color'];?>" style="width: <?=number_format($notify_topten[1][0]['percent'],2);?>%;"></div>
                      </div>
                    </a>
                       <a class='text-black'href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$notify_topten[2][0]['report_id']; ?>">
                       <div class="clearfix">
                        <span class="pull-left"><?=$notify_topten[2][0]['report_name'];?></span>
                        <small class="pull-right"><?=number_format($notify_topten[2][0]['y_cases']);?>/<?=number_format($notify_topten[2][0]['percent'],2);?>%</small>
                      </div>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-<?=$cgt[2]['level_color'];?>" style="width: <?=number_format($notify_topten[2][0]['percent'],2);?>%;"></div>
                      </div>
                    </a>
                       <a class='text-black'href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$notify_topten[3][0]['report_id']; ?>">
                       <div class="clearfix">
                        <span class="pull-left"><?=$notify_topten[3][0]['report_name'];?></span>
                        <small class="pull-right"><?=number_format($notify_topten[3][0]['y_cases']);?>/<?=number_format($notify_topten[3][0]['percent'],2);?>%</small>
                      </div>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-<?=$cgt[3]['level_color'];?>" style="width: <?=number_format($notify_topten[3][0]['percent'],2);?>%;"></div>
                      </div>
                    </a>
                     <a class='text-black'href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$notify_topten[4][0]['report_id']; ?>">
                       <div class="clearfix">
                        <span class="pull-left"><?=$notify_topten[4][0]['report_name'];?></span>
                        <small class="pull-right"><?=number_format($notify_topten[4][0]['y_cases']);?>/<?=number_format($notify_topten[4][0]['percent'],2);?>%</small>
                      </div>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-<?=$cgt[4]['level_color'];?>" style="width: <?=number_format($notify_topten[4][0]['percent'],2);?>%;"></div>
                      </div>
                    </a>
                    </div><!-- /.col -->
                     <div class="col-sm-6">
                      <!-- Progress bars -->
                       <a class='text-black'href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$notify_topten[5][0]['report_id']; ?>">
                      <div class="clearfix">
                        <span class="pull-left"><?=$notify_topten[5][0]['report_name'];?></span>
                        <small class="pull-right"><?=number_format($notify_topten[5][0]['y_cases']);?>/<?=number_format($notify_topten[5][0]['percent'],2);?>%</small>
                      </div>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-<?=$cgt[5]['level_color'];?>" style="width: <?=number_format($notify_topten[5][0]['percent'],2);?>%;"></div>
                      </div>
                    </a>
                     <a class='text-black'href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$notify_topten[6][0]['report_id']; ?>">
                        <div class="clearfix">
                        <span class="pull-left"><?=$notify_topten[6][0]['report_name'];?></span>
                        <small class="pull-right"><?=number_format($notify_topten[6][0]['y_cases']);?>/<?=number_format($notify_topten[6][0]['percent'],2);?>%</small>
                      </div>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-<?=$cgt[6]['level_color'];?>" style="width: <?=number_format($notify_topten[6][0]['percent'],2);?>%;"></div>
                      </div>
                    </a>
                     <a class='text-black'href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$notify_topten[7][0]['report_id']; ?>">
                      <div class="clearfix">
                        <span class="pull-left"><?=$notify_topten[7][0]['report_name'];?></span>
                        <small class="pull-right"><?=number_format($notify_topten[7][0]['y_cases']);?>/<?=number_format($notify_topten[7][0]['percent'],2);?>%</small>
                      </div>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-<?=$cgt[7]['level_color'];?>" style="width: <?=number_format($notify_topten[7][0]['percent'],2);?>%;"></div>
                      </div>
                    </a>
                     <a class='text-black'href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$notify_topten[8][0]['report_id']; ?>">
                      <div class="clearfix">
                        <span class="pull-left"><?=$notify_topten[8][0]['report_name'];?></span>
                        <small class="pull-right"><?=number_format($notify_topten[8][0]['y_cases']);?>/<?=number_format($notify_topten[8][0]['percent'],2);?>%</small>
                      </div>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-<?=$cgt[8]['level_color'];?>" style="width: <?=number_format($notify_topten[8][0]['percent'],2);?>%;"></div>
                      </div>
                    </a>
                     <a class='text-black'href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$notify_topten[9][0]['report_id']; ?>">
                      <div class="clearfix">
                        <span class="pull-left"><?=$notify_topten[9][0]['report_name'];?></span>
                        <small class="pull-right"><?=number_format($notify_topten[9][0]['y_cases']);?>/<?=number_format($notify_topten[9][0]['percent'],2);?>%</small>
                      </div>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-<?=$cgt[9]['level_color'];?>" style="width: <?=number_format($notify_topten[9][0]['percent'],2);?>%;"></div>
                      </div>
                    </a>
                      
                    </div><!-- /.col -->
                  </div>
 </div>
</div>



<div class="col-md-4">
              <!-- Info Boxes Style 2 -->
              <div class="info-box <?=$cg[0]['level_color'];?>">
                <a  data-toggle="tooltip" title="<?=$data_notify[0]['report_name'];?>" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[0]['report_id']; ?>">
                <span class="info-box-icon"><i class="<?=$cg[0]['level_icon'];?>"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text"><?=$data_notify[0]['report_name'];?></span>
                  <span class="info-box-number"><?=number_format($data_notify[0]['y_cases']);?></span>
                  <div class="progress">
                    <div class="progress-bar" style="width: <?=$data_notify[0]['percent'];?>%"></div>
                  </div>
                  <span class="info-box-number">
                  <?=number_format($data_notify[0]['percent'],2);?>%
                  </span>
                </a>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
              <div class="info-box <?=$cg[1]['level_color'];?>">
                <a data-toggle="tooltip" title="<?=$data_notify[1]['report_name'];?>" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[1]['report_id']; ?>">
                <span class="info-box-icon"><i class="<?=$cg[1]['level_icon'];?>"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text"><?=$data_notify[1]['report_name'];?></span>
                  <span class="info-box-number"><?=number_format($data_notify[1]['y_cases']);?></span>
                  <div class="progress">
                    <div class="progress-bar" style="width: <?=$data_notify[1]['percent'];?>%"></div>
                  </div>
                  <span class="info-box-number">
                    <?=number_format($data_notify[1]['percent'],2);?>%
                  </span>
                </a>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
              <div class="info-box <?=$cg[2]['level_color'];?>">
                <a data-toggle="tooltip" title="<?=$data_notify[2]['report_name'];?>" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[2]['report_id']; ?>">
                <span class="info-box-icon"><i class="<?=$cg[2]['level_icon'];?>"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text"><?=$data_notify[2]['report_name'];?></span>
                  <span class="info-box-number"><?=number_format($data_notify[2]['y_cases']);?></span>
                  <div class="progress">
                    <div class="progress-bar" style="width: <?=$data_notify[2]['percent'];?>%"></div>
                  </div>
                  <span class="progress-description">
                    <?=number_format($data_notify[2]['percent'],2);?>%
                  </span>
                </a>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
              <div class="info-box <?=$cg[3]['level_color'];?>">
                <a data-toggle="tooltip" title="<?=$data_notify[3]['report_name'];?>" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[3]['report_id']; ?>">
                <span class="info-box-icon"><i class="<?=$cg[3]['level_icon'];?>"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text"><?=$data_notify[3]['report_name'];?></span>
                  <span class="info-box-number"><?=number_format($data_notify[3]['y_cases']);?></span>
                  <div class="progress">
                    <div class="progress-bar" style="width: <?=$data_notify[3]['percent'];?>%"></div>
                  </div>
                  <span class="progress-description">
                    <?=number_format($data_notify[3]['percent'],2);?>%
                  </span>
                </a>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->

            
            </div>
            

      <div class="col-md-6">
              <div class="box">
                <div class="box-header with-border">
                  <h3 class="box-title"><a style="color:#00C0EF;" href="
                    <?=Yii::$app->homeUrl;?>?r=report/report/notifyall">ดูรายงานทั้งหมด</a></h3>
                  <div class="box-tools pull-right">
                    <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                   <!--  <div class="btn-group">
                      <button class="btn btn-box-tool dropdown-toggle" data-toggle="dropdown"><i class="fa fa-wrench"></i></button>
                      <ul class="dropdown-menu" role="menu">
                        <li><a href="#">Action</a></li>
                        <li><a href="#">Another action</a></li>
                        <li><a href="#">Something else here</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Separated link</a></li>
                      </ul>
                    </div> -->
                    <button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                  </div>
                </div><!-- /.box-header -->
                <div class="box-body">
                  <div class="row">
                    
                    <div class="col-md-6">
                      <p class="text-center">
                        <strong>&nbsp;</strong>
                      </p>
                      <div class="progress-group">
                       <a data-toggle="tooltip" title="<?=$data_notify[4]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[4]['report_id']; ?>">
                        <span class="progress-text "><?=$data_notify[4]['report_name'];?></span>
                        <span class="progress-number"><b><?=number_format($data_notify[4]['y_cases']);?>/<?=number_format($data_notify[4]['percent'],2);?>%</b></span>
                         </a>
                        <div class="progress sm">
                          <div class="progress-bar <?=$cg[4]['level_color'];?>" style="width: <?=$data_notify[4]['percent'];?>%"></div>
                        </div>
                      </div><!-- /.progress-group -->
                      <div class="progress-group">
                        <a  data-toggle="tooltip" title="<?=$data_notify[5]['report_name'];?>"style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[5]['report_id']; ?>">
                        
                        <span class="progress-text"><?=$data_notify[5]['report_name'];?></span>
                        <span class="progress-number"><b><?=number_format($data_notify[5]['y_cases']);?>/<?=number_format($data_notify[5]['percent'],2);?>%</b></span>
                        </a>
                        <div class="progress sm">
                          <div class="progress-bar <?=$cg[5]['level_color'];?>" style="width: <?=$data_notify[5]['percent'];?>%"></div>
                        </div>
                      </div><!-- /.progress-group -->
                      <div class="progress-group">
                        <a data-toggle="tooltip" title="<?=$data_notify[6]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[6]['report_id']; ?>">
                        
                        <span class="progress-text" ><?=$data_notify[6]['report_name'];?></span>
                        <span class="progress-number"><b><?=number_format($data_notify[6]['y_cases']);?>/<?=number_format($data_notify[6]['percent'],2);?>%</b></span>
                      </a>
                        <div class="progress sm">
                          <div class="progress-bar <?=$cg[6]['level_color'];?>" style="width: <?=$data_notify[6]['percent'];?>%"></div>
                        </div>
                      </div><!-- /.progress-group -->
                      <div class="progress-group" >
                        <a data-toggle="tooltip" title="<?=$data_notify[7]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[7]['report_id']; ?>">
                        
                        <span class="progress-text" ><?=$data_notify[7]['report_name'];?></span>
                        <span class="progress-number"><b><?=number_format($data_notify[7]['y_cases']);?>/<?=number_format($data_notify[7]['percent'],2);?>%</b></span>
                      </a>
                        <div class="progress sm">
                          <div class="progress-bar <?=$cg[7]['level_color'];?>" style="width: <?=$data_notify[7]['percent'];?>%"></div>
                        </div>
                      </div><!-- /.progress-group -->
                    </div><!-- /.col -->

                       <div class="col-md-6">
                      <p class="text-center">
                        <strong>&nbsp;</strong>
                      </p>
                      <div class="progress-group" >
                        <a data-toggle="tooltip" title="<?=$data_notify[8]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[8]['report_id']; ?>">
                        
                        <span class="progress-text"><?=$data_notify[8]['report_name'];?></span>
                        <span class="progress-number"><b><?=number_format($data_notify[8]['y_cases']);?>/<?=number_format($data_notify[8]['percent'],2);?>%</b></span>
                      </a>
                        <div class="progress sm">
                          <div class="progress-bar <?=$cg[8]['level_color'];?>" style="width: <?=$data_notify[8]['percent'];?>%"></div>
                        </div>
                      </div><!-- /.progress-group -->
                      <div class="progress-group">
                        <a data-toggle="tooltip" title="<?=$data_notify[9]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[9]['report_id']; ?>">
                        
                        <span class="progress-text"><?=$data_notify[9]['report_name'];?></span>
                        <span class="progress-number"><b><?=number_format($data_notify[9]['y_cases']);?>/<?=number_format($data_notify[9]['percent'],2);?>%</b></span>
                      </a>
                        <div class="progress sm">
                          <div class="progress-bar <?=$cg[9]['level_color'];?>" style="width: <?=$data_notify[9]['percent'];?>%"></div>
                        </div>
                      </div><!-- /.progress-group -->
                      <div class="progress-group">
                        <a data-toggle="tooltip" title="<?=$data_notify[10]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[10]['report_id']; ?>">
                        
                        <span class="progress-text"><?=$data_notify[10]['report_name'];?></span>
                        <span class="progress-number"><b><?=number_format($data_notify[10]['y_cases']);?>/<?=number_format($data_notify[10]['percent'],2);?>%</b></span>
                      </a>
                        <div class="progress sm">
                          <div class="progress-bar <?=$cg[10]['level_color'];?>" style="width: <?=$data_notify[10]['percent'];?>%"></div>
                        </div>
                      </div><!-- /.progress-group -->
                      <div class="progress-group">
                        <a data-toggle="tooltip" title="<?=$data_notify[11]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[11]['report_id']; ?>">
                        
                        <span class="progress-text"><?=$data_notify[11]['report_name'];?></span>
                        <span class="progress-number"><b><?=number_format($data_notify[11]['y_cases']);?>/<?=number_format($data_notify[11]['percent'],2);?>%</b></span>
                      </a>
                        <div class="progress sm">
                          <div class="progress-bar <?=$cg[11]['level_color'];?>" style="width: <?=$data_notify[11]['percent'];?>%"></div>
                        </div>
                      </div><!-- /.progress-group -->
                    </div><!-- /.col -->

                       

                  </div><!-- /.row -->
                </div><!-- ./box-body -->
                <div class="box-footer">
                  <div class="row">
                    <div class="col-sm-3 col-xs-6">
                      <div class="description-block border-right">
                        <span class="description-percentage text-green"><i class=""></i>&nbsp;</span>
                        <h5 class="description-header"><span class="description-percentage <?=$cg[12]['level_color'];?>">
                          <?=number_format($data_notify[12]['y_cases']);?>/<?=number_format($data_notify[12]['percent'],2);?>%</span> </h5>
                          <a data-toggle="tooltip" title="<?=$data_notify[12]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[12]['report_id']; ?>">
                        
                        <span class="description-text" ><?=$data_notify[12]['report_name'];?></span>
                      </a>
                      </div><!-- /.description-block -->
                    </div><!-- /.col -->
                    <div class="col-sm-3 col-xs-6">
                      <div class="description-block border-right">
                         <span class="description-percentage text-green"><i class=""></i>&nbsp;</span>
                        <h5 class="description-header"><span class="description-percentage <?=$cg[13]['level_color'];?>">
                          <?=number_format($data_notify[13]['y_cases']);?>/<?=number_format($data_notify[13]['percent'],2);?>%</span> </h5>
                          <a data-toggle="tooltip" title="<?=$data_notify[13]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[13]['report_id']; ?>">
                        
                        <span class="description-text"><?=$data_notify[13]['report_name'];?></span>
                      </a>
                      </div><!-- /.description-block -->
                    </div><!-- /.col -->
                    <div class="col-sm-3 col-xs-6">
                      <div class="description-block border-right">
                        <span class="description-percentage text-green"><i class=""></i>&nbsp;</span>
                        <h5 class="description-header"><span class="description-percentage <?=$cg[14]['level_color'];?>">
                          <?=number_format($data_notify[14]['y_cases']);?>/<?=number_format($data_notify[14]['percent'],2);?>%</span> </h5>
                          <a data-toggle="tooltip" title="<?=$data_notify[14]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[14]['report_id']; ?>">
                        
                        <span class="description-text"><?=$data_notify[14]['report_name'];?></span>
                      </a>
                      </div><!-- /.description-block -->
                    </div><!-- /.col -->
                    <div class="col-sm-3 col-xs-6">
                      <div class="description-block">
                        <span class="description-percentage text-green"><i class=""></i>&nbsp;</span>
                        <h5 class="description-header"><span class="description-percentage <?=$cg[15]['level_color'];?>">
                          <?=number_format($data_notify[15]['y_cases']);?>/<?=number_format($data_notify[15]['percent'],2);?>%</span> </h5>
                          <a data-toggle="tooltip" title="<?=$data_notify[15]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[15]['report_id']; ?>">
                        
                        <span class="description-text"><?=$data_notify[15]['report_name'];?></span>
                      </a>
                      </div><!-- /.description-block -->
                    </div>
                  </div><!-- /.row -->
                </div><!-- /.box-footer -->
              </div><!-- /.box -->
            </div>

              <div class="row">
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">
                <a data-toggle="tooltip" title="<?=$data_notify[16]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[16]['report_id']; ?>">
                        
                <span class="info-box-icon <?=$cg[16]['level_color'];?>"><i class="<?=$cg[16]['level_icon'];?>"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text"><?=$data_notify[16]['report_name'];?></span>
                  <span class="info-box-number"><small><?=number_format($data_notify[16]['y_cases']);?></small><br>
                    (<?=number_format($data_notify[16]['percent'],2);?>%)</span>
                </div><!-- /.info-box-content -->
              </a>
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">
                <a data-toggle="tooltip" title="<?=$data_notify[17]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[17]['report_id']; ?>">
                        
                <span class="info-box-icon <?=$cg[17]['level_color'];?>"><i class="<?=$cg[17]['level_icon'];?>"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text"><?=$data_notify[17]['report_name'];?></span>
                  <span class="info-box-number"><small><?=number_format($data_notify[17]['y_cases']);?></small><br>
                    (<?=number_format($data_notify[17]['percent'],2);?>%)</span>
                </div><!-- /.info-box-content -->
              </a>
              </div><!-- /.info-box -->
            </div><!-- /.col -->

            <!-- fix for small devices only -->
            <div class="clearfix visible-sm-block"></div>

            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">
                <a data-toggle="tooltip" title="<?=$data_notify[18]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[18]['report_id']; ?>">
                        
                <span class="info-box-icon <?=$cg[18]['level_color'];?>"><i class="<?=$cg[18]['level_icon'];?>"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text"><?=$data_notify[18]['report_name'];?></span>
                  <span class="info-box-number"><small><?=number_format($data_notify[18]['y_cases']);?></small><br>
                    (<?=number_format($data_notify[18]['percent'],2);?>%)</span>
                </div><!-- /.info-box-content -->
              </a>
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">
                <a data-toggle="tooltip" title="<?=$data_notify[19]['report_name'];?>" style="color:black;" href="<?=Yii::$app->homeUrl;?>?r=report/report/chk&r_table=<?=$data_notify[19]['report_id']; ?>">
                        
                <span class="info-box-icon <?=$cg[19]['level_color'];?>"><i class="<?=$cg[19]['level_icon'];?>"></i></span>
                <div class="info-box-content">
                   <span class="info-box-text"><?=$data_notify[19]['report_name'];?></span>
                  <span class="info-box-number"><small><?=number_format($data_notify[19]['y_cases']);?></small><br>
                    (<?=number_format($data_notify[19]['percent'],2);?>%)</span>
                </div><!-- /.info-box-content -->
              </a>
              </div><!-- /.info-box -->
            </div><!-- /.col -->
          </div>       


          <div class="box box-info" >
                <div class="box-header ui-sortable-handle" style="cursor: move;">
                  <i class="fa fa-check"></i>
                  <h3 class="box-title">การแปรผลระดับความผิดพลาดของข้อมูล</h3>
                  <!-- tools box -->
                  <div class="pull-right box-tools">
                    <!-- <button class="btn btn-info btn-sm" data-widget="remove" data-toggle="tooltip" title="" data-original-title="Remove"><i class="fa fa-times"></i></button> -->
                  </div><!-- /. tools -->
                </div>
                <div class="box-body">
                   <div class="row">
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">          
                <span class="info-box-icon bg-aqua"><i class="ion ion-ios-heart-outline"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text">มีข้อมูลต้องสงสัย</span>
                  <span class="info-box-number"><small>เท่ากับ 0%</small><br>
                    <small>(0 %)</small></span>
                </div><!-- /.info-box-content -->
              
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">          
                <span class="info-box-icon bg-green"><i class="fa fa-database"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text">มีข้อมูลต้องสงสัย</span>
                  <span class="info-box-number"><small>น้อยกว่าหรือเท่ากับ 1% </small><br>
                    <small>(<=1%)</small></span>
                </div><!-- /.info-box-content -->
              
              </div><!-- /.info-box -->
            </div><!-- /.col -->

            <!-- fix for small devices only -->
            <div class="clearfix visible-sm-block"></div>

            <div class="col-md-3 col-sm-6 col-xs-12">
             <div class="info-box">          
                <span class="info-box-icon bg-yellow"><i class="ion-ios-chatbubble-outline"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text">มีข้อมูลต้องสงสัย</span>
                  <span class="info-box-number"><small>น้อยกว่าหรือเท่ากับ 20%</small><br>
                    <small>(<=20%)</small></span>
                </div><!-- /.info-box-content -->
              
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">          
                <span class="info-box-icon bg-red"><i class="fa fa-exclamation"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text">มีข้อมูลต้องสงสัย</span>
                  <span class="info-box-number"><small>มากกว่า 20% ขึ้นไป</small><br>
                    <small>(>20%)</small></span>
                </div><!-- /.info-box-content -->
              
              </div><!-- /.info-box -->
            </div><!-- /.col -->
          </div>       
                  
                </div>
                <div class="box-footer clearfix">
                  
                </div>
              </div>
          


 <script src="/eh/frontend/themes/lte/cssjs/plugins/knob/jquery.knob.js" type="text/javascript"></script>
  <script src="/eh/frontend/themes/lte/cssjs/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
                 <?php
          $this->registerJsFile('/eh/frontend/themes/lte/cssjs/bootstrap/js/bootstrap.min.js');
           $this->registerJsFile('/eh/frontend/themes/lte/cssjs/plugins/knob/jquery.knob.js');


          ?>