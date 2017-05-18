<?php
 $url=Yii::$app->urlManager->createUrl(['report/report/index']);
         Yii::$app->getResponse()->redirect($url);

?>