<?php
use yii\helpers\Url;
use yii\helpers\Html;


?>
<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>

<button id='link' value="http://203.157.151.20/eh/backend/web/documents/4288e3330b2e365eceed74c27b4c95dd.pdf">Get External Content</button>
<button id='link2' value="http://infolab.stanford.edu/pub/papers/google.pdf">Get External Content</button>
<?php // searchname: $('#link2').val()  ,
$docs='http://infolab.stanford.edu/pub/papers/google.pdf';
echo Html::button('Button 3', [ 'class' => 'btn btn-primary', 
  'onclick' => "(function () {
    $.ajax({
       url: '".Url::toRoute('report/calldocs')."',
       type: 'post',
       data: {
                 searchname: '".$docs."'  , 
               
                 _csrf : '".Yii::$app->request->getCsrfToken()."'
             },
       success: function (data) {
          console.log(data.search);
          $('#docs').html(data);
       }
  });

    })();" ]);
?>
        </div>
        <div class="modal-body"><!-- body -->
        	 <center><div  class="embed-responsive embed-responsive-16by9">
            <div id='docs'>

            </div>
          
 			 </div></center><!-- endcontent -->
        </div><!-- endbody -->
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  <!-- endModal -->
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    $("#link").click(function(){

 $.ajax({
       url: '<?php echo Url::toRoute('report/calldocs'); ?>',
       type: 'post',
       data: {
                 searchname: $("#link").val()  , 
                // searchby: $("#link2").val()  , 
                 _csrf : '<?=Yii::$app->request->getCsrfToken()?>'
             },
       success: function (data) {
          console.log(data.search);
          $("#docs").html(data);
       }
  });
});
});
$(document).ready(function(){
    $("#link2").click(function(){

 $.ajax({
       url: '<?php echo Url::toRoute('report/calldocs'); ?>',
       type: 'post',
       data: {
                 searchname: $("#link2").val()  , 
                // searchby: $("#link2").val()  , 
                 _csrf : '<?=Yii::$app->request->getCsrfToken()?>'
             },
       success: function (data) {
          console.log(data.search);
          $("#docs").html(data);
       }
  });
});
});
</script>



