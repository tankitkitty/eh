/*
Navicat MySQL Data Transfer

Source Server         : HDC
Source Server Version : 50615
Source Host           : 203.157.151.20:3306
Source Database       : eh_begin

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2017-06-06 11:20:38
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `diag_no_price`
-- ----------------------------
DROP TABLE IF EXISTS `diag_no_price`;
CREATE TABLE `diag_no_price` (
`code`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`reference`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`code`)
)
ENGINE=MyISAM
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of diag_no_price
-- ----------------------------
BEGIN;
INSERT INTO `diag_no_price` VALUES ('Z001', 'การตรวจสุขภาพเด็กตามปกติ', null), ('Z131', 'การตรวจคัดกรองพิเศษสำหรับเบาหวาน', null), ('Z138', 'การตรวจคัดกรองพิเศษสำหรับโรคและความผิดปกติอื่นที่ระบุรายละเอียด', null), ('Z713', 'การให้คำปรึกษาและการเฝ้าระวังด้านอาหาร', null), ('Z133', 'การตรวจคัดกรองพิเศษสำหรับความผิดปกติทางจิตและพฤติกรรม', null), ('Z123', 'การตรวจมะเร็งเต้านม', null), ('Z124', 'การตรวจมะเร็งปากมดลูก', null), ('Z013', 'การตรวจความดันโลหิต', null), ('Z011', 'การตรวจหูและการได้ยิน', null), ('Z012', 'การตรวจทางทันตกรรม', null), ('Z010', 'การตรวจตาและการมองเห็น', null), ('Z014', 'การตรวจทางนรีเวชวิทยา(ทั่วไป)', null), ('Z108', 'ตรวจสุขภาพนักเรียน', null);
COMMIT;

-- ----------------------------
-- Table structure for `sys_report`
-- ----------------------------
DROP TABLE IF EXISTS `sys_report`;
CREATE TABLE `sys_report` (
`report_id`  int(9) NOT NULL AUTO_INCREMENT ,
`report_name`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ชื่อรายงาน' ,
`a_table`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`s_table`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ตารางประมวลผลแล้ว' ,
`t_table`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`t_sql`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ประมวลจากตาราง ตัวอย่างการเก็บ(table1|table2)' ,
`s_sql`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'script sql ประมวลผล' ,
`a_sql`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`active`  int(1) NOT NULL DEFAULT 1 ,
`aname`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`bname`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`notice`  longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'หมาเหตุ, แหล่งข้อมูล' ,
`report_procedure`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`menu_group`  varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'c' COMMENT 'รหัสกลุ่มรายงาน' ,
`pageview`  int(3) NULL DEFAULT 25 ,
`defination`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`docs`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`ref`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`report_id`)
)
ENGINE=MyISAM
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=10070

;

-- ----------------------------
-- Records of sys_report
-- ----------------------------
BEGIN;
INSERT INTO `sys_report` VALUES ('1', 'ตรวจสอบความไม่เชื่อมโยงระหว่างแฟ้ม ANC กับ PERSON', 'anc_noperson_a', 'anc_noperson_s', 'anc_noperson_t', 'select a.hospcode,c.hosname,a.PID,p.pid,a.DATE_SERV,cast(a.ga as signed) as ga\r\nfrom hdc.anc a\r\nleft join hdc.person p on p.hospcode=a.hospcode and p.pid=a.pid\r\nLEFT JOIN hdc.chospital c on c.hoscode=a.HOSPCODE\r\nwhere p.pid is null\r\nAND a.date_serv BETWEEN @start_d AND @end_d  \r\norder by a.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.anc \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN \r\n(select a.hospcode,c.hosname, count(a.pid) as y_cases ,c.distcode\r\nfrom hdc.anc a\r\nleft join hdc.person p on p.hospcode=a.hospcode and p.pid=a.pid\r\nLEFT JOIN hdc.chospital c on c.hoscode=a.HOSPCODE \r\nwhere p.pid is null \r\nAND a.date_serv BETWEEN @start_d AND @end_d  \r\ngroup by a.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(a.pid) as pid FROM hdc.anc a\r\njoin hdc.chospital c on c.hoscode=a.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere a.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(a.pid) as y_cases\r\nfrom hdc.anc a\r\nleft join hdc.person p on p.hospcode=a.hospcode and p.pid=a.pid\r\njoin hdc.chospital c on c.hoscode=a.HOSPCODE\r\nwhere p.pid is null \r\nAND a.date_serv BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'anc_noperson', 'anc', '25', 'เอ๊ะ!! มีข้อมูลทะเบียนบุคคล (pid) ก่อนคลอด ในแฟ้ม anc แต่ไม่มีข้อมูลทะเบียนบุคคล (pid) ในแฟ้ม person', '{\"1c68c299f79e33ac2d35c374b5f9aa0d.pdf\":\"1_ANC_Person.pdf\"}', '7ZsQFVbfPmuxvJvGeFcRC7'), ('2', 'ตรวจสอบ ความไม่เชื่อมโยงระหว่างแฟ้ม NEWBORN กับ PERSON', 'newborn_noperson_a', 'newborn_noperson_s', 'newborn_noperson_t', 'select n.hospcode,c.hosname,n.PID,p.pid as person_pid,n.BDATE\r\nfrom hdc.newborn n\r\nLEFT JOIN hdc.chospital c on c.hoscode=n.HOSPCODE\r\nleft join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid\r\nwhere p.pid is null AND n.bdate BETWEEN @start_d AND @end_d\r\norder by n.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.newborn \r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select n.hospcode,c.hosname,count(n.pid) as y_cases, c.distcode\r\nfrom hdc.newborn n\r\nLEFT JOIN hdc.chospital c on c.hoscode=n.HOSPCODE\r\nleft join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid\r\nwhere p.pid is null AND n.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY n.hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.newborn n\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere n.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(n.pid) as y_cases\r\nfrom hdc.newborn n\r\nleft join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere p.pid is null AND n.bdate BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'newborn_noperson', 'newborn', '25', 'เอ๊ะ!! มีทะเบียนบุคคล(pid)การคลอดทารกแฟ้ม newborn แต่ไม่มีทะเบียนบุคคล(pid)ใน person', '{\"1eab6d5e4ce25ac03e920d90b29e345f.pdf\":\"2_NEWBORN_Noperson.pdf\"}', 'NDoRCF2qL7v--8-fLKBF2D'), ('4', 'ตรวจสอบผลการฝากครรภ์ที่ผิดปกติ', 'anc_falseresult_a', 'anc_falseresult_s', 'anc_falseresult_t', 'select a.hospcode, c.hosname,a.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,DATE_SERV,\r\n(if(ancresult=2,ancresult,NULL)) as abnormal, \r\n(if(ancresult=9,ancresult,NULL)) as unknown, \r\n(if(ancresult not in (1,2,9),ancresult,NULL)) as error \r\nfrom hdc.anc a\r\nleft join hdc.person p on p.hospcode=a.hospcode and p.pid=a.pid\r\nLEFT JOIN hdc.chospital c on c.hoscode=a.HOSPCODE\r\nwhere \r\na.ancresult not in (\'1\') and\r\na.date_serv BETWEEN @start_d AND @end_d \r\norder by HOSPCODE \r\n', 'select hospcode,c.hosname,concat(@province,c.distcode) as distcode, \r\ncount(a.pid) as total,\r\nsum(if(ancresult=1,1,0)) as normal, \r\nsum(if(ancresult=2,1,0)) as abnormal, \r\nsum(if(ancresult=9,1,0)) as unknown, \r\nsum(if(ancresult not in (1,2,9),1,0)) as error,\r\nsum(if(ancresult=2,1,0))+sum(if(ancresult=9,1,0))+sum(if(ancresult not in (1,2,9),1,0)) as y_cases,\r\nround(((sum(if(ancresult=2,1,0))+sum(if(ancresult=9,1,0))+sum(if(ancresult not in (1,2,9),1,0)))/count(pid))*100,2) as percent\r\nfrom hdc.anc a\r\nLEFT JOIN hdc.chospital c on c.hoscode=a.HOSPCODE\r\nWHERE \r\na.date_serv BETWEEN @start_d AND @end_d \r\ngroup by hospcode\r\norder by percent desc, error desc, hospcode', 'select concat(@province,c.distcode) as distcode,ca.ampurname, \r\ncount(pid) as total_pid,\r\nsum(if(ancresult=2,1,0))+sum(if(ancresult=9,1,0))+sum(if(ancresult not in (1,2,9),1,0)) as y_cases,\r\nround(((sum(if(ancresult=2,1,0))+sum(if(ancresult=9,1,0))+sum(if(ancresult not in (1,2,9),1,0)))/count(pid))*100,2) as percent\r\nfrom hdc.anc a\r\nJOIN hdc.chospital c on c.hoscode=a.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province \r\nWHERE a.date_serv BETWEEN @start_d AND @end_d\r\ngroup by c.distcode\r\norder by y_cases desc ', '1', '', '', '', 'anc_falseresult', 'anc', '25', 'เอ๊ะ!! มีการบันทึกผลการฝากครรภ์ มีผลการตรวจ(ancresult) = 2 (ผิดปกติ)', '{\"81363a0adf2ffbaafdec5b57991a247b.pdf\":\"4_ANC_Falseresult.pdf\"}', 'r28kq6J6Zhq48WQdYhGsAH'), ('6', 'ตรวจสอบการเยี่ยมมารดาหลังคลอด', 'postnatal_after_a', 'postnatal_after_s', 'postnatal_after_t', 'select p.hospcode,c.hosname,p.pid,concat(pe.`NAME`,\' \',pe.LNAME)as fullname,p.gravida,p.bdate,p.ppcare,p.provider\r\nfrom hdc.postnatal p\r\nleft join hdc.person pe on pe.hospcode=p.hospcode and pe.pid=p.pid\r\nleft outer join hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere (bdate=ppcare or gravida=\'\' or ppresult=\'\')\r\nAND p.bdate BETWEEN @start_d AND @end_d\r\norder by p.hospcode\r\n', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.postnatal \r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select p.hospcode,c.hosname,count(p.pid) as y_cases,c.distcode\r\nfrom hdc.postnatal p\r\nleft outer join hdc.chospital c on c.hoscode=p.hospcode\r\nwhere (bdate=ppcare or gravida=\'\' or ppresult=\'\')\r\nAND p.bdate BETWEEN @start_d AND @end_d  \r\ngroup by p.hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.postnatal p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere p.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(p.pid) as y_cases\r\nfrom hdc.postnatal p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere (bdate=ppcare or gravida=\'\' or ppresult=\'\')\r\nAND p.bdate BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'postnatal_after', 'anc', '25', 'เอ๊ะ!! ตรวจสอบวันที่คลอด(bdate) เป็นวันเดียวกับวันที่ดูแลแม่(ppcare) หรือ ผลการตรวจมารดาหลังคลอด (ppresult) เป็นค่าว่าง', '{\"14514cecececc17d0e70b5dab9d9143f.pdf\":\"6_ANC_Postnatal_After.pdf\"}', '_Q6iEDtGXcjGXvpEReqIhk'), ('7', 'ตรวจสอบอายุครรภ์ไม่อยู่ระหว่าง 1-45 สัปดาห์', 'anc_ga1_46_a', 'anc_ga1_46_s', 'anc_ga1_46_t', 'select a.hospcode,c.hosname,a.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,a.date_serv,a.gravida,a.ga,p.typearea \r\nfrom hdc.anc a\r\nleft outer join hdc.person p on p.pid=a.pid and a.hospcode=p.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=a.HOSPCODE  \r\nwhere (a.ga*1) not between \'1\' and \'45\'\r\nAND a.date_serv BETWEEN @start_d AND @end_d\r\norder by a.hospcode,a.pid,a.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode ,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.anc \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select a.hospcode,c.hosname,count(a.pid) as y_cases,c.distcode\r\nfrom hdc.anc a\r\nleft outer join hdc.chospital c on c.hoscode=a.hospcode\r\nleft outer join hdc.person p on p.pid=a.pid and p.hospcode=a.hospcode  \r\nwhere (a.ga*1) not between \'1\' and \'45\'\r\nAND a.date_serv BETWEEN @start_d AND @end_d \r\ngroup by a.hospcode)as st\r\non nd.hospcode=st.hospcode\r\nORDER BY st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(a.pid) as pid FROM hdc.anc a\r\njoin hdc.chospital c on c.hoscode=a.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere a.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(a.pid) as y_cases\r\nfrom hdc.anc a\r\njoin hdc.chospital c on c.hoscode=a.HOSPCODE\r\nwhere (a.ga*1) not between \'1\' and \'45\'\r\nAND a.date_serv BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc\r\n', '1', '', '', '', 'anc_ga1_46', 'anc', '25', 'เอ๊ะ!! อายุครรภ์(ga) ไม่อยู่ระหว่าง 1 ถึง 45 สัปดาห์ ท้องนานเกินไปไหม??', '{\"00c4b14a88488a05f70b348c04199940.pdf\":\"7_ANC_Anc_Ga1_46.pdf\"}', '7K997HAW1z7SOyDFofTTEs'), ('8', 'ตรวจสอบวันที่เยี่ยมมารดาหลังคลอดเป็นวันก่อนคลอดหรือวันเดียวกับวันที่คลอด', 'anc_ppcare_a', 'anc_ppcare_s', 'anc_ppcare_t', 'select c.hoscode,c.hosname,p.pid,concat(pe.`NAME`,\'\',pe.LNAME)as fullname,\r\npe.nation,p.GRAVIDA,p.ppcare,p.bdate,p.ppplace,pe.typearea \r\nfrom hdc.postnatal p\r\nleft outer join hdc.person pe on pe.pid=p.pid and pe.hospcode=p.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere p.ppcare <=p.BDATE\r\nAND p.bdate BETWEEN @start_d AND @end_d\r\norder by c.hoscode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.postnatal \r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select p.hospcode,c.hosname,count(p.pid) as y_cases,c.distcode\r\nfrom hdc.postnatal p\r\nleft outer join hdc.person pe on pe.pid=p.pid and pe.hospcode=p.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere p.ppcare <=p.BDATE\r\nAND p.bdate BETWEEN @start_d AND @end_d   \r\ngroup by p.hospcode)as st\r\non nd.hospcode=st.hospcode\r\nORDER BY y_cases desc', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.postnatal p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere p.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(p.pid) as y_cases\r\nfrom hdc.postnatal p\r\nleft outer join hdc.person pe on pe.pid=p.pid and pe.hospcode=p.hospcode\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere p.ppcare <=p.BDATE\r\nAND p.bdate BETWEEN @start_d AND @end_d\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'anc_ppcare', 'anc', '25', 'เอ๊ะ!! ทำไมวันที่ดูแลแม่หลังคลอด (ppcare) เป็นวันที่ก่อนคลอดหรือวันเดียวกับวันที่คลอด', '{\"763684a106fc8701d0cb06389ca64cfc.pdf\":\"8_ANC_Anc_Ppcare.pdf\"}', 'VTggXlzvj3feTIDJSRqdmh'), ('9', 'ตรวจสอบ ครรภ์ที่คลอดไม่ตรงกับครรภ์ที่ฝากครรภ์', 'anc_gravida_not_as_labor_a', 'anc_gravida_not_as_labor_s', 'anc_gravida_not_as_labor_t', 'select l.hospcode,concat(p1.`NAME`,\'\',p1.LNAME)as fullname,l.pid as labor_pid,a.hospcode as prenatal_hospcode,a.pid as prenatal_pid,l.bhosp,l.gravida as labor_gravida,a.gravida as prenatal_gravida,l.bdate,a.edc \r\nfrom hdc.labor l \r\nleft outer join hdc.person p1 on p1.hospcode=l.hospcode and p1.pid=l.PID \r\nleft outer join (select p2.cid,a.* from hdc.prenatal a \r\n  left outer join hdc.person p2 on p2.hospcode=a.hospcode and p2.pid=a.PID  ) a on a.cid=p1.cid\r\nleft outer join hdc.chospital c on c.hoscode=l.hospcode\r\nwhere  l.bdate between @start_d AND @end_d and l.gravida<> a.gravida \r\nand (timestampdiff(month,a.edc,l.bdate )<=\'3\' ) \r\ngroup by l.hospcode,p1.cid \r\norder by l.hospcode ', 'SELECT a.hospcode,c.hosname,concat(@province,c.distcode) as distcode,a.ta as total_pid,IFNULL(count(b.labor_pid),0) as y_cases \r\n,round((IFNULL(count(b.labor_pid),0) /a.ta)*100,2) as percent from \r\n(SELECT hospcode,count(pid) as  ta from hdc.labor  where bdate between @start_d AND @end_d  GROUP BY hospcode) a\r\nLEFT JOIN (select l.hospcode as labor_hospcode,l.pid as labor_pid,c.hosname,a.hospcode as prenatal_hospcode,a.pid as prenatal_pid,l.bhosp,l.gravida as labor_gravida,a.gravida as prenatal_gravida,l.bdate,a.edc \r\nfrom hdc.labor l \r\nleft outer join hdc.person p1 on p1.hospcode=l.hospcode and p1.pid=l.PID \r\nleft outer join (select p2.cid,a.* from hdc.prenatal a \r\n  left outer join hdc.person p2 on p2.hospcode=a.hospcode and p2.pid=a.PID  ) a on a.cid=p1.cid\r\nleft outer join hdc.chospital c on c.hoscode=l.hospcode\r\nwhere  l.bdate between @start_d AND @end_d and l.gravida<> a.gravida \r\nand (timestampdiff(month,a.edc,l.bdate )<=\'3\' ) \r\ngroup by l.hospcode,p1.cid \r\norder by l.hospcode ) b on a.hospcode=b.labor_hospcode\r\nLEFT JOIN hdc.chospital c on c.hoscode=a.hospcode\r\ngroup by a.hospcode', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere bdate between @start_d AND @end_d \r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(SELECT c.distcode,count(a.labor_pid) as y_cases from\r\n(select l.hospcode as labor_hospcode,l.pid as labor_pid,c.hosname,a.hospcode as prenatal_hospcode,a.pid as prenatal_pid,l.bhosp,l.gravida as labor_gravida,a.gravida as prenatal_gravida,l.bdate,a.edc \r\nfrom hdc.labor l \r\nleft outer join hdc.person p1 on p1.hospcode=l.hospcode and p1.pid=l.PID \r\nleft outer join (select p2.cid,a.* from hdc.prenatal a \r\n  left outer join hdc.person p2 on p2.hospcode=a.hospcode and p2.pid=a.PID  ) a on a.cid=p1.cid\r\nleft outer join hdc.chospital c on c.hoscode=l.hospcode\r\nwhere  l.bdate between @start_d AND @end_d and l.gravida<> a.gravida \r\nand (timestampdiff(month,a.edc,l.bdate )<=\'3\' ) \r\ngroup by l.hospcode,p1.cid \r\norder by l.hospcode) a\r\nLEFT JOIN hdc.chospital c on c.hoscode=a.labor_hospcode\r\nGROUP BY c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'anc_gravida_not_as_labor', 'anc', '25', 'เอ๊ะ!! ครรภ์ที่คลอดไม่ตรงกับครรภ์ที่ระบุประวัติตั้งครรภ์ โดยคิดจาก แฟ้ม Prenatal ที่มี EDC ใกล้เคียงกับวันที่ คลอด BDATE +/- 3 เดือน ของแฟ้ม LABOR เทียบ GRAVIDA ทั้ง 2 แฟ้ม', '{\"4899e5758e15e260e54bfb694fbd292b.pdf\":\"9_ANC_Gravida_Not_As_Labor.pdf\"}', 'zZ2TkFWFh6PYWE4D3hzV2c'), ('11', 'ตรวจสอบความไม่เชื่อมโยงระหว่างแฟ้ม LABOR กับ PERSON', 'labor_noperson_a', 'labor_noperson_s', 'labor_noperson_t', 'select l.hospcode,c.hosname,l.pid,p.pid as person_pid,l.bdate,l.GRAVIDA,l.BRESULT,l.bhosp \r\nfrom hdc.labor l\r\nleft join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid\r\nLEFT JOIN chospital c on c.hoscode=l.HOSPCODE\r\nwhere p.pid is null\r\nAND l.bdate BETWEEN @start_d AND @end_d  and l.hospcode=l.bhosp\r\norder by l.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.labor \r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select l.hospcode,c.hosname,c.distcode,count(l.pid) as y_cases\r\nfrom hdc.labor l\r\nleft join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid\r\nLEFT JOIN hdc.chospital c on c.hoscode=l.HOSPCODE\r\nwhere p.pid is null\r\nAND l.bdate BETWEEN @start_d AND @end_d  and l.hospcode=l.bhosp\r\ngroup by l.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere l.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(l.pid) as y_cases\r\nfrom hdc.labor l\r\nleft join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\nwhere p.pid is null\r\nAND l.bdate BETWEEN @start_d AND @end_d   and l.hospcode=l.bhosp\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'labor_noperson', 'anc', '25', 'เอ๊ะ!! ทำไมมีทะเบียนบุคคล( PID )ในการคลอด(LABOR)  แต่ไม่มีทะเบียนบุคคล( PID) ใน PERSON', '{\"2a92011e4638c3e79419bd39b53ea09a.pdf\":\"11_ANC_Labor_Noperson.pdf\"}', 'GDftYspimKCPxce5UGRPF1'), ('12', 'ตรวจสอบ การบันทึกผลการคลอดไม่ตรงมาตรฐาน', 'labor_record_a', 'labor_record_s', 'labor_record_t', 'select l.hospcode,c.hosname,l.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,p.hn,l.bdate,l.bresult ,l.bhosp\r\nfrom hdc.labor l\r\nleft join hdc.person p on p.pid=l.pid and p.hospcode=l.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=p.hospcode\r\nwhere l.bresult not in (SELECT id_bresult FROM hdc.cbresult)\r\nAND l.bdate BETWEEN @start_d AND @end_d \r\norder by l.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.labor\r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select l.hospcode,c.hosname,count(l.pid) as y_cases,c.distcode\r\nfrom hdc.labor l\r\nleft join hdc.person p on p.pid=l.pid and p.hospcode=l.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=p.hospcode\r\nwhere l.bresult not in (SELECT id_bresult FROM hdc.cbresult)\r\nAND l.bdate BETWEEN @start_d AND @end_d \r\ngroup by l.hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere l.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(l.pid) as y_cases\r\nfrom hdc.labor l\r\nleft join hdc.person p on p.pid=l.pid and p.hospcode=l.hospcode\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\nwhere l.bresult not in (SELECT bresult_code FROM cbresult_thcc)\r\nAND l.bdate BETWEEN @start_d AND @end_d   \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'labor_record', 'anc', '25', 'เอ๊ะ!! มีผู้มารับบริการการคลอด หลังจากการคลอดแล้วไม่ได้บันทึกผลการคลอด', '{\"1cd95271ece804dc63a4648dd07527ac.pdf\":\"12_ANC_Labor_Record.pdf\"}', 'kwFvZETg4ly9zTDN0uys-M'), ('13', 'ตรวจสอบ ความไม่เชื่อมโยงระหว่างแฟ้ม LABORกับ ANC', 'labor_noanc_a', 'labor_noanc_s', 'labor_noanc_t', 'select p.hospcode,c.hosname,l.bhosp,l.bdate,l.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,a.pid,p.nation,p.typearea\r\nfrom hdc.labor l\r\nleft outer join hdc.person p on p.pid=l.pid and p.hospcode=l.HOSPCODE\r\nleft outer join hdc.anc a on a.pid=p.pid and a.hospcode=p.HOSPCODE\r\nleft outer join hdc.chospital c on c.hoscode=l.hospcode\r\nwhere p.typearea in (\'1\',\'3\')and a.pid is null\r\nAND l.bdate BETWEEN @start_d AND @end_d\r\norder by p.hospcode desc ', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.labor \r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select p.hospcode,c.hosname,count(l.pid) as y_cases,c.distcode\r\nfrom hdc.labor l\r\nleft outer join hdc.person p on p.pid=l.pid and p.hospcode=l.HOSPCODE\r\nleft outer join hdc.anc a on a.pid=p.pid and a.hospcode=p.HOSPCODE\r\nleft outer join hdc.chospital c on c.hoscode=l.hospcode\r\nwhere p.typearea in (\'1\',\'3\')and a.pid is null\r\nAND l.bdate BETWEEN @start_d AND @end_d\r\ngroup by p.hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC\r\n', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere l.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(l.pid) as y_cases\r\nfrom hdc.labor l\r\nleft outer join hdc.person p on p.pid=l.pid and p.hospcode=l.HOSPCODE\r\nleft outer join hdc.anc a on a.pid=p.pid and a.hospcode=p.HOSPCODE\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\nwhere p.typearea in (\'1\',\'3\')and a.pid is null\r\nAND l.bdate BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'labor_noanc', 'anc', '25', 'เอ๊ะ!! มีทะเบียนบุคคล( PID )ในการคลอด(LABOR)  แต่ไม่มีทะเบียนบุคคล( PID )ในการบริการฝากครรภ์ (ANC) ', '{\"bc9415d52dda2124eb948065b22c294b.pdf\":\"13_ANC_Labor_Noanc.pdf\"}', 'HrTfXeq64Ft9l6bA9A2Bw0'), ('14', 'ตรวจสอบ ความไม่เชื่อมโยงระหว่างแฟ้ม LABOR กับ NEWBORN', 'labor_nonewborn_a', 'labor_nonewborn_s', 'labor_nonewborn_t', 'select l.hospcode,c.hosname,p.hn,l.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,n.mpid,l.bdate,l.bhosp,p.typearea\r\nfrom hdc.labor l\r\nleft outer join hdc.newborn n on n.hospcode=l.hospcode and n.mpid=l.pid\r\nleft outer join hdc.person p on p.pid=l.pid and l.hospcode=p.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=l.hospcode\r\nwhere n.mpid is null AND l.BTYPE <> 6\r\nAND l.bdate BETWEEN @start_d AND @end_d  \r\norder by l.hospcode', 'SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.labor \r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nLEFT JOIN\r\n(select l.hospcode,count(l.pid) as y_cases\r\nfrom hdc.labor l\r\nleft outer join hdc.newborn n on n.hospcode=l.hospcode and n.mpid=l.pid\r\nleft outer join hdc.person p on p.pid=l.pid and l.hospcode=p.hospcode\r\nwhere n.mpid is null AND l.BTYPE <> 6\r\nAND l.bdate BETWEEN @start_d AND @end_d  \r\ngroup by l.hospcode)as st\r\non nd.hospcode=st.hospcode\r\nleft join hdc.chospital c on c.hoscode=nd.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere l.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(l.pid) as y_cases\r\nfrom hdc.labor l\r\nleft outer join hdc.newborn n on n.hospcode=l.hospcode and n.mpid=l.pid\r\nleft outer join hdc.person p on p.pid=l.pid and l.hospcode=p.hospcode\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\nwhere n.mpid is null AND l.BTYPE <> 6\r\nAND l.bdate BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'labor_nonewborn', 'anc', '25', 'เอ๊ะ!! มีทะเบียนบุคคลในการคลอดของแม่...แต่ไม่มีทะเบียนบุคคล ของลูก ', '{\"2ecdb46aca2918bdeac3334c6c0662b2.pdf\":\"14_Labor_Nonewborn.pdf\"}', 'W8CpHCLRuIi1oJrrtW1bSQ'), ('15', 'ตรวจสอบ น้ำหนักแรกรับ เป็น 0', 'newborn_admitweight_a', 'newborn_admitweight_s', 'newborn_admitweight_t', 'select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,s.datetime_admit, s.datetime_disch, s.admitweight\r\nfrom hdc.admission s\r\nleft join hdc.chospital h on h.hoscode=s.hospcode\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\nwhere s.datetime_disch BETWEEN @start_d AND @end_d \r\nand (s.admitweight > 200 or (timestampdiff(year,p.birth,s.datetime_admit) <= 1 and (s.admitweight is null or s.admitweight=\'\' or s.admitweight=0)))\r\norder by h.hoscode, p.pid, s.datetime_disch', 'select hoscode,hosname,concat(@province,distcode) as distcode,pid,IFNULL(y_cases,0) as y_cases,\r\nround((IFNULL(y_cases,0) /pid)*100,2) as percent\r\nfrom\r\n(select hospcode, count(pid) as pid from hdc.admission \r\nwhere datetime_disch BETWEEN @start_d AND @end_d group by hospcode) as t\r\nRIGHT JOIN\r\n(select h. hoscode, h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.admission s\r\nleft join hdc.chospital h on h.hoscode=s.hospcode\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\nwhere s.datetime_disch BETWEEN @start_d AND @end_d\r\nand (s.admitweight > 200 or (timestampdiff(year,p.birth,s.datetime_admit) <= 1 and (s.admitweight is null or s.admitweight=\'\' or s.admitweight=0)))\r\ngroup by h.hoscode) as err on err.hoscode=t.hospcode\r\nORDER BY err.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.admission s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.datetime_disch BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.admission s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere s.datetime_disch BETWEEN @start_d AND @end_d\r\nand (s.admitweight > 200 or (timestampdiff(year,p.birth,s.datetime_admit) <= 1 and (s.admitweight is null or s.admitweight=\'\' or s.admitweight=0)))  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, null, 'newborn_admitweight', 'admission', '25', 'เอ๊ะ!! มีน้ำหนักแรกรับ admitweight เป็นค่าว่าง หรือ เท่ากับ 0 ในเด็กอายุต่ำกว่า 1 ปี ลืมบันทึก หรือปล่าว??', null, null), ('16', 'ตรวจสอบ น้ำหนักทารกแรกเกิดผิดปกติ', 'newborn_bweight_a', 'newborn_bweight_s', 'newborn_bweight_t', 'select n.hospcode,c.hosname,n.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,n.gravida,n.ga,n.bweight,n.BHOSP,n.btype,n.bdate\r\nfrom hdc.newborn n\r\nleft join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid\r\nleft outer join hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere (bweight < 1000 or bweight > 4500)\r\nAND bdate BETWEEN @start_d AND @end_d\r\norder by hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0)/pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.newborn \r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select n.hospcode,c.hosname,count(n.pid) as y_cases,c.distcode\r\nfrom hdc.newborn n\r\nleft outer join hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere (bweight < 1000 or bweight > 4500)\r\nand bdate BETWEEN @start_d AND @end_d\r\ngroup by n.hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.newborn n\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere n.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(n.pid) as y_cases\r\nfrom hdc.newborn n\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere (bweight < 1000 or bweight > 4500)\r\nand n.bdate BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'newborn_bweight', 'newborn', '25', 'เอ๊ะ!!  ทำไมน้ำหนักแรกคลอด (bweight) น้อยกว่า 1,000 กรัม หรือ มากกว่า 4,500 กรัม', '{\"7e2aa3f8724420d27441ba3757d4f092.pdf\":\"16_NEWBORN_Bweight.pdf\"}', '7N8b9ys32ErCWGrxDpLGI3'), ('18', 'ตรวจสอบ ผลการเยี่ยมทารกหลังคลอด เท่ากับไม่ทราบ', 'newborncare_falseresult_a', 'newborncare_falseresult_s', 'newborncare_falseresult_t', 'select n.hospcode,c.hosname,n.PID,concat(pe.`NAME`,\' \',pe.LNAME)as fullname,pe.TYPEAREA,n.BDATE,n.bcare,n.bcareresult,n.BCPLACE from hdc.newborncare  n\r\nleft outer join hdc.person pe on pe.pid=n.pid and pe.hospcode=n.hospcode \r\nleft outer join hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere n.bdate BETWEEN @start_d AND @end_d  and n.bcareresult not in (1,2) and n.hospcode=n.bcplace\r\norder by n.hospcode', 'SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0)/pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid,c.hosname,c.distcode from hdc.newborncare n\r\nleft outer join hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nLEFT JOIN \r\n(select n.hospcode,count(n.pid) as y_cases from hdc.newborncare  n\r\nleft outer join hdc.person pe on pe.pid=n.pid and pe.hospcode=n.hospcode \r\nleft outer join hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere n.bdate BETWEEN @start_d AND @end_d  and n.bcareresult not in (1,2) and n.hospcode=n.bcplace\r\ngroup by n.hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.newborncare  n\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere n.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(n.pid) as y_cases\r\nfrom hdc.newborncare  n\r\nleft outer join hdc.person pe on pe.pid=n.pid and pe.hospcode=n.hospcode \r\nleft outer join hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere n.bdate BETWEEN @start_d AND @end_d  and n.bcareresult =\'9\' and n.hospcode=n.bcplace\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'newborncare_falseresult', 'newborn', '25', 'เอ๊ะ!! ทำไมมีการเยี่ยมทารกหลังคลอดแฟ้มnewborncare มี ผลการเยี่ยมค่าbcareresult เท่ากับไม่ทราบ(9)', '{\"8d620a6fef761ce162539e80d81ada73.pdf\":\"18_NEWBORN_Falseresult.pdf\"}', 'cucn_ACH1gVNs-MeD8YLRZ'), ('19', 'ตรวจสอบ เยี่ยมทารกก่อนเกิดหรือในวันเกิด', 'newborncare_before_a', 'newborncare_before_s', 'newborncare_before_t', 'select c.hoscode,c.hosname,p.pid,concat(pe.`NAME`,\' \',pe.LNAME)as fullname,pe.nation,p.BCARE,p.bdate,p.BCPLACE,pe.typearea\r\nfrom hdc.newborncare p\r\nleft outer join hdc.person pe on pe.pid=p.pid and pe.hospcode=p.hospcode \r\nleft outer join hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere p.BCARE <=p.BDATE\r\nAND p.bdate BETWEEN @start_d AND @end_d    \r\norder by c.hoscode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.newborncare \r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select p.hospcode,c.hosname,count(p.pid) as y_cases ,c.distcode\r\nfrom hdc.newborncare p\r\nleft outer join hdc.person pe on pe.pid=p.pid and pe.hospcode=p.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere p.BCARE <=p.BDATE\r\nAND p.bdate BETWEEN @start_d AND @end_d\r\ngroup by p.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\nORDER BY st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.newborncare n\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere n.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(n.pid) as y_cases\r\nfrom hdc.newborncare n\r\nleft outer join hdc.person pe on pe.pid=n.pid and pe.hospcode=n.hospcode\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere n.BCARE <=n.BDATE\r\nAND n.bdate BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc\r\n', '1', '', '', '', 'newborncare_before', 'newborn', '25', 'เอ๊ะ!! มีการดูแลลูก (bcare) ก่อนหรือเป็นวันเดียวกับวันที่คลอด (bdate) ', '{\"e20b43616dd176ccaeb61fb87a94636c.pdf\":\"19_NEWBORN_Before.pdf\"}', 'YFFDq_IX5blSrljiK3G6K7'), ('20', 'ตรวจสอบ เด็กอายุมากกว่า6 เดือนยังกินนมแม่อย่างเดียวอยู่', 'newborncare_food_a', 'newborncare_food_s', 'newborncare_food_t', 'select n.hospcode,c.hosname,n.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,n.DATE_SERV,\r\nTIMESTAMPDIFF(month,p.birth,CURDATE()) AS month,\r\n(case when food =1 then 1 else 0 end) as breast\r\nfrom hdc.nutrition n\r\nleft outer join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid\r\nleft outer join hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere n.DATE_SERV BETWEEN @start_d AND @end_d\r\nand TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > \'6\' \r\nand FOOD=\'1\'\r\norder by n.HOSPCODE  ', 'select n.hospcode,c.hosname,concat(@province,c.distcode) as distcode,\r\ncount( concat(n.hospcode,n.pid))as total_pid,\r\nsum(case when food =1 and TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > \'6\' then 1 else 0 end) as y_cases,\r\nround((sum(case when food =1 and TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > \'6\' then 1 else 0 end)/count( concat(n.hospcode,n.pid)))*100,2) as percent\r\nfrom hdc.nutrition n\r\nleft outer join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid\r\nleft outer join hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere n.DATE_SERV BETWEEN @start_d AND @end_d\r\nand TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > \'6\' \r\ngroup by n.HOSPCODE\r\norder by y_cases desc ', 'select concat(@province,c.distcode) as distcode,ca.ampurname, \r\ncount( concat(n.hospcode,n.pid))as total_pid,\r\nsum(case when food =1 and TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > \'6\' then 1 else 0 end)as y_cases, \r\nround((sum(case when food =1 and TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > \'6\' then 1 else 0 end)/count( concat(n.hospcode,n.pid)))*100,2) as percent\r\nfrom hdc.nutrition n\r\nleft outer join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid and p.nation=\'099\'\r\nJOIN hdc.chospital c on c.hoscode=n.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province \r\nwhere n.DATE_SERV BETWEEN @start_d AND @end_d\r\nand TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > \'6\' \r\ngroup by c.distcode\r\norder by y_cases desc ', '1', '', '', '', 'newborncare_food', 'newborn', '25', 'เอ๊ะ!! เด็กที่มีอายุมากกว่า 6 เดือน แต่ยังกินนมแม่อย่างเดียว (food=1)  หรือ... นับจากแฟ้ม nutririon นับอายุตั้งแต่วันเกิดของเด็ก birth แฟ้ม person ถึงวันที่รับบริการ มีอายุมากกว่า 6 เดือน', '{\"17aa6283ebc0a53319a0a93a8880eeec.pdf\":\"20_NEWBORN_Food.pdf\"}', 'GlYgqMuBwxva6R8KVFk420'), ('21', 'ตรวจสอบ TypeArea ไม่ใช่ 1-5', 'person_notypearea_a', 'person_notypearea_s', 'person_notypearea_t', 'select p.hospcode, h.hosname, pid,concat(`NAME`,\' \',LNAME)as fullname,typearea\r\nfrom hdc.person p\r\njoin hdc.chospital h on h.hoscode=p.hospcode\r\nwhere \r\ntypearea not in (\'1\',\'2\',\'3\',\'4\',\'5\')\r\norder by hospcode asc', 'SELECT st.HOSPCODE,st.hosname,concat(@province,st.distcode) as distcode,nd.Total_PID,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /Total_PID)*100,2) as percent\r\nFROM\r\n(SELECT HOSPCODE,count(PID) as Total_PID FROM hdc.person GROUP BY HOSPCODE) nd\r\nRIGHT JOIN\r\n(select p.hospcode, h.hosname,count(p.PID) as y_cases,c.distcode\r\nfrom hdc.person p\r\njoin hdc.chospital h on h.hoscode=p.hospcode\r\nLEFT JOIN hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere typearea not in (\'1\',\'2\',\'3\',\'4\',\'5\')\r\ngroup by hospcode) as st\r\non nd.hospcode=st.hospcode\r\norder by st.hospcode', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(p.pid) as y_cases\r\nfrom hdc.person p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere typearea not in (\'1\',\'2\',\'3\',\'4\',\'5\')\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'person_notypearea', 'person', '25', 'เอ๊ะ!! สถานะบุคคล (typearea) ไม่ใช่ 1-5 ตามกฎของ สนย.นะ', '{\"d6c3c5e2fb756db025907cdc0ec3f1db.pdf\":\"21_PERSON_Notypearea.pdf\"}', 'k5T33zkWzRiUxWdYgnwLq9'), ('22', 'ตรวจสอบ มีการตรวจจอประสาทตาให้คนที่ไม่ได้อยู่ในChronic', 'chronicfu_amd_a', 'chronicfu_amd_s', 'chronicfu_amd_t', 'SELECT p.hospcode,c.hosname,p.pid,p.fullname,p.TYPEAREA,p.date_serv,p.procedcode,c.cid chronic_pid from \r\n(SELECT o.hospcode,p.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,p.cid,p.TYPEAREA,o.date_serv,o.procedcode from hdc.procedure_opd o\r\nLEFT JOIN hdc.person p on p.HOSPCODE=o.HOSPCODE and p.PID=o.PID\r\nwhere o.procedcode in (\'9511\',\'9390141\',\'1621\',\'9390140\') and o.date_serv BETWEEN @start_d AND @end_d) p\r\nLEFT JOIN (SELECT hospcode,cid FROM hdc.t_dmht where type_dx in (2,3) ) c on c.cid=p.cid \r\nleft join hdc.chospital c on c.hoscode=p.hospcode\r\nwhere c.cid is NULL', 'SELECT st.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,st.y_cases,\r\nround((y_cases/pid)*100,2) as percent\r\nFROM \r\n(SELECT hospcode,count(pid) as pid from hdc.procedure_opd\r\nwhere procedcode in (\'9511\',\'9390141\',\'1621\',\'9390140\') and date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\n\r\nRIGHT JOIN (SELECT p.hospcode, count(p.pid) as y_cases  from \r\n(SELECT o.hospcode,p.pid,p.cid,o.date_serv,o.procedcode from hdc.procedure_opd o\r\nLEFT JOIN hdc.person p on p.HOSPCODE=o.HOSPCODE and p.PID=o.PID\r\nwhere o.procedcode in (\'9511\',\'9390141\',\'1621\',\'9390140\') and o.date_serv BETWEEN @start_d AND @end_d) p\r\nLEFT JOIN (SELECT hospcode,cid FROM hdc.t_dmht where type_dx in (2,3) ) c on c.cid=p.cid \r\nleft join hdc.chospital c on c.hoscode=p.hospcode\r\nwhere c.cid is NULL\r\ngroup by p.hospcode\r\n)as st on nd.hospcode=st.hospcode\r\nleft join hdc.chospital c on c.hoscode=nd.hospcode\r\norder by st.y_cases desc', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.procedure_opd p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere p.procedcode  in (\'9511\',\'9390141\',\'1621\',\'9390140\') and p.DATE_SERV BETWEEN @start_d AND @end_d \r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(p.procedure_pid) as y_cases\r\nfrom (SELECT p.hospcode,p.pid procedure_pid,p.date_serv,p.procedcode,c.cid chronic_pid from \r\n(SELECT o.hospcode,p.pid,p.cid,o.date_serv,o.procedcode from hdc.procedure_opd o\r\nLEFT JOIN hdc.person p on p.HOSPCODE=o.HOSPCODE and p.PID=o.PID\r\nwhere o.procedcode in (\'9511\',\'9390141\',\'1621\',\'9390140\') and o.date_serv BETWEEN @start_d AND @end_d) p\r\nLEFT JOIN (SELECT hospcode,cid FROM hdc.t_dmht where type_dx in (2,3) ) c on c.cid=p.cid \r\nwhere c.cid is NULL) p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, '', 'chronicfu_amd', 'chronicfu', '25', 'เอ๊ะ!! มีข้อมูลการตรวจจอประสาทตา แต่ไม่มีชื่อในทะเบียนโรคเรื้อรัง (Chronic)', '{\"08d659967f3cc8b015a3e50869aefb49.pdf\":\"22_chronicfu_amd.pdf\"}', '0AeaBnOcxaziTIM7tzq_mE'), ('23', 'ตรวจสอบ มีวันคลอดในอนาคต', 'labor_future_a', 'labor_future_s', 'labor_future_t', 'select l.hospcode,c.hosname,l.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,l.bdate,l.bhosp \r\nfrom hdc.labor l\r\nleft join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid\r\nleft join hdc.chospital c on c.hoscode=l.HOSPCODE\r\nwhere l.bdate >curdate()\r\nAND l.bdate BETWEEN @start_d AND @end_d\r\norder by l.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.labor \r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select l.hospcode,c.hosname,count(l.pid) as y_cases,c.distcode\r\nfrom hdc.labor l\r\nleft join hdc.chospital c on c.hoscode=l.HOSPCODE\r\nwhere l.bdate >curdate()\r\nAND l.bdate BETWEEN @start_d AND @end_d\r\ngroup by l.hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere l.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(l.pid) as y_cases\r\nfrom hdc.labor l\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\nwhere l.bdate >curdate()\r\nAND l.bdate BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'labor_future', 'anc', '25', 'เอ๊ะ!!  มีการบันทึกวันคลอดในอนาคตหรือหลังวันที่ปรับปรุงข้อมูล จริงไหม??', '{\"1496533f42881953c7c6d119b9439b7a.pdf\":\"23_ANC_Labor_Future.pdf\"}', 'EVPzTPoIAvCFWuxSJHS-BR'), ('24', 'ตรวจสอบ คนมีสัญชาติไทย แต่ Cid ไม่ถูกต้อง', 'person_notcid_a', 'person_notcid_s', 'person_notcid_t', 'select p.hospcode, p.cid, p.pid, name, lname, sex, nation, typearea\r\nfrom hdc.person  p\r\njoin hdc.service s on s.HOSPCODE=p.HOSPCODE and p.pid=s.pid\r\nwhere cid like \'0%\' and nation=\'099\' and typearea in (1,3)\r\nand (lname like \'%พม่า%\' or lname like \'เขมร\' or lname like \'กัมพูชา\' or lname like \'ลาว\')', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode ,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(DISTINCT pid) as pid from hdc.person GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select p.hospcode, c.hosname, c.distcode,count(DISTINCT p.pid) as y_cases\r\nfrom hdc.person  p\r\njoin hdc.service s on s.HOSPCODE=p.HOSPCODE and p.pid=s.pid\r\nleft join hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere cid like \'0%\' and nation=\'099\' and typearea in (1,3)\r\nand (lname like \'%พม่า%\' or lname like \'เขมร\' or lname like \'กัมพูชา\' or lname like \'ลาว\')\r\ngroup by p.hospcode)as st\r\non nd.hospcode=st.hospcode\r\nORDER BY st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(p.pid) as y_cases\r\nfrom hdc.person p\r\njoin hdc.service s on s.HOSPCODE=p.HOSPCODE and p.pid=s.pid\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere cid like \'0%\' and nation=\'099\' and typearea in (1,3)\r\nand (lname like \'%พม่า%\' or lname like \'เขมร\' or lname like \'กัมพูชา\' or lname like \'ลาว\')\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'person_notcid', 'person', '25', 'เอ๊ะ!! บุคคลที่มีสัญชาติไทย(099) แต่เลขที่บัตรประชาชน (cid) ขึ้นต้นด้วย 0 แล้วเป็นคนไทยจริงหรือ??', '{\"f7be50c63f7fd4458440554c5ecff737.pdf\":\"24_PERSON_Notcid.pdf\"}', 'FsjYfHQ1ub-lLr7sD0MrtP'), ('25', 'ตรวจสอบ PERSON มีอายุเกิน 100 ปี', 'person_age100_a', 'person_age100_s', 'person_age100_t', 'select hospcode,c.hosname,p.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,birth,\r\nTIMESTAMPDIFF(YEAR,p.birth,CURDATE()) AS age,\r\nNATION,TYPEAREA\r\nfrom hdc.person p\r\nleft join hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere discharge=\'9\' and typearea in (\'1\',\'3\')\r\nAND TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) > 100', 'SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode ,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.person GROUP BY HOSPCODE) nd\r\nLEFT JOIN\r\n(select hospcode,birth,count(p.PID) as y_cases,\r\nTIMESTAMPDIFF(YEAR,p.birth,CURDATE()) AS age,\r\nNATION,TYPEAREA\r\nfrom hdc.person p\r\nwhere discharge=\'9\' and typearea in (\'1\',\'3\')\r\nAND TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) > 100\r\ngroup by p.hospcode) as st\r\non nd.hospcode=st.hospcode\r\nleft join hdc.chospital c on c.hoscode=nd.HOSPCODE\r\nORDER BY st.hospcode DESC\r\n', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(p.pid) as y_cases\r\nfrom hdc.person p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere discharge=\'9\' and typearea in (\'1\',\'3\')\r\nAND TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) > 100\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc\r\n', '1', '', '', '', 'person_age100', 'person', '25', 'เอ๊ะ!! เขาคนนี้มีอายุเกิน 100 ปี จริงหรือปล่าว?', '{\"89a9b43855e0a497e7e51f1714913c8d.pdf\":\"25_PERSON_Age100.pdf\"}', 'hoQwYVl1FqhJbyVXIOIGat'), ('26', 'ตรวจสอบ คนไทย แต่มีนามสกุล เป็น พม่า,เขมร,ลาว', 'person_lnamenothai_a', 'person_lnamenothai_s', 'person_lnamenothai_t', 'select p.hospcode,c.hosname,p.cid,p.`NAME`,p.lname,p.nation,p.typearea \r\nfrom hdc.service s\r\nleft outer join hdc.chospital c on c.hoscode=s.hospcode\r\ninner join hdc.person p on p.pid=s.pid and s.hospcode=p.hospcode\r\nwhere (p.cid like \'07%\' or p.cid like \'007%\') \r\nand p.nation=\'099\'  \r\nand ( p.lname like \'เขม%\' or p.lname like \'พม่%\' or p.lname like \'กะ%\' or p.lname like \'ลา%\' )and p.race=\'099\' \r\nand p.TYPEAREA in (\'1\',\'3\')\r\ngroup by p.CID \r\norder by p.hospcode desc', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode ,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.person GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select p.hospcode,c.hosname,c.distcode,count(p.cid) as y_cases\r\nfrom hdc.service s\r\nleft outer join hdc.chospital c on c.hoscode=s.hospcode\r\ninner join hdc.person p on p.pid=s.pid and s.hospcode=p.hospcode\r\nwhere (p.cid like \'07%\' or p.cid like \'007%\') \r\nand p.nation=\'099\'  \r\nand ( p.lname like \'เขมร%\' or p.lname like \'พม่%\' or p.lname like \'กะ%\' or p.lname like \'ลา%\' )and p.race=\'099\' \r\nand p.TYPEAREA in (\'1\',\'3\')\r\ngroup by p.hospcode\r\n)as st\r\non nd.hospcode=st.hospcode\r\nORDER BY st.hospcode', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(p.cid) as y_cases\r\nfrom hdc.service s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\ninner join hdc.person p on p.pid=s.pid and s.hospcode=p.hospcode\r\nwhere (p.cid like \'07%\' or p.cid like \'007%\') \r\nand p.nation=\'099\'  \r\nand ( p.lname like \'เขม%\' or p.lname like \'พม่%\' or p.lname like \'กะ%\' or p.lname like \'ลา%\' )and p.race=\'099\' \r\nand p.TYPEAREA in (\'1\',\'3\') \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'person_lnamenothai', 'person', '25', 'เอ๊ะ!! บุคคลที่มีสัญชาติไทย แต่มีนามสกุล (lname) เป็นพม่า เขมร ลาว นะ', '{\"94c2bbe52f1c4f96b46c8c85c254f5fb.pdf\":\"26_PERSON_lnamenothai.pdf\"}', 'VqCrKCKUFQteXqS2ZVqWgF'), ('27', 'ตรวจสอบ ไม่ใช่คนไทย แต่ Typearea เป็น 1 และ 3', 'person_notthaitype_a', 'person_notthaitype_s', 'person_notthaitype_t', 'select hospcode,pid,concat(`NAME`,\' \',LNAME)as fullname,hn,nation,nationname,typearea\r\nfrom hdc.person \r\nleft join hdc.chospital on hoscode=hospcode\r\nleft join hdc.cnation on nationcode=nation\r\nwhere nation!=\'099\' and typearea in (\'1\',\'3\') and discharge =\'9\'\r\norder by hospcode desc\r\n', 'SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.cid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /cid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as cid from hdc.person \r\nwhere typearea in (\'1\',\'3\') and discharge =\'9\' GROUP BY HOSPCODE) nd\r\nLEFT JOIN\r\n(select hospcode,count(pid) as y_cases\r\nfrom person_notthaitype_t p\r\ngroup by hospcode\r\norder by hospcode desc\r\n)as st\r\non nd.hospcode=st.hospcode\r\nleft join hdc.chospital c on c.hoscode=nd.hospcode\r\nORDER BY nd.hospcode', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.cid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /cid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(pid) as cid FROM hdc.person p\r\ninner join hdc.chospital c on c.hoscode=p.HOSPCODE\r\ninner join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere typearea in (\'1\',\'3\') and discharge =\'9\'\r\nGROUP BY c.distcode) nd\r\nLEFT JOIN \r\n(select c.distcode,count(pid) as y_cases\r\nfrom person_notthaitype_t p\r\nleft join hdc.chospital c on c.hoscode=p.HOSPCODE\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'person_notthaitype', 'person', '25', 'เอ๊ะ!! รู้ไหมบุคคลที่ไม่ใช่คนไทย แต่สถานะบุคคล (typearea) เป็น 1,3  นะ', '{\"3648b0cb988179b06871a9e7efdb27b9.pdf\":\"27_person_notthaitype.pdf\"}', 'reAjFPKHj8M3qynMebSY1N'), ('28', 'ตรวจสอบ ประชากร มีประวัติเสียชีวิตแล้ว แต่ไม่มีการจำหน่าย', 'person_nodeath_a', 'person_nodeath_s', 'person_nodeath_t', 'select h.hoscode,\r\nh.hosname,p.pid,p.hn,\r\nx.ddeath,\r\nx.CDEATH_A,\r\nx.hospdeath,typearea,\r\ncase  when  discharge = \'9\' then \'ยังมีชีวิต\' else discharge end as statuss \r\nfrom hdc.person p \r\ninner join (select p.cid,d.ddeath,d.CDEATH_A,d.hospcode,d.hospdeath from hdc.person p\r\ninner join hdc.death d on d.hospcode=p.hospcode and d.pid=p.pid\r\nwhere d.ddeath is not null and d.CDEATH_A <>\'\' group by p.cid )x on p.cid=x.cid\r\njoin hdc.chospital h on h.hoscode=p.hospcode\r\nwhere p.discharge=\'9\' and TYPEAREA in (\'1\',\'3\')\r\norder by p.hospcode\r\n', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(p.pid) as pid FROM hdc.person p where p.discharge = \'9\' and p.TYPEAREA in (\'1\',\'3\') GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select p.hospcode,h.hosname, count(p.pid) as y_cases ,h.distcode\r\nfrom hdc.person p \r\ninner join (select p.cid,d.ddeath,d.CDEATH_A,d.hospcode,d.hospdeath from hdc.person p\r\ninner join hdc.death d on d.hospcode=p.hospcode and d.pid=p.pid\r\nwhere d.ddeath is not null and d.CDEATH_A <>\'\' group by p.cid )x on p.cid=x.cid\r\njoin hdc.chospital h on h.hoscode=p.hospcode\r\nwhere p.discharge = \'9\' and p.TYPEAREA in (\'1\',\'3\')\r\ngroup by p.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases desc', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere p.discharge=\'9\' and TYPEAREA in (\'1\',\'3\') GROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(p.pid) as y_cases\r\nfrom hdc.person p \r\ninner join (select p.cid,d.ddeath,d.CDEATH_A,d.hospcode,d.hospdeath from hdc.person p\r\ninner join hdc.death d on d.hospcode=p.hospcode and d.pid=p.pid\r\nwhere d.ddeath is not null and d.CDEATH_A <>\'\' group by p.cid )x on p.cid=x.cid\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere p.discharge=\'9\' and TYPEAREA in (\'1\',\'3\')  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'person_nodeath', 'person', '25', 'เอ๊ะ!! มีข้อมูลประวัติการเสียชีวิต ในแฟ้ม Death  แต่สถานะการจำหน่าย (discharge) = 9 (ไม่จำหน่าย)', '{\"39828ebb82cf59822d0b871b07299025.pdf\":\"28_PERSON_nodeath.pdf\"}', 'AVTiAYgBEFu5i3PGxvDeRB'), ('29', 'ตรวจสอบ NCDSCREEN บันทึกค่าความดันผิดพลาด', 'ncdscreen_check_a', 'ncdscreen_check_s', 'ncdscreen_check_t', 'select n.hospcode,c.hosname,n.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,n.date_serv,n.sbp_1,n.dbp_1,n.weight,n.height,n.waist_cm,n.bslevel \r\nfrom hdc.ncdscreen n\r\nleft join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid\r\nleft outer join hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere (n.sbp_1<=50 or n.dbp_1<=50)\r\nAND n.date_serv BETWEEN @start_d AND @end_d\r\norder by n.HOSPCODE ', 'SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.ncdscreen \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nLEFT JOIN \r\n(select n.hospcode, count(n.pid) as y_cases\r\nfrom hdc.ncdscreen n\r\nwhere (n.sbp_1<=50 or n.dbp_1<=50)\r\nAND n.date_serv BETWEEN @start_d AND @end_d\r\ngroup by n.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\nleft join hdc.chospital c on c.hoscode=nd.HOSPCODE\r\norder by st.y_cases desc', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.ncdscreen n\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere n.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(n.pid) as y_cases\r\nfrom hdc.ncdscreen n\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere (n.sbp_1<=50 or n.dbp_1<=50)\r\nAND n.date_serv BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc\r\n', '1', '', '', '', 'ncdscreen_check', 'ncdscreen', '25', 'เอ๊ะ!! ตรวจสอบข้อมูลการให้บริการคัดกรองโรคเบาหวานและความดันโลหิตสูง บันทึกค่าความดันผิดพลาด', '{\"86e005b23fc9cd7e9178e069d46f4542.pdf\":\"eh-ncdsreen-bp.pdf\"}', 'wwbyqvZQfRcZrpkessjXzk'), ('30', 'ตรวจสอบช่วงค่าความดัน Pulse Pressure ผิดปกติ', 'ncdscreen_ht_false_a', 'ncdscreen_ht_false_s', 'ncdscreen_ht_false_t', 'select ch.hospcode,c.hosname,ch.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,p.hn,ch.DATE_SERV,ch.sbp_1,ch.dbp_1,ch.sbp_2,ch.dbp_2\r\nFROM hdc.ncdscreen ch\r\nLEFT JOIN hdc.person p on ch.HOSPCODE=p.HOSPCODE and ch.PID=p.PID\r\ninner join hdc.chospital c on c.hoscode=ch.HOSPCODE\r\nWHERE  ch.sbp_2 >0 and ch.dbp_2 >0 and (ch.sbp_1-dbp_1 <15 or ch.sbp_1-dbp_1 > 105  or ch.sbp_2-dbp_2 <15 or ch.sbp_2-dbp_2 > 105 )\r\nAND ch.date_serv BETWEEN @start_d AND @end_d\r\ngroup by ch.hospcode, ch.pid \r\norder by ch.hospcode', 'SELECT s.hospcode,s.hosname,concat(@province,s.distcode) as distcode,s.pid AS total_pid,IFNULL(s.y_cases,0) as y_cases,\r\nround((IFNULL(s.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT nd.hospcode,c.hosname,c.distcode as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.ncdscreen \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) AS nd\r\nLEFT JOIN\r\n(select ch.hospcode,count(ch.pid) as y_cases\r\nFROM hdc.ncdscreen ch\r\nWHERE ch.sbp_2 >0 and ch.dbp_2 >0 and (ch.sbp_1-dbp_1 <15 or ch.sbp_1-dbp_1 > 105  or ch.sbp_2-dbp_2 <15 or ch.sbp_2-dbp_2 > 105 )\r\nand ch.date_serv BETWEEN @start_d AND @end_d\r\ngroup by ch.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\nleft join hdc.chospital c on c.hoscode=nd.HOSPCODE\r\norder by st.y_cases desc\r\n)AS s', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid AS total_pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(ch.pid) as pid FROM hdc.ncdscreen ch\r\njoin hdc.chospital c on c.hoscode=ch.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere ch.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(ch.pid) as y_cases\r\nFROM hdc.ncdscreen ch\r\njoin hdc.chospital c on c.hoscode=ch.HOSPCODE\r\nWHERE ch.sbp_2 >0 and ch.dbp_2 >0 and (ch.sbp_1-dbp_1 <15 or ch.sbp_1-dbp_1 > 105  or ch.sbp_2-dbp_2 <15 or ch.sbp_2-dbp_2 > 105 )\r\nand ch.date_serv BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'ncdscreen_ht_false', 'ncdscreen', '25', 'เอ๊ะ!! มีช่วงค่าความดัน Pulse Pressure น้อยกว่า 15 หรือ มากกว่า 100', '{\"71330f49b8d73cae44d5a5312cf3a3f2.pdf\":\"eh-ncdsreen-bp-upper-lower.pdf\"}', 'X_UIOFRUrk0CmT-e2s9Ire'), ('10001', 'ตรวจสอบ ตรวจสภาวะทันตสุขภาพแต่ละประเภท', 'dental_workload_a', 'dental_workload_s', 'dental_workload_t', 'SELECT d.hospcode,c.hosname,d.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,d.DATE_SERV,d.denttype,\r\nTIMESTAMPDIFF(YEAR,p.birth,d.DATE_SERV) AS age\r\nFROM (SELECT a.HOSPCODE,a.PID,a.DATE_SERV,a.denttype,a.PROVIDER\r\n	FROM hdc.dental a\r\n	WHERE a.DATE_SERV BETWEEN @start_d AND @end_d) d\r\nLEFT JOIN (SELECT v.HOSPCODE,v.provider,v.PROVIDERTYPE \r\n		FROM hdc.provider v\r\n		WHERE v.PROVIDERTYPE   IN (\'02\',\'06\')) c\r\nON d.HOSPCODE = c.HOSPCODE AND d.PROVIDER = c.provider\r\nLEFT JOIN hdc.chospital c ON c.hoscode = d.hospcode\r\nLEFT JOIN hdc.person p ON p.pid = d.pid AND d.hospcode=p.hospcode\r\nWHERE d.date_serv BETWEEN @start_d AND @end_d  and d.DENTTYPE NOT IN (1,2,3,4,5)  \r\nAND c.provider IS NULL \r\nORDER BY d.hospcode', 'SELECT d.hospcode,c.hosname,CONCAT(@province,c.distcode) AS distcode,\r\nSUM(CASE WHEN denttype=1 THEN 1 ELSE 0 END) AS pregnancy,\r\nSUM(CASE WHEN denttype=2 THEN 1 ELSE 0 END) AS preschool,\r\nSUM(CASE WHEN denttype=3 THEN 1 ELSE 0 END) AS student,\r\nSUM(CASE WHEN denttype=4 THEN 1 ELSE 0 END) AS elderly,\r\nSUM(CASE WHEN denttype=5 THEN 1 ELSE 0 END) AS elsegroup,\r\nSUM(CASE WHEN denttype NOT IN (1,2,3,4,5)  THEN 1 ELSE 0 END) y_cases,\r\nCOUNT(DISTINCT p.cid) AS totalperson,\r\nCOUNT(d.pid) AS numberscreen,\r\nROUND((SUM(CASE WHEN denttype NOT IN (1,2,3,4,5)  THEN 1 ELSE 0 END)/COUNT(d.pid))*100,2) AS percent\r\nFROM (SELECT a.HOSPCODE,a.PID,a.DATE_SERV,a.denttype,a.PROVIDER\r\n	FROM hdc.dental a\r\n	WHERE  a.DATE_SERV BETWEEN @start_d AND @end_d) d\r\nLEFT JOIN (SELECT v.HOSPCODE,v.provider,v.PROVIDERTYPE \r\n		FROM hdc.provider v\r\n		WHERE v.PROVIDERTYPE   IN (\'02\',\'06\')) c\r\nON d.HOSPCODE = c.HOSPCODE AND d.PROVIDER = c.provider\r\nLEFT JOIN hdc.chospital c ON c.hoscode = d.hospcode\r\nLEFT JOIN hdc.person p ON p.pid = d.pid AND d.hospcode=p.hospcode\r\nWHERE d.date_serv BETWEEN @start_d AND @end_d \r\nAND c.provider IS NULL \r\nGROUP BY d.hospcode\r\nORDER BY d.hospcode', 'SELECT CONCAT(@province,c.distcode) AS distcode,ca.ampurname, \r\nCOUNT(d.pid) AS totalscreen,\r\nSUM(CASE WHEN denttype NOT IN (1,2,3,4,5)  THEN 1 ELSE 0 END) other,\r\nROUND((SUM(CASE WHEN denttype NOT IN (1,2,3,4,5)  THEN 1 ELSE 0 END)/COUNT(d.pid))*100,2) AS percent\r\nFROM (SELECT a.HOSPCODE,a.PID,a.DATE_SERV,a.denttype,a.PROVIDER\r\n	FROM hdc.dental a\r\n	WHERE a.DATE_SERV BETWEEN @start_d AND @end_d) d\r\nLEFT JOIN (SELECT v.HOSPCODE,v.provider,v.PROVIDERTYPE \r\n		FROM hdc.provider v\r\n		WHERE v.PROVIDERTYPE   IN (\'02\',\'06\')) c\r\nON d.HOSPCODE = c.HOSPCODE AND d.PROVIDER = c.provider\r\nLEFT JOIN hdc.chospital c ON c.hoscode = d.hospcode\r\nLEFT JOIN hdc.person p ON p.pid = d.pid AND d.hospcode=p.hospcode\r\nLEFT JOIN hdc.campur ca ON ca.ampurcode = c.distcode AND ca.changwatcode=@province \r\nWHERE d.date_serv BETWEEN @start_d AND @end_d \r\nAND c.provider IS NULL\r\nGROUP BY c.distcode\r\nORDER BY d.hospcode', '1', '', '', '', 'dental_workload', 'dental', '25', 'เอ๊ะ!! ตรวจสอบพบว่า ประเภทผู้ได้รับบริการตรวจสภาวะทันตสุขภาพ (denttype) ไม่ใช่ 1-5', '{\"40625067e712b3cfb4cf7eed2ae03f48.pdf\":\"eh-denttype.pdf\"}', 'no4wB1iYB1x4svMrweVaz-'), ('10002', 'ตรวจสอบ ความไม่เชื่อมโยงระหว่างแฟ้ม EPI กับ PERSON', 'epi_noperson_a', 'epi_noperson_s', 'epi_noperson_t', 'select e.hospcode,c.hosname,e.pid,p.pid,e.DATE_SERV\r\nfrom hdc.epi e\r\nleft join hdc.person p on p.hospcode=e.hospcode and p.pid=e.pid\r\nLEFT JOIN chospital c on c.hoscode=e.HOSPCODE\r\nwhere p.pid is null\r\nAND e.date_serv BETWEEN @start_d AND @end_d\r\norder by e.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.epi \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select e.hospcode,c.hosname,c.distcode,count(e.pid) as y_cases\r\nfrom hdc.epi e\r\nleft join hdc.person p on p.hospcode=e.hospcode and p.pid=e.pid\r\ninner JOIN hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere p.pid is null\r\nAND e.date_serv BETWEEN @start_d AND @end_d\r\ngroup by e.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(e.pid) as pid FROM hdc.epi e\r\njoin hdc.chospital c on c.hoscode=e.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere e.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(e.pid) as y_cases\r\nfrom hdc.epi e\r\nleft join hdc.person p on p.hospcode=e.hospcode and p.pid=e.pid\r\njoin hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere p.pid is null\r\nAND e.date_serv BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'epi_noperson', 'epi', '25', 'เอ๊ะ!! มีข้อมูลทะเบียนบุคคล(pid) ในแฟ้ม epi แต่ไม่มีข้อมูลทะเบียนบุคคล(pid) ในแฟ้ม person', '{\"e5f66a64e04bc5b8b4ffd71784cdf25e.pdf\":\"eh-epi-person.pdf\"}', 'unm5fn8brnOAOIODydh25X'), ('10004', 'ตรวจสอบ มีการได้รับวัคซีนก่อนวันเกิดในเด็กอายุน้อยกว่า 16 ปี', 'epi_bcg_BAbdate_a', 'epi_bcg_BAbdate_s', 'epi_bcg_BAbdate_t', 'select n.hospcode as n_hosp,c.hosname, n.pid, concat(p.`NAME`,\' \',p.LNAME)as fullname,n.bdate, n.bhosp, e.vaccineplace, e.date_serv, datediff(e.date_serv,n.bdate) as diff_date, e.hospcode as e_hosp\r\nfrom hdc.newborn n\r\nleft join hdc.epi e on e.hospcode=n.hospcode and e.pid=n.pid\r\nleft join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid\r\nleft outer join hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere e.date_serv < n.bdate\r\nAND n.bdate BETWEEN @start_d AND @end_d \r\norder by n.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.newborn\r\nwhere bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select n.hospcode,c.hosname, count(n.pid) as y_cases ,c.distcode\r\nfrom hdc.newborn n\r\nleft join hdc.epi e on e.hospcode=n.hospcode and e.pid=n.pid\r\nleft outer join hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere e.date_serv < n.bdate\r\nAND n.bdate BETWEEN @start_d AND @end_d  \r\ngroup by n.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases desc', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.newborn n\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere n.bdate BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(n.pid) as y_cases\r\nfrom hdc.newborn n\r\nleft join hdc.epi e on e.hospcode=n.hospcode and e.pid=n.pid\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\nwhere e.date_serv < n.bdate\r\nAND n.bdate BETWEEN @start_d AND @end_d    \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'epi_bcg_BAbdate', 'epi', '25', 'เอ๊ะ!! มีการให้วัคซีนก่อนวันเกิดในกลุ่มอายุน้อยกว่า 16 ปี ด้วยหรือ', '{\"ab966f33f52c5f6b011d3067c0f1d280.pdf\":\"eh-epi-before-born.pdf\"}', 'TByHXYOvhzT7HJK-6s9wsi'), ('10006', 'ตรวจสอบ ได้รับวัคซีนแรกเกิด BCG อายุมากกว่า 1 ปี', 'epi_firstvaccine_a', 'epi_firstvaccine_s', 'epi_firstvaccine_t', 'select e.hospcode,c.hosname,e.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,p.hn,p.birth,e.date_serv,e.vaccinetype,e.vaccineplace\r\nfrom hdc.epi e\r\nleft join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere e.vaccinetype =010 and e.hospcode=e.vaccineplace  AND TIMESTAMPDIFF(YEAR,p.BIRTH,e.DATE_SERV) >1\r\nAND e.date_serv BETWEEN @start_d AND @end_d  \r\norder by e.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT e.hospcode,count(e.pid) as pid FROM hdc.epi e\r\nleft join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode\r\nwhere e.vaccinetype =010 and e.hospcode=e.vaccineplace\r\nand e.date_serv BETWEEN @start_d AND @end_d group by e.hospcode) nd\r\nright JOIN\r\n(select e.hospcode,c.hosname, count(e.pid) as y_cases ,c.distcode\r\nfrom hdc.epi e\r\nleft join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere e.vaccinetype =010 and e.hospcode=e.vaccineplace AND TIMESTAMPDIFF(YEAR,p.BIRTH,e.DATE_SERV) >1\r\nand e.date_serv BETWEEN @start_d AND @end_d \r\ngroup by e.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases desc', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(e.pid) as pid FROM hdc.epi e\r\njoin hdc.chospital c on c.hoscode=e.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nleft join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode\r\nwhere e.vaccinetype =010 and e.hospcode=e.vaccineplace \r\nand e.date_serv BETWEEN @start_d AND @end_d \r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(e.pid) as y_cases\r\nfrom hdc.epi e\r\njoin hdc.chospital c on c.hoscode=e.HOSPCODE\r\nleft join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode\r\nwhere e.vaccinetype =010 and e.hospcode=e.vaccineplace AND TIMESTAMPDIFF(YEAR,p.BIRTH,e.DATE_SERV) >1\r\nand e.date_serv BETWEEN @start_d AND @end_d   \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'epi_firstvaccine', 'epi', '25', 'เอ๊ะ!! มีการให้วัคซีน BCG ในเด็กแรกเกิด อายุเด็กมากกว่า 1 ปี โดยคิดจากวันเกิด Birth แฟ้ม Person ถึง วันที่ให้บริการวัคซัน Date_serv แฟ้ม EPI', '{\"69435b1c225d167c03a5b6812e6fb9b3.pdf\":\"eh-epi-bcg.pdf\"}', 'KZZ-qh16Itw8olxDsJsvjm'), ('10007', 'ตรวจสอบ มีการได้รับวัคซีนแรกเกิด HBV1 อายุเด็กมากกว่า 60 วัน', 'epi_firstvaccine2_a', 'epi_firstvaccine2_s', 'epi_firstvaccine2_t', 'select e.hospcode,c.hosname,e.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,p.hn,p.birth,e.date_serv,e.vaccinetype,e.vaccineplace\r\nfrom hdc.epi e\r\nleft join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere e.vaccinetype =041 and e.hospcode=e.vaccineplace  AND TIMESTAMPDIFF(DAY,p.BIRTH,e.DATE_SERV) >60\r\nAND e.date_serv BETWEEN @start_d AND @end_d  \r\norder by e.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT e.hospcode,count(e.pid) as pid FROM hdc.epi e\r\nleft join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode\r\nwhere e.vaccinetype =041 and e.hospcode=e.vaccineplace\r\nand e.date_serv BETWEEN @start_d AND @end_d group by e.hospcode) nd\r\nright JOIN\r\n(select e.hospcode,c.hosname, count(e.pid) as y_cases ,c.distcode\r\nfrom hdc.epi e\r\nleft join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere e.vaccinetype =041 and e.hospcode=e.vaccineplace AND TIMESTAMPDIFF(DAY,p.BIRTH,e.DATE_SERV) >60\r\nand e.date_serv BETWEEN @start_d AND @end_d \r\ngroup by e.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases desc', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(e.pid) as pid FROM hdc.epi e\r\njoin hdc.chospital c on c.hoscode=e.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nleft join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode\r\nwhere e.vaccinetype =041 and e.hospcode=e.vaccineplace\r\nand e.date_serv BETWEEN @start_d AND @end_d \r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(e.pid) as y_cases\r\nfrom hdc.epi e\r\njoin hdc.chospital c on c.hoscode=e.HOSPCODE\r\nleft join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode\r\nwhere e.vaccinetype =041 and e.hospcode=e.vaccineplace AND TIMESTAMPDIFF(DAY,p.BIRTH,e.DATE_SERV) >60\r\nand e.date_serv BETWEEN @start_d AND @end_d   \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'epi_firstvaccine2', 'epi', '25', 'เอ๊ะ!! ตรวจสอบข้อมูลการให้วัคซีนในเด็กแรกเกิด HBV1 อายุเด็กมากกว่า 60 วัน โดยคิดจากวันเกิด แฟ้ม Person ถึง วันที่ให้บริการวัคซัน แฟ้ม EPI ', '{\"222e565458f7f9f71a9a6fb18f98e482.pdf\":\"eh-epi-hbv1.pdf\"}', 'sy9rUsoyFIsKSv09HVThNk'), ('10011', 'ตรวจสอบ คนไทยได้รับวัคซีน แต่มี CID ไม่ถูกต้อง', 'epi_nocid_a', 'epi_nocid_s', 'epi_nocid_t', 'select e.hospcode,c.hosname,e.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,p.hn,p.cid,p.nation,p.typearea,e.date_serv,e.vaccineplace\r\nfrom hdc.epi e\r\nleft outer join hdc.person p on p.pid=e.pid and e.hospcode=p.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere  p.nation=\'099\'  and (cid like \'0%\' or cid =\'\')\r\nand e.date_serv BETWEEN @start_d AND @end_d\r\norder by e.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.epi \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select e.hospcode,c.hosname, count(e.pid) as y_cases ,c.distcode\r\nfrom hdc.epi e\r\nleft outer join hdc.person p on p.pid=e.pid and e.hospcode=p.hospcode\r\nleft outer join hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere  p.nation=\'099\'  and (cid like \'0%\' or cid =\'\')\r\nAND e.date_serv BETWEEN @start_d AND @end_d\r\ngroup by e.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases desc', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(e.pid) as pid FROM hdc.epi e\r\njoin hdc.chospital c on c.hoscode=e.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere e.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(e.pid) as y_cases\r\nfrom hdc.epi e\r\nleft outer join hdc.person p on p.pid=e.pid and e.hospcode=p.hospcode\r\njoin hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere  p.nation=\'099\'  and (cid like \'0%\' or cid =\'\')\r\nAND e.date_serv BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'epi_nocid', 'person', '25', 'เอ๊ะ!! คนที่มีสัญชาติไทยได้รับวัคซีนแต่เลขประจำตัวประชาชนไม่ถูกต้องนะ...ไม่มีผลงาน อิอิ', '{\"99d51758971cf57febebbd348df2e58c.pdf\":\"10011_EPI_Nocid.pdf\"}', 'm8Kk0EmFIDJT0WYf1_qRGV'), ('10012', 'ตรวจสอบ มีการได้รับวัคซีนที่ไม่มีรหัสมาตรฐานกลาง', 'epi_vaccine_nostandardcenter_a', 'epi_vaccine_nostandardcenter_s', 'epi_vaccine_nostandardcenter_t', 'select e.hospcode,c.hosname,e.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,e.date_Serv,e.vaccinetype,e.vaccineplace \r\nfrom hdc.epi e\r\nleft join hdc.person p on p.hospcode=e.hospcode and p.pid=e.pid\r\nleft outer join hdc.chospital c on c.hoscode=e.hospcode\r\nwhere e.date_serv BETWEEN @start_d AND @end_d \r\nand e.vaccinetype  not in (select vaccinecode from hdc.cvaccinetype)\r\norder by e.hospcode ', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.epi \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select e.hospcode,c.hosname,count(e.pid) as y_cases ,c.distcode\r\nfrom hdc.epi e\r\nleft outer join hdc.chospital c on c.hoscode=e.hospcode\r\nwhere e.date_serv BETWEEN @start_d AND @end_d\r\nand e.vaccinetype  not in (select vaccinecode from hdc.cvaccinetype)\r\ngroup by e.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases desc', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(e.pid) as pid FROM hdc.epi e\r\njoin hdc.chospital c on c.hoscode=e.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere e.date_serv BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(e.pid) as y_cases\r\nfrom hdc.epi e\r\nleft join hdc.cvaccinetype v on v.vaccinecode=e.vaccinetype\r\njoin hdc.chospital c on c.hoscode=e.HOSPCODE\r\nwhere e.date_serv BETWEEN @start_d AND @end_d\r\nand e.vaccinetype  not in (select vaccinecode from hdc.cvaccinetype)\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'epi_vaccine_nostandardcenter', 'epi', '25', 'เอ๊ะ!! มีการบันทึกรหัสวัคซีน ไม่ตรงตามมาตรฐานกลาง', '{\"75c42a63bd490c4c6fafbf5dacb3eef6.pdf\":\"eh-epi-error-code.pdf\"}', '8kmYAwT5yJkUppB3pyVXGk'), ('10014', 'ตรวจสอบ Type area 1,3 ซ้ำซ้อนระหว่างหน่วยบริการ', 'person_double_a', 'person_double_s', 'person_double_t', 'select h1.hoscode,p1.pid,concat(p1.name,\' \',p1.lname) as name1,\r\np1.typearea ,p1.D_UPDATE,h2.hoscode, p2.pid,\r\nconcat(p2.name,\' \',p2.lname)as name2, p2.typearea ,p2.D_UPDATE\r\nfrom hdc.person p1 \r\nleft outer join  hdc.person p2 on p2.cid=p1.cid and  p1.hospcode <> p2.hospcode and p2.typearea in (\'1\', \'3\')  \r\nleft outer join hdc.chospital h1 on p1.hospcode=h1.hoscode\r\nleft outer join hdc.chospital h2 on p2.hospcode=h2.hoscode\r\nwhere p1.discharge = \'9\' and p1.typearea in (\'1\', \'3\') and p2.cid is not null \r\nand (p1.nation =\'099\' or p2.nation =\'099\')\r\norder by p1.hospcode', 'SELECT st.hoscode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n\r\n(SELECT hospcode,count(pid) as pid from hdc.person \r\nwhere TYPEAREA in (1,3) and NATION=\'099\' and discharge<>\'1\' and cid is not null\r\nGROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select h1.hoscode ,h1.hosname,count(p1.pid) as y_cases,h1.distcode\r\nfrom hdc.person p1 \r\nleft outer join  hdc.person p2 on p2.cid=p1.cid and  p1.hospcode <> p2.hospcode and p2.typearea in (\'1\', \'3\')  \r\nleft outer join hdc.chospital h1 on p1.hospcode=h1.hoscode\r\nleft outer join hdc.chospital h2 on p2.hospcode=h2.hoscode\r\nwhere p1.discharge = \'9\'  and p1.typearea in (\'1\', \'3\') and p2.cid is not null \r\nand (p1.nation =\'099\' or p2.nation =\'099\')\r\ngroup by p1.hospcode)as st\r\non nd.hospcode=st.hoscode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere TYPEAREA in (1,3) and NATION=\'099\' and discharge<>\'1\' and cid is not null\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select h1.distcode,count(p1.pid) as y_cases\r\nfrom hdc.person p1\r\nleft outer join  hdc.person p2 on p2.cid=p1.cid and  p1.hospcode <> p2.hospcode and p2.typearea in (\'1\', \'3\')  \r\nleft outer join hdc.chospital h1 on p1.hospcode=h1.hoscode\r\nleft outer join hdc.chospital h2 on p2.hospcode=h2.hoscode\r\nwhere p1.discharge = \'9\'  and p1.typearea in (\'1\', \'3\') and p2.cid is not null \r\nand (p1.nation =\'099\' or p2.nation =\'099\')\r\ngroup by h1.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'person_double', 'person', '25', 'เอ๊ะ!! ประชากรในเขตรับผิดชอบ มี typearea ซ้ำซ้อนกับหน่วยบริการอื่นๆ นะ', '{\"eacc7a3edf6c4eef63ff2526fd920c1d.pdf\":\"10014_PERSON_double.pdf\"}', 'fA-PT-toVg4ldEPIi_Pyhy'), ('10016', 'ตรวจสอบ มีการนำคนป่วยทั้ง 2 โรคมาคัดกรอง DM HT', 'ncdscreen1_htdm_old_a', 'ncdscreen1_htdm_old_s', 'ncdscreen1_htdm_old_t', 'select n.hospcode ,ch.hosname,n.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,p.nation,p.typearea,n.DATE_SERV as Screendate,\r\npcht.chronic as Dx_HT,\r\npcdm.chronic as Dx_DM,\r\npcht.DATE_DIAG as RegistHT,\r\npcdm.DATE_DIAG as RegistDM,\r\npcht.d_update as HT_dupdate,\r\npcdm.d_update as DM_dupdate,\r\np.D_UPDATE as Person_dupdate\r\nfrom hdc.ncdscreen n\r\ninner join hdc.chospital ch on ch.hoscode=n.HOSPCODE\r\ninner join hdc.person p on p.pid=n.pid and p.hospcode=n.hospcode\r\nLEFT JOIN (SELECT* from hdc.chronic where chronic  BETWEEN \'I10\' and \'I159\'  and TYPEDISCH =\'03\')  pcht on n.PID = pcht.PID and n.HOSPCODE = pcht.hospcode \r\nLEFT JOIN (SELECT* from hdc.chronic where chronic BETWEEN \'E10\' and \'E149\'  and TYPEDISCH =\'03\')  pcdm on n.PID = pcdm.PID and n.HOSPCODE = pcdm.hospcode \r\nwhere n.date_serv BETWEEN @start_d AND @end_d  and n.date_serv >=pcht.d_update  and n.date_serv >=pcdm.d_update\r\nand (pcdm.CHRONIC between \"E10\" and \"E149\" and pcht.CHRONIC between \"I10\" and \"I159\")\r\norder by n.hospcode desc', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.ncdscreen\r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select n.hospcode,ch.hosname,count(n.pid) as y_cases,ch.distcode\r\nfrom hdc.ncdscreen n\r\ninner join hdc.chospital ch on ch.hoscode=n.HOSPCODE\r\ninner join hdc.person p on p.pid=n.pid and p.hospcode=n.hospcode\r\nLEFT JOIN (SELECT* from hdc.chronic where chronic  BETWEEN \'I10\' and \'I159\'  and TYPEDISCH =\'03\')  pcht on n.PID = pcht.PID and n.HOSPCODE = pcht.hospcode \r\nLEFT JOIN (SELECT* from hdc.chronic where chronic BETWEEN \'E10\' and \'E149\'  and TYPEDISCH =\'03\')  pcdm on n.PID = pcdm.PID and n.HOSPCODE = pcdm.hospcode \r\nwhere n.date_serv BETWEEN @start_d AND @end_d  and n.date_serv >=pcht.d_update  and n.date_serv >=pcdm.d_update\r\nand (pcdm.CHRONIC between \"E10\" and \"E149\" and pcht.CHRONIC between \"I10\" and \"I159\")\r\ngroup by n.hospcode\r\n)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.ncdscreen n\r\njoin hdc.chospital c on c.hoscode=n.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere n.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select ch.distcode,count(n.pid) as y_cases\r\nfrom hdc.ncdscreen n\r\ninner join hdc.chospital ch on ch.hoscode=n.HOSPCODE\r\ninner join hdc.person p on p.pid=n.pid and p.hospcode=n.hospcode\r\nLEFT JOIN (SELECT* from hdc.chronic where chronic  BETWEEN \'I10\' and \'I159\'  and TYPEDISCH =\'03\')  pcht on n.PID = pcht.PID and n.HOSPCODE = pcht.hospcode \r\nLEFT JOIN (SELECT* from hdc.chronic where chronic BETWEEN \'E10\' and \'E149\'  and TYPEDISCH =\'03\')  pcdm on n.PID = pcdm.PID and n.HOSPCODE = pcdm.hospcode \r\nwhere n.date_serv BETWEEN @start_d AND @end_d  and n.date_serv >=pcht.d_update  and n.date_serv >=pcdm.d_update\r\nand (pcdm.CHRONIC between \"E10\" and \"E149\" and pcht.CHRONIC between \"I10\" and \"I159\")\r\ngroup by ch.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'ncdscreen1_htdm_old', 'ncdscreen', '25', 'เอ๊ะ!! มีการนำผู้ป่วยกลุ่ม DM HT มาคัดกรอง นะ น่าจะนำไปขึ้นทะเบียนโรคเรื้อรัง', '{\"84ee4b86c5f7a686655cd31319718db2.pdf\":\"eh-ncdsreen-dmht.pdf\"}', 'hWf_VhxjeJJKX3uz6sXIfQ'), ('10017', 'ตรวจสอบ อาจมีการบันทึกค่าความดันผิดพลาด', 'chronicfu_bp_a', 'chronicfu_bp_s', 'chronicfu_bp_t', 'select f.hospcode,c.hosname,f.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,f.date_Serv,f.sbp,f.dbp,f.retina,f.foot  \r\nfrom hdc.chronicfu f\r\nleft join hdc.person p on p.hospcode=f.hospcode and p.pid=f.pid\r\nLEFT JOIN hdc.chospital c on c.hoscode=f.HOSPCODE\r\nwhere f.sbp<=dbp  and f.sbp<>\'0\'\r\nAND f.DATE_SERV BETWEEN @start_d AND @end_d \r\norder by f.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.chronicfu \r\nwhere DATE_SERV BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select hospcode,hosname,count(pid) as y_cases,date_Serv,sbp,dbp,retina,foot,c.distcode  \r\nfrom hdc.chronicfu f\r\ninner join hdc.chospital c on c.hoscode=f.hospcode\r\nwhere sbp<=dbp  and sbp<>\'0\'\r\nAND DATE_SERV BETWEEN @start_d AND @end_d \r\ngroup by hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(f.pid) as pid FROM hdc.chronicfu f\r\njoin hdc.chospital c on c.hoscode=f.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere f.DATE_SERV BETWEEN @start_d AND @end_d \r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(f.pid) as y_cases\r\nfrom hdc.chronicfu f\r\njoin hdc.chospital c on c.hoscode=f.HOSPCODE\r\nwhere sbp<=dbp  and sbp<>\'0\'\r\nAND DATE_SERV BETWEEN @start_d AND @end_d\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc\r\n', '1', null, null, '', 'chronicfu_bp', 'chronicfu', '25', 'เอ๊ะ!! ได้รับการติดตามโรคเรื้อรัง แต่ยังไม่ได้ขึ้นทะเบียนโรคเรื้อรัง หรือ บันทึกข้อมูลผิดพลาด', '{\"3f70944dce10b3dee8749be971207726.pdf\":\"10017_chronicfu_bp.pdf\"}', 'AKs0mSBPOWvFvk3T5liGDL'), ('10018', 'ตรวจสอบ มีการให้บริการก่อนเกิด', 'service_before_birth_a', 'service_before_birth_s', 'service_before_birth_t', 'select s.hospcode,hosname,s.pid as service_pid,p.pid as person_pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,p.birth,s.date_serv,p.typearea  \r\nfrom hdc.service s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\nLEFT JOIN hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere s.date_serv < p.birth\r\nAND DATE_SERV BETWEEN @start_d AND @end_d \r\norder by s.hospcode', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid \r\nfrom hdc.service \r\nwhere DATE_SERV BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,hosname,c.distcode,count(p.pid) as y_cases\r\nfrom hdc.service s\r\nleft JOIN hdc.chospital c on c.hoscode=s.HOSPCODE\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\nwhere s.date_serv < p.birth\r\nAND DATE_SERV BETWEEN @start_d AND @end_d \r\ngroup by  s.hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.service s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.service s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere s.date_serv < p.birth\r\nAND s.DATE_SERV BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, '', 'service_before_birth', 'service', '25', 'เอ๊ะ!! มีประวัติการมารับบริการก่อนวันเกิด นะ', '{\"6112600f66356a0120e984a38387c729.pdf\":\"10018_Service_Before_Birth.pdf\"}', 'Wd9H5DSffJVIS6KiF_dWOf'), ('10019', 'ตรวจสอบ มีรายการยาเม็ดเสริม IODINE ที่รหัสไม่ถูกต้อง', 'anc_iodine_a', 'anc_iodine_s', 'anc_iodine_t', 'select d.hospcode,c.hosname,d.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname, d.didstd ,d.DATE_SERV\r\nfrom hdc.drug_opd d\r\nleft join hdc.person p on p.hospcode=d.hospcode and p.pid=d.pid\r\nLEFT JOIN hdc.chospital c on c.hoscode=d.HOSPCODE\r\nwhere ((d.dname like \'%trifer%\' or d.dname like \'%obimin%\' or d.dname like \'%iodine%\' or d.dname like \'%nataral%\') \r\nand (d.dname not like \'%obiminaf%\' and d.dname not like \'%obimin-af%\' and d.dname not like \'%obimin af%\') and (d.dname not like \'%povid%\')) \r\nand d.didstd not in (\'201120320037726221781506\',\'201110100019999920381199\',\'101110000003082121781506\',\'201110100019999920381341\',\'201110100019999921881341\')\r\nAND d.DATE_SERV BETWEEN @start_d AND @end_d ', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0)/pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.drug_opd\r\nwhere DATE_SERV BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select hospcode,hosname,distcode, dname, didstd, count(pid) as y_cases \r\nfrom hdc.drug_opd d\r\nLEFT JOIN hdc.chospital c on c.hoscode=d.HOSPCODE\r\nwhere ((dname like \'%trifer%\' or dname like \'%obimin%\' or dname like \'%iodine%\' or dname like \'%nataral%\') \r\nand (dname not like \'%obiminaf%\' and dname not like \'%obimin-af%\' and dname not like \'%obimin af%\') and (dname not like \'%povid%\')) \r\nand didstd not in (\'201120320037726221781506\',\'201110100019999920381199\',\'101110000003082121781506\',\'201110100019999920381341\',\'201110100019999921881341\')\r\nAND d.DATE_SERV BETWEEN @start_d AND @end_d \r\ngroup by hospcode\r\n)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(DISTINCT d.pid) as pid FROM hdc.drug_opd d\r\njoin hdc.chospital c on c.hoscode=d.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere d.DATE_SERV BETWEEN @start_d AND @end_d \r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(DISTINCT d.pid) as y_cases\r\nfrom hdc.drug_opd d\r\njoin hdc.chospital c on c.hoscode=d.HOSPCODE\r\nwhere ((dname like \'%trifer%\' or dname like \'%obimin%\' or dname like \'%iodine%\' or dname like \'%nataral%\') \r\nand (dname not like \'%obiminaf%\' and dname not like \'%obimin-af%\' and dname not like \'%obimin af%\') and (dname not like \'%povid%\')) \r\nand didstd not in (\'201120320037726221781506\', \'201110100019999920381199\', \'101110000003082121781506\', \'201110100019999920381341\',\'201110100019999921881341\')\r\nAND d.DATE_SERV BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'anc_iodine', 'anc', '25', 'เอ๊ะ!! เราพบว่ารายการยาเม็ดเสริม iodine มีรหัส 24 หลักไม่ถูกต้อง', '{\"005b24f73cb0ce8879323f327ec49723.pdf\":\"10019_ANC_Iodine.pdf\"}', 'h6NHPXUy5PY_93YjmQkjm4'), ('10020', 'ตรวจสอบ ผลตรวจตาไม่อยู่ในรหัสมาตรฐาน', 'chronicfu_retina_not_hdc_a', 'chronicfu_retina_not_hdc_s', 'chronicfu_retina_not_hdc_t', 'select ch.hospcode,c.hosname,ch.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,ch.date_serv,ch.weight,ch.waist_cm,ch.sbp,ch.dbp,ch.foot,ch.retina \r\nfrom hdc.chronicfu ch \r\nleft join hdc.person p on p.hospcode=ch.hospcode and p.pid=ch.pid\r\nleft  join hdc.chospital c on c.hoscode=ch.hospcode\r\nwhere ch.date_serv BETWEEN @start_d AND @end_d \r\nand  ch.retina not in (\'1\',\'2\',\'3\',\'4\',\'8\',\'9\')\r\norder by ch.hospcode', 'SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0)/pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid,c.hosname,c.distcode from hdc.chronicfu ch\r\nleft  join hdc.chospital c on c.hoscode=ch.hospcode\r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nLEFT JOIN \r\n(select ch.hospcode,count(ch.pid) as y_cases\r\nfrom hdc.chronicfu ch \r\nleft  join hdc.chospital c on c.hoscode=ch.hospcode\r\nwhere ch.date_serv BETWEEN @start_d AND @end_d \r\nand ch.retina not in (\'1\',\'2\',\'3\',\'4\',\'8\',\'9\')\r\n\r\ngroup by ch.hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(ch.pid) as pid FROM hdc.chronicfu ch\r\njoin hdc.chospital c on c.hoscode=ch.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere ch.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(ch.pid) as y_cases\r\nfrom hdc.chronicfu ch\r\njoin hdc.chospital c on c.hoscode=ch.HOSPCODE\r\nwhere ch.date_serv BETWEEN @start_d AND @end_d \r\nand ch.retina not in (\'1\',\'2\',\'3\',\'4\',\'8\',\'9\')\r\n\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, null, 'chronicfu_retina_not_hdc', 'chronicfu', '25', 'เอ๊ะ!! มีการบันทึกผลตรวจตาไม่อยู่ในรหัสมาตรฐานแฟ้ม Chronicfu มี retina ที่ไม่ใช่ (1,2,3,4,8,9)', null, null), ('10021', 'ตรวจสอบ ผลตรวจเท้าไม่อยู่ในรหัสมาตรฐาน', 'chronicfu_foot_not_hdc_a', 'chronicfu_foot_not_hdc_s', 'chronicfu_foot_not_hdc_t', 'select ch.hospcode,c.hosname,ch.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,ch.date_serv,ch.weight,ch.waist_cm,ch.sbp,ch.dbp,ch.foot,ch.retina \r\nfrom hdc.chronicfu ch \r\nleft join hdc.person p on p.hospcode=ch.hospcode and p.pid=ch.pid\r\nleft  join hdc.chospital c on c.hoscode=ch.hospcode\r\nwhere ch.date_serv BETWEEN @start_d AND @end_d \r\nand ch.foot not in (\'1\',\'2\',\'3\',\'9\') \r\norder by ch.hospcode', 'SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0)/pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid,c.hosname,c.distcode from hdc.chronicfu ch\r\nLEFT JOIN  hdc.chospital c on c.hoscode=ch.hospcode\r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nLEFT JOIN \r\n(select ch.hospcode,count(ch.pid) as y_cases\r\nfrom hdc.chronicfu ch \r\nLEFT JOIN  hdc.chospital c on c.hoscode=ch.hospcode\r\nwhere ch.date_serv BETWEEN @start_d AND @end_d \r\nand  ch.foot not in (\'1\',\'2\',\'3\',\'9\') \r\n\r\ngroup by ch.hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(ch.pid) as pid FROM hdc.chronicfu ch\r\njoin hdc.chospital c on c.hoscode=ch.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere ch.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(ch.pid) as y_cases\r\nfrom hdc.chronicfu ch\r\njoin hdc.chospital c on c.hoscode=ch.HOSPCODE\r\nwhere ch.date_serv BETWEEN @start_d AND @end_d \r\nand ch.foot not in (\'1\',\'2\',\'3\',\'9\')  \r\n\r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, null, 'chronicfu_foot_not_hdc', 'chronicfu', '25', 'เอ๊ะ!! มีการบันทึกผลตรวจเท้าไม่อยู่ในรหัสมาตรฐาน แฟ้ม Chronicfu มี foot ที่ไม่ใช่ (1,2,3,9)', null, null), ('10023', 'ตรวจสอบ มูลค่าการให้บริการเป็น 0 ในแฟ้ม SERVICE', 'service_sell_a', 'service_sell_s', 'service_sell_t', 'select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,s.date_serv, s.cost, s.price\r\nfrom hdc.service s\r\nLEFT JOIN (SELECT * from hdc.diagnosis_opd \r\nwhere  DIAGTYPE=1 AND date_serv BETWEEN @start_d AND @end_d ) d on d.HOSPCODE=s.HOSPCODE and d.PID=s.PID and d.SEQ=s.SEQ and d.DATE_SERV=s.DATE_SERV\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere (s.price = 0 or s.price < s.cost) and d.DIAGCODE not in (select code from diag_no_price)\r\nand s.date_serv BETWEEN @start_d AND @end_d\r\norder by h.hoscode, p.pid, s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.service \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.service s\r\nLEFT JOIN (SELECT * from hdc.diagnosis_opd \r\nwhere  DIAGTYPE=1 AND date_serv BETWEEN @start_d AND @end_d ) d on d.HOSPCODE=s.HOSPCODE and d.PID=s.PID and d.SEQ=s.SEQ and d.DATE_SERV=s.DATE_SERV\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere (s.price = 0 or s.price < s.cost) and d.DIAGCODE not in (select code from diag_no_price)\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC   ', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.service s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.service s\r\nLEFT JOIN (SELECT * from hdc.diagnosis_opd \r\nwhere  DIAGTYPE=1 AND date_serv BETWEEN @start_d AND @end_d ) d on d.HOSPCODE=s.HOSPCODE and d.PID=s.PID and d.SEQ=s.SEQ and d.DATE_SERV=s.DATE_SERV\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere (s.price = 0 or s.price < s.cost) and d.DIAGCODE not in (select code from diag_no_price)\r\nAND s.date_serv BETWEEN @start_d AND @end_d   \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, '', 'service_sell', 'service', '25', 'เอ๊ะ!! ทำไมมูลค่าการให้บริการ (ราคาขาย) เป็น 0 หรือมูลค่าบริการน้อยกว่าราคาทุน ในแฟ้ม SERVICE', '{\"7a38f361120cf2194a0aea7e8f6d960a.pdf\":\"10023_service_sell.pdf\"}', 'ja6sIJX-vLJlO7sqy-O-MJ'), ('10025', 'ตรวจสอบ วันที่ให้บริการเป็นวันที่หลัง d_update', 'service_after_dupdate_a', 'service_after_dupdate_s', 'service_after_dupdate_t', 'select s.hospcode, h.hosname, s.pid, concat(p.`NAME`,\' \',p.LNAME)as fullname, s.date_serv, s.d_update\r\nfrom hdc.service s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere s.date_serv > s.d_update\r\nAND s.date_serv BETWEEN @start_d AND @end_d\r\norder by  h.hoscode, p.pid, s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.service\r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname, count(s.pid) as y_cases ,h.distcode\r\nfrom hdc.service s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere s.date_serv > s.d_update\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.service s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.service s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere s.date_serv > s.d_update\r\nAND s.date_serv BETWEEN @start_d AND @end_d   \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, null, 'service_after_dupdate', 'service', '25', 'เอ๊ะ!! มีวันที่ให้บริการเป็นวันที่หลัง d_update ด้วยหรือ ในแฟ้ม SERVICE', null, null), ('10027', 'ตรวจสอบ ประเภทการวินิจฉัยของผู้ป่วยนอกในแฟ้ม diagnosis opd ไม่ถูกต้อง', 'diagnosis_opd_a', 'diagnosis_opd_s', 'diagnosis_opd_t', 'select s.hospcode,h.hosname,s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,s.date_serv,s.diagcode,s.diagtype\r\nfrom hdc.diagnosis_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere s.diagtype not in (\'1\',\'4\',\'5\',\'7\')\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\norder by s.hospcode, p.pid, s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.diagnosis_opd\r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.diagnosis_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere s.diagtype not in (\'1\',\'4\',\'5\',\'7\')\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.diagnosis_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.diagnosis_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere s.diagtype not in (\'1\',\'4\',\'5\',\'7\')\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, '', 'diagnosis_opd', 'service', '25', 'เอ๊ะ!! มีประเภทการวินิจฉัยของผู้ป่วยนอก ในแฟ้ม diagnosis_opd  แบบนี้ด้วยนะ', '{\"4d4f1642f24df78a07a3156371caac0b.pdf\":\"10027.pdf\"}', 'W4kwWCV3TtQ5Ns5I9yUjtO'), ('10028', 'ตรวจสอบ มีการวินิจฉัยในกลุ่ม External cause ในแฟ้ม diagnosis_opd', 'diagnosis_opd_externalcause_a', 'diagnosis_opd_externalcause_s', 'diagnosis_opd_externalcause_t', 'select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname, s.date_serv, s.diagcode, s.diagtype\r\nfrom hdc.diagnosis_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere (diagcode like \'v%\' or diagcode like \'w%\' or diagcode like \'x%\' or diagcode like \'y%\')\r\nand diagtype<>\'5\'\r\nAND s.date_serv BETWEEN @start_d AND @end_d  \r\norder by h.hoscode, p.pid, s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.diagnosis_opd \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.diagnosis_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere (diagcode like \'v%\' or diagcode like \'w%\' or diagcode like \'x%\' or diagcode like \'y%\')\r\nand diagtype<>\'5\'\r\nand s.date_serv BETWEEN @start_d AND @end_d\r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.diagnosis_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.diagnosis_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere (diagcode like \'v%\' or diagcode like \'w%\' or diagcode like \'x%\' or diagcode like \'y%\')\r\nand diagtype<>\'5\'\r\nand s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, '', 'diagnosis_opd_externalcause', 'service', '25', 'เอ๊ะ!! มีการวินิจฉัยของผู้ป่วยนอกกับรหัสวินิจฉัยในกลุ่ม External cause ในแฟ้ม diagnosis_opd', '{\"cce9d4d44c99b2d47103918de25c477c.pdf\":\"10028_Diagnosis_opd_externalcause.pdf\"}', 'IHLufypfWQYXb3ELXocKJ1'), ('10029', 'ตรวจสอบ มีการวินิจฉัยที่มิใช่กลุ่ม External cause ในแฟ้ม diagnosis_opd', 'diagnosis_opd_noexternalcause_a', 'diagnosis_opd_noexternalcause_s', 'diagnosis_opd_noexternalcause_t', 'select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,s.date_serv, s.diagcode, s.diagtype\r\nfrom hdc.diagnosis_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere (diagcode not like \'v%\' and diagcode not like \'w%\' and diagcode not like \'x%\' and diagcode not like \'y%\')\r\nand diagtype=\'5\'\r\nand s.date_serv BETWEEN @start_d AND @end_d\r\norder by h.hoscode, p.pid, s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.diagnosis_opd \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.diagnosis_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\n#join hdc.cprename pn on pn.id_prename=p.prename\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere (diagcode not like \'v%\' and diagcode not like \'w%\' and diagcode not like \'x%\' and diagcode not like \'y%\')\r\nand diagtype=\'5\'\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.diagnosis_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.diagnosis_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere (diagcode not like \'v%\' and diagcode not like \'w%\' and diagcode not like \'x%\' and diagcode not like \'y%\')\r\nand diagtype=\'5\'\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, null, 'diagnosis_opd_noexternalcause', 'service', '25', 'เอ๊ะ!! มีการวินิจฉัยของผู้ป่วยนอกกับรหัสวินิจฉัยที่มิใช่กลุ่ม External cause ในแฟ้ม diagnosis_opd', null, null), ('10030', 'ตรวจสอบ มีการให้รหัสโรคที่มีการยกเลิกการใช้งานแล้ว', 'diagnosis_opd_diagcode_a', 'diagnosis_opd_diagcode_s', 'diagnosis_opd_diagcode_t', 'select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,s.date_serv, s.diagcode\r\nfrom hdc.diagnosis_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nWHERE s.diagcode IN (SELECT CODE FROM l_icd101)\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\norder by h.hoscode, p.pid, s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.diagnosis_opd \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.diagnosis_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\n#join hdc.cprename pn on pn.id_prename=p.prename\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere s.diagcode IN (SELECT CODE FROM l_icd101)\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode = st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.diagnosis_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.diagnosis_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere s.diagcode IN (SELECT CODE FROM l_icd101)\r\nAND s.date_serv BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, '', 'diagnosis_opd_diagcode', 'service', '25', 'เอ๊ะ!! ยังมีการใช้รหัสโรคที่มีการยกเลิกการใช้งานแล้ว ในแฟ้ม diagnosis_opd', '{\"c007e01695010b451320ed2cd49f6b67.pdf\":\"10030_Diagnosis_opd_diagcode.pdf\"}', 'mT5rkLesc2YLRZm0kvUEVL'), ('10031', 'ตรวจสอบ มีการให้รหัสหัตถการที่เป็น icd9cm ใน รพ.สต.', 'procedure_opd_procedcode_a', 'procedure_opd_procedcode_s', 'procedure_opd_procedcode_t', 'select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname, s.date_serv, s.procedcode\r\nfrom hdc.procedure_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere h.hostype in (\'03\',\'18\')\r\nand length(s.procedcode) < 7\r\nand s.date_serv BETWEEN @start_d AND @end_d\r\norder by h.hoscode, p.pid, s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.procedure_opd \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.procedure_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere h.hostype in (\'03\',\'18\')\r\nand length(s.procedcode) < 7\r\nAND s.date_serv BETWEEN @start_d AND @end_d\r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.procedure_opd p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere p.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(p.pid) as y_cases\r\nfrom hdc.procedure_opd p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere c.hostype in (\'03\',\'18\')\r\nand length(p.procedcode) < 7\r\nAND p.date_serv BETWEEN @start_d AND @end_d  \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'procedure_opd_procedcode', 'procedure', '25', 'เอ๊ะ!! ยังมีการให้รหัสหัตถการที่เป็น icd9cm ใน รพ.สต. ในแฟ้ม procedure_opd อยู่นะ', '{\"f2cab96a23c8ecc8d49efaf0527fb91a.pdf\":\"10031.pdf\"}', 'e7gLwmDeBgSqZe2gK34JM_'), ('10032', 'ตรวจสอบ มูลค่าหัตถการ เป็น 0 บาท', 'procedure_opd_serviceprice_a', 'procedure_opd_serviceprice_s', 'procedure_opd_serviceprice_t', 'select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname, s.date_serv, s.procedcode, s.serviceprice\r\nfrom hdc.procedure_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere s.procedcode not in (SELECT * FROM procedure_no_price) and s.serviceprice =\'0\'\r\nand s.date_serv BETWEEN @start_d AND @end_d\r\norder by h.hoscode, p.pid, s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.procedure_opd \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.procedure_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere s.procedcode not in  (SELECT * FROM procedure_no_price) and s.serviceprice =\'0\'\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC  ', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.procedure_opd p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere p.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(p.pid) as y_cases\r\nfrom hdc.procedure_opd p\r\njoin hdc.chospital c on c.hoscode=p.HOSPCODE\r\nwhere p.procedcode not in  (SELECT * FROM procedure_no_price) and p.serviceprice =\'0\'\r\nAND p.date_serv BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'procedure_opd_serviceprice', 'procedure', '25', 'เอ๊ะ!! มูลค่าหัตถการ เป็น 0 บาท ในแฟ้ม procedure_opd จริงไหม', '{\"5a5cb0c60a4e0badf6a77813710bef3c.pdf\":\"10032.pdf\"}', 'WLj0TII69vdSPcTeizmS6D'), ('10033', 'ตรวจสอบ หมวดค่ารักษาที่ไม่ตรงมาตรฐาน', 'charge_opd_chargeitem_a', 'charge_opd_chargeitem_s', 'charge_opd_chargeitem_t', 'select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname, s.date_serv, s.chargeitem\r\nfrom hdc.charge_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere s.chargeitem not in (\'01\',\'02\',\'03\',\'04\',\'05\',\'06\',\'07\',\'08\',\'09\',\'10\',\'11\',\'12\',\'13\',\'14\',\'15\',\'16\',\'17\',\'18\')\r\nand s.date_serv BETWEEN @start_d AND @end_d\r\norder by h.hoscode, p.pid, s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.charge_opd \r\nwhere date_serv BETWEEN @start_d AND @end_d  GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.charge_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere s.chargeitem not in (\'01\',\'02\',\'03\',\'04\',\'05\',\'06\',\'07\',\'08\',\'09\',\'10\',\'11\',\'12\',\'13\',\'14\',\'15\',\'16\',\'17\',\'18\')\r\nAND s.date_serv BETWEEN @start_d AND @end_d\r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC    ', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.charge_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d \r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.charge_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere s.chargeitem not in (\'01\',\'02\',\'03\',\'04\',\'05\',\'06\',\'07\',\'08\',\'09\',\'10\',\'11\',\'12\',\'13\',\'14\',\'15\',\'16\',\'17\',\'18\')\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc\r\n', '1', '', '', '', 'charge_opd_chargeitem', 'charge', '25', 'เอ๊ะ!! มีหมวดค่ารักษาที่ไม่ตรงตามหมวดมาตรฐาน ในแฟ้ม charge_opd นะ', '{\"a605cbca3dc1d3865a8f1c41ab761691.pdf\":\"10033.pdf\"}', '5TjcVIKqfdinfNa6SLlO5v'), ('10034', 'ตรวจสอบ ค่ารักษาที่ไม่ควรมีใน รพ.สต.', 'charge_opd_nochargeitem_a', 'charge_opd_nochargeitem_s', 'charge_opd_nochargeitem_t', 'select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname, s.date_serv, s.chargeitem\r\nfrom hdc.charge_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere h.hostype in (\'03\',\'18\')\r\nand s.chargeitem in (\'01\',\'06\',\'08\',\'09\')\r\nand s.date_serv BETWEEN @start_d AND @end_d\r\norder by h.hoscode, p.pid, s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.charge_opd \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.charge_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere h.hostype in (\'03\',\'18\')\r\nand s.chargeitem in (\'01\',\'06\',\'08\',\'09\')\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC   ', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.charge_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d \r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.charge_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere c.hostype in (\'03\',\'18\')\r\nand s.chargeitem in (\'01\',\'06\',\'08\',\'09\')\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'charge_opd_nochargeitem', 'charge', '25', 'เอ๊ะ!! ค่ารักษา นี้ ไม่ควรมีใน รพ.สต. ในแฟ้ม charge_opd แล้วนะ', '{\"0dbee1de5dbb9b48c356200deadf8ab0.pdf\":\"10034.pdf\"}', 'PVc6DIcCqQEbYZEMi5vJO_'), ('10035', 'ตรวจสอบ ค่ารักษาที่ไม่ควรมีในผู้ป่วยนอกของ รพ.', 'charge_opd_nochargeitem_food_a', 'charge_opd_nochargeitem_food_s', 'charge_opd_nochargeitem_food_t', 'select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname, s.date_serv, s.chargeitem,s.price\r\nfrom hdc.charge_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere  h.hostype not in (\'03\',\'18\')\r\nand s.chargeitem = \'01\' and s.price >\'100\'\r\nand s.date_serv BETWEEN @start_d AND @end_d \r\norder by h.hoscode,p.pid,s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.charge_opd \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.charge_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere h.hostype not in (\'03\',\'18\')\r\nand s.chargeitem = \'01\' and s.price >\'100\'\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC   ', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.charge_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d \r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.charge_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere c.hostype not in (\'03\',\'18\')\r\nand s.chargeitem = \'01\' and s.price >\'100\'\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc\r\n', '1', null, null, null, 'charge_opd_nochargeitem_food', 'charge', '25', 'เอ๊ะ!! หมวดค่ารักษานี้ ไม่ควรมีในผู้ป่วยนอกของ รพ./รพ.สต (หมวดค่าห้องและอาหาร) ในแฟ้ม charge_opd', null, null), ('10036', 'ตรวจสอบ มูลค่าการให้บริการเป็น 0 บาทในแฟ้ม charge_opd', 'charge_opd_sell_a', 'charge_opd_sell_s', 'charge_opd_sell_t', 'select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,i.chargeitem, s.date_serv, s.cost, s.price\r\nfrom hdc.charge_opd s\r\nLEFT JOIN hdc.cchargeitem i on i.id_chargeitem=s.CHARGEITEM\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere (s.price = 0 or s.price < s.cost)\r\nand s.date_serv BETWEEN @start_d AND @end_d\r\norder by h.hoscode, p.pid, s.date_serv', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.charge_opd \r\nwhere date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.charge_opd s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nwhere (s.price = 0 or s.price < s.cost)\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC  ', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.charge_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d \r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.charge_opd s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere (s.price = 0 or s.price < s.cost)\r\nAND s.date_serv BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', null, null, '', 'charge_opd_sell', 'service', '25', 'เอ๊ะ!! ทำไมมูลค่าการให้บริการ (ราคาขาย) เป็น 0 หรือมูลค่าบริการน้อยกว่าราคาทุน ในแฟ้ม charge_opd', '{\"f99a6eae220f533b08d69c0ff0b951f8.pdf\":\"10036_Charge_opd_sell.pdf\"}', 'QZLhxQ2cXwch79n1WOvlDw'), ('10037', 'ตรวจสอบวันที่จำหน่ายก่อนวัน admit', 'admission_datetime_disch_a', 'admission_datetime_disch_s', 'admission_datetime_disch_t', 'select s.hospcode, h.hosname,s.an, s.pid, concat(p.`NAME`,\' \',p.LNAME)as fullname,s.datetime_admit, s.datetime_disch\r\nfrom hdc.admission s\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\nwhere s.datetime_admit > s.datetime_disch\r\nAND s.datetime_disch BETWEEN @start_d AND @end_d\r\norder by h.hoscode, p.pid, s.datetime_disch', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0)/pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.admission \r\nwhere datetime_disch BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.admission s\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\nwhere s.datetime_admit > s.datetime_disch\r\nAND s.datetime_disch BETWEEN @start_d AND @end_d \r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(a.pid) as pid FROM hdc.admission a\r\njoin hdc.chospital c on c.hoscode=a.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere a.datetime_disch BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(a.pid) as y_cases\r\nfrom hdc.admission a\r\njoin hdc.chospital c on c.hoscode=a.HOSPCODE\r\nwhere a.datetime_admit > a.datetime_disch\r\nAND a.datetime_disch BETWEEN @start_d AND @end_d \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc\r\n', '1', null, null, null, 'admission_datetime_disch', 'admission', '25', 'เอ๊ะ!! ทำไมวันที่จำหน่ายผู้ป่วย datetime_disch จึงเป็นวันที่ก่อนวันที่รับผู้ป่วย datetime_admit  ในแฟ้ม admission', null, null), ('10038', 'ตรวจสอบ มูลค่าให้บริการ (ราคาขาย) เป็น 0 admission', 'admission_sell_a', 'admission_sell_s', 'admission_sell_t', 'select s.hospcode, h.hosname, s.an,s.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname, s.datetime_admit, s.datetime_disch, s.cost, s.price\r\nfrom hdc.admission s\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\nwhere (s.price = 0 or s.price < s.cost)\r\nAND s.datetime_disch BETWEEN @start_d AND @end_d\r\norder by h.hoscode, p.pid, s.datetime_disch', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid FROM hdc.admission \r\nwhere datetime_disch BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nright JOIN\r\n(select s.hospcode,h.hosname,h.distcode,count(s.pid) as y_cases\r\nfrom hdc.admission s\r\njoin hdc.chospital h on h.hoscode=s.hospcode\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\nwhere (s.price = 0 or s.price < s.cost)\r\nAND s.datetime_disch BETWEEN @start_d AND @end_d \r\ngroup by s.hospcode\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC ', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(a.pid) as pid FROM hdc.admission a\r\njoin hdc.chospital c on c.hoscode=a.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere a.datetime_disch BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(a.pid) as y_cases\r\nfrom hdc.admission a\r\njoin hdc.chospital c on c.hoscode=a.HOSPCODE\r\nwhere (a.price = 0 or a.price < a.cost)\r\nAND a.datetime_disch BETWEEN @start_d AND @end_d   \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc\r\n', '1', null, null, null, 'admission_sell', 'admission', '25', 'เอ๊ะ!! ทำไมมูลค่าการให้บริการ (ราคาขาย) เป็น 0 หรือมูลค่าบริการน้อยกว่าราคาทุน ในแฟ้ม admission', null, null), ('10039', 'ตรวจสอบ มีการให้บริการหลังเสียชีวิต', 'person_service_death_a', 'person_service_death_s', 'person_service_death_t', 'select p.hospcode,c.hosname,p.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,p.hn,d.ddeath,s.date_serv\r\nfrom hdc.service s\r\nleft join hdc.person p on p.pid=s.pid and s.hospcode=p.hospcode\r\nleft  join hdc.death d on d.pid=p.pid and d.hospcode =p.hospcode\r\nleft join hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere s.date_serv BETWEEN @start_d AND @end_d  \r\nand DATEDIFF(s.date_serv,d.ddeath) > 7', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from hdc.service\r\nwhere DATE_SERV BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd\r\nleft JOIN\r\n(select p.hospcode,hosname,distcode,count(s.pid) as y_cases \r\nfrom hdc.service s\r\nleft join hdc.person p on p.pid=s.pid and s.hospcode=p.hospcode\r\nleft  join hdc.death d on d.pid=p.pid and d.hospcode =p.hospcode\r\nLEFT JOIN hdc.chospital c on c.hoscode=d.HOSPCODE\r\nwhere s.date_serv BETWEEN @start_d AND @end_d  \r\nand DATEDIFF(s.date_serv,d.ddeath) > 7 \r\ngroup by p.hospcode\r\n)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.service s\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\njoin hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere s.DATE_SERV BETWEEN @start_d AND @end_d\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.service s\r\nleft join hdc.person p on p.pid=s.pid and s.hospcode=p.hospcode\r\nleft  join hdc.death d on d.pid=p.pid and d.hospcode =p.hospcode\r\njoin hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere s.date_serv BETWEEN @start_d AND @end_d  \r\nand DATEDIFF(s.date_serv,d.ddeath) > 7 \r\ngroup by c.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by st.y_cases desc', '1', '', '', '', 'person_service_death', 'person', '25', 'เอ๊ะ!! เราให้บริการหลังเสียชีวิต หรือปล่าวนะ??', '{\"e9c426acef2f3a886f43a32facfeeac8.pdf\":\"10039_PERSON_service_death.pdf\"}', '3gjmClFF3ILt5crLhyQ1xI'), ('10040', 'ตรวจสอบ ผู้ป่วย DM มี HbA1c นอกพิสัยที่เป็นไปได้ (0.01 - 25 )', 'labfu_hba1c_not_standard_a', 'labfu_hba1c_not_standard_s', 'labfu_hba1c_not_standard_t', 'SELECT l.HOSPCODE, ch.hosname,l.PID,concat(p.`NAME`,\' \',p.LNAME)as fullname,lt.LABTEST,l.DATE_SERV,l.LABRESULT,c.CHRONIC FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND  \'N189\'   and TYPEDISCH <>\'02\')  c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'05\', \'0531601\') AND l.labresult NOT BETWEEN \'0.01\' AND \'25\' ORDER BY l.HOSPCODE', 'SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode ,nd.pid,IFNULL(st.y_cases,0) as y_cases, round((IFNULL(st.y_cases,0)/pid)*100,2) as percent FROM (SELECT l.HOSPCODE,ch.hosname,ch.distcode ,COUNT(l.pid) as pid FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\')  c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'05\', \'0531601\') GROUP BY l.HOSPCODE) nd LEFT JOIN (SELECT l.HOSPCODE,ch.hosname,COUNT(l.pid) as y_cases FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'05\', \'0531601\') AND l.labresult NOT BETWEEN \'0.01\' AND \'25\' GROUP BY l.HOSPCODE )as st on nd.hospcode=st.hospcode ORDER BY st.hospcode', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid, IFNULL(st.y_cases,0) as y_cases, round((IFNULL(st.y_cases,0) /pid)*100,2) as percent FROM (SELECT c.distcode,ca.ampurname,COUNT(l.pid) as pid FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic  WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE JOIN hdc.chospital c on c.hoscode=l.HOSPCODE JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'05\', \'0531601\') GROUP BY c.distcode) nd left JOIN (SELECT ch.distcode,COUNT(l.pid) as y_cases FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic  WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.clabtest lt on lt.id_labtest=l.LABTEST LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'05\', \'0531601\') AND l.labresult NOT BETWEEN \'0.01\' AND \'25\' GROUP BY ch.distcode )as st on nd.distcode=st.distcode order by st.y_cases desc', '1', null, null, '', 'labfu_hba1c_not_standard', 'chronicfu', '25', 'เอ๊ะ!! ผู้ป่วยเบาหวานในทะเบียนโรคเรื้อรัง แฟ้ม Chronic มีการตรวจ HbA1c แฟ้ม Labfu  ผลการตรวจ labresult นอกพิสัยที่ควรเป็นไปได้ (0.01 - 25 )', '{\"0b5d5dbac1a4bf4a24d365a67cc2d9b5.pdf\":\"10040_labfu_hba1c_not_standard.pdf\"}', 'RDAmX_G4viJSD8ElHpcXoX'), ('10042', 'ตรวจสอบ ผู้ป่วยนอกมีส่งต่อ แต่ไม่ระบุสถานพยาบาลปลายทาง หรือเหตุผลการส่งต่อ', 'service_send_a', 'service_send_s', 'service_send_t', 'select s.hospcode,c.hosname,s.PID,concat(p.`NAME`,\' \',p.LNAME)as fullname,s.DATE_SERV,s.REFEROUTHOSP,s.CAUSEOUT\r\nfrom hdc.service s\r\nleft join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid\r\nleft outer join hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere s.date_serv BETWEEN @start_d AND @end_d  and typeout=3\r\nand (isnull(s.referouthosp) or isnull(s.causeout))\r\nORDER BY s.HOSPCODE', 'SELECT st.hospcode,st.hosname,concat(@province,st.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(select s.hospcode,count(s.PID) as pid from hdc.service s\r\nRIGHT join hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere date_serv BETWEEN @start_d AND @end_d and typeout=3 \r\nGROUP BY s.HOSPCODE) nd\r\nleft JOIN\r\n(select s.hospcode,c.hosname,count(s.pid) as y_cases,c.distcode		\r\nfrom hdc.service s\r\nleft join hdc.chospital c on c.hoscode=s.HOSPCODE\r\nwhere date_serv BETWEEN @start_d AND @end_d  and typeout=3\r\nand (isnull(referouthosp) or isnull(causeout))\r\ngroup by s.hospcode)as st\r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.service s\r\nleft join hdc.chospital c on c.hoscode=s.HOSPCODE\r\nleft join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere date_serv BETWEEN @start_d AND @end_d and TYPEOUT=3\r\nGROUP BY c.distcode) nd\r\nleft JOIN \r\n(select c.distcode,count(s.pid) as y_cases\r\nfrom hdc.service s\r\nleft join hdc.chospital c on c.hoscode=s.hospcode\r\nwhere date_serv BETWEEN @start_d AND @end_d  and typeout=3\r\nand (isnull(referouthosp) or isnull(causeout))\r\ngroup by c.distcode)as st\r\non nd.distcode=st.distcode\r\norder by st.y_cases DESC', '1', null, null, '', 'service_send', 'service', '25', 'เอ๊ะ!!  มีผู้ป่วยนอกส่งต่อไปยังสถานพยาบาลอื่น แต่ไม่ระบุสาเหตุ  นะ', '{\"871283e6a66be27f33e01cda1cf207d1.pdf\":\"10042_Service_send.pdf\"}', 'i5D6wQ4MSN_Vm-htU2cjlt'), ('10043', 'ตรวจสอบ ผล macroalbumin หรือ microalbumin ที่ไม่ใส่ค่า 0,1,2', 'macroalbumin_a', 'macroalbumin_s', 'macroalbumin_t', 'select l.hospcode,c.hosname,l.PID,concat(p.`NAME`,\' \',p.LNAME)as fullname,l.LABTEST,l.labresult,l.DATE_SERV\r\nfrom hdc.labfu l\r\nleft join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid\r\nLEFT JOIN chospital c on c.hoscode=l.HOSPCODE\r\nwhere date_serv between @start_d AND @end_d \r\nand labtest in (\'12\',\'14\') \r\nand labresult not in (\'0\',\'1\',\'2\')\r\nORDER BY l.HOSPCODE', 'select t2.hospcode, h.hosname, concat(@province,h.distcode) as distcode  \r\n,t2.total, IFNULL(t1.error,0) as y_cases, (IFNULL(t1.error,0)/t2.total)*100 as percent from \r\n(select hospcode, count(pid) as total\r\nfrom hdc.labfu\r\nwhere date_serv between @start_d AND @end_d \r\nand labtest in (\'12\',\'14\')\r\ngroup by hospcode) t2\r\nLEFT JOIN\r\n(select hospcode, count(pid) as error\r\nfrom hdc.labfu\r\nwhere date_serv between @start_d AND @end_d \r\nand labtest in (\'12\',\'14\') \r\nand labresult not in (\'0\',\'1\',\'2\')\r\ngroup by hospcode) t1 on t2.hospcode=t1.hospcode\r\nleft join chospital h on h.hoscode=t2.hospcode\r\norder by t1.error', 'SELECT concat(@province,t2.distcode) as distcode,t2.ampurname,t2.total,\r\nIFNULL(t1.error,0) as y_cases,\r\nround((IFNULL(t1.error,0) /t2.total)*100,2) as percent\r\nfrom \r\n(select c.distcode,ca.ampurname, count(pid) as total\r\nfrom hdc.labfu l\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere date_serv between @start_d AND @end_d \r\nand labtest in (\'12\',\'14\')\r\ngroup by c.distcode) t2 \r\nLEFT JOIN\r\n(select c.distcode,ca.ampurname, count(pid) as error\r\nfrom hdc.labfu l\r\njoin hdc.chospital c on c.hoscode=l.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province\r\nwhere date_serv between @start_d AND @end_d  \r\nand labtest in (\'12\',\'14\') \r\nand labresult not in (\'0\',\'1\',\'2\')\r\ngroup by c.distcode) t1\r\non t1.distcode=t2.distcode\r\norder by t1.error desc', '0', null, null, '', 'macroalbumin', 'service', '25', 'เอ๊ะ!! มีการรายงานผล macroalbumin หรือ microalbumin ที่บันทึกผลการตรวจไม่ตรงตามมาตรฐาน (ไม่เป็น 0, 1 หรือ 2)', '{\"ca42880d0be2e19cd60f8c63a1c9d376.pdf\":\"10043_Macroalbumin.pdf\"}', '5vPCP5VaWVziFMhLEy40R7'), ('10044', 'ตรวจสอบ ส่งต่อไปยังสถานพยาบาลอื่นแต่ไม่ระบุสาเหตุ', 'admission_refer_a', 'admission_refer_s', 'admission_refer_t', 'SELECT a.hospcode,c.hosname,a.an,a.pid,concat(p.`NAME`,\' \',p.LNAME)as fullname,a.datetime_admit, a.datetime_disch,a.referouthosp,a.causeout\r\nFROM hdc.admission a\r\nLEFT JOIN hdc.chospital c ON c.hoscode = a.hospcode\r\nleft join hdc.person p on p.hospcode=a.hospcode and p.pid=a.pid\r\nWHERE DATE_FORMAT(a.datetime_disch,\'%Y-%m-%d\') BETWEEN @start_d AND @end_d \r\nAND a.dischtype = 4\r\nAND (ISNULL(a.referouthosp) OR ISNULL(a.causeout))\r\nORDER BY a.hospcode', 'SELECT a.hospcode,ch.hosname,CONCAT(@province,ch.distcode) AS distcode,\r\na.t AS total_pid,\r\nIFNULL(COUNT(b.t),0) AS y_cases ,\r\nROUND((IFNULL(COUNT(b.t),0) /a.t)*100,2) AS percent \r\nFROM (SELECT a.hospcode,COUNT(a.pid) AS t \r\n	FROM hdc.admission a\r\n	WHERE DATE_FORMAT(a.datetime_disch,\'%Y-%m-%d\') BETWEEN @start_d AND @end_d \r\n	AND a.dischtype = 4 \r\n	GROUP BY a.hospcode) a\r\nLEFT JOIN (SELECT a.hospcode,pid AS t \r\n		FROM hdc.admission a\r\n		LEFT JOIN hdc.chospital c ON c.hoscode = a.hospcode\r\n		WHERE DATE_FORMAT(a.datetime_disch,\'%Y-%m-%d\') BETWEEN @start_d AND @end_d \r\n		AND a.dischtype = 4 AND (ISNULL(a.referouthosp) OR ISNULL(a.causeout)))  b \r\nON a.HOSPCODE = b.HOSPCODE\r\nLEFT JOIN hdc.chospital ch ON ch.hoscode = a.hospcode\r\nGROUP BY a.hospcode\r\nORDER BY a.hospcode', 'SELECT CONCAT(@province,ch.distcode) AS distcode,ca.ampurname,\r\na.t AS total_pid,\r\nIFNULL(COUNT(b.t),0) AS y_cases ,\r\nROUND((IFNULL(COUNT(b.t),0) /a.t)*100,2) AS percent \r\nFROM (SELECT a.hospcode,COUNT(a.pid) AS t \r\n	FROM hdc.admission a\r\n	WHERE DATE_FORMAT(a.datetime_disch,\'%Y-%m-%d\') BETWEEN @start_d AND @end_d \r\n	AND a.dischtype = 4 \r\n	GROUP BY a.hospcode) a\r\nLEFT JOIN (SELECT a.hospcode,pid AS t \r\n		FROM hdc.admission a\r\n		LEFT JOIN hdc.chospital c ON c.hoscode = a.hospcode\r\n		WHERE DATE_FORMAT(a.datetime_disch,\'%Y-%m-%d\') BETWEEN @start_d AND @end_d \r\n		AND a.dischtype = 4 AND (ISNULL(a.referouthosp) OR ISNULL(a.causeout)))  b \r\nON a.HOSPCODE = b.HOSPCODE\r\nLEFT JOIN hdc.chospital ch ON ch.hoscode = a.hospcode\r\nLEFT JOIN hdc.campur ca ON ca.ampurcode = ch.distcode AND ca.changwatcode=@province \r\nGROUP BY ch.distcode\r\nORDER BY a.hospcode', '1', null, null, null, 'admission_refer', 'admission', '25', 'เอ๊ะ!! บอกว่าผู้ป่วยใน\"ส่งต่อไปยังสถานพยาบาลอื่น\" แต่ไม่ระบุสถานพยาบาลปลายทาง หรือเหตุผลการส่งต่อ นะ', null, null), ('10045', 'ตรวจสอบ ผู้ป่วยHT/DM มี Creatinine นอกพิสัยที่ควรเป็นไปได้   (0.01 - 25 )', 'labfu_Creatinine_not_standard_a', 'labfu_Creatinine_not_standard_s', 'labfu_Creatinine_not_standard_t', 'SELECT l.HOSPCODE, ch.hosname,l.PID,concat(p.`NAME`,\' \',p.LNAME)as fullname,lt.LABTEST,l.DATE_SERV,l.LABRESULT,c.CHRONIC FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND  \'N189\'   and TYPEDISCH <>\'02\')  c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'11\', \'0581803\') AND l.labresult NOT BETWEEN \'0.01\' AND \'25\' ORDER BY l.HOSPCODE', 'SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode ,nd.pid,IFNULL(st.y_cases,0) as y_cases, round((IFNULL(st.y_cases,0)/pid)*100,2) as percent FROM (SELECT l.HOSPCODE,ch.hosname,ch.distcode ,COUNT(l.pid) as pid FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\')  c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'11\', \'0581803\') GROUP BY l.HOSPCODE) nd LEFT JOIN (SELECT l.HOSPCODE,ch.hosname,COUNT(l.pid) as y_cases FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'11\', \'0581803\') AND l.labresult NOT BETWEEN \'0.01\' AND \'25\' GROUP BY l.HOSPCODE )as st on nd.hospcode=st.hospcode ORDER BY st.hospcode', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid, IFNULL(st.y_cases,0) as y_cases, round((IFNULL(st.y_cases,0) /pid)*100,2) as percent FROM (SELECT c.distcode,ca.ampurname,COUNT(l.pid) as pid FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I15\'  or CHRONIC BETWEEN \'N18\' AND N189\'   and TYPEDISCH <>\'02\') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE JOIN hdc.chospital c on c.hoscode=l.HOSPCODE JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'11\',’ 0581803’) GROUP BY c.distcode) nd left JOIN (SELECT ch.distcode,COUNT(l.pid) as y_cases FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I15\'  or CHRONIC BETWEEN \'N18\' AND N189\'   and TYPEDISCH <>\'02\') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.clabtest lt on lt.id_labtest=l.LABTEST LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'11\',\' 0581803\') AND l.labresult NOT BETWEEN \'0.01\' AND \'25\' GROUP BY ch.distcode )as st on nd.distcode=st.distcode order by st.y_cases desc', '1', '', '', '', 'labfu_Creatinine_not_standard', 'chronicfu', '25', 'เอ๊ะ!! ผู้ป่วยในทะเบียนโรคเรื้อรัง แฟ้ม Chronic มีการตรวจ Creatinine แฟ้ม Labfu ผลการตรวจ labresult นอกพิสัยที่ควรเป็นไปได้ (0.01 - 25 )', '{\"e432370eb713b9e6bab3529f2cf595aa.pdf\":\"10045.pdf\"}', 'FFeLyETpqJRPf66YI_Q6O4'), ('10046', 'ตรวจสอบ ผู้ป่วยHT/DM รายงานผล microalbumin/macroalbumin ไม่ใช่รหัสมาตรฐานตามกำหนด (0 ,1 , 2)', 'labfu_microalbumin_not_standard_a', 'labfu_microalbumin_not_standard_s', 'labfu_microalbumin_not_standard_t', 'SELECT l.HOSPCODE, ch.hosname,l.PID,concat(p.`NAME`,\' \',p.LNAME)as fullname,lt.LABTEST,l.DATE_SERV,l.LABRESULT,c.CHRONIC FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND  \'N189\'   and TYPEDISCH <>\'02\')  c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'12\', \'14\', \'0440204\', \'0440203\') AND l.labresult NOT IN (\'0\', \'1\', \'2\') ORDER BY l.HOSPCODE', 'SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode ,nd.pid,IFNULL(st.y_cases,0) as y_cases, round((IFNULL(st.y_cases,0)/pid)*100,2) as percent FROM (SELECT l.HOSPCODE,ch.hosname,ch.distcode ,COUNT(l.pid) as pid FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\')  c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'12\', \'14\', \'0440204\', \'0440203\') GROUP BY l.HOSPCODE) nd LEFT JOIN (SELECT l.HOSPCODE,ch.hosname,COUNT(l.pid) as y_cases FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'12\', \'14\', \'0440204\', \'0440203\') AND l.labresult NOT IN (\'0\', \'1\', \'2\')  GROUP BY l.HOSPCODE )as st on nd.hospcode=st.hospcode ORDER BY st.hospcode', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid, IFNULL(st.y_cases,0) as y_cases, round((IFNULL(st.y_cases,0) /pid)*100,2) as percent FROM (SELECT c.distcode,ca.ampurname,COUNT(l.pid) as pid FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic  WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE JOIN hdc.chospital c on c.hoscode=l.HOSPCODE JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'12\', \'14\', \'0440204\', \'0440203\') GROUP BY c.distcode) nd left JOIN (SELECT ch.distcode,COUNT(l.pid) as y_cases FROM hdc.labfu l INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic  WHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\'  or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE LEFT JOIN hdc.clabtest lt on lt.id_labtest=l.LABTEST LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'12\', \'14\', \'0440204\', \'0440203\') AND l.labresult NOT IN (\'0\', \'1\', \'2\') GROUP BY ch.distcode )as st on nd.distcode=st.distcode order by st.y_cases desc', '1', '', '', '', 'labfu_microalbumin_not_standard', 'chronicfu', '25', 'เอ๊ะ!! ผู้ป่วยในทะเบียนโรคเรื้อรัง แฟ้ม Chronic มีการตรวจ microalbumin แฟ้ม Labfu ผลการตรวจ labresult ไม่ใช่รหัสมาตรฐาน ปล.รหัสมาตรฐานมีค่า 0,1,2  เท่านั้น หมายเหตุ ผลการตรวจแต่ละรหัส 0=negative, 1=trace, 2=positive', null, null), ('10047', 'ตรวจสอบ การบันทึก วันคลอดในแฟ้ม Labor  ไม่สัมพันธ์ กับวันลูกเกิด ในแฟ้ม Newborn', 'labor_bdate_not_as_newborn_a', 'labor_bdate_not_as_newborn_s', 'labor_bdate_not_as_newborn_t', 'select l.hospcode,l.pid as pid_mather,concat(p1.`NAME`,\' \',p1.LNAME)as fullname1,p1.hn as hn_mather,l.gravida as labor_gravida,l.bdate as labor_bdate , n.pid as pid_newborn,concat(p2.`NAME`,\' \',p2.LNAME)as fullname2,p2.hn as hn_newborn ,n.gravida as newborn_gravida,n.bdate as newborn_bdate from hdc.labor l\r\nleft  join hdc.newborn n on l.hospcode=n.hospcode and l.pid=n.mpid \r\nLEFT JOIN hdc.person p1 on p1.pid=l.pid and p1.HOSPCODE=l.HOSPCODE\r\nLEFT JOIN hdc.person p2 on p2.pid=n.pid and p2.HOSPCODE=n.HOSPCODE\r\nwhere l.bdate BETWEEN @start_d AND @end_d  and n.bdate BETWEEN @start_d AND @end_d  and l.bdate<>n.bdate and timestampdiff(month,l.bdate,n.bdate ) between \'-3\' and \'3\' \r\n', 'SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0)/pid)*100,2) as percent\r\nFROM\r\n(select l.hospcode,h.hosname,h.distcode,count(l.pid) as pid from hdc.labor l\r\nleft  join hdc.newborn n on l.hospcode=n.hospcode and l.pid=n.mpid \r\njoin hdc.chospital h on h.hoscode=l.hospcode\r\nwhere l.bdate BETWEEN @start_d AND @end_d  and n.bdate BETWEEN @start_d AND @end_d GROUP BY l.HOSPCODE) nd\r\nLEFT JOIN\r\n(select l.hospcode,count(l.pid) as y_cases from hdc.labor l\r\nleft  join hdc.newborn n on l.hospcode=n.hospcode and l.pid=n.mpid \r\nLEFT JOIN hdc.person p1 on p1.pid=l.pid and p1.HOSPCODE=l.HOSPCODE\r\nLEFT JOIN hdc.person p2 on p2.pid=n.pid and p2.HOSPCODE=n.HOSPCODE\r\nwhere l.bdate BETWEEN @start_d AND @end_d  and n.bdate BETWEEN @start_d AND @end_d  and l.bdate<>n.bdate and timestampdiff(month,l.bdate,n.bdate ) between \'-3\' and \'3\' \r\nGROUP BY l.HOSPCODE\r\n)as st \r\non nd.hospcode=st.hospcode\r\norder by st.y_cases DESC  ', 'SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /pid)*100,2) as percent\r\nFROM\r\n(select h.distcode,ca.ampurname,COUNT(l.pid) as pid from hdc.labor l\r\nleft  join hdc.newborn n on l.hospcode=n.hospcode and l.pid=n.mpid \r\njoin hdc.chospital h on h.hoscode=l.hospcode\r\nJOIN hdc.campur ca on ca.ampurcode = h.distcode and ca.changwatcode=@province\r\nwhere l.bdate BETWEEN @start_d AND @end_d  and n.bdate BETWEEN @start_d AND @end_d GROUP BY h.distcode) nd\r\nLEFT JOIN\r\n(select ch.distcode,count(l.pid) as y_cases from hdc.labor l\r\nleft  join hdc.newborn n on l.hospcode=n.hospcode and l.pid=n.mpid \r\nLEFT JOIN hdc.person p1 on p1.pid=l.pid and p1.HOSPCODE=l.HOSPCODE\r\nLEFT JOIN hdc.person p2 on p2.pid=n.pid and p2.HOSPCODE=n.HOSPCODE\r\nLEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE\r\nwhere l.bdate BETWEEN @start_d AND @end_d  and n.bdate BETWEEN @start_d AND @end_d  and l.bdate<>n.bdate and timestampdiff(month,l.bdate,n.bdate ) between \'-3\' and \'3\' \r\nGROUP BY ch.distcode\r\n)as st \r\non nd.distcode=st.distcode\r\norder by distcode ', '1', '', '', '', 'labor_bdate_not_as_newborn', 'newborn', '25', 'เอ๊ะ!! เด็กคนเดียวกัน ทำไม บันทึก วันคลอดในแฟ้ม Labor  ไม่สัมพันธ์ กับวันลูกเกิด ในแฟ้ม Newborn', '{\"637a28d44702acbf853a4de01e4a3894.pdf\":\"10047_Labor_Bdate_Not_As_Newborn.pdf\"}', 'irbKUtM5zhgTwK2ff1HUK0'), ('10062', 'ตรวจสอบคนไทย Typearea ไม่ใช่ 1,3', 't_person_cid_notin13_a', 't_person_cid_notin13_s', 't_person_cid_notin13_t', 'SELECT p.HOSPCODE,h.hosname,p.PID,p.cid,CONCAT(p.`NAME`,\' \',p.LNAME) AS fullname,p.SEX,p.age_y,p.TYPEAREA\r\nFROM hdc.t_person_cid p\r\nLEFT JOIN hdc.chospital h ON h.hoscode = p.HOSPCODE\r\nWHERE TYPEAREA NOT IN (\'1\',\'3\')\r\nAND p.DISCHARGE=9 AND p.nation=99\r\nORDER BY p.HOSPCODE,p.PID', 'SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) AS distcode ,nd.cid,\r\nIFNULL(st.y_cases,0) AS y_cases,\r\nround((IFNULL(st.y_cases,0) /nd.cid)*100,2) AS percent\r\nFROM\r\n(SELECT hospcode,count(cid) AS cid FROM hdc.t_person_cid \r\nWHERE DISCHARGE=9 AND nation=99\r\nGROUP BY HOSPCODE)AS nd\r\nLEFT JOIN\r\n(SELECT p.hospcode,count(p.cid) AS y_cases\r\nFROM t_person_cid_notin13_t p  \r\nGROUP BY p.hospcode)AS st\r\nON nd.hospcode=st.hospcode\r\nLEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode\r\nORDER BY st.y_cases DESC', 'SELECT nd.distcode,ca.ampurname,nd.cid,\r\nIFNULL(st.y_cases,0) AS y_cases,\r\nround((IFNULL(st.y_cases,0) /nd.cid)*100,2) AS percent\r\nFROM\r\n(SELECT p.distcode,sum(p.total_cid) as cid FROM t_person_cid_notin13_s p\r\nGROUP BY p.distcode)AS nd\r\nLEFT JOIN \r\n(SELECT p.distcode,sum(p.y_cases) AS y_cases FROM t_person_cid_notin13_s p\r\nGROUP BY p.distcode\r\n)AS st \r\nON nd.distcode=st.distcode\r\nLEFT JOIN hdc.campur ca on ca.ampurcodefull = nd.distcode and ca.changwatcode=@province\r\norder by st.y_cases desc', '0', null, null, null, 't_person_cid_notin13', 'person', '25', 'คนไทย Typearea ไม่ใช่ 1,3', null, null), ('10066', 'ประชากรไทยในรับผิดชอบไม่ถูกนำเข้าแฟ้มที่พักอาศัย(HOME) / ประเภทที่พักผิดมาตรฐาน', 'person_nohome_a', 'person_nohome_s', 'person_nohome_t', 'select p.hospcode as \'รหัสสถานพยาบาล\',p.hid as\'รหัสบัาน (HID)\',p.pid as \'รหัสประจำตัว (PID)\',concat( left(p.cid,8),\'xxxxx\') as cid ,concat(p.name,\' \',p.lname)as \'ชื่อ-สกุล\',p.nation,p.typearea,h.housetype,h.hid,h.village from person p\r\nleft outer join home h on p.hospcode=h.hospcode and p.hid=h.hid\r\nwhere p.nation=\'099\' and p.typearea in (\'1\',\'2\',\'3\') and p.discharge=\'9\'  and ( h.hid is null  or h.housetype is null  or h.housetype=\'0\')\r\ngroup by p.hospcode,p.cid\r\norder by p.hospcode ;', 'SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode ,nd.cid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /nd.cid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(cid) as cid from tmp_person_nohome_t \r\nGROUP BY HOSPCODE) AS nd\r\nLEFT JOIN\r\n(select hospcode,count(cid) as y_cases from person_nohome_t\r\ngroup by hospcode)as st\r\non nd.hospcode=st.hospcode\r\nLEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode\r\nORDER BY st.y_cases DESC', 'SELECT s.distcode,ca.ampurname,\r\nSUM(s.total_cid) AS total_cid,\r\nIFNULL(SUM(s.y_cases),0) AS y_cases,\r\nround((IFNULL(SUM(s.y_cases),0) /SUM(s.total_cid))*100,2) AS percent\r\nFROM person_nohome_s s\r\nLEFT JOIN hdc.campur ca ON ca.ampurcodefull = s.distcode AND ca.changwatcode=@province\r\nGROUP BY s.distcode\r\nORDER BY y_cases DESC', '1', null, null, '', 'person_nohome', 'person', '25', '', '{\"602ab7725d7228eafa3fbea21c7bb298.pdf\":\"Eh Person_NoHome.pdf\"}', 'MuxZQ_PshE6WFOS4IdvUc2'), ('10067', 'ประชากรในเขตรับผิดชอบหรือคนไทยที่เข้ารับบริการในปีงบประมาณมีเลขประชาชนไม่ครบ 13 หลัก หรือไม่ถูกต้องตามนิยาม', 'person_nocid_13_a', 'person_nocid_13_s', 'person_nocid_13_t', 'select p.hospcode,c.hosname,p.pid,p.cid,p.name,p.lname,nation,typearea,p.discharge,p.d_update,count(distinct s.seq) as total_service  from person p\r\nleft join service s on s.hospcode=p.hospcode and s.pid=p.pid\r\nleft join chospital c on c.hoscode=p.hospcode\r\nwhere s.date_serv >\'2016-09-30\' and p.discharge=\'9\' and p.nation=\'099\' and length(p.cid) <13\r\nUNION\r\nselect p.hospcode,c.hosname,p.pid,p.cid,p.name,p.lname,nation,typearea,p.discharge,p.d_update,count(distinct s.seq) as total_service  from person p\r\nleft join service s on s.hospcode=p.hospcode and s.pid=p.pid\r\nleft join chospital c on c.hoscode=p.hospcode\r\nwhere s.date_serv >\'2016-09-30\' and p.discharge=\'9\' and p.nation=\'099\' and p.typearea in (\'1\',\'3\')and p.cid like \'0%\'\r\ngroup by p.hospcode,p.cid\r\norder by hospcode', 'SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode ,nd.cid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /nd.cid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(cid) as cid from tmp_person_nocid_13_t \r\nGROUP BY HOSPCODE) AS nd\r\nLEFT JOIN\r\n(select hospcode,count(cid) as y_cases from person_nocid_13_t\r\ngroup by hospcode)as st\r\non nd.hospcode=st.hospcode\r\nLEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode\r\nORDER BY st.y_cases DESC', '\r\nSELECT s.distcode,ca.ampurname,\r\nSUM(s.total_cid) AS total_cid,\r\nIFNULL(SUM(s.y_cases),0) AS y_cases,\r\nround((IFNULL(SUM(s.y_cases),0) /SUM(s.total_cid))*100,2) AS percent\r\nFROM person_nocid_13_s s\r\nLEFT JOIN hdc.campur ca ON ca.ampurcodefull = s.distcode AND ca.changwatcode=@province\r\nGROUP BY s.distcode\r\nORDER BY y_cases DESC', '1', null, null, '', 'person_nocid_13', 'person', '25', '', '', ''), ('10068', 'ประชากรผิดเพศในพื้นที่รับผิดชอบที่กระทบเป้าหมายงานเชิงรุก', 'person_falsesex_a', 'person_falsesex_s', 'person_falsesex_t', 'DROP TABLE IF EXISTS tmp_person_falsesex_t;\r\nCREATE TABLE tmp_person_falsesex_t (\r\nid int(15) NOT NULL AUTO_INCREMENT COMMENT \'ลำดับ\',\r\nhospcode varchar(5) NOT NULL DEFAULT \'\' COMMENT \'รหัสหน่วยบริการ\',\r\nhosname varchar(100) NOT NULL DEFAULT \'\' COMMENT \'ชื่อหน่วยบริการ\',\r\npid VARCHAR(10) NOT NULL DEFAULT \'\' COMMENT \'ทะเบียนบุคคล\',\r\ncid VARCHAR(15) NOT NULL DEFAULT \'\' COMMENT \'เลขที่บัตรประชาชน\',\r\npprename VARCHAR(5) NOT NULL DEFAULT \'\' COMMENT \'คำนำหน้า\',\r\ncprename VARCHAR(50) NOT NULL DEFAULT \'\' COMMENT \'คำนำหน้า\',\r\nfullname VARCHAR(100) NOT NULL DEFAULT \'\' COMMENT \'ชื่อนามสกุล\',\r\nsex VARCHAR(1) NOT NULL DEFAULT \'\' COMMENT \'เพศ\',\r\ntypearea varchar(5) NOT NULL DEFAULT \'\' COMMENT \'สถานะบุคคล\',\r\nd_update varchar(15) NOT NULL DEFAULT \'\' COMMENT \'วันเดือนปีที่ปรับปรุงข้อมูล\',\r\n\r\nPRIMARY KEY (id)\r\n\r\n)ENGINE=MyISAM DEFAULT CHARSET=utf8;\r\n\r\nTRUNCATE TABLE tmp_person_falsesex_t;\r\n\r\nINSERT INTO tmp_person_falsesex_t\r\n(\r\nhospcode,hosname,pid,cid,pprename,cprename,fullname,sex,typearea,d_update\r\n)\r\n\r\n( \r\nselect hospcode,ch.hosname,pid,cid,p.prename,c.prename,concat(p.NAME,\' \', p.lname)AS fullname,sex,typearea,d_update from hdc.person p\r\nleft join hdc.cprename c on c.id_prename=p.PRENAME\r\nleft join hdc.chospital ch on ch.hoscode=p.hospcode\r\nwhere nation =\'099\' AND ((p.prename in (\'001\',\'003\')) OR ((p.prename like \'7%\' or p.prename like \'8%\' or p.prename like \'9%\') and p.prename <>\'863\'))\r\ngroup by hospcode,pid\r\n\r\n\r\n);\r\n\r\nDROP TABLE IF EXISTS person_falsesex_t;\r\nCREATE TABLE person_falsesex_t (\r\nid int(15) NOT NULL AUTO_INCREMENT COMMENT \'ลำดับ\',\r\nhospcode varchar(5) NOT NULL DEFAULT \'\' COMMENT \'รหัสหน่วยบริการ\',\r\nhosname varchar(100) NOT NULL DEFAULT \'\' COMMENT \'ชื่อหน่วยบริการ\',\r\npid VARCHAR(10) NOT NULL DEFAULT \'\' COMMENT \'ทะเบียนบุคคล\',\r\ncid VARCHAR(15) NOT NULL DEFAULT \'\' COMMENT \'เลขที่บัตรประชาชน\',\r\npprename VARCHAR(5) NOT NULL DEFAULT \'\' COMMENT \'คำนำหน้า\',\r\ncprename VARCHAR(50) NOT NULL DEFAULT \'\' COMMENT \'คำนำหน้า\',\r\nfullname VARCHAR(100) NOT NULL DEFAULT \'\' COMMENT \'ชื่อนามสกุล\',\r\nsex VARCHAR(1) NOT NULL DEFAULT \'\' COMMENT \'เพศ\',\r\ntypearea varchar(5) NOT NULL DEFAULT \'\' COMMENT \'สถานะบุคคล\',\r\nd_update varchar(15) NOT NULL DEFAULT \'\' COMMENT \'วันเดือนปีที่ปรับปรุงข้อมูล\',\r\n\r\nPRIMARY KEY (id)\r\n\r\n)ENGINE=MyISAM DEFAULT CHARSET=utf8;\r\n\r\nTRUNCATE TABLE person_falsesex_t;\r\n\r\nINSERT INTO person_falsesex_t\r\n(\r\nhospcode,hosname,pid,cid,pprename,cprename,fullname,sex,typearea,d_update\r\n)\r\n\r\n( \r\nselect hospcode,ch.hosname,pid,cid,p.prename,c.prename,concat(p.NAME,\' \', p.lname)AS fullname,sex,typearea,d_update from hdc.person p\r\nleft join hdc.cprename c on c.id_prename=p.PRENAME\r\nleft join hdc.chospital ch on ch.hoscode=p.hospcode\r\nwhere nation =\'099\' and sex <>\'1\' AND ((p.prename in (\'001\',\'003\')) OR ((p.prename like \'7%\' or p.prename like \'8%\' or p.prename like \'9%\') and p.prename <>\'863\'))\r\ngroup by hospcode,pid\r\n\r\n);', 'SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode ,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,\r\nround((IFNULL(st.y_cases,0) /nd.pid)*100,2) as percent\r\nFROM\r\n(SELECT hospcode,count(pid) as pid from tmp_person_falsesex_t \r\nGROUP BY HOSPCODE) AS nd\r\nLEFT JOIN\r\n(select hospcode,count(pid) as y_cases from person_falsesex_t\r\ngroup by hospcode)as st\r\non nd.hospcode=st.hospcode\r\nLEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode\r\nORDER BY st.y_cases DESC', 'SELECT s.distcode,ca.ampurname,\r\nSUM(s.total_pid) AS total_pid,\r\nIFNULL(SUM(s.y_cases),0) AS y_cases,\r\nround((IFNULL(SUM(s.y_cases),0) /SUM(s.total_pid))*100,2) AS percent\r\nFROM person_falsesex_s s\r\nLEFT JOIN hdc.campur ca ON ca.ampurcodefull = s.distcode AND ca.changwatcode=@province\r\nGROUP BY s.distcode\r\nORDER BY y_cases DESC', '1', null, null, '', 'person_falsesex', 'person', '25', '', '', ''), ('10069', 'ตรวจสอบ ผู้ป่วยHT/DM/CKD มี ค่า LDL นอกพิสัยที่ควรเป็นไปได้ (10 -400)', 'labfu_ldl_not_standard_a', 'labfu_ldl_not_standard_s', 'labfu_ldl_not_standard_t', 'SET @province:=(SELECT province_config FROM sys_config LIMIT 1);\r\nSET @b_year:= YEAR(CURRENT_TIMESTAMP);\r\nSET @start_d:=concat(@b_year-1,\'1001\');\r\nSET @end_d:=concat(@b_year,\'0930\');\r\n\r\nselect t.HOSPCODE,t.hosname,t.PID,t.fullname,t.LABTEST,t.DATE_SERV,t.LABRESULT,group_concat(distinct t.CHRONIC) as CHRONIC from\r\n(SELECT l.HOSPCODE, ch.hosname,l.PID,concat(p.`NAME`,\' \',p.LNAME)as fullname,if(l.LABTEST=\'09\',lt.LABTEST,ltn.TH) AS LABTEST,l.DATE_SERV,l.LABRESULT,c.CHRONIC \r\nFROM hdc.labfu l \r\nINNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic \r\nWHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\' or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE \r\nLEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST\r\nLEFT JOIN hdc.clabtest_new ltn ON ltn.`code` = l.LABTEST  \r\nleft join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid \r\nLEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE \r\nWHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'09\',\' 0541402\') AND l.labresult NOT BETWEEN \'10\' AND \'400\' \r\nORDER BY l.HOSPCODE) t\r\ngroup by t.HOSPCODE,t.PID\r\norder by t.CHRONIC\r\n', 'SET @province:=(SELECT province_config FROM sys_config LIMIT 1);\r\nSET @b_year:= YEAR(CURRENT_TIMESTAMP);\r\nSET @start_d:=concat(@b_year-1,\'1001\');\r\nSET @end_d:=concat(@b_year,\'0930\');\r\n\r\nSELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode ,nd.pid,\r\nIFNULL(st.y_cases,0) as y_cases,round((IFNULL(st.y_cases,0)/pid)*100,2) as percent \r\nFROM (\r\nSELECT l.HOSPCODE, ch.hosname,ch.distcode,COUNT(l.pid) as pid\r\nFROM hdc.labfu l \r\nINNER JOIN (SELECT HOSPCODE  ,PID,CHRONIC FROM hdc.chronic \r\nWHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\' or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE \r\nLEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE \r\nWHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'09\',\' 0541402\') \r\nGROUP BY l.HOSPCODE\r\nORDER BY ch.distcode,l.HOSPCODE) nd\r\nLEFT JOIN (\r\nselect t.HOSPCODE,t.hosname,COUNT(t.pid) as y_cases  from\r\n(SELECT l.HOSPCODE, ch.hosname,l.PID\r\nFROM hdc.labfu l \r\nINNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic \r\nWHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\' or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE \r\nLEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE \r\nWHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'09\',\' 0541402\') AND l.labresult NOT BETWEEN \'10\' AND \'400\' \r\nGROUP BY l.HOSPCODE,l.PID) t\r\ngroup by t.HOSPCODE\r\n)as st on nd.hospcode=st.hospcode \r\nORDER BY st.hospcode\r\n', 'SET @province:=(SELECT province_config FROM sys_config LIMIT 1);\r\nSET @b_year:= YEAR(CURRENT_TIMESTAMP);\r\nSET @start_d:=concat(@b_year-1,\'1001\');\r\nSET @end_d:=concat(@b_year,\'0930\');\r\n\r\nSELECT concat(@province,nd.distcode) as distcode,nd.ampurname as ampurname ,nd.pid AS total_pid,\r\nIFNULL(st.y_cases,0) as y_cases,round((IFNULL(st.y_cases,0)/pid)*100,2) as percent \r\nFROM (\r\nSELECT ch.distcode, ca.ampurname,COUNT(l.pid) as pid\r\nFROM hdc.labfu l \r\nINNER JOIN (SELECT HOSPCODE  ,PID,CHRONIC FROM hdc.chronic \r\nWHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\' or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE \r\nLEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE\r\nJOIN hdc.campur ca on ca.ampurcode = ch.distcode and ca.changwatcode=@province  \r\nWHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'09\',\' 0541402\') \r\nGROUP BY ch.distcode\r\nORDER BY ch.distcode) nd\r\nLEFT JOIN (\r\nselect t.distcode, COUNT(t.pid) as y_cases  from\r\n(SELECT l.HOSPCODE, ch.distcode,l.PID\r\nFROM hdc.labfu l \r\nINNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic \r\nWHERE CHRONIC BETWEEN \'E10\' AND \'E149\' OR CHRONIC BETWEEN \'I10\' AND \'I159\' or CHRONIC BETWEEN \'N18\' AND \'N189\' and TYPEDISCH <>\'02\')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE \r\nLEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE \r\nWHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in (\'09\',\' 0541402\') AND l.labresult NOT BETWEEN \'10\' AND \'400\' \r\nGROUP BY l.HOSPCODE,l.PID) t\r\ngroup by t.distcode\r\n)as st on nd.distcode=st.distcode \r\norder by st.y_cases desc\r\n', '1', null, null, '', 'labfu_ldl_not_standard', 'chronicfu', '25', 'เอ๊ะ!! ผู้ป่วยที่ขึ้นทะเบียนโรคเรื้อรัง DM/HT/CKD  มีการตรวจ LDL ในแฟ้ม Labfu และผลLABที่บันทึก เป็นค่านอกพิสัยที่ควรเป็นไปได้ (10 - 400)', '', '');
COMMIT;

-- ----------------------------
-- Procedure structure for `admission_datetime_disch`
-- ----------------------------
DROP PROCEDURE IF EXISTS `admission_datetime_disch`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admission_datetime_disch`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS admission_datetime_disch_t;
CREATE TABLE admission_datetime_disch_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
an varchar(15) NOT NULL DEFAULT '' COMMENT 'AN',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
DATETIME_ADMIT datetime NOT NULL COMMENT 'วันที่และเวลารับผู้ป่วย',
datetime_disch datetime NOT NULL  COMMENT 'วันที่และเวลาจำหน่ายผู้ป่วย',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE admission_datetime_disch_t;

INSERT INTO admission_datetime_disch_t
(
hospcode,hosname,an,pid,fullname,datetime_admit,datetime_disch
)

( 
select s.hospcode, h.hosname,s.an, s.pid, concat(p.`NAME`,' ',p.LNAME)as fullname,s.datetime_admit, s.datetime_disch
from hdc.admission s
join hdc.chospital h on h.hoscode=s.hospcode
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where s.datetime_admit > s.datetime_disch
AND s.datetime_disch BETWEEN @start_d AND @end_d
order by h.hoscode, p.pid, s.datetime_disch
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS admission_datetime_disch_s;
CREATE TABLE admission_datetime_disch_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE admission_datetime_disch_s;

INSERT INTO admission_datetime_disch_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.admission 
where datetime_disch BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.admission s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where s.datetime_admit > s.datetime_disch
AND s.datetime_disch BETWEEN @start_d AND @end_d 
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS admission_datetime_disch_a;
CREATE TABLE admission_datetime_disch_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE admission_datetime_disch_a;

INSERT INTO admission_datetime_disch_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(a.pid) as pid FROM hdc.admission a
join hdc.chospital c on c.hoscode=a.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where a.datetime_disch BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(a.pid) as y_cases
from hdc.admission a
join hdc.chospital c on c.hoscode=a.HOSPCODE
where a.datetime_admit > a.datetime_disch
AND a.datetime_disch BETWEEN @start_d AND @end_d 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);




 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `admission_refer`
-- ----------------------------
DROP PROCEDURE IF EXISTS `admission_refer`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admission_refer`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS admission_refer_t;
CREATE TABLE admission_refer_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
an VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'AN',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
datetime_admit datetime COMMENT 'วันที่และเวลารับผู้ป่วย',
datetime_disch datetime COMMENT 'วันที่และเวลาจำหน่ายผู้ป่วย',
referouthosp VARCHAR(5) COMMENT 'สถานบริการที่ส่งผู้ป่วยไป',
causeout varchar(2) COMMENT 'สาเหตุการส่งต่อผู้ป่วย',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE admission_refer_t;
INSERT INTO admission_refer_t
(
hospcode,hosname,an,pid,fullname,datetime_admit,datetime_disch,referouthosp,causeout
)
( 
SELECT a.hospcode,c.hosname,a.an,a.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,a.datetime_admit, a.datetime_disch,a.referouthosp,a.causeout
FROM hdc.admission a
LEFT JOIN hdc.chospital c ON c.hoscode = a.hospcode
left join hdc.person p on p.hospcode=a.hospcode and p.pid=a.pid
WHERE DATE_FORMAT(a.datetime_disch,'%Y-%m-%d') BETWEEN @start_d AND @end_d 
AND a.dischtype = 4
AND (ISNULL(a.referouthosp) OR ISNULL(a.causeout))
ORDER BY a.hospcode
);
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS admission_refer_s;
CREATE TABLE admission_refer_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases varchar(2) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(6) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE admission_refer_s;
INSERT INTO admission_refer_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)
( 
SELECT a.hospcode,ch.hosname,CONCAT(@province,ch.distcode) AS distcode,
a.t AS total_pid,
IFNULL(b.t,0) AS y_cases ,
ROUND((IFNULL(b.t,0) /a.t)*100,2) AS percent 
FROM (SELECT a.hospcode,COUNT(a.pid) AS t 
	FROM hdc.admission a
	WHERE DATE_FORMAT(a.datetime_disch,'%Y-%m-%d') BETWEEN @start_d AND @end_d 
	AND a.dischtype = 4 
	GROUP BY a.hospcode) a
LEFT JOIN (SELECT a.hospcode,count(a.pid) AS t 
		FROM hdc.admission a
		WHERE DATE_FORMAT(a.datetime_disch,'%Y-%m-%d') BETWEEN @start_d AND @end_d 
		AND a.dischtype = 4 AND (ISNULL(a.referouthosp) OR ISNULL(a.causeout))
	GROUP BY a.hospcode)  b 
ON a.HOSPCODE = b.HOSPCODE
LEFT JOIN hdc.chospital ch ON ch.hoscode = a.hospcode
ORDER BY a.hospcode
);
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS admission_refer_a;
CREATE TABLE admission_refer_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(6) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE admission_refer_a;
INSERT INTO admission_refer_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT CONCAT(@province,a.distcode) AS distcode,a.ampurname,
a.t AS total_pid,
IFNULL(b.t,0) AS y_cases ,
ROUND((IFNULL(b.t,0) /a.t)*100,2) AS percent 
FROM (SELECT ch.distcode,ca.ampurname,COUNT(a.pid) AS t 
	FROM hdc.admission a
	LEFT JOIN hdc.chospital ch ON ch.hoscode = a.hospcode
	LEFT JOIN hdc.campur ca ON ca.ampurcode = ch.distcode AND ca.changwatcode=@province
	WHERE DATE_FORMAT(a.datetime_disch,'%Y-%m-%d') BETWEEN @start_d AND @end_d 
	AND a.dischtype = 4 
	GROUP BY ch.distcode) a
LEFT JOIN (SELECT ch.distcode,COUNT(a.pid) AS t 
		FROM hdc.admission a
		LEFT JOIN hdc.chospital ch ON ch.hoscode = a.hospcode
		LEFT JOIN hdc.campur ca ON ca.ampurcode = ch.distcode AND ca.changwatcode=@province
		WHERE DATE_FORMAT(a.datetime_disch,'%Y-%m-%d') BETWEEN @start_d AND @end_d 
		AND a.dischtype = 4 AND (ISNULL(a.referouthosp) OR ISNULL(a.causeout))
	GROUP BY ch.distcode)  b 
ON a.distcode = b.distcode
ORDER BY a.distcode
);
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `admission_sell`
-- ----------------------------
DROP PROCEDURE IF EXISTS `admission_sell`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admission_sell`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS admission_sell_t;
CREATE TABLE admission_sell_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
an varchar(15) NOT NULL DEFAULT '' COMMENT 'AN',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
datetime_admit datetime COMMENT 'วันที่และเวลารับผู้ป่วย',
datetime_disch datetime COMMENT 'วันที่และเวลาจำหน่ายผู้ป่วย',
cost varchar(15)  COMMENT 'ราคาทุน',
price varchar(15)  COMMENT 'ราคาขาย',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE admission_sell_t;

INSERT INTO admission_sell_t
(
hospcode,hosname,an,pid,fullname,datetime_admit,datetime_disch,cost,price
)

( 
select s.hospcode, h.hosname, s.an,s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname, s.datetime_admit, s.datetime_disch, s.cost, s.price
from hdc.admission s
join hdc.chospital h on h.hoscode=s.hospcode
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where (s.price = 0 or s.price < s.cost)
AND s.datetime_disch BETWEEN @start_d AND @end_d
order by h.hoscode, p.pid, s.datetime_disch
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS admission_sell_s;
CREATE TABLE admission_sell_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE admission_sell_s;

INSERT INTO admission_sell_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.admission 
where datetime_disch BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.admission s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where (s.price = 0 or s.price < s.cost)
AND s.datetime_disch BETWEEN @start_d AND @end_d 
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC 

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS admission_sell_a;
CREATE TABLE admission_sell_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE admission_sell_a;

INSERT INTO admission_sell_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(a.pid) as pid FROM hdc.admission a
join hdc.chospital c on c.hoscode=a.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where a.datetime_disch BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(a.pid) as y_cases
from hdc.admission a
join hdc.chospital c on c.hoscode=a.HOSPCODE
where (a.price = 0 or a.price < a.cost)
AND a.datetime_disch BETWEEN @start_d AND @end_d   
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `anc_falseresult`
-- ----------------------------
DROP PROCEDURE IF EXISTS `anc_falseresult`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `anc_falseresult`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS anc_falseresult_t;
CREATE TABLE anc_falseresult_t (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
abnormal varchar(15)  COMMENT 'ผิดปกติ',
unknown varchar(15)  COMMENT 'ไม่ทราบ',
error varchar(15)  COMMENT 'Error',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_falseresult_t;

INSERT INTO anc_falseresult_t
(
hospcode,hosname,pid,fullname,date_serv,abnormal,unknown,error
)

( 
select a.hospcode, c.hosname,a.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,DATE_SERV,
(if(ancresult=2,ancresult,NULL)) as abnormal, 
(if(ancresult=9,ancresult,NULL)) as unknown, 
(if(ancresult not in (1,2,9),ancresult,NULL)) as error 
from hdc.anc a
left join hdc.person p on p.hospcode=a.hospcode and p.pid=a.pid
LEFT JOIN hdc.chospital c on c.hoscode=a.HOSPCODE
where 
a.ancresult not in ('1') and
a.date_serv BETWEEN @start_d AND @end_d 
order by HOSPCODE 



);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS anc_falseresult_s;
CREATE TABLE anc_falseresult_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'จำนวนทั้งหมด',
normal VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ปกติ(1)',
abnormal VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ผิดปกติ(2)',
unknown VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ไม่ทราบ(3)',
error VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'error(4)',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ(2+3+4)',
percent VARCHAR(6) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_falseresult_s;

INSERT INTO anc_falseresult_s
(
hospcode,hosname,distcode,total,normal,abnormal,unknown,error,y_cases,percent
)

( 
select hospcode,c.hosname,concat(@province,c.distcode) as distcode, 
count(a.pid) as total,
sum(if(ancresult=1,1,0)) as normal, 
sum(if(ancresult=2,1,0)) as abnormal, 
sum(if(ancresult=9,1,0)) as unknown, 
sum(if(ancresult not in (1,2,9),1,0)) as error, 
sum(if(ancresult=2,1,0))+sum(if(ancresult=9,1,0))+sum(if(ancresult not in (1,2,9),1,0)) as y_cases,
round(((sum(if(ancresult=2,1,0))+sum(if(ancresult=9,1,0))+sum(if(ancresult not in (1,2,9),1,0)))/count(pid))*100,2) as percent
from hdc.anc a
LEFT JOIN hdc.chospital c on c.hoscode=a.HOSPCODE
WHERE 
a.date_serv BETWEEN @start_d AND @end_d 
group by hospcode
order by percent desc, error desc, hospcode

);




#################################   

 #Routine body goes here...
DROP TABLE IF EXISTS anc_falseresult_a;
CREATE TABLE anc_falseresult_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_falseresult_a;

INSERT INTO anc_falseresult_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

select concat(@province,c.distcode) as distcode,ca.ampurname, 
count(pid) as total_pid,
sum(if(ancresult=2,1,0))+sum(if(ancresult=9,1,0))+sum(if(ancresult not in (1,2,9),1,0)) as y_cases,
round(((sum(if(ancresult=2,1,0))+sum(if(ancresult=9,1,0))+sum(if(ancresult not in (1,2,9),1,0)))/count(pid))*100,2) as percent
from hdc.anc a
JOIN hdc.chospital c on c.hoscode=a.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province 
WHERE a.date_serv BETWEEN @start_d AND @end_d
group by c.distcode
order by y_cases desc 

);



 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `anc_ga1_46`
-- ----------------------------
DROP PROCEDURE IF EXISTS `anc_ga1_46`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `anc_ga1_46`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS anc_ga1_46_t;
CREATE TABLE anc_ga1_46_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
gravida varchar(5) COMMENT 'ครรภ์ที่',
ga varchar(5) COMMENT 'อายุครรภ์',
typearea varchar(5) NOT NULL DEFAULT '' COMMENT 'สถานะบุคคล',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_ga1_46_t;

INSERT INTO anc_ga1_46_t
(
hospcode,hosname,pid,fullname,date_serv,gravida,ga,typearea
)

( 
select a.hospcode,c.hosname,a.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,a.date_serv,a.gravida,a.ga,p.typearea 
from hdc.anc a
left outer join hdc.person p on p.pid=a.pid and a.hospcode=p.hospcode
left outer join hdc.chospital c on c.hoscode=a.HOSPCODE  
where (a.ga*1) not between '1' and '45'
AND a.date_serv BETWEEN @start_d AND @end_d
order by a.hospcode,a.pid,a.date_serv


);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS anc_ga1_46_s;
CREATE TABLE anc_ga1_46_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_ga1_46_s;

INSERT INTO anc_ga1_46_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode ,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.anc 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select a.hospcode,count(a.pid) as y_cases
from hdc.anc a
left outer join hdc.person p on p.pid=a.pid and p.hospcode=a.hospcode  
where (a.ga*1) not between '1' and '45'
AND a.date_serv BETWEEN @start_d AND @end_d 
group by a.hospcode)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
ORDER BY st.y_cases DESC


);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS anc_ga1_46_a;
CREATE TABLE anc_ga1_46_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_ga1_46_a;

INSERT INTO anc_ga1_46_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(a.pid) as pid FROM hdc.anc a
join hdc.chospital c on c.hoscode=a.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where a.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(a.pid) as y_cases
from hdc.anc a
join hdc.chospital c on c.hoscode=a.HOSPCODE
where (a.ga*1) not between '1' and '45'
AND a.date_serv BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `anc_gravida_not_as_labor`
-- ----------------------------
DROP PROCEDURE IF EXISTS `anc_gravida_not_as_labor`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `anc_gravida_not_as_labor`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS anc_gravida_not_as_labor_t;
CREATE TABLE anc_gravida_not_as_labor_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ Labor',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
labor_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล Labor',
prenatal_hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ Prenatal',
prenatal_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล Prenatal',
bhosp VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'สถานที่คลอด',
labor_gravida VARCHAR(3) NOT NULL DEFAULT '' COMMENT  'ครรภ์ที่ แฟ้ม labor',
prenatal_gravida VARCHAR(3) NOT NULL DEFAULT '' COMMENT  'ครรภ์ที่ แฟ้ม prenatal',
bdate date COMMENT 'วันที่คลอด Labor',
edc  date COMMENT 'วันคะเนคลอด (EDC) prenatal',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_gravida_not_as_labor_t;

INSERT INTO anc_gravida_not_as_labor_t
(
hospcode,fullname,labor_pid,prenatal_hospcode,prenatal_pid,bhosp,labor_gravida,prenatal_gravida,bdate,edc
)

( 
select l.hospcode,concat(p1.`NAME`,'',p1.LNAME)as fullname,l.pid as labor_pid,a.hospcode as prenatal_hospcode,a.pid as prenatal_pid,l.bhosp,l.gravida as labor_gravida,a.gravida as prenatal_gravida,l.bdate,a.edc 
from hdc.labor l 
left outer join hdc.person p1 on p1.hospcode=l.hospcode and p1.pid=l.PID 
left outer join (select p2.cid,a.* from hdc.prenatal a 
  left outer join hdc.person p2 on p2.hospcode=a.hospcode and p2.pid=a.PID  ) a on a.cid=p1.cid
left outer join hdc.chospital c on c.hoscode=l.hospcode
where  l.bdate between @start_d AND @end_d and l.gravida<> a.gravida 
and (timestampdiff(month,a.edc,l.bdate )<='3' ) 
group by l.hospcode,p1.cid 
order by l.hospcode 


);

#################################

 #Routine body goes here...
DROP TABLE IF EXISTS anc_gravida_not_as_labor_s;
CREATE TABLE anc_gravida_not_as_labor_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_gravida_not_as_labor_s;

INSERT INTO anc_gravida_not_as_labor_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT a.hospcode,c.hosname,concat(@province,c.distcode) as distcode,a.ta as total_pid,IFNULL(count(b.labor_pid),0) as y_cases 
,round((IFNULL(count(b.labor_pid),0) /a.ta)*100,2) as percent from 
(SELECT hospcode,count(pid) as  ta from hdc.labor  where bdate between @start_d AND @end_d  GROUP BY hospcode) a
LEFT JOIN (select l.hospcode as labor_hospcode,l.pid as labor_pid,c.hosname,a.hospcode as prenatal_hospcode,a.pid as prenatal_pid,l.bhosp,l.gravida as labor_gravida,a.gravida as prenatal_gravida,l.bdate,a.edc 
from hdc.labor l 
left outer join hdc.person p1 on p1.hospcode=l.hospcode and p1.pid=l.PID 
left outer join (select p2.cid,a.* from hdc.prenatal a 
  left outer join hdc.person p2 on p2.hospcode=a.hospcode and p2.pid=a.PID  ) a on a.cid=p1.cid
left outer join hdc.chospital c on c.hoscode=l.hospcode
where  l.bdate between @start_d AND @end_d and l.gravida<> a.gravida 
and (timestampdiff(month,a.edc,l.bdate )<='3' ) 
group by l.hospcode,p1.cid 
order by l.hospcode ) b on a.hospcode=b.labor_hospcode
LEFT JOIN hdc.chospital c on c.hoscode=a.hospcode
group by a.hospcode

);




#################################

################################

 #Routine body goes here...
DROP TABLE IF EXISTS anc_gravida_not_as_labor_a;
CREATE TABLE anc_gravida_not_as_labor_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_gravida_not_as_labor_a;

INSERT INTO anc_gravida_not_as_labor_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l
join hdc.chospital c on c.hoscode=l.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where bdate between @start_d AND @end_d 
GROUP BY c.distcode) nd
left JOIN 
(SELECT c.distcode,count(a.labor_pid) as y_cases from
(select l.hospcode as labor_hospcode,l.pid as labor_pid,c.hosname,a.hospcode as prenatal_hospcode,a.pid as prenatal_pid,l.bhosp,l.gravida as labor_gravida,a.gravida as prenatal_gravida,l.bdate,a.edc 
from hdc.labor l 
left outer join hdc.person p1 on p1.hospcode=l.hospcode and p1.pid=l.PID 
left outer join (select p2.cid,a.* from hdc.prenatal a 
  left outer join hdc.person p2 on p2.hospcode=a.hospcode and p2.pid=a.PID  ) a on a.cid=p1.cid
left outer join hdc.chospital c on c.hoscode=l.hospcode
where  l.bdate between @start_d AND @end_d and l.gravida<> a.gravida 
and (timestampdiff(month,a.edc,l.bdate )<='3' ) 
group by l.hospcode,p1.cid 
order by l.hospcode) a
LEFT JOIN hdc.chospital c on c.hoscode=a.labor_hospcode
GROUP BY c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc
);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `anc_iodine`
-- ----------------------------
DROP PROCEDURE IF EXISTS `anc_iodine`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `anc_iodine`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################

DROP TABLE if  EXISTS tmp_drug_anc;
CREATE TABLE if not EXISTS tmp_drug_anc
REPLACE SELECT * from hdc.drug_opd d
where d.DATE_SERV BETWEEN @start_d AND @end_d and ((d.dname like '%trifer%' or d.dname like '%obimin%' or d.dname like '%iodine%' or d.dname like '%nataral%') 
and (d.dname not like '%obiminaf%' and d.dname not like '%obimin-af%' and d.dname not like '%obimin af%') and (d.dname not like '%povid%')) ;




DROP TABLE IF EXISTS anc_iodine_t;
CREATE TABLE anc_iodine_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
dname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อยา',
didstd varchar(30) NOT NULL DEFAULT '' COMMENT 'รหัสยา',
date_serv date COMMENT 'วันที่รับบริการ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_iodine_t;

INSERT INTO anc_iodine_t
(
hospcode,hosname,pid,fullname,dname,didstd,date_serv
)

( 
select d.hospcode,c.hosname,d.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,d.DNAME, d.didstd ,d.DATE_SERV
from tmp_drug_anc d
left join hdc.person p on p.hospcode=d.hospcode and p.pid=d.pid
LEFT JOIN hdc.chospital c on c.hoscode=d.HOSPCODE
where d.didstd not in ('201120320037726221781506','201110100019999920381199','101110000003082121781506','201110100019999920381341','201110100019999921881341')


);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS anc_iodine_s;
CREATE TABLE anc_iodine_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_iodine_s;

INSERT INTO anc_iodine_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent
FROM
(SELECT d.hospcode,count(d.pid) as pid from tmp_drug_anc d GROUP BY HOSPCODE) nd
LEFT JOIN
(select hospcode,count(pid) as y_cases 
from anc_iodine_t d
group by hospcode
)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital c on c.hoscode=nd.HOSPCODE
order by st.y_cases DESC

);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS anc_iodine_a;
CREATE TABLE anc_iodine_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_iodine_a;

INSERT INTO anc_iodine_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 
SELECT concat(@province,ca.ampurcode) as distcode,ca.ampurname,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent
FROM
(SELECT c.distcode,count(d.pid) as pid from tmp_drug_anc d 
JOIN hdc.chospital c on c.hoscode=d.HOSPCODE
GROUP BY distcode) nd
LEFT JOIN
(select distcode,count(pid) as y_cases from anc_iodine_t d
JOIN hdc.chospital c on c.hoscode=d.HOSPCODE
group by distcode
)as st
on nd.distcode=st.distcode
JOIN hdc.campur ca on ca.ampurcode = nd.distcode and ca.changwatcode=@province
order by distcode
);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `anc_noperson`
-- ----------------------------
DROP PROCEDURE IF EXISTS `anc_noperson`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `anc_noperson`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################

 #Routine body goes here...
DROP TABLE IF EXISTS anc_noperson_t;
CREATE TABLE anc_noperson_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
a_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล(anc)',
p_pid varchar(15) COMMENT 'ทะเบียนบุคคล(person)',
date_serv date COMMENT 'วันที่รับบริการ',
ga varchar(15) NOT NULL DEFAULT '' COMMENT 'อายุครรภ์',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_noperson_t;

INSERT INTO anc_noperson_t
(
hospcode,hosname,a_pid,p_pid,date_serv,ga
)

( 
select a.hospcode,c.hosname,a.PID,p.pid,a.DATE_SERV,cast(a.ga as signed) as ga
from hdc.anc a
left join hdc.person p on p.hospcode=a.hospcode and p.pid=a.pid
LEFT JOIN hdc.chospital c on c.hoscode=a.HOSPCODE
where p.pid is null
AND a.date_serv BETWEEN @start_d AND @end_d  
order by a.hospcode
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS anc_noperson_s;
CREATE TABLE anc_noperson_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_noperson_s;

INSERT INTO anc_noperson_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.anc 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN 
(select a.hospcode,count(a.pid) as y_cases
from hdc.anc a
left join hdc.person p on p.hospcode=a.hospcode and p.pid=a.pid 
where p.pid is null 
AND a.date_serv BETWEEN @start_d AND @end_d  
group by a.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.HOSPCODE
order by st.y_cases DESC

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS anc_noperson_a;
CREATE TABLE anc_noperson_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_noperson_a;

INSERT INTO anc_noperson_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(a.pid) as pid FROM hdc.anc a
join hdc.chospital c on c.hoscode=a.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where a.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(a.pid) as y_cases
from hdc.anc a
left join hdc.person p on p.hospcode=a.hospcode and p.pid=a.pid
join hdc.chospital c on c.hoscode=a.HOSPCODE
where p.pid is null 
AND a.date_serv BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);






################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `anc_ppcare`
-- ----------------------------
DROP PROCEDURE IF EXISTS `anc_ppcare`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `anc_ppcare`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS anc_ppcare_t;
CREATE TABLE anc_ppcare_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
nation varchar(5) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
GRAVIDA varchar(5) NOT NULL DEFAULT '' COMMENT 'ครรภ์ที่',
ppcare date COMMENT 'วันที่ดูแลแม่',
bdate date COMMENT 'วันที่คลอด',
ppplace varchar(5) NOT NULL DEFAULT '' COMMENT 'สถานบริการดูแลแม่',
typearea VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'สถานะบุคคล',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_ppcare_t;

INSERT INTO anc_ppcare_t
(
hospcode,hosname,pid,fullname,nation,GRAVIDA,ppcare,bdate,ppplace,typearea
)

( 
select c.hoscode,c.hosname,p.pid,concat(pe.`NAME`,'',pe.LNAME)as fullname,
pe.nation,p.GRAVIDA,p.ppcare,p.bdate,p.ppplace,pe.typearea 
from hdc.postnatal p
left outer join hdc.person pe on pe.pid=p.pid and pe.hospcode=p.hospcode
left outer join hdc.chospital c on c.hoscode=p.HOSPCODE
where p.ppcare <=p.BDATE
AND p.bdate BETWEEN @start_d AND @end_d
order by c.hoscode
);





#################################


 #Routine body goes here...
DROP TABLE IF EXISTS anc_ppcare_s;
CREATE TABLE anc_ppcare_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_ppcare_s;

INSERT INTO anc_ppcare_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.postnatal 
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select p.hospcode,count(p.pid) as y_cases
from hdc.postnatal p
left outer join hdc.person pe on pe.pid=p.pid and pe.hospcode=p.hospcode
where p.ppcare <=p.BDATE
AND p.bdate BETWEEN @start_d AND @end_d   
group by p.hospcode)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.HOSPCODE
ORDER BY y_cases desc


);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS anc_ppcare_a;
CREATE TABLE anc_ppcare_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_ppcare_a;

INSERT INTO anc_ppcare_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.postnatal p
join hdc.chospital c on c.hoscode=p.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where p.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(p.pid) as y_cases
from hdc.postnatal p
left outer join hdc.person pe on pe.pid=p.pid and pe.hospcode=p.hospcode
join hdc.chospital c on c.hoscode=p.HOSPCODE
where p.ppcare <=p.BDATE
AND p.bdate BETWEEN @start_d AND @end_d
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `charge_opd_chargeitem`
-- ----------------------------
DROP PROCEDURE IF EXISTS `charge_opd_chargeitem`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `charge_opd_chargeitem`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS charge_opd_chargeitem_t;
CREATE TABLE charge_opd_chargeitem_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
chargeitem varchar(15) NOT NULL DEFAULT '' COMMENT 'หมวดของค่าบริการ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_chargeitem_t;

INSERT INTO charge_opd_chargeitem_t
(
hospcode,hosname,pid,fullname,date_serv,chargeitem
)

( 
select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname, s.date_serv, s.chargeitem
from hdc.charge_opd s
join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where s.chargeitem not in ('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18')
and s.date_serv BETWEEN @start_d AND @end_d
order by h.hoscode, p.pid, s.date_serv
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS charge_opd_chargeitem_s;
CREATE TABLE charge_opd_chargeitem_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_chargeitem_s;

INSERT INTO charge_opd_chargeitem_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.charge_opd 
where date_serv BETWEEN @start_d AND @end_d  GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.charge_opd s
join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where s.chargeitem not in ('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18')
AND s.date_serv BETWEEN @start_d AND @end_d
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC  

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS charge_opd_chargeitem_a;
CREATE TABLE charge_opd_chargeitem_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_chargeitem_a;

INSERT INTO charge_opd_chargeitem_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.charge_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.DATE_SERV BETWEEN @start_d AND @end_d 
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.charge_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
where s.chargeitem not in ('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18')
AND s.date_serv BETWEEN @start_d AND @end_d 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `charge_opd_nochargeitem`
-- ----------------------------
DROP PROCEDURE IF EXISTS `charge_opd_nochargeitem`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `charge_opd_nochargeitem`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS charge_opd_nochargeitem_t;
CREATE TABLE charge_opd_nochargeitem_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
chargeitem varchar(15) NOT NULL DEFAULT '' COMMENT 'หมวดของค่าบริการ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_nochargeitem_t;

INSERT INTO charge_opd_nochargeitem_t
(
hospcode,hosname,pid,fullname,date_serv,chargeitem
)

( 
select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname, s.date_serv, s.chargeitem
from hdc.charge_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where h.hostype in ('03','18')
and s.chargeitem in ('01','06','08','09')
and s.date_serv BETWEEN @start_d AND @end_d
order by h.hoscode, p.pid, s.date_serv
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS charge_opd_nochargeitem_s;
CREATE TABLE charge_opd_nochargeitem_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_nochargeitem_s;

INSERT INTO charge_opd_nochargeitem_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.charge_opd 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.charge_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where h.hostype in ('03','18')
and s.chargeitem in ('01','06','08','09')
AND s.date_serv BETWEEN @start_d AND @end_d 
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC   

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS charge_opd_nochargeitem_a;
CREATE TABLE charge_opd_nochargeitem_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_nochargeitem_a;

INSERT INTO charge_opd_nochargeitem_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.charge_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.DATE_SERV BETWEEN @start_d AND @end_d 
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.charge_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
where c.hostype in ('03','18')
and s.chargeitem in ('01','06','08','09')
AND s.date_serv BETWEEN @start_d AND @end_d 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `charge_opd_nochargeitem_food`
-- ----------------------------
DROP PROCEDURE IF EXISTS `charge_opd_nochargeitem_food`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `charge_opd_nochargeitem_food`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS charge_opd_nochargeitem_food_t;
CREATE TABLE charge_opd_nochargeitem_food_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
chargeitem varchar(15) NOT NULL DEFAULT '' COMMENT 'หมวดของค่าบริการ',
price varchar(15)  COMMENT 'ค่าบริการ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_nochargeitem_food_t;

INSERT INTO charge_opd_nochargeitem_food_t
(
hospcode,hosname,pid,fullname,date_serv,chargeitem,price
)

( 
select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname, s.date_serv, s.chargeitem,s.price
from hdc.charge_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where  h.hostype not in ('03','18')
and s.chargeitem = '01' and s.price >'100'
and s.date_serv BETWEEN @start_d AND @end_d 
order by h.hoscode,p.pid,s.date_serv
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS charge_opd_nochargeitem_food_s;
CREATE TABLE charge_opd_nochargeitem_food_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_nochargeitem_food_s;

INSERT INTO charge_opd_nochargeitem_food_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.charge_opd 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.charge_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where h.hostype not in ('03','18')
and s.chargeitem = '01' and s.price >'100'
AND s.date_serv BETWEEN @start_d AND @end_d 
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC   

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS charge_opd_nochargeitem_food_a;
CREATE TABLE charge_opd_nochargeitem_food_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_nochargeitem_food_a;

INSERT INTO charge_opd_nochargeitem_food_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.charge_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.DATE_SERV BETWEEN @start_d AND @end_d 
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.charge_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
where c.hostype not in ('03','18')
and s.chargeitem = '01' and s.price >'100'
AND s.date_serv BETWEEN @start_d AND @end_d 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `charge_opd_sell`
-- ----------------------------
DROP PROCEDURE IF EXISTS `charge_opd_sell`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `charge_opd_sell`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS charge_opd_sell_t;
CREATE TABLE charge_opd_sell_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
chargeitem varchar(50) NOT NULL DEFAULT '' COMMENT 'หมวดค่าบริการ',
date_serv date COMMENT 'วันที่รับบริการ',
cost varchar(15) COMMENT 'ราคาทุน',
price varchar(15) COMMENT 'ราคาขาย',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_sell_t;

INSERT INTO charge_opd_sell_t
(
hospcode,hosname,pid,fullname,chargeitem,date_serv,cost,price
)

( 
select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,i.chargeitem, s.date_serv, s.cost, s.price
from hdc.charge_opd s
LEFT JOIN hdc.cchargeitem i on i.id_chargeitem=s.CHARGEITEM
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where (s.price = 0 or s.price < s.cost)
and s.date_serv BETWEEN @start_d AND @end_d
order by h.hoscode, p.pid, s.date_serv
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS charge_opd_sell_s;
CREATE TABLE charge_opd_sell_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_sell_s;

INSERT INTO charge_opd_sell_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.charge_opd 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.charge_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where (s.price = 0 or s.price < s.cost)
AND s.date_serv BETWEEN @start_d AND @end_d 
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC  

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS charge_opd_sell_a;
CREATE TABLE charge_opd_sell_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_sell_a;

INSERT INTO charge_opd_sell_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.charge_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.DATE_SERV BETWEEN @start_d AND @end_d 
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.charge_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
where (s.price = 0 or s.price < s.cost)
AND s.date_serv BETWEEN @start_d AND @end_d 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `chronicfu_amd`
-- ----------------------------
DROP PROCEDURE IF EXISTS `chronicfu_amd`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `chronicfu_amd`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################

DROP TABLE if  EXISTS tmp_chronicfu_amd;
CREATE TABLE if not EXISTS tmp_chronicfu_amd
REPLACE SELECT * from hdc.procedure_opd d
where procedcode in ('9511','9390141','1621','9390140') and date_serv BETWEEN @start_d AND @end_d ;



DROP TABLE IF EXISTS chronicfu_amd_t;
CREATE TABLE chronicfu_amd_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
TYPEAREA VARCHAR(1) NOT NULL DEFAULT '' COMMENT 'สถานะบุคคล',
date_serv date COMMENT 'วันที่รับบริการ',
procedcode varchar(7) NOT NULL DEFAULT '' COMMENT 'หัตถการ',
chronic_pid varchar(10) COMMENT 'ทะเบียนบุคคล Chronic',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_amd_t;

INSERT INTO chronicfu_amd_t
(
hospcode,hosname,pid,fullname,TYPEAREA,date_serv,procedcode,chronic_pid
)

( 
SELECT p.hospcode,c.hosname,p.pid,p.fullname,p.TYPEAREA,p.date_serv,p.procedcode,c.pid chronic_pid from 
(SELECT o.hospcode,o.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.cid,p.TYPEAREA,o.date_serv,o.procedcode from tmp_chronicfu_amd o
LEFT JOIN hdc.person p on p.HOSPCODE=o.HOSPCODE and p.PID=o.PID) p
LEFT JOIN (SELECT hospcode,pid FROM hdc.chronic where LEFT(CHRONIC,3) between 'E10' and 'E14') c on c.pid=p.pid and c.hospcode=p.hospcode
left join hdc.chospital c on c.hoscode=p.hospcode
where c.pid is NULL

);






#################################


 #Routine body goes here...
DROP TABLE IF EXISTS chronicfu_amd_s;
CREATE TABLE chronicfu_amd_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ตรวจจอประสาทตา(ครั้ง)',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ไม่ได้ลงทะเบียน Chronic',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_amd_s;

INSERT INTO chronicfu_amd_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM tmp_chronicfu_amd
GROUP BY HOSPCODE) nd
LEFT JOIN
(select p.hospcode,count(p.pid) as y_cases
from 
(SELECT o.hospcode,o.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.cid,p.TYPEAREA,o.date_serv,o.procedcode from tmp_chronicfu_amd o
LEFT JOIN hdc.person p on p.HOSPCODE=o.HOSPCODE and p.PID=o.PID) p
LEFT JOIN (SELECT hospcode,pid FROM hdc.chronic where LEFT(CHRONIC,3) between 'E10' and 'E14') c on c.pid=p.pid and c.hospcode=p.hospcode
left join hdc.chospital c on c.hoscode=p.hospcode
where c.pid is NULL
group by p.hospcode
)as st on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC  

);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS chronicfu_amd_a;
CREATE TABLE chronicfu_amd_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ตรวจจอประสาทตา(ครั้ง)',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ไม่ได้ลงทะเบียน Chronic',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_amd_a;

INSERT INTO chronicfu_amd_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,ca.ampurcode) as distcode,ca.ampurname,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent
FROM
(SELECT c.distcode,count(s.pid) as pid FROM tmp_chronicfu_amd s
JOIN hdc.chospital c on c.hoscode=s.HOSPCODE
GROUP BY distcode) nd
LEFT JOIN
(select c.distcode,count(p.pid) as y_cases
from 
(SELECT o.hospcode,o.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.cid,p.TYPEAREA,o.date_serv,o.procedcode from tmp_chronicfu_amd o
LEFT JOIN hdc.person p on p.HOSPCODE=o.HOSPCODE and p.PID=o.PID) p
LEFT JOIN (SELECT hospcode,pid FROM hdc.chronic where LEFT(CHRONIC,3) between 'E10' and 'E14') c on c.pid=p.pid and c.hospcode=p.hospcode
left join hdc.chospital c on c.hoscode=p.hospcode
where c.pid is NULL
group by c.distcode
)as st on nd.distcode=st.distcode
JOIN hdc.campur ca on ca.ampurcode = nd.distcode and ca.changwatcode=@province
order by distcode

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `chronicfu_bp`
-- ----------------------------
DROP PROCEDURE IF EXISTS `chronicfu_bp`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `chronicfu_bp`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS chronicfu_bp_t;
CREATE TABLE chronicfu_bp_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
sbp varchar(5) NOT NULL DEFAULT '' COMMENT 'ซิสโตลิก',
dbp varchar(5) NOT NULL DEFAULT '' COMMENT 'ไดแอสโตลิก',
retina varchar(5) NOT NULL DEFAULT '' COMMENT 'ตรวจจอปราสาทตา',
foot varchar(5) NOT NULL DEFAULT '' COMMENT 'ตรวจเท้า',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_bp_t;

INSERT INTO chronicfu_bp_t
(
hospcode,hosname,pid,fullname,date_serv,sbp,dbp,retina,foot
)

( 

select f.hospcode,c.hosname,f.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,f.date_Serv,f.sbp,f.dbp,f.retina,f.foot  
from hdc.chronicfu f
left join hdc.person p on p.hospcode=f.hospcode and p.pid=f.pid
LEFT JOIN hdc.chospital c on c.hoscode=f.HOSPCODE
where f.sbp<=dbp  and f.sbp<>'0'
AND f.DATE_SERV BETWEEN @start_d AND @end_d 
order by f.hospcode



);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS chronicfu_bp_s;
CREATE TABLE chronicfu_bp_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_bp_s;

INSERT INTO chronicfu_bp_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.chronicfu 
where DATE_SERV BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select hospcode,count(pid) as y_cases,date_Serv,sbp,dbp,retina,foot 
from hdc.chronicfu f
where sbp<=dbp  and sbp<>'0'
AND DATE_SERV BETWEEN @start_d AND @end_d 
group by hospcode)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC

);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS chronicfu_bp_a;
CREATE TABLE chronicfu_bp_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_bp_a;

INSERT INTO chronicfu_bp_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(f.pid) as pid FROM hdc.chronicfu f
join hdc.chospital c on c.hoscode=f.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where f.DATE_SERV BETWEEN @start_d AND @end_d 
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(f.pid) as y_cases
from hdc.chronicfu f
join hdc.chospital c on c.hoscode=f.HOSPCODE
where sbp<=dbp  and sbp<>'0'
AND DATE_SERV BETWEEN @start_d AND @end_d
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `chronicfu_foot_not_hdc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `chronicfu_foot_not_hdc`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `chronicfu_foot_not_hdc`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS chronicfu_foot_not_hdc_t;
CREATE TABLE chronicfu_foot_not_hdc_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',

hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
weight varchar(9) NOT NULL DEFAULT '' COMMENT 'น้ำหนัก',
waist_cm varchar(9) NOT NULL DEFAULT '' COMMENT 'เส้นรอบเอว',
sbp varchar(9) NOT NULL DEFAULT '' COMMENT 'ซิสโตลิก',
dbp varchar(9) NOT NULL DEFAULT '' COMMENT 'ไดแอสโตลิก',
foot varchar(5) NOT NULL DEFAULT '' COMMENT 'ตรวจเท้า',
retina varchar(5) NOT NULL DEFAULT '' COMMENT 'ตรวจตา',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_foot_not_hdc_t;

INSERT INTO chronicfu_foot_not_hdc_t
(
hospcode,hosname,pid,fullname,date_serv,weight,waist_cm,sbp,dbp,foot,retina
)

( 

select ch.hospcode,c.hosname,ch.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,ch.date_serv,ch.weight,ch.waist_cm,ch.sbp,ch.dbp,ch.foot,ch.retina 
from hdc.chronicfu ch 
left join hdc.person p on p.hospcode=ch.hospcode and p.pid=ch.pid
left  join hdc.chospital c on c.hoscode=ch.hospcode
where ch.date_serv BETWEEN @start_d AND @end_d 
and ch.foot not in ('1','2','3','9') 
order by ch.hospcode


);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS chronicfu_foot_not_hdc_s;
CREATE TABLE chronicfu_foot_not_hdc_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_foot_not_hdc_s;

INSERT INTO chronicfu_foot_not_hdc_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

(
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.chronicfu ch
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN 
(select ch.hospcode,count(ch.pid) as y_cases
from hdc.chronicfu ch 
where ch.date_serv BETWEEN @start_d AND @end_d 
and  ch.foot not in ('1','2','3','9') 
group by ch.hospcode)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC





);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS chronicfu_foot_not_hdc_a;
CREATE TABLE chronicfu_foot_not_hdc_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_foot_not_hdc_a;

INSERT INTO chronicfu_foot_not_hdc_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(ch.pid) as pid FROM hdc.chronicfu ch
join hdc.chospital c on c.hoscode=ch.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where ch.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(ch.pid) as y_cases
from hdc.chronicfu ch
join hdc.chospital c on c.hoscode=ch.HOSPCODE
where ch.date_serv BETWEEN @start_d AND @end_d 
and ch.foot not in ('1','2','3','9')  

group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc



);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `chronicfu_retina_not_hdc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `chronicfu_retina_not_hdc`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `chronicfu_retina_not_hdc`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS chronicfu_retina_not_hdc_t;
CREATE TABLE chronicfu_retina_not_hdc_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',

hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
weight varchar(9) NOT NULL DEFAULT '' COMMENT 'น้ำหนัก',
waist_cm varchar(9) NOT NULL DEFAULT '' COMMENT 'เส้นรอบเอว',
sbp varchar(9) NOT NULL DEFAULT '' COMMENT 'ซิสโตลิก',
dbp varchar(9) NOT NULL DEFAULT '' COMMENT 'ไดแอสโตลิก',
foot varchar(5) NOT NULL DEFAULT '' COMMENT 'ตรวจเท้า',
retina varchar(5) NOT NULL DEFAULT '' COMMENT 'ตรวจตา',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_retina_not_hdc_t;

INSERT INTO chronicfu_retina_not_hdc_t
(
hospcode,hosname,pid,fullname,date_serv,weight,waist_cm,sbp,dbp,foot,retina
)

( 

select ch.hospcode,c.hosname,ch.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,ch.date_serv,ch.weight,ch.waist_cm,ch.sbp,ch.dbp,ch.foot,ch.retina 
from hdc.chronicfu ch 
left join hdc.person p on p.hospcode=ch.hospcode and p.pid=ch.pid
left  join hdc.chospital c on c.hoscode=ch.hospcode
where ch.date_serv BETWEEN @start_d AND @end_d 
and  ch.retina not in ('1','2','3','4','8','9')
order by ch.hospcode


);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS chronicfu_retina_not_hdc_s;
CREATE TABLE chronicfu_retina_not_hdc_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_retina_not_hdc_s;

INSERT INTO chronicfu_retina_not_hdc_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.chronicfu ch
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN 
(select ch.hospcode,count(ch.pid) as y_cases
from hdc.chronicfu ch 
where ch.date_serv BETWEEN @start_d AND @end_d 
and ch.retina not in ('1','2','3','4','8','9')
group by ch.hospcode)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC





);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS chronicfu_retina_not_hdc_a;
CREATE TABLE chronicfu_retina_not_hdc_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronicfu_retina_not_hdc_a;

INSERT INTO chronicfu_retina_not_hdc_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(ch.pid) as pid FROM hdc.chronicfu ch
join hdc.chospital c on c.hoscode=ch.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where ch.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(ch.pid) as y_cases
from hdc.chronicfu ch
join hdc.chospital c on c.hoscode=ch.HOSPCODE
where ch.date_serv BETWEEN @start_d AND @end_d 
and ch.retina not in ('1','2','3','4','8','9')

group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc



);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `dental_workload`
-- ----------------------------
DROP PROCEDURE IF EXISTS `dental_workload`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dental_workload`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS dental_workload_t;
CREATE TABLE dental_workload_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันรับบริการ',
denttype varchar(2) NOT NULL DEFAULT '' COMMENT 'Error',
age varchar(3) NOT NULL DEFAULT '' COMMENT 'อายุ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE dental_workload_t;
INSERT INTO dental_workload_t
(
hospcode,hosname,pid,fullname,date_serv,denttype,age
)
( 
SELECT d.hospcode,c.hosname,d.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,d.DATE_SERV,d.denttype,
TIMESTAMPDIFF(YEAR,p.birth,d.DATE_SERV) AS age
FROM (SELECT a.HOSPCODE,a.PID,a.DATE_SERV,a.denttype,a.PROVIDER
	FROM hdc.dental a
	WHERE a.DATE_SERV BETWEEN @start_d AND @end_d) d
LEFT JOIN (SELECT v.HOSPCODE,v.provider,v.PROVIDERTYPE 
		FROM hdc.provider v
		WHERE v.PROVIDERTYPE   IN ('02','06')) c
ON d.HOSPCODE = c.HOSPCODE AND d.PROVIDER = c.provider
LEFT JOIN hdc.chospital c ON c.hoscode = d.hospcode
LEFT JOIN hdc.person p ON p.pid = d.pid AND d.hospcode=p.hospcode
WHERE d.date_serv BETWEEN @start_d AND @end_d  and d.DENTTYPE NOT IN (1,2,3,4,5)  
AND c.provider IS NULL 
ORDER BY d.hospcode
);
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS dental_workload_s;
CREATE TABLE dental_workload_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
totalperson VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด/คน',
numberscreen VARCHAR(5) NOT NULL DEFAULT '' COMMENT  'จำนวนทั้งหมด/ครั้ง',
pregnancy varchar(2) NOT NULL DEFAULT '' COMMENT 'หญิงตั้งครรภ์',
preschool varchar(2) NOT NULL DEFAULT '' COMMENT 'เด็กก่อนเรียน',
student varchar(2) NOT NULL DEFAULT '' COMMENT 'เด็กวัยเรียน',
elderly varchar(2) NOT NULL DEFAULT '' COMMENT 'ผู้สูงอายุ',
elsegroup varchar(2) NOT NULL DEFAULT '' COMMENT 'กลุ่มอื่่น',
y_cases varchar(2) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE dental_workload_s;
INSERT INTO dental_workload_s
(
hospcode,hosname,distcode,totalperson,numberscreen,pregnancy,preschool,student,elderly,elsegroup,y_cases,percent
)
( 
SELECT d.hospcode,c.hosname,CONCAT(@province,c.distcode) AS distcode,
COUNT(DISTINCT p.cid) AS totalperson,
COUNT(d.pid) AS numberscreen,
SUM(CASE WHEN denttype=1 THEN 1 ELSE 0 END) AS pregnancy,
SUM(CASE WHEN denttype=2 THEN 1 ELSE 0 END) AS preschool,
SUM(CASE WHEN denttype=3 THEN 1 ELSE 0 END) AS student,
SUM(CASE WHEN denttype=4 THEN 1 ELSE 0 END) AS elderly,
SUM(CASE WHEN denttype=5 THEN 1 ELSE 0 END) AS elsegroup,
SUM(CASE WHEN denttype NOT IN (1,2,3,4,5)  THEN 1 ELSE 0 END) y_cases,
ROUND((SUM(CASE WHEN denttype NOT IN (1,2,3,4,5)  THEN 1 ELSE 0 END)/COUNT(d.pid))*100,2) AS percent
FROM (SELECT a.HOSPCODE,a.PID,a.DATE_SERV,a.denttype,a.PROVIDER
	FROM hdc.dental a
	WHERE  a.DATE_SERV BETWEEN @start_d AND @end_d) d
LEFT JOIN (SELECT v.HOSPCODE,v.provider,v.PROVIDERTYPE 
		FROM hdc.provider v
		WHERE v.PROVIDERTYPE   IN ('02','06')) c
ON d.HOSPCODE = c.HOSPCODE AND d.PROVIDER = c.provider
LEFT JOIN hdc.chospital c ON c.hoscode = d.hospcode
LEFT JOIN hdc.person p ON p.pid = d.pid AND d.hospcode=p.hospcode
WHERE d.date_serv BETWEEN @start_d AND @end_d 
AND c.provider IS NULL 
GROUP BY d.hospcode
ORDER BY d.hospcode
);
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS dental_workload_a;
CREATE TABLE dental_workload_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE dental_workload_a;
INSERT INTO dental_workload_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT CONCAT(@province,c.distcode) AS distcode,ca.ampurname, 
COUNT(d.pid) AS totalscreen,
SUM(CASE WHEN denttype NOT IN (1,2,3,4,5)  THEN 1 ELSE 0 END) other,
ROUND((SUM(CASE WHEN denttype NOT IN (1,2,3,4,5)  THEN 1 ELSE 0 END)/COUNT(d.pid))*100,2) AS percent
FROM (SELECT a.HOSPCODE,a.PID,a.DATE_SERV,a.denttype,a.PROVIDER
	FROM hdc.dental a
	WHERE a.DATE_SERV BETWEEN @start_d AND @end_d) d
LEFT JOIN (SELECT v.HOSPCODE,v.provider,v.PROVIDERTYPE 
		FROM hdc.provider v
		WHERE v.PROVIDERTYPE   IN ('02','06')) c
ON d.HOSPCODE = c.HOSPCODE AND d.PROVIDER = c.provider
LEFT JOIN hdc.chospital c ON c.hoscode = d.hospcode
LEFT JOIN hdc.person p ON p.pid = d.pid AND d.hospcode=p.hospcode
LEFT JOIN hdc.campur ca ON ca.ampurcode = c.distcode AND ca.changwatcode=@province 
WHERE d.date_serv BETWEEN @start_d AND @end_d 
AND c.provider IS NULL
GROUP BY c.distcode
ORDER BY d.hospcode
);
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `diagnosis_opd`
-- ----------------------------
DROP PROCEDURE IF EXISTS `diagnosis_opd`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `diagnosis_opd`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS diagnosis_opd_t;
CREATE TABLE diagnosis_opd_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
diagcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสการวินิจฉัย',
diagtype varchar(15) NOT NULL DEFAULT '' COMMENT 'ประเภทการวินิจฉัย',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE diagnosis_opd_t;

INSERT INTO diagnosis_opd_t
(
hospcode,hosname,pid,fullname,date_serv,diagcode,diagtype
)

( 
select s.hospcode,h.hosname,s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,s.date_serv,s.diagcode,s.diagtype
from hdc.diagnosis_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where s.diagtype not in ('1','4','5','7')
AND s.date_serv BETWEEN @start_d AND @end_d 
order by s.hospcode, p.pid, s.date_serv
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS diagnosis_opd_s;
CREATE TABLE diagnosis_opd_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE diagnosis_opd_s;

INSERT INTO diagnosis_opd_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.diagnosis_opd
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.diagnosis_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where s.diagtype not in ('1','4','5','7')
AND s.date_serv BETWEEN @start_d AND @end_d 
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC


);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS diagnosis_opd_a;
CREATE TABLE diagnosis_opd_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE diagnosis_opd_a;

INSERT INTO diagnosis_opd_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.diagnosis_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.diagnosis_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
where s.diagtype not in ('1','4','5','7')
AND s.date_serv BETWEEN @start_d AND @end_d 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `diagnosis_opd_diagcode`
-- ----------------------------
DROP PROCEDURE IF EXISTS `diagnosis_opd_diagcode`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `diagnosis_opd_diagcode`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS diagnosis_opd_diagcode_t;
CREATE TABLE diagnosis_opd_diagcode_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
diagcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสการวินิจฉัย',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE diagnosis_opd_diagcode_t;
INSERT INTO diagnosis_opd_diagcode_t
(
hospcode,hosname,pid,fullname,date_serv,diagcode
)
( 
select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,s.date_serv, s.diagcode
from hdc.diagnosis_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
WHERE s.diagcode IN (SELECT CODE FROM l_icd101)
AND s.date_serv BETWEEN @start_d AND @end_d 
order by h.hoscode, p.pid, s.date_serv
);
#################################
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS diagnosis_opd_diagcode_s;
CREATE TABLE diagnosis_opd_diagcode_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE diagnosis_opd_diagcode_s;
INSERT INTO diagnosis_opd_diagcode_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)
( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.diagnosis_opd 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.diagnosis_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
#join hdc.cprename pn on pn.id_prename=p.prename
where s.diagcode IN (SELECT CODE FROM l_icd101)
AND s.date_serv BETWEEN @start_d AND @end_d 
group by s.hospcode
)as st 
on nd.hospcode = st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC
);
#################################
################################
 #Routine body goes here...
DROP TABLE IF EXISTS diagnosis_opd_diagcode_a;
CREATE TABLE diagnosis_opd_diagcode_a (
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE diagnosis_opd_diagcode_a;
INSERT INTO diagnosis_opd_diagcode_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.diagnosis_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.diagnosis_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
where s.diagcode IN (SELECT CODE FROM l_icd101)
AND s.date_serv BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc
);
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `diagnosis_opd_externalcause`
-- ----------------------------
DROP PROCEDURE IF EXISTS `diagnosis_opd_externalcause`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `diagnosis_opd_externalcause`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS diagnosis_opd_externalcause_t;
CREATE TABLE diagnosis_opd_externalcause_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
diagcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสการวินิจฉัย',
diagtype varchar(15) NOT NULL DEFAULT '' COMMENT 'ประเภทการวินิจฉัย',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE diagnosis_opd_externalcause_t;

INSERT INTO diagnosis_opd_externalcause_t
(
hospcode,hosname,pid,fullname,date_serv,diagcode,diagtype
)

( 
select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname, s.date_serv, s.diagcode, s.diagtype
from hdc.diagnosis_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where (diagcode like 'v%' or diagcode like 'w%' or diagcode like 'x%' or diagcode like 'y%')
and diagtype<>'5'
AND s.date_serv BETWEEN @start_d AND @end_d  
order by h.hoscode, p.pid, s.date_serv
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS diagnosis_opd_externalcause_s;
CREATE TABLE diagnosis_opd_externalcause_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE diagnosis_opd_externalcause_s;

INSERT INTO diagnosis_opd_externalcause_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.diagnosis_opd 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.diagnosis_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where (diagcode like 'v%' or diagcode like 'w%' or diagcode like 'x%' or diagcode like 'y%')
and diagtype<>'5'
and s.date_serv BETWEEN @start_d AND @end_d
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS diagnosis_opd_externalcause_a;
CREATE TABLE diagnosis_opd_externalcause_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE diagnosis_opd_externalcause_a;

INSERT INTO diagnosis_opd_externalcause_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.diagnosis_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.diagnosis_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
where (diagcode like 'v%' or diagcode like 'w%' or diagcode like 'x%' or diagcode like 'y%')
and diagtype<>'5'
and s.date_serv BETWEEN @start_d AND @end_d 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `diagnosis_opd_noexternalcause`
-- ----------------------------
DROP PROCEDURE IF EXISTS `diagnosis_opd_noexternalcause`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `diagnosis_opd_noexternalcause`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS diagnosis_opd_noexternalcause_t;
CREATE TABLE diagnosis_opd_noexternalcause_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
diagcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสการวินิจฉัย',
diagtype varchar(15) NOT NULL DEFAULT '' COMMENT 'ประเภทการวินิจฉัย',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE diagnosis_opd_noexternalcause_t;

INSERT INTO diagnosis_opd_noexternalcause_t
(
hospcode,hosname,pid,fullname,date_serv,diagcode,diagtype
)

( 
select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,s.date_serv, s.diagcode, s.diagtype
from hdc.diagnosis_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where (diagcode not like 'v%' and diagcode not like 'w%' and diagcode not like 'x%' and diagcode not like 'y%')
and diagtype='5'
and s.date_serv BETWEEN @start_d AND @end_d
order by h.hoscode, p.pid, s.date_serv
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS diagnosis_opd_noexternalcause_s;
CREATE TABLE diagnosis_opd_noexternalcause_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE diagnosis_opd_noexternalcause_s;

INSERT INTO diagnosis_opd_noexternalcause_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.diagnosis_opd 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.diagnosis_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
#join hdc.cprename pn on pn.id_prename=p.prename
where (diagcode not like 'v%' and diagcode not like 'w%' and diagcode not like 'x%' and diagcode not like 'y%')
and diagtype='5'
AND s.date_serv BETWEEN @start_d AND @end_d 
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS diagnosis_opd_noexternalcause_a;
CREATE TABLE diagnosis_opd_noexternalcause_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE diagnosis_opd_noexternalcause_a;

INSERT INTO diagnosis_opd_noexternalcause_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.diagnosis_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.diagnosis_opd s
join hdc.chospital c on c.hoscode=s.HOSPCODE
where (diagcode not like 'v%' and diagcode not like 'w%' and diagcode not like 'x%' and diagcode not like 'y%')
and diagtype='5'
AND s.date_serv BETWEEN @start_d AND @end_d 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `epi_bcg_BAbdate`
-- ----------------------------
DROP PROCEDURE IF EXISTS `epi_bcg_BAbdate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `epi_bcg_BAbdate`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS epi_bcg_BAbdate_t;
CREATE TABLE epi_bcg_BAbdate_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
bdate varchar(15) NOT NULL DEFAULT '' COMMENT 'วันที่คลอด',
bhosp varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสสถานพยาบาลที่คลอด',
vaccineplace varchar(15) NOT NULL DEFAULT '' COMMENT 'สถานที่รับวัคซีน',
date_serv date COMMENT 'วันที่รับบริการ',
diff_date varchar(15) NOT NULL DEFAULT '' COMMENT 'อายุ (วัน)',
e_hosp varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการที่รับวัคซีน',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_bcg_BAbdate_t;
INSERT INTO epi_bcg_BAbdate_t
(
hospcode,hosname,pid,fullname,bdate,bhosp,vaccineplace,date_serv,diff_date,e_hosp
)
( 
select n.hospcode as n_hosp,c.hosname, n.pid, concat(p.`NAME`,' ',p.LNAME)as fullname,n.bdate, n.bhosp, e.vaccineplace, e.date_serv, datediff(e.date_serv,n.bdate) as diff_date, e.hospcode as e_hosp
from hdc.newborn n
left join hdc.epi e on e.hospcode=n.hospcode and e.pid=n.pid
left join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid
left outer join hdc.chospital c on c.hoscode=e.HOSPCODE
where e.date_serv < n.bdate
AND n.bdate BETWEEN @start_d AND @end_d 
order by n.hospcode
);
#################################
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_bcg_BAbdate_s;
CREATE TABLE epi_bcg_BAbdate_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_bcg_BAbdate_s;
INSERT INTO epi_bcg_BAbdate_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)
( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.newborn
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select n.hospcode,count(n.pid) as y_cases
from hdc.newborn n
left join hdc.epi e on e.hospcode=n.hospcode and e.pid=n.pid
where e.date_serv < n.bdate
AND n.bdate BETWEEN @start_d AND @end_d  
group by n.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases desc
);
#################################
################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_bcg_BAbdate_a;
CREATE TABLE epi_bcg_BAbdate_a (
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_bcg_BAbdate_a;
INSERT INTO epi_bcg_BAbdate_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.newborn n
join hdc.chospital c on c.hoscode=n.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where n.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(n.pid) as y_cases
from hdc.newborn n
left join hdc.epi e on e.hospcode=n.hospcode and e.pid=n.pid
join hdc.chospital c on c.hoscode=n.HOSPCODE
where e.date_serv < n.bdate
AND n.bdate BETWEEN @start_d AND @end_d    
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc
);
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `epi_firstvaccine`
-- ----------------------------
DROP PROCEDURE IF EXISTS `epi_firstvaccine`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `epi_firstvaccine`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS epi_firstvaccine_t;
CREATE TABLE epi_firstvaccine_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
hn varchar(15) NOT NULL DEFAULT '' COMMENT 'เลขที่ผู้ป่วยนอก',
BIRTH date COMMENT 'วันเกิด',
date_serv date COMMENT 'วันที่รับบริการ',
vaccinetype varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสวัคซีน',
vaccineplace varchar(15) COMMENT 'สถานที่รับวัคซีน',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_firstvaccine_t;
INSERT INTO epi_firstvaccine_t
(
hospcode,hosname,pid, fullname,hn,birth,date_serv,vaccinetype,vaccineplace
)
( 
select e.hospcode,c.hosname,e.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.hn,p.birth,e.date_serv,e.vaccinetype,e.vaccineplace
from hdc.epi e
left join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode
left outer join hdc.chospital c on c.hoscode=e.HOSPCODE
where e.vaccinetype ='010' and e.hospcode=e.vaccineplace  AND TIMESTAMPDIFF(YEAR,p.BIRTH,e.DATE_SERV) >1
AND e.date_serv BETWEEN @start_d AND @end_d  
order by e.hospcode
);
#################################
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_firstvaccine_s;
CREATE TABLE epi_firstvaccine_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_firstvaccine_s;
INSERT INTO epi_firstvaccine_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)
( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT e.hospcode,count(e.pid) as pid FROM hdc.epi e
left join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode
where e.vaccinetype =010 and e.hospcode=e.vaccineplace
and e.date_serv BETWEEN @start_d AND @end_d group by e.hospcode) nd
LEFT JOIN
(select e.hospcode,count(e.pid) as y_cases
from hdc.epi e
left join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode
where e.vaccinetype ='010' and e.hospcode=e.vaccineplace AND TIMESTAMPDIFF(YEAR,p.BIRTH,e.DATE_SERV) >1
and e.date_serv BETWEEN @start_d AND @end_d 
group by e.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases desc
);
#################################
################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_firstvaccine_a;
CREATE TABLE epi_firstvaccine_a (
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_firstvaccine_a;
INSERT INTO epi_firstvaccine_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(e.pid) as pid FROM hdc.epi e
join hdc.chospital c on c.hoscode=e.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
left join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode
where e.vaccinetype ='010' and e.hospcode=e.vaccineplace 
and e.date_serv BETWEEN @start_d AND @end_d 
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(e.pid) as y_cases
from hdc.epi e
join hdc.chospital c on c.hoscode=e.HOSPCODE
left join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode
where e.vaccinetype =010 and e.hospcode=e.vaccineplace AND TIMESTAMPDIFF(YEAR,p.BIRTH,e.DATE_SERV) >1
and e.date_serv BETWEEN @start_d AND @end_d   
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `epi_firstvaccine2`
-- ----------------------------
DROP PROCEDURE IF EXISTS `epi_firstvaccine2`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `epi_firstvaccine2`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS epi_firstvaccine2_t;
CREATE TABLE epi_firstvaccine2_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
hn varchar(15) NOT NULL DEFAULT '' COMMENT 'เลขที่ผู้ป่วยนอก',
BIRTH date COMMENT 'วันเกิด',
date_serv date COMMENT 'วันที่รับบริการ',
vaccinetype varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสวัคซีน',
vaccineplace varchar(15) COMMENT 'สถานที่รับวัคซีน',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_firstvaccine2_t;
INSERT INTO epi_firstvaccine2_t
(
hospcode,hosname,pid,fullname,hn,birth,date_serv,vaccinetype,vaccineplace
)
( 
select e.hospcode,c.hosname,e.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.hn,p.birth,e.date_serv,e.vaccinetype,e.vaccineplace
from hdc.epi e
left join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode
left outer join hdc.chospital c on c.hoscode=e.HOSPCODE
where e.vaccinetype =041 and e.hospcode=e.vaccineplace  AND TIMESTAMPDIFF(DAY,p.BIRTH,e.DATE_SERV) >60
AND e.date_serv BETWEEN @start_d AND @end_d  
order by e.hospcode
);
#################################
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_firstvaccine2_s;
CREATE TABLE epi_firstvaccine2_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_firstvaccine2_s;
INSERT INTO epi_firstvaccine2_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)
( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT e.hospcode,count(e.pid) as pid FROM hdc.epi e
left join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode
where e.vaccinetype =041 and e.hospcode=e.vaccineplace
and e.date_serv BETWEEN @start_d AND @end_d group by e.hospcode) nd
LEFT JOIN
(select e.hospcode,count(e.pid) as y_cases
from hdc.epi e
left join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode
where e.vaccinetype =041 and e.hospcode=e.vaccineplace AND TIMESTAMPDIFF(DAY,p.BIRTH,e.DATE_SERV) >60
and e.date_serv BETWEEN @start_d AND @end_d 
group by e.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases desc
);
#################################
################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_firstvaccine2_a;
CREATE TABLE epi_firstvaccine2_a (
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_firstvaccine2_a;
INSERT INTO epi_firstvaccine2_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(e.pid) as pid FROM hdc.epi e
join hdc.chospital c on c.hoscode=e.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
left join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode
where e.vaccinetype =041 and e.hospcode=e.vaccineplace
and e.date_serv BETWEEN @start_d AND @end_d 
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(e.pid) as y_cases
from hdc.epi e
join hdc.chospital c on c.hoscode=e.HOSPCODE
left join hdc.person p on p.pid=e.pid and p.hospcode=e.hospcode
where e.vaccinetype =041 and e.hospcode=e.vaccineplace AND TIMESTAMPDIFF(DAY,p.BIRTH,e.DATE_SERV) >60
and e.date_serv BETWEEN @start_d AND @end_d   
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `epi_nocid`
-- ----------------------------
DROP PROCEDURE IF EXISTS `epi_nocid`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `epi_nocid`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS epi_nocid_t;
CREATE TABLE epi_nocid_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
hn varchar(15) NOT NULL DEFAULT '' COMMENT 'HN',
cid varchar(15) NOT NULL DEFAULT '' COMMENT 'เลขที่บัตรประชาชน',
nation varchar(15) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
typearea varchar(15) NOT NULL DEFAULT '' COMMENT 'TYPE AREA',
date_serv date COMMENT 'วันที่รับบริการ',
vaccineplace varchar(15) NOT NULL DEFAULT '' COMMENT 'สถานที่รับวัคซีน',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_nocid_t;
INSERT INTO epi_nocid_t
(
hospcode,hosname,pid,fullname,hn,cid,nation,typearea,date_serv,vaccineplace
)
( 
select e.hospcode,c.hosname,e.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.hn,p.cid,p.nation,p.typearea,e.date_serv,e.vaccineplace
from hdc.epi e
left outer join hdc.person p on p.pid=e.pid and e.hospcode=p.hospcode
left outer join hdc.chospital c on c.hoscode=e.HOSPCODE
where  p.nation='099'  and (cid like '0%' or cid ='')
and e.date_serv BETWEEN @start_d AND @end_d
order by e.hospcode
);
#################################
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_nocid_s;
CREATE TABLE epi_nocid_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_nocid_s;
INSERT INTO epi_nocid_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)
( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.epi 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select e.hospcode,count(e.pid) as y_cases
from hdc.epi e
left outer join hdc.person p on p.pid=e.pid and e.hospcode=p.hospcode
where  p.nation='099'  and (cid like '0%' or cid ='')
AND e.date_serv BETWEEN @start_d AND @end_d
group by e.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases desc
);
#################################
################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_nocid_a;
CREATE TABLE epi_nocid_a (
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_nocid_a;
INSERT INTO epi_nocid_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(e.pid) as pid FROM hdc.epi e
join hdc.chospital c on c.hoscode=e.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where e.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(e.pid) as y_cases
from hdc.epi e
left outer join hdc.person p on p.pid=e.pid and e.hospcode=p.hospcode
join hdc.chospital c on c.hoscode=e.HOSPCODE
where  p.nation='099'  and (cid like '0%' or cid ='')
AND e.date_serv BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `epi_noperson`
-- ----------------------------
DROP PROCEDURE IF EXISTS `epi_noperson`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `epi_noperson`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS epi_noperson_t;
CREATE TABLE epi_noperson_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
e_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล (epi)',
p_pid varchar(15) COMMENT 'ทะเบียนบุคคล (person)',
date_serv date COMMENT 'วันที่รับบริการ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_noperson_t;
INSERT INTO epi_noperson_t
(
hospcode,hosname,e_pid,p_pid,date_serv
)
( 
select e.hospcode,c.hosname,e.pid,p.pid,e.DATE_SERV
from hdc.epi e
left join hdc.person p on p.hospcode=e.hospcode and p.pid=e.pid
LEFT JOIN hdc.chospital c on c.hoscode=e.HOSPCODE
where p.pid is null
AND e.date_serv BETWEEN @start_d AND @end_d
order by e.hospcode
);
#################################
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_noperson_s;
CREATE TABLE epi_noperson_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_noperson_s;
INSERT INTO epi_noperson_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)
( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.epi 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select e.hospcode,count(e.pid) as y_cases
from hdc.epi e
left join hdc.person p on p.hospcode=e.hospcode and p.pid=e.pid
where p.pid is null
AND e.date_serv BETWEEN @start_d AND @end_d
group by e.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC
);
#################################
################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_noperson_a;
CREATE TABLE epi_noperson_a (
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_noperson_a;
INSERT INTO epi_noperson_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(e.pid) as pid FROM hdc.epi e
join hdc.chospital c on c.hoscode=e.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where e.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(e.pid) as y_cases
from hdc.epi e
left join hdc.person p on p.hospcode=e.hospcode and p.pid=e.pid
join hdc.chospital c on c.hoscode=e.HOSPCODE
where p.pid is null
AND e.date_serv BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `epi_vaccine_nostandardcenter`
-- ----------------------------
DROP PROCEDURE IF EXISTS `epi_vaccine_nostandardcenter`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `epi_vaccine_nostandardcenter`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS epi_vaccine_nostandardcenter_t;
CREATE TABLE epi_vaccine_nostandardcenter_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
vaccinetype varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสวัคซีน',
vaccineplace varchar(15) NOT NULL DEFAULT '' COMMENT 'สถานที่รับวัคซีน',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_vaccine_nostandardcenter_t;
INSERT INTO epi_vaccine_nostandardcenter_t
(
hospcode,hosname,pid,fullname,date_serv,vaccinetype,vaccineplace
)
( 
select e.hospcode,c.hosname,e.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,e.date_Serv,e.vaccinetype,e.vaccineplace 
from hdc.epi e
left join hdc.person p on p.hospcode=e.hospcode and p.pid=e.pid
left outer join hdc.chospital c on c.hoscode=e.hospcode
where e.date_serv BETWEEN @start_d AND @end_d 
and e.vaccinetype  not in (select vaccinecode from hdc.cvaccinetype)
order by e.hospcode 
);
#################################
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_vaccine_nostandardcenter_s;
CREATE TABLE epi_vaccine_nostandardcenter_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_vaccine_nostandardcenter_s;
INSERT INTO epi_vaccine_nostandardcenter_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)
( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.epi 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select e.hospcode,count(e.pid) as y_cases
from hdc.epi e
where e.date_serv BETWEEN @start_d AND @end_d
and e.vaccinetype  not in (select vaccinecode from hdc.cvaccinetype)
group by e.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases desc
);
#################################
################################
 #Routine body goes here...
DROP TABLE IF EXISTS epi_vaccine_nostandardcenter_a;
CREATE TABLE epi_vaccine_nostandardcenter_a (
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE epi_vaccine_nostandardcenter_a;
INSERT INTO epi_vaccine_nostandardcenter_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(e.pid) as pid FROM hdc.epi e
join hdc.chospital c on c.hoscode=e.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where e.date_serv BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(e.pid) as y_cases
from hdc.epi e
left join hdc.cvaccinetype v on v.vaccinecode=e.vaccinetype
join hdc.chospital c on c.hoscode=e.HOSPCODE
where e.date_serv BETWEEN @start_d AND @end_d
and e.vaccinetype  not in (select vaccinecode from hdc.cvaccinetype)
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc
);
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `labfu_Creatinine_not_standard`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labfu_Creatinine_not_standard`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labfu_Creatinine_not_standard`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS labfu_Creatinine_not_standard_t;
CREATE TABLE labfu_Creatinine_not_standard_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
HOSPCODE varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
PID VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
LABTEST VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'การเจาะตรวจCreatinine',
date_serv date COMMENT 'วันที่รับบริการ',
LABRESULT varchar(5) NOT NULL DEFAULT '' COMMENT 'ผลการตรวจCreatinine',
CHRONIC varchar(50) NOT NULL DEFAULT '' COMMENT 'รหัสโรคเรื้อรัง',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_Creatinine_not_standard_t;

INSERT INTO labfu_Creatinine_not_standard_t
(
HOSPCODE,hosname,PID,fullname,LABTEST,date_serv,LABRESULT,CHRONIC
)

( 
select t.HOSPCODE,t.hosname,t.PID,t.fullname,t.LABTEST,t.DATE_SERV,t.LABRESULT,group_concat(t.CHRONIC) as CHRONIC FROM
(SELECT l.HOSPCODE, ch.hosname,l.PID,concat(p.`NAME`,' ',p.LNAME)as fullname
,if(l.LABTEST='11',lt.LABTEST,ltn.TH) AS LABTEST,l.DATE_SERV,l.LABRESULT,c.CHRONIC 
FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I15'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST
LEFT JOIN hdc.clabtest_new ltn ON ltn.`code` = l.LABTEST 
left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('11',' 0581803') AND l.labresult NOT BETWEEN '0.01' AND '25' 
ORDER BY l.HOSPCODE) t
group by t.HOSPCODE,t.PID
order by t.CHRONIC


);





#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labfu_Creatinine_not_standard_s;
CREATE TABLE labfu_Creatinine_not_standard_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ตรวจ Creatinine ทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'นอกพิสัยที่ควรเป็นไปได้ (0.01 - 25 )',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_Creatinine_not_standard_s;

INSERT INTO labfu_Creatinine_not_standard_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 

SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode ,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent
 FROM (SELECT l.HOSPCODE,ch.hosname,ch.distcode ,COUNT(l.pid) as pid FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I15' or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE 
where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('11',' 0581803') 
GROUP BY l.HOSPCODE) nd 
LEFT JOIN (SELECT l.HOSPCODE,ch.hosname,COUNT(distinct l.pid) as y_cases FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I15'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('11',' 0581803') AND l.labresult NOT BETWEEN '0.01' AND '25' 
GROUP BY l.HOSPCODE )as st on nd.hospcode=st.hospcode 
ORDER BY st.hospcode


);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labfu_Creatinine_not_standard_a;
CREATE TABLE labfu_Creatinine_not_standard_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ตรวจ Creatinine ทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'นอกพิสัยที่ควรเป็นไปได้ (0.01 - 25 )',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_Creatinine_not_standard_a;

INSERT INTO labfu_Creatinine_not_standard_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname as ampurname,nd.pid AS total_pid, 
IFNULL(st.y_cases,0) as y_cases, 
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent 
FROM (SELECT c.distcode,ca.ampurname,COUNT(l.pid) as pid FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I15'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
JOIN hdc.chospital c on c.hoscode=l.HOSPCODE 
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province 
where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('11','0581803') 
GROUP BY c.distcode) nd 
left JOIN (SELECT ch.distcode,COUNT(DISTINCT l.pid) as y_cases 
FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I15'  or CHRONIC BETWEEN 'N18' AND 'N189'   and TYPEDISCH <>'02') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt on lt.id_labtest=l.LABTEST 
LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE 
where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('11','0581803') AND l.labresult NOT BETWEEN '0.01' AND '25' 
GROUP BY ch.distcode )as st on nd.distcode=st.distcode 
order by st.y_cases desc
);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `labfu_hba1c_not_standard`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labfu_hba1c_not_standard`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labfu_hba1c_not_standard`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS labfu_hba1c_not_standard_t;
CREATE TABLE labfu_hba1c_not_standard_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
labtest VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'การเจาะตรวจHbA1c',
date_serv date COMMENT 'วันที่รับบริการ',
LABRESULT varchar(5) NOT NULL DEFAULT '' COMMENT 'ผลHbA1c',
CHRONIC varchar(50) NOT NULL DEFAULT '' COMMENT 'รหัสโรคเรื้อรัง',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_hba1c_not_standard_t;

INSERT INTO labfu_hba1c_not_standard_t
(
hospcode,hosname,pid,fullname,labtest,date_serv,LABRESULT,CHRONIC
)

( 

select t.HOSPCODE,t.hosname,t.PID,t.fullname,t.LABTEST,t.DATE_SERV,t.LABRESULT,group_concat(distinct t.CHRONIC) as CHRONIC from
(SELECT l.HOSPCODE, ch.hosname,l.PID,concat(p.`NAME`,' ',p.LNAME)as fullname,if(l.LABTEST='05',lt.LABTEST,ltn.TH) AS LABTEST,l.DATE_SERV,l.LABRESULT,c.CHRONIC 
FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159' or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST
LEFT JOIN hdc.clabtest_new ltn ON ltn.`code` = l.LABTEST  
left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('05','0531601') AND l.labresult NOT BETWEEN '0.01' AND '25' 
ORDER BY l.HOSPCODE) t
group by t.HOSPCODE,t.PID
order by t.CHRONIC


);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labfu_hba1c_not_standard_s;
CREATE TABLE labfu_hba1c_not_standard_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ตรวจ HbA1c ทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'นอกพิสัยที่เป็นไปได้ (0.01 - 25 )',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_hba1c_not_standard_s;

INSERT INTO labfu_hba1c_not_standard_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 

SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode ,nd.pid,IFNULL(st.y_cases,0) as y_cases, 
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent 
FROM (SELECT l.HOSPCODE,ch.hosname,ch.distcode ,COUNT(l.pid) as pid FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')  c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE 
where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('05', '0531601') 
GROUP BY l.HOSPCODE) nd 
LEFT JOIN (SELECT l.HOSPCODE,ch.hosname,COUNT(distinct l.pid) as y_cases FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('05', '0531601') AND l.labresult NOT BETWEEN '0.01' AND '25' 
GROUP BY l.HOSPCODE )as st on nd.hospcode=st.hospcode 
ORDER BY st.hospcode

);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labfu_hba1c_not_standard_a;
CREATE TABLE labfu_hba1c_not_standard_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ตรวจ HbA1c ทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'นอกพิสัยที่เป็นไปได้ (0.01 - 25 )',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_hba1c_not_standard_a;

INSERT INTO labfu_hba1c_not_standard_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid, 
IFNULL(st.y_cases,0) as y_cases, 
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent 
FROM (SELECT c.distcode,ca.ampurname,COUNT(l.pid) as pid FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic  WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
JOIN hdc.chospital c on c.hoscode=l.HOSPCODE 
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province 
where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('05', '0531601') 
GROUP BY c.distcode) nd 
left JOIN (SELECT ch.distcode,COUNT(distinct l.pid) as y_cases FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic  WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt on lt.id_labtest=l.LABTEST 
LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('05', '0531601') AND l.labresult NOT BETWEEN '0.01' AND '25' 
GROUP BY ch.distcode )as st on nd.distcode=st.distcode 
order by st.y_cases desc 


);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `labfu_ldl_not_standard`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labfu_ldl_not_standard`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labfu_ldl_not_standard`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS labfu_ldl_not_standard_t;
CREATE TABLE labfu_ldl_not_standard_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
HOSPCODE varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
PID VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
LABTEST VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'LDL',
date_serv date COMMENT 'วันที่รับบริการ',
LABRESULT varchar(5) NOT NULL DEFAULT '' COMMENT 'เอ๊ะผลตรวจผิดปกติ??',
CHRONIC varchar(50) NOT NULL DEFAULT '' COMMENT 'รหัสโรคเรื้อรัง',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_ldl_not_standard_t;

INSERT INTO labfu_ldl_not_standard_t
(
HOSPCODE,hosname,PID,fullname,LABTEST,date_serv,LABRESULT,CHRONIC
)

( 
select t.HOSPCODE,t.hosname,t.PID,t.fullname,t.LABTEST,t.DATE_SERV,t.LABRESULT,group_concat(distinct t.CHRONIC) as CHRONIC from
(SELECT l.HOSPCODE, ch.hosname,l.PID,concat(p.`NAME`,' ',p.LNAME)as fullname,if(l.LABTEST='09',lt.LABTEST,ltn.TH) AS LABTEST,l.DATE_SERV,l.LABRESULT,c.CHRONIC 
FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159' or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST
LEFT JOIN hdc.clabtest_new ltn ON ltn.`code` = l.LABTEST  
left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('09',' 0541402') AND l.labresult NOT BETWEEN '10' AND '400' 
ORDER BY l.HOSPCODE) t
group by t.HOSPCODE,t.PID
order by t.CHRONIC


);

################################################################################
#####################################  S_table   ###########################################
DROP TABLE IF EXISTS labfu_ldl_not_standard_s;
CREATE TABLE labfu_ldl_not_standard_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ตรวจ LDL ทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'นอกพิสัยที่ควรเป็นไปได้ (10 -400)',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_ldl_not_standard_s;

INSERT INTO labfu_ldl_not_standard_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode ,nd.pid AS total_pid,
IFNULL(st.y_cases,0) as y_cases,round((IFNULL(st.y_cases,0)/pid)*100,2) as percent 
FROM (
SELECT l.HOSPCODE, ch.hosname,ch.distcode,COUNT(l.pid) as pid
FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE  ,PID,CHRONIC FROM hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159' or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('09',' 0541402') 
GROUP BY l.HOSPCODE
ORDER BY ch.distcode,l.HOSPCODE) nd
LEFT JOIN (
select t.HOSPCODE,t.hosname,COUNT(t.pid) as y_cases  from
(SELECT l.HOSPCODE, ch.hosname,l.PID
FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159' or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('09',' 0541402') AND l.labresult NOT BETWEEN '10' AND '400' 
GROUP BY l.HOSPCODE,l.PID) t
group by t.HOSPCODE
)as st on nd.hospcode=st.hospcode 
ORDER BY st.hospcode
);
################################################################################
##############################  A_TABLE   ##################################################
DROP TABLE IF EXISTS labfu_ldl_not_standard_a;
CREATE TABLE labfu_ldl_not_standard_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ตรวจ LDL ทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'นอกพิสัยที่ควรเป็นไปได้ (10 -400)',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_ldl_not_standard_a;

INSERT INTO labfu_ldl_not_standard_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname as ampurname ,nd.pid AS total_pid,
IFNULL(st.y_cases,0) as y_cases,round((IFNULL(st.y_cases,0)/pid)*100,2) as percent 
FROM (
SELECT ch.distcode, ca.ampurname,COUNT(l.pid) as pid
FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE  ,PID,CHRONIC FROM hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159' or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = ch.distcode and ca.changwatcode=@province  
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('09',' 0541402') 
GROUP BY ch.distcode
ORDER BY ch.distcode) nd
LEFT JOIN (
select t.distcode, COUNT(t.pid) as y_cases  from
(SELECT l.HOSPCODE, ch.distcode,l.PID
FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159' or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('09',' 0541402') AND l.labresult NOT BETWEEN '10' AND '400' 
GROUP BY l.HOSPCODE,l.PID) t
group by t.distcode
)as st on nd.distcode=st.distcode 
order by st.y_cases desc
);
################################################################################
UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `labfu_microalbumin_not_standard`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labfu_microalbumin_not_standard`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labfu_microalbumin_not_standard`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS labfu_microalbumin_not_standard_t;
CREATE TABLE labfu_microalbumin_not_standard_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
labtest VARCHAR(120) NOT NULL DEFAULT '' COMMENT 'การเจาะตรวจmicroalbumin',
date_serv date COMMENT 'วันที่รับบริการ',
LABRESULT varchar(5) NOT NULL DEFAULT '' COMMENT 'ผลการตรวจmicroalbumin',
CHRONIC varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสโรคเรื้อรัง',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_microalbumin_not_standard_t;

INSERT INTO labfu_microalbumin_not_standard_t
(
hospcode,hosname,pid,fullname,labtest,date_serv,LABRESULT,CHRONIC
)

( 
SELECT l.HOSPCODE, ch.hosname,l.PID,concat(p.`NAME`,' ',p.LNAME)as fullname,if(l.LABTEST='12' OR l.LABTEST='14',lt.LABTEST,ltn.TH) AS LABTEST,l.DATE_SERV,l.LABRESULT,c.CHRONIC 
FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159'  or CHRONIC BETWEEN 'N18' AND  'N189'   and TYPEDISCH <>'02')  c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST 
LEFT JOIN hdc.clabtest_new ltn ON ltn.`code` = l.LABTEST  
left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('12', '14', '0440204', '0440203') AND l.labresult NOT IN ('0', '1', '2') 
ORDER BY l.HOSPCODE


);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labfu_microalbumin_not_standard_s;
CREATE TABLE labfu_microalbumin_not_standard_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ตรวจ microalbumin ทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_microalbumin_not_standard_s;

INSERT INTO labfu_microalbumin_not_standard_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode ,nd.pid,
IFNULL(st.y_cases,0) as y_cases,round((IFNULL(st.y_cases,0)/pid)*100,2) as percent 
FROM (SELECT l.HOSPCODE,ch.hosname,ch.distcode ,COUNT(l.pid) as pid FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')  c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE 
where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('12', '14', '0440204', '0440203') 
GROUP BY l.HOSPCODE) nd 
LEFT JOIN (SELECT l.HOSPCODE,ch.hosname,COUNT(l.pid) as y_cases FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('12', '14', '0440204', '0440203') AND l.labresult NOT IN ('0', '1', '2')  
GROUP BY l.HOSPCODE )as st on nd.hospcode=st.hospcode 
ORDER BY st.hospcode

);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labfu_microalbumin_not_standard_a;
CREATE TABLE labfu_microalbumin_not_standard_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ตรวจ microalbumin ทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_microalbumin_not_standard_a;

INSERT INTO labfu_microalbumin_not_standard_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid, 
IFNULL(st.y_cases,0) as y_cases, 
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent 
FROM (SELECT c.distcode,ca.ampurname,COUNT(l.pid) as pid FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic  WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
JOIN hdc.chospital c on c.hoscode=l.HOSPCODE 
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province 
where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('12', '14', '0440204', '0440203') 
GROUP BY c.distcode) nd 
left JOIN (SELECT ch.distcode,COUNT(l.pid) as y_cases FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic  WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I159'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt on lt.id_labtest=l.LABTEST 
LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE 
where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('12', '14', '0440204', '0440203') AND l.labresult NOT IN ('0', '1', '2') 
GROUP BY ch.distcode )as st on nd.distcode=st.distcode 
order by st.y_cases desc

);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `labor_bdate_not_as_newborn`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labor_bdate_not_as_newborn`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labor_bdate_not_as_newborn`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS labor_bdate_not_as_newborn_t;
CREATE TABLE labor_bdate_not_as_newborn_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
pid_mather varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคลแม่',
fullname1 varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล แม่',
hn_mather varchar(15) NOT NULL DEFAULT '' COMMENT 'HN แม่',
labor_gravida varchar(15) NOT NULL DEFAULT '' COMMENT 'ครรภ์ที่ Labor',
labor_bdate date COMMENT 'วันที่คลอด Labor',
pid_newborn varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคลลูก',
fullname2 varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล ลูก',
hn_newborn varchar(15) NOT NULL DEFAULT '' COMMENT 'HN ลูก',
newborn_gravida varchar(15) NOT NULL DEFAULT '' COMMENT 'ครรภ์ที่ Newborn',
newborn_bdate date COMMENT 'วันที่เกิด',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_bdate_not_as_newborn_t;

INSERT INTO labor_bdate_not_as_newborn_t
(
hospcode,pid_mather,fullname1,hn_mather,labor_gravida,labor_bdate,pid_newborn,fullname2,hn_newborn,newborn_gravida,newborn_bdate
)

( 
select l.hospcode,l.pid as pid_mather,concat(p1.`NAME`,' ',p1.LNAME)as fullname1,p1.hn as hn_mather,l.gravida as labor_gravida,l.bdate as labor_bdate , n.pid as pid_newborn,concat(p2.`NAME`,' ',p2.LNAME)as fullname2,p2.hn as hn_newborn ,n.gravida as newborn_gravida,n.bdate as newborn_bdate from hdc.labor l
left  join hdc.newborn n on l.hospcode=n.hospcode and l.pid=n.mpid 
LEFT JOIN hdc.person p1 on p1.pid=l.pid and p1.HOSPCODE=l.HOSPCODE
LEFT JOIN hdc.person p2 on p2.pid=n.pid and p2.HOSPCODE=n.HOSPCODE
where l.bdate BETWEEN @start_d AND @end_d  and n.bdate BETWEEN @start_d AND @end_d  and l.bdate<>n.bdate and timestampdiff(month,l.bdate,n.bdate ) between '-3' and '3' 
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labor_bdate_not_as_newborn_s;
CREATE TABLE labor_bdate_not_as_newborn_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_bdate_not_as_newborn_s;

INSERT INTO labor_bdate_not_as_newborn_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent
FROM
(select l.hospcode,count(l.pid) as pid from hdc.labor l
left  join hdc.newborn n on l.hospcode=n.hospcode and l.pid=n.mpid
where l.bdate BETWEEN @start_d AND @end_d  and n.bdate BETWEEN @start_d AND @end_d GROUP BY l.HOSPCODE) nd
LEFT JOIN
(select l.hospcode,count(l.pid) as y_cases from hdc.labor l
left  join hdc.newborn n on l.hospcode=n.hospcode and l.pid=n.mpid 
LEFT JOIN hdc.person p1 on p1.pid=l.pid and p1.HOSPCODE=l.HOSPCODE
LEFT JOIN hdc.person p2 on p2.pid=n.pid and p2.HOSPCODE=n.HOSPCODE
where l.bdate BETWEEN @start_d AND @end_d  and n.bdate BETWEEN @start_d AND @end_d  and l.bdate<>n.bdate and timestampdiff(month,l.bdate,n.bdate ) between '-3' and '3' 
GROUP BY l.HOSPCODE
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC    

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS labor_bdate_not_as_newborn_a;
CREATE TABLE labor_bdate_not_as_newborn_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_bdate_not_as_newborn_a;

INSERT INTO labor_bdate_not_as_newborn_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(select h.distcode,ca.ampurname,COUNT(l.pid) as pid from hdc.labor l
left  join hdc.newborn n on l.hospcode=n.hospcode and l.pid=n.mpid 
join hdc.chospital h on h.hoscode=l.hospcode
JOIN hdc.campur ca on ca.ampurcode = h.distcode and ca.changwatcode=@province
where l.bdate BETWEEN @start_d AND @end_d  and n.bdate BETWEEN @start_d AND @end_d GROUP BY h.distcode) nd
LEFT JOIN
(select ch.distcode,count(l.pid) as y_cases from hdc.labor l
left  join hdc.newborn n on l.hospcode=n.hospcode and l.pid=n.mpid 
LEFT JOIN hdc.person p1 on p1.pid=l.pid and p1.HOSPCODE=l.HOSPCODE
LEFT JOIN hdc.person p2 on p2.pid=n.pid and p2.HOSPCODE=n.HOSPCODE
LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE
where l.bdate BETWEEN @start_d AND @end_d  and n.bdate BETWEEN @start_d AND @end_d  and l.bdate<>n.bdate and timestampdiff(month,l.bdate,n.bdate ) between '-3' and '3' 
GROUP BY ch.distcode
)as st 
on nd.distcode=st.distcode
order by distcode 


);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `labor_future`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labor_future`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labor_future`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS labor_future_t;
CREATE TABLE labor_future_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
bdate VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'วันที่คลอด',
bplace VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'สถานที่คลอด',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_future_t;

INSERT INTO labor_future_t
(
hospcode,hosname,pid,fullname,bdate,bplace
)

( 
select l.hospcode,c.hosname,l.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,l.bdate,l.bhosp 
from hdc.labor l
left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid
left join hdc.chospital c on c.hoscode=l.HOSPCODE
where l.bdate >curdate()
AND l.bdate BETWEEN @start_d AND @end_d
order by l.hospcode
);



 #Routine body goes here...
DROP TABLE IF EXISTS labor_future_s;
CREATE TABLE labor_future_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_future_s;

INSERT INTO labor_future_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.labor 
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select l.hospcode,count(l.pid) as y_cases
from hdc.labor l
where l.bdate >curdate()
AND l.bdate BETWEEN @start_d AND @end_d
group by l.hospcode)as st
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.HOSPCODE
order by st.y_cases DESC

);


 #Routine body goes here...
DROP TABLE IF EXISTS labor_future_a;
CREATE TABLE labor_future_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_future_a;

INSERT INTO labor_future_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l
join hdc.chospital c on c.hoscode=l.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where l.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(l.pid) as y_cases
from hdc.labor l
join hdc.chospital c on c.hoscode=l.HOSPCODE
where l.bdate >curdate()
AND l.bdate BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `labor_noanc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labor_noanc`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labor_noanc`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS labor_noanc_t;
CREATE TABLE labor_noanc_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
bhosp VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'สถานที่คลอด',
bdate date COMMENT 'วันคลอด',
labor_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียน(labor)',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
anc_pid varchar(15)  COMMENT 'ทะเบียน(anc)',
nation varchar(3) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
typearea varchar(2) NOT NULL DEFAULT '' COMMENT 'TypeArea',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_noanc_t;

INSERT INTO labor_noanc_t
(
hospcode,hosname,bhosp,bdate,labor_pid,fullname,anc_pid,nation,typearea
)

( 

select p.hospcode,c.hosname,l.bhosp,l.bdate,l.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,a.pid,p.nation,p.typearea
from hdc.labor l
left outer join hdc.person p on p.pid=l.pid and p.hospcode=l.HOSPCODE
left outer join hdc.anc a on a.pid=p.pid and a.hospcode=p.HOSPCODE
left outer join hdc.chospital c on c.hoscode=l.hospcode
where p.typearea in ('1','3')and a.pid is null
AND l.bdate BETWEEN @start_d AND @end_d
order by p.hospcode desc 


);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labor_noanc_s;
CREATE TABLE labor_noanc_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_noanc_s;

INSERT INTO labor_noanc_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.labor 
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select p.hospcode,count(l.pid) as y_cases
from hdc.labor l
left outer join hdc.person p on p.pid=l.pid and p.hospcode=l.HOSPCODE
left outer join hdc.anc a on a.pid=p.pid and a.hospcode=p.HOSPCODE
where p.typearea in ('1','3')and a.pid is null
AND l.bdate BETWEEN @start_d AND @end_d
group by p.hospcode)as st
on nd.hospcode=st.hospcode
left outer join hdc.chospital c on c.hoscode=nd.hospcode
order by st.y_cases DESC

);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labor_noanc_a;
CREATE TABLE labor_noanc_a (

distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_noanc_a;

INSERT INTO labor_noanc_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l
join hdc.chospital c on c.hoscode=l.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where l.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(l.pid) as y_cases
from hdc.labor l
left outer join hdc.person p on p.pid=l.pid and p.hospcode=l.HOSPCODE
left outer join hdc.anc a on a.pid=p.pid and a.hospcode=p.HOSPCODE
join hdc.chospital c on c.hoscode=l.HOSPCODE
where p.typearea in ('1','3')and a.pid is null
AND l.bdate BETWEEN @start_d AND @end_d 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);



 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `labor_nonewborn`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labor_nonewborn`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labor_nonewborn`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS labor_nonewborn_t;
CREATE TABLE labor_nonewborn_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วย',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วย',
hn VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'HN แม่',
pid VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'PID แม่แฟ้ม Labor',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล แม่',
mpid VARCHAR(20) COMMENT 'PID แม่แฟ้ม Newborn',
bdate date COMMENT 'วันคลอด',
bhosp VARCHAR(7) NOT NULL DEFAULT '' COMMENT 'สถานที่คลอด',
typearea varchar(2) NOT NULL DEFAULT '' COMMENT 'TypeArea',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_nonewborn_t;

INSERT INTO labor_nonewborn_t
(
hospcode,hosname,hn,pid,fullname,mpid,bdate,bhosp,typearea
)

( 
select l.hospcode,c.hosname,p.hn,l.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,n.mpid,l.bdate,l.bhosp,p.typearea
from hdc.labor l
left outer join hdc.newborn n on n.hospcode=l.hospcode and n.mpid=l.pid
left outer join hdc.person p on p.pid=l.pid and l.hospcode=p.hospcode
left outer join hdc.chospital c on c.hoscode=l.hospcode
where n.mpid is null AND l.BTYPE <> 6
AND l.bdate BETWEEN @start_d AND @end_d  
order by l.hospcode

);




#################################

################################

 #Routine body goes here...
DROP TABLE IF EXISTS labor_nonewborn_s;
CREATE TABLE labor_nonewborn_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนข้อมูลคลอด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนไม่พบข้อมูลทารก',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละจำนวนวไม่พบข้อมูลทารก',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_nonewborn_s;

INSERT INTO labor_nonewborn_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 

SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.labor 
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select l.hospcode,count(l.pid) as y_cases
from hdc.labor l
left outer join hdc.newborn n on n.hospcode=l.hospcode and n.mpid=l.pid
left outer join hdc.person p on p.pid=l.pid and l.hospcode=p.hospcode
where n.mpid is null AND l.BTYPE <> 6
AND l.bdate BETWEEN @start_d AND @end_d  
group by l.hospcode)as st
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.hospcode
order by st.y_cases DESC

);




#################################


##################################

 #Routine body goes here...
DROP TABLE IF EXISTS labor_nonewborn_a;
CREATE TABLE labor_nonewborn_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนข้อมูลคลอด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ไม่พบข้อมูลทารก',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละจำนวนไม่พบข้อมูลทารก',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_nonewborn_a;

INSERT INTO labor_nonewborn_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l
join hdc.chospital c on c.hoscode=l.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where l.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(l.pid) as y_cases
from hdc.labor l
left outer join hdc.newborn n on n.hospcode=l.hospcode and n.mpid=l.pid
left outer join hdc.person p on p.pid=l.pid and l.hospcode=p.hospcode
join hdc.chospital c on c.hoscode=l.HOSPCODE
where n.mpid is null AND l.BTYPE <> 6
AND l.bdate BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `labor_noperson`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labor_noperson`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labor_noperson`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS labor_noperson_t;
CREATE TABLE labor_noperson_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'pid แฟ้ม labor',
person_pid VARCHAR(15) COMMENT 'pid แฟ้ม person',
bdate date COMMENT 'วันที่คลอด',
gravida VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ครรภ์ที่',
bresult VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'วินิจฉัยวิธีคลอด',
bhosp VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'สถานที่คลอด',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_noperson_t;

INSERT INTO labor_noperson_t
(
hospcode,hosname,pid,person_pid,bdate,gravida,bresult,bhosp
)

( 
select l.hospcode,c.hosname,l.pid,p.pid as person_pid,l.bdate,l.GRAVIDA,l.BRESULT,l.bhosp 
from hdc.labor l
left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid
LEFT JOIN hdc.chospital c on c.hoscode=l.HOSPCODE
where p.pid is null
AND l.bdate BETWEEN @start_d AND @end_d  and l.hospcode=l.bhosp
order by l.hospcode


);

#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labor_noperson_s;
CREATE TABLE labor_noperson_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_noperson_s;

INSERT INTO labor_noperson_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.labor 
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select l.hospcode,count(l.pid) as y_cases
from hdc.labor l
left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid
where p.pid is null
AND l.bdate BETWEEN @start_d AND @end_d  and l.hospcode=l.bhosp
group by l.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital c on c.hoscode=nd.HOSPCODE

);




#################################

################################

 #Routine body goes here...
DROP TABLE IF EXISTS labor_noperson_a;
CREATE TABLE labor_noperson_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_noperson_a;

INSERT INTO labor_noperson_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l
join hdc.chospital c on c.hoscode=l.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where l.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(l.pid) as y_cases
from hdc.labor l
left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid
join hdc.chospital c on c.hoscode=l.HOSPCODE
where p.pid is null
AND l.bdate BETWEEN @start_d AND @end_d   and l.hospcode=l.bhosp
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `labor_record`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labor_record`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labor_record`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS labor_record_t;
CREATE TABLE labor_record_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วย',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วย',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
hn VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'HN',
bdate date COMMENT 'วันคลอด',
bresult VARCHAR(6) NOT NULL DEFAULT '' COMMENT 'วินิจฉัยวิธีคลอด',
bhosp VARCHAR(7) COMMENT 'สถานที่คลอด',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_record_t;

INSERT INTO labor_record_t
(
hospcode,hosname,pid,fullname,hn,bdate,bresult,bhosp
)
( 
select l.hospcode,c.hosname,l.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.hn,l.bdate,l.bresult ,l.bhosp
from hdc.labor l
left join hdc.person p on p.pid=l.pid and p.hospcode=l.hospcode
left outer join hdc.chospital c on c.hoscode=p.hospcode
where l.bresult not in (SELECT id_bresult FROM hdc.cbresult)
AND l.bdate BETWEEN @start_d AND @end_d 
order by l.hospcode
);




#################################

#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labor_record_s;
CREATE TABLE labor_record_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_record_s;

INSERT INTO labor_record_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.labor
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select l.hospcode,count(l.pid) as y_cases
from hdc.labor l
left join hdc.person p on p.pid=l.pid and p.hospcode=l.hospcode
where l.bresult not in (SELECT id_bresult FROM hdc.cbresult)
AND l.bdate BETWEEN @start_d AND @end_d 
group by l.hospcode)as st
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.hospcode
order by st.y_cases DESC

);




#################################

################################

 #Routine body goes here...
DROP TABLE IF EXISTS labor_record_a;
CREATE TABLE labor_record_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labor_record_a;

INSERT INTO labor_record_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(l.pid) as pid FROM hdc.labor l
join hdc.chospital c on c.hoscode=l.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where l.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(l.pid) as y_cases
from hdc.labor l
left join hdc.person p on p.pid=l.pid and p.hospcode=l.hospcode
join hdc.chospital c on c.hoscode=l.HOSPCODE
where l.bresult not in (SELECT id_bresult FROM hdc.cbresult)
AND l.bdate BETWEEN @start_d AND @end_d   
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `macroalbumin`
-- ----------------------------
DROP PROCEDURE IF EXISTS `macroalbumin`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `macroalbumin`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS macroalbumin_t;
CREATE TABLE macroalbumin_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
labtest varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสการตรวจทางห้องปฏิบัติการ',
labresult varchar(15) NOT NULL DEFAULT '' COMMENT 'ผลของการตรวจทางห้องปฏิบัติการ',
date_serv date COMMENT 'วันที่รับบริการ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE macroalbumin_t;

INSERT INTO macroalbumin_t
(
hospcode,hosname,pid,fullname,labtest,labresult,date_serv
)

( 
select l.hospcode,c.hosname,l.PID,concat(p.`NAME`,' ',p.LNAME)as fullname,l.LABTEST,l.labresult,l.DATE_SERV
from hdc.labfu l
left join hdc.person p on p.hospcode=l.hospcode and p.pid=l.pid
LEFT JOIN hdc.chospital c on c.hoscode=l.HOSPCODE
where date_serv between @start_d AND @end_d 
and labtest in ('12','14') 
and labresult not in ('0','1','2')
ORDER BY l.HOSPCODE
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS macroalbumin_s;
CREATE TABLE macroalbumin_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE macroalbumin_s;

INSERT INTO macroalbumin_s
(
hospcode,hosname,distcode,total,y_cases,percent
)

( 
select t2.hospcode, h.hosname, concat(@province,h.distcode) as distcode  
,t2.total, IFNULL(t1.error,0) as y_cases, (IFNULL(t1.error,0)/t2.total)*100 as percent from 
(select hospcode, count(pid) as total
from hdc.labfu
where date_serv between @start_d AND @end_d 
and labtest in ('12','14')
group by hospcode) t2
LEFT JOIN
(select hospcode, count(pid) as error
from hdc.labfu
where date_serv between @start_d AND @end_d 
and labtest in ('12','14') 
and labresult not in ('0','1','2')
group by hospcode) t1 on t2.hospcode=t1.hospcode
left join hdc.chospital h on h.hoscode=t2.hospcode
order by t1.error

);


#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS macroalbumin_a;
CREATE TABLE macroalbumin_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE macroalbumin_a;

INSERT INTO macroalbumin_a
(
distcode,ampurname,total,y_cases,percent
)

( 

SELECT concat(@province,t2.distcode) as distcode,t2.ampurname,t2.total,
IFNULL(t1.error,0) as y_cases,
round((IFNULL(t1.error,0) /t2.total)*100,2) as percent
from 
(select c.distcode,ca.ampurname, count(pid) as total
from hdc.labfu l
join hdc.chospital c on c.hoscode=l.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where date_serv between @start_d AND @end_d 
and labtest in ('12','14')
group by c.distcode) t2 
LEFT JOIN
(select c.distcode,ca.ampurname, count(pid) as error
from hdc.labfu l
join hdc.chospital c on c.hoscode=l.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where date_serv between @start_d AND @end_d  
and labtest in ('12','14') 
and labresult not in ('0','1','2')
group by c.distcode) t1
on t1.distcode=t2.distcode
order by t1.error desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `ncdscreen_check`
-- ----------------------------
DROP PROCEDURE IF EXISTS `ncdscreen_check`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ncdscreen_check`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS ncdscreen_check_t;
CREATE TABLE ncdscreen_check_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
sbp_1 varchar(15) NOT NULL DEFAULT '' COMMENT 'ความดันโลหิตซิสโตลิก',
dbp_1 varchar(15) NOT NULL DEFAULT '' COMMENT 'ความดันโลหิตไดแอสโตลิก',
weight varchar(15) NOT NULL DEFAULT '' COMMENT 'น้ำหนัก',
height varchar(15) NOT NULL DEFAULT '' COMMENT 'ส่วนสูง',
waist_cm varchar(15) NOT NULL DEFAULT '' COMMENT 'เส้นรอบเอว',
bslevel varchar(15) NOT NULL DEFAULT '' COMMENT 'ระดับน้ำตาลในเลือด',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE ncdscreen_check_t;
INSERT INTO ncdscreen_check_t
(
hospcode,hosname,pid,fullname,date_serv,sbp_1,dbp_1,weight,height,waist_cm,bslevel
)
( 
select n.hospcode,c.hosname,n.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,n.date_serv,n.sbp_1,n.dbp_1,n.weight,n.height,n.waist_cm,n.bslevel 
from hdc.ncdscreen n
left join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid
left outer join hdc.chospital c on c.hoscode=n.HOSPCODE
where (n.sbp_1<=50 or n.dbp_1<=50)
AND n.date_serv BETWEEN @start_d AND @end_d
order by n.HOSPCODE 
);
#################################
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS ncdscreen_check_s;
CREATE TABLE ncdscreen_check_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE ncdscreen_check_s;
INSERT INTO ncdscreen_check_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)
( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.ncdscreen 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN 
(select n.hospcode, count(n.pid) as y_cases
from hdc.ncdscreen n
where (n.sbp_1<=50 or n.dbp_1<=50)
AND n.date_serv BETWEEN @start_d AND @end_d
group by n.hospcode
)as st 
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.HOSPCODE
order by st.y_cases desc
);
#################################
################################
 #Routine body goes here...
DROP TABLE IF EXISTS ncdscreen_check_a;
CREATE TABLE ncdscreen_check_a (
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE ncdscreen_check_a;
INSERT INTO ncdscreen_check_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.ncdscreen n
join hdc.chospital c on c.hoscode=n.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where n.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(n.pid) as y_cases
from hdc.ncdscreen n
join hdc.chospital c on c.hoscode=n.HOSPCODE
where (n.sbp_1<=50 or n.dbp_1<=50)
AND n.date_serv BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `ncdscreen_ht_false`
-- ----------------------------
DROP PROCEDURE IF EXISTS `ncdscreen_ht_false`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ncdscreen_ht_false`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS ncdscreen_ht_false_t;
CREATE TABLE ncdscreen_ht_false_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
hn varchar(15) NOT NULL DEFAULT '' COMMENT 'HN',
date_serv date COMMENT 'วันที่รับบริการ',
sbp_1 varchar(15) NOT NULL DEFAULT '' COMMENT 'ซิสโตลิกครั้งที่ 1',
dbp_1 varchar(15) NOT NULL DEFAULT '' COMMENT 'ไดแอสโตลิก ครั้งที่ 1',
sbp_2 varchar(15) NOT NULL DEFAULT '' COMMENT 'ซิสโตลิก ครั้งที่ 2',
dbp_2 varchar(15) NOT NULL DEFAULT '' COMMENT 'ไดแอสโตลิก ครั้งที่ 2',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE ncdscreen_ht_false_t;
INSERT INTO ncdscreen_ht_false_t
(
hospcode,hosname,pid,fullname,hn,date_serv,sbp_1,dbp_1,sbp_2,dbp_2
)
( 
select ch.hospcode,c.hosname,ch.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.hn,ch.DATE_SERV,ch.sbp_1,ch.dbp_1,ch.sbp_2,ch.dbp_2
FROM hdc.ncdscreen ch
LEFT JOIN hdc.person p on ch.HOSPCODE=p.HOSPCODE and ch.PID=p.PID
inner join hdc.chospital c on c.hoscode=ch.HOSPCODE
WHERE  ch.sbp_2 >0 and ch.dbp_2 >0 and (ch.sbp_1-dbp_1 <15 or ch.sbp_1-dbp_1 > 105  or ch.sbp_2-dbp_2 <15 or ch.sbp_2-dbp_2 > 105 )
AND ch.date_serv BETWEEN @start_d AND @end_d
group by ch.hospcode, ch.pid 
order by ch.hospcode
);
#################################
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS ncdscreen_ht_false_s;
CREATE TABLE ncdscreen_ht_false_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE ncdscreen_ht_false_s;
INSERT INTO ncdscreen_ht_false_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)
( 
SELECT s.hospcode,s.hosname,concat(@province,s.distcode) as distcode,s.pid AS total_pid,IFNULL(s.y_cases,0) as y_cases,
round((IFNULL(s.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT nd.hospcode,c.hosname,c.distcode as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.ncdscreen 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) AS nd
LEFT JOIN
(select ch.hospcode,count(ch.pid) as y_cases
FROM hdc.ncdscreen ch
WHERE ch.sbp_2 >0 and ch.dbp_2 >0 and (ch.sbp_1-dbp_1 <15 or ch.sbp_1-dbp_1 > 105  or ch.sbp_2-dbp_2 <15 or ch.sbp_2-dbp_2 > 105 )
and ch.date_serv BETWEEN @start_d AND @end_d
group by ch.hospcode
)as st 
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.HOSPCODE
order by st.y_cases desc
)AS s);
#################################
################################
 #Routine body goes here...
DROP TABLE IF EXISTS ncdscreen_ht_false_a;
CREATE TABLE ncdscreen_ht_false_a (
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
TRUNCATE TABLE ncdscreen_ht_false_a;
INSERT INTO ncdscreen_ht_false_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid AS total_pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(ch.pid) as pid FROM hdc.ncdscreen ch
join hdc.chospital c on c.hoscode=ch.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where ch.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(ch.pid) as y_cases
FROM hdc.ncdscreen ch
join hdc.chospital c on c.hoscode=ch.HOSPCODE
WHERE ch.sbp_2 >0 and ch.dbp_2 >0 and (ch.sbp_1-dbp_1 <15 or ch.sbp_1-dbp_1 > 105  or ch.sbp_2-dbp_2 <15 or ch.sbp_2-dbp_2 > 105 )
and ch.date_serv BETWEEN @start_d AND @end_d 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc
);
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `ncdscreen1_htdm_old`
-- ----------------------------
DROP PROCEDURE IF EXISTS `ncdscreen1_htdm_old`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ncdscreen1_htdm_old`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS ncdscreen1_htdm_old_t;
CREATE TABLE ncdscreen1_htdm_old_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
nation VARCHAR(3) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
typearea VARCHAR(1) NOT NULL DEFAULT '' COMMENT 'สถานะภาพการอยุ่อาศัย',
Screendate date COMMENT 'วันที่ตรวจ',
Dx_DM  VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'รหัสโรค DM',
Dx_HT  VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'รหัสโรค HT',
Hos_RegistHT  VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'วินิจฉัยครั้งแรก DM',
Hos_RegistDM  VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'วินิจฉัยครั้งแรก HT',
RegistHT date COMMENT 'วันที่ขึ้นทะเบียน HT',
RegistDM date COMMENT 'วันที่ขึ้นทะเบียน DM',
HT_dupdate datetime COMMENT 'วันที่ปรับปรุง HT',
DM_dupdate datetime COMMENT 'วันที่ปรับปรุง DM',
Person_dupdate datetime COMMENT 'วันที่ปรับปรุงทะเบียนบุคคล',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE ncdscreen1_htdm_old_t;

INSERT INTO ncdscreen1_htdm_old_t
(
hospcode,hosname,pid,fullname,nation,typearea,Screendate,Dx_HT,Dx_DM,Hos_RegistHT,Hos_RegistDM,RegistHT,RegistDM,HT_dupdate,DM_dupdate,Person_dupdate
)

( 

select n.hospcode ,ch.hosname,n.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.nation,p.typearea,n.DATE_SERV as Screendate,
pcht.chronic as Dx_HT,
pcdm.chronic as Dx_DM,
pcht.HOSP_DX as Hos_RegistHT,
pcdm.HOSP_DX as Hos_RegistDM,

pcht.DATE_DIAG as RegistHT,
pcdm.DATE_DIAG as RegistDM,
pcht.d_update as HT_dupdate,
pcdm.d_update as DM_dupdate,
p.D_UPDATE as Person_dupdate
from hdc.ncdscreen n
inner join hdc.chospital ch on ch.hoscode=n.HOSPCODE
inner join hdc.person p on p.pid=n.pid and p.hospcode=n.hospcode
LEFT JOIN (SELECT* from hdc.chronic where chronic  BETWEEN 'I10' and 'I159'  and TYPEDISCH ='03')  pcht on n.PID = pcht.PID and n.HOSPCODE = pcht.hospcode 
LEFT JOIN (SELECT* from hdc.chronic where chronic BETWEEN 'E10' and 'E149'  and TYPEDISCH ='03')  pcdm on n.PID = pcdm.PID and n.HOSPCODE = pcdm.hospcode 
where n.date_serv BETWEEN @start_d AND @end_d  and n.date_serv >=pcht.d_update  and n.date_serv >=pcdm.d_update
and (pcdm.CHRONIC between "E10" and "E149" and pcht.CHRONIC between "I10" and "I159")
order by n.hospcode desc

);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS ncdscreen1_htdm_old_s;
CREATE TABLE ncdscreen1_htdm_old_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE ncdscreen1_htdm_old_s;

INSERT INTO ncdscreen1_htdm_old_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.ncdscreen
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select n.hospcode,count(n.pid) as y_cases
from hdc.ncdscreen n
inner join hdc.person p on p.pid=n.pid and p.hospcode=n.hospcode
LEFT JOIN (SELECT* from hdc.chronic where chronic  BETWEEN 'I10' and 'I159'  and TYPEDISCH ='03')  pcht on n.PID = pcht.PID and n.HOSPCODE = pcht.hospcode 
LEFT JOIN (SELECT* from hdc.chronic where chronic BETWEEN 'E10' and 'E149'  and TYPEDISCH ='03')  pcdm on n.PID = pcdm.PID and n.HOSPCODE = pcdm.hospcode 
where n.date_serv BETWEEN @start_d AND @end_d  and n.date_serv >=pcht.d_update  and n.date_serv >=pcdm.d_update
and (pcdm.CHRONIC between "E10" and "E149" and pcht.CHRONIC between "I10" and "I159")
group by n.hospcode
)as st
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.HOSPCODE
order by st.y_cases DESC


);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS ncdscreen1_htdm_old_a;
CREATE TABLE ncdscreen1_htdm_old_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE ncdscreen1_htdm_old_a;

INSERT INTO ncdscreen1_htdm_old_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.ncdscreen n
join hdc.chospital c on c.hoscode=n.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where n.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select ch.distcode,count(n.pid) as y_cases
from hdc.ncdscreen n
inner join hdc.chospital ch on ch.hoscode=n.HOSPCODE
inner join hdc.person p on p.pid=n.pid and p.hospcode=n.hospcode
LEFT JOIN (SELECT* from hdc.chronic where chronic  BETWEEN 'I10' and 'I159'  and TYPEDISCH ='03')  pcht on n.PID = pcht.PID and n.HOSPCODE = pcht.hospcode 
LEFT JOIN (SELECT* from hdc.chronic where chronic BETWEEN 'E10' and 'E149'  and TYPEDISCH ='03')  pcdm on n.PID = pcdm.PID and n.HOSPCODE = pcdm.hospcode 
where n.date_serv BETWEEN @start_d AND @end_d  and n.date_serv >=pcht.d_update  and n.date_serv >=pcdm.d_update
and (pcdm.CHRONIC between "E10" and "E149" and pcht.CHRONIC between "I10" and "I159")
group by ch.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `newborn_admitweight`
-- ----------------------------
DROP PROCEDURE IF EXISTS `newborn_admitweight`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `newborn_admitweight`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS newborn_admitweight_t;
CREATE TABLE newborn_admitweight_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วย',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วย',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
datetime_admit date COMMENT 'วันรับเข้า รพ.',
datetime_disch date COMMENT 'วันจำหน่าย',
admitweight varchar(5) NOT NULL DEFAULT '' COMMENT 'น้ำหนักแรก',
#ps_name varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_admitweight_t;

INSERT INTO newborn_admitweight_t
(
hospcode,hosname,pid,fullname,datetime_admit,datetime_disch,admitweight
)

( 
select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,s.datetime_admit, s.datetime_disch, s.admitweight
from hdc.admission s
left join hdc.chospital h on h.hoscode=s.hospcode
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where s.datetime_disch BETWEEN @start_d AND @end_d 
and (s.admitweight > 200 or (timestampdiff(year,p.birth,s.datetime_admit) <= 1 and (s.admitweight is null or s.admitweight='' or s.admitweight=0)))
order by h.hoscode, p.pid, s.datetime_disch



);




#################################

#################################

 #Routine body goes here...
DROP TABLE IF EXISTS newborn_admitweight_s;
CREATE TABLE newborn_admitweight_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_admitweight_s;

INSERT INTO newborn_admitweight_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 

select t.hospcode,c.hosname,concat(@province,c.distcode) as distcode,pid,IFNULL(y_cases,0) as y_cases,
round((IFNULL(y_cases,0) /pid)*100,2) as percent
from
(select hospcode, count(pid) as pid from hdc.admission 
where datetime_disch BETWEEN @start_d AND @end_d group by hospcode) as t
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.admission s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where s.datetime_disch BETWEEN @start_d AND @end_d
and (s.admitweight > 200 or (timestampdiff(year,p.birth,s.datetime_admit) <= 1 and (s.admitweight is null or s.admitweight='' or s.admitweight=0)))
group by s.hospcode) as err on err.hospcode=t.hospcode
left join hdc.chospital c on c.hoscode=t.hospcode
ORDER BY err.y_cases DESC


);




#################################

#################################

 #Routine body goes here...
DROP TABLE IF EXISTS newborn_admitweight_a;
CREATE TABLE newborn_admitweight_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_admitweight_a;

INSERT INTO newborn_admitweight_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.admission s
join hdc.chospital c on c.hoscode=s.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.datetime_disch BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.admission s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital c on c.hoscode=s.HOSPCODE
where s.datetime_disch BETWEEN @start_d AND @end_d
and (s.admitweight > 200 or (timestampdiff(year,p.birth,s.datetime_admit) <= 1 and (s.admitweight is null or s.admitweight='' or s.admitweight=0)))  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `newborn_bweight`
-- ----------------------------
DROP PROCEDURE IF EXISTS `newborn_bweight`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `newborn_bweight`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS newborn_bweight_t;
CREATE TABLE newborn_bweight_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วย',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วย',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
gravida varchar(2) NOT NULL DEFAULT '' COMMENT 'ครรภ์ที่',
ga varchar(3) NOT NULL DEFAULT '' COMMENT 'อายุครรภ์',
bweight varchar(7) NOT NULL DEFAULT '' COMMENT 'น้ำหนักแรก',
BHOSP varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสรพ.ที่คลอด',
btype varchar(3) NOT NULL DEFAULT '' COMMENT 'วิธีคลอด',
bdate varchar(15) NOT NULL DEFAULT '' COMMENT 'วันที่คลอด',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_bweight_t;

INSERT INTO newborn_bweight_t
(
hospcode,hosname,pid,fullname,gravida,ga,bweight,BHOSP,btype,bdate
)

( 

select n.hospcode,c.hosname,n.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,n.gravida,n.ga,n.bweight,n.BHOSP,n.btype,n.bdate
from hdc.newborn n
left join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid
left outer join hdc.chospital c on c.hoscode=n.HOSPCODE
where (bweight < 1000 or bweight > 4500)
AND bdate BETWEEN @start_d AND @end_d
order by hospcode

);




#################################

#################################


 #Routine body goes here...
DROP TABLE IF EXISTS newborn_bweight_s;
CREATE TABLE newborn_bweight_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_bweight_s;

INSERT INTO newborn_bweight_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 

SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.newborn 
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select n.hospcode,count(n.pid) as y_cases
from hdc.newborn n
where (bweight < 1000 or bweight > 4500)
and bdate BETWEEN @start_d AND @end_d
group by n.hospcode)as st
on nd.hospcode=st.hospcode
left outer join hdc.chospital c on c.hoscode=nd.HOSPCODE
order by st.y_cases DESC

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS newborn_bweight_a;
CREATE TABLE newborn_bweight_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทารก',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนน้ำหนักผิดปกติ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_bweight_a;

INSERT INTO newborn_bweight_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.newborn n
join hdc.chospital c on c.hoscode=n.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where n.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(n.pid) as y_cases
from hdc.newborn n
join hdc.chospital c on c.hoscode=n.HOSPCODE
where (bweight < 1000 or bweight > 4500)
and n.bdate BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);



 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `newborn_noperson`
-- ----------------------------
DROP PROCEDURE IF EXISTS `newborn_noperson`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `newborn_noperson`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################

 #Routine body goes here...
DROP TABLE IF EXISTS newborn_noperson_t;
CREATE TABLE newborn_noperson_t (
id int(5) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'pid แฟ้ม newborn',
person_pid VARCHAR(15)  COMMENT 'pid แฟ้ม person',
BDATE date COMMENT 'วันคลอด',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_noperson_t;

INSERT INTO newborn_noperson_t
(
hospcode,hosname,pid,person_pid,bdate
)

( 
select n.hospcode,c.hosname,n.PID,p.pid as person_pid,n.BDATE
from hdc.newborn n
LEFT JOIN hdc.chospital c on c.hoscode=n.HOSPCODE
left join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid
where p.pid is null AND n.bdate BETWEEN @start_d AND @end_d
order by n.hospcode
);




#################################


###################################

 #Routine body goes here...
DROP TABLE IF EXISTS newborn_noperson_s;
CREATE TABLE newborn_noperson_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_noperson_s;

INSERT INTO newborn_noperson_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.newborn 
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select n.hospcode,count(n.pid) as y_cases
from hdc.newborn n
left join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid
where p.pid is null AND n.bdate BETWEEN @start_d AND @end_d
GROUP BY n.hospcode)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital c on c.hoscode=nd.HOSPCODE
order by st.y_cases DESC
);




#################################

################################

 #Routine body goes here...
DROP TABLE IF EXISTS newborn_noperson_a;
CREATE TABLE newborn_noperson_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_noperson_a;

INSERT INTO newborn_noperson_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.newborn n
join hdc.chospital c on c.hoscode=n.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where n.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(n.pid) as y_cases
from hdc.newborn n
left join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid
join hdc.chospital c on c.hoscode=n.HOSPCODE
where p.pid is null AND n.bdate BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `newborncare_before`
-- ----------------------------
DROP PROCEDURE IF EXISTS `newborncare_before`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `newborncare_before`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS newborncare_before_t;
CREATE TABLE newborncare_before_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
nation VARCHAR(3) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
bcare date COMMENT 'วันที่ดูแลลูก',
bdate date COMMENT 'วันที่เกิด',
bcplace VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'สถานที่ดูแลลูก',
typearea varchar(5) NOT NULL DEFAULT '' COMMENT 'typearea',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborncare_before_t;

INSERT INTO newborncare_before_t
(
hospcode,hosname,pid,fullname,nation,bcare,bdate,bcplace,typearea
)

( 

select c.hoscode,c.hosname,p.pid,concat(pe.`NAME`,' ',pe.LNAME)as fullname,pe.nation,p.BCARE,p.bdate,p.BCPLACE,pe.typearea
from hdc.newborncare p
left outer join hdc.person pe on pe.pid=p.pid and pe.hospcode=p.hospcode 
left outer join hdc.chospital c on c.hoscode=p.HOSPCODE
where p.BCARE <=p.BDATE
AND p.bdate BETWEEN @start_d AND @end_d    
order by c.hoscode
);

###############################################3

DROP TABLE IF EXISTS newborncare_before_s;
CREATE TABLE newborncare_before_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborncare_before_s;

INSERT INTO newborncare_before_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.newborncare 
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select p.hospcode,count(p.pid) as y_cases
from hdc.newborncare p
left outer join hdc.person pe on pe.pid=p.pid and pe.hospcode=p.hospcode
where p.BCARE <=p.BDATE
AND p.bdate BETWEEN @start_d AND @end_d
group by p.hospcode
)as st 
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.HOSPCODE
ORDER BY st.y_cases DESC


);

##########################################33

DROP TABLE IF EXISTS newborncare_before_a;
CREATE TABLE newborncare_before_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborncare_before_a;

INSERT INTO newborncare_before_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.newborncare n
join hdc.chospital c on c.hoscode=n.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where n.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(n.pid) as y_cases
from hdc.newborncare n
left outer join hdc.person pe on pe.pid=n.pid and pe.hospcode=n.hospcode
join hdc.chospital c on c.hoscode=n.HOSPCODE
where n.BCARE <=n.BDATE
AND n.bdate BETWEEN @start_d AND @end_d 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `newborncare_falseresult`
-- ----------------------------
DROP PROCEDURE IF EXISTS `newborncare_falseresult`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `newborncare_falseresult`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS newborncare_falseresult_t;
CREATE TABLE newborncare_falseresult_t (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
TYPEAREA varchar(1) NOT NULL DEFAULT '' COMMENT 'TYPEAREA',
BDATE date COMMENT 'วันที่ทารกเกิด',
bcare date COMMENT 'วันที่เยี่ยมทารก',
bcareresult varchar(15)  COMMENT 'ผลการเยี่ยมทารกหลังคลอด',
BCPLACE varchar(15)  COMMENT 'หน่วยบริการที่เยี่ยม',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborncare_falseresult_t;

INSERT INTO newborncare_falseresult_t
(
hospcode,hosname,PID,fullname,TYPEAREA,BDATE,bcare,bcareresult,BCPLACE
)

( 
select n.hospcode,c.hosname,n.PID,concat(pe.`NAME`,' ',pe.LNAME)as fullname,pe.TYPEAREA,n.BDATE,n.bcare,n.bcareresult,n.BCPLACE from hdc.newborncare  n
left outer join hdc.person pe on pe.pid=n.pid and pe.hospcode=n.hospcode 
left outer join hdc.chospital c on c.hoscode=n.HOSPCODE
where n.bdate BETWEEN @start_d AND @end_d  and n.bcareresult not in (1,2) and n.hospcode=n.bcplace
order by n.hospcode



);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS newborncare_falseresult_s;
CREATE TABLE newborncare_falseresult_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'เยี่ยมทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'มีผลการเยี่ยมที่ผิดปกติ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborncare_falseresult_s;

INSERT INTO newborncare_falseresult_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid,c.hosname,c.distcode from hdc.newborncare n
left outer join hdc.chospital c on c.hoscode=n.HOSPCODE
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN 
(select n.hospcode,count(n.pid) as y_cases from hdc.newborncare  n
left outer join hdc.person pe on pe.pid=n.pid and pe.hospcode=n.hospcode 
left outer join hdc.chospital c on c.hoscode=n.HOSPCODE
where n.bdate BETWEEN @start_d AND @end_d  and n.bcareresult not in (1,2) and n.hospcode=n.bcplace
group by n.hospcode)as st
on nd.hospcode=st.hospcode
order by st.y_cases DESC
);




#################################   

 #Routine body goes here...
DROP TABLE IF EXISTS newborncare_falseresult_a;
CREATE TABLE newborncare_falseresult_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'เยี่ยมทั้งหมด',
y_abnormal VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'มีผลการเยี่ยมที่ผิดปกติ',
percent VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ร้อยละ',

PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborncare_falseresult_a;

INSERT INTO newborncare_falseresult_a
(
distcode,ampurname,total_pid,y_abnormal,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(n.pid) as pid FROM hdc.newborncare  n
join hdc.chospital c on c.hoscode=n.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where n.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(n.pid) as y_cases
from hdc.newborncare  n
left outer join hdc.person pe on pe.pid=n.pid and pe.hospcode=n.hospcode 
left outer join hdc.chospital c on c.hoscode=n.HOSPCODE
where n.bdate BETWEEN @start_d AND @end_d  and n.bcareresult not in (1,2) and n.hospcode=n.bcplace
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `newborncare_food`
-- ----------------------------
DROP PROCEDURE IF EXISTS `newborncare_food`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `newborncare_food`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS newborncare_food_t;
CREATE TABLE newborncare_food_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
bmonth varchar(5) NOT NULL DEFAULT '' COMMENT 'อายุเดือน',
breast varchar(5) NOT NULL DEFAULT '' COMMENT 'นมแม่',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborncare_food_t;

INSERT INTO newborncare_food_t
(
hospcode,hosname,pid,fullname,date_serv,bmonth,breast
)

( 

select n.hospcode,c.hosname,n.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,n.DATE_SERV,
TIMESTAMPDIFF(month,p.birth,CURDATE()) AS month,
(case when food =1 then 1 else 0 end) as breast
from hdc.nutrition n
left outer join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid
left outer join hdc.chospital c on c.hoscode=n.HOSPCODE
where n.DATE_SERV BETWEEN @start_d AND @end_d
and TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > '6' 
and FOOD='1'
order by n.HOSPCODE  

);



###############################

DROP TABLE IF EXISTS newborncare_food_s;
CREATE TABLE newborncare_food_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ดื่มนมแม่',

percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborncare_food_s;

INSERT INTO newborncare_food_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
select n.hospcode,c.hosname,concat(@province,c.distcode) as distcode,
count( concat(n.hospcode,n.pid))as total_pid,
sum(case when food =1 and TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > '6' then 1 else 0 end) as y_cases,
round((sum(case when food =1 and TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > '6' then 1 else 0 end)/count( concat(n.hospcode,n.pid)))*100,2) as percent
from hdc.nutrition n
left outer join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid
left outer join hdc.chospital c on c.hoscode=n.HOSPCODE
where n.DATE_SERV BETWEEN @start_d AND @end_d
and TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > '6' 
group by n.HOSPCODE
order by y_cases desc  
#ORDER BY st.y_cases DESC

);



######################################################

DROP TABLE IF EXISTS newborncare_food_a;
CREATE TABLE newborncare_food_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborncare_food_a;

INSERT INTO newborncare_food_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

select concat(@province,c.distcode) as distcode,ca.ampurname, 
count( concat(n.hospcode,n.pid))as total_pid,
sum(case when food =1 and TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > '6' then 1 else 0 end)as y_cases, 
round((sum(case when food =1 and TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > '6' then 1 else 0 end)/count( concat(n.hospcode,n.pid)))*100,2) as percent
from hdc.nutrition n
left outer join hdc.person p on p.hospcode=n.hospcode and p.pid=n.pid
JOIN hdc.chospital c on c.hoscode=n.HOSPCODE
JOIN hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province 
where n.DATE_SERV BETWEEN @start_d AND @end_d
and TIMESTAMPDIFF(MONTH,p.BIRTH,n.DATE_SERV) > '6' 
group by c.distcode
order by y_cases desc 

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `person_age100`
-- ----------------------------
DROP PROCEDURE IF EXISTS `person_age100`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `person_age100`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS person_age100_t;
CREATE TABLE person_age100_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
birth date COMMENT 'วันเกิด',
age VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'อายุ',
nation varchar(10) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
typearea varchar(2) NOT NULL DEFAULT '' COMMENT 'TYPE AREA',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_age100_t;

INSERT INTO person_age100_t
(
hospcode,hosname,pid,fullname,birth,age,nation,typearea
)

( 

select hospcode,c.hosname,p.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,birth,
TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) AS age,
NATION,TYPEAREA
from hdc.person p
left join hdc.chospital c on c.hoscode=p.HOSPCODE
where discharge='9' and typearea in ('1','3')
AND TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) > 100

);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_age100_s;
CREATE TABLE person_age100_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_age100_s;

INSERT INTO person_age100_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode ,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.person GROUP BY HOSPCODE) nd
LEFT JOIN
(select hospcode,birth,count(p.PID) as y_cases,
TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) AS age,
NATION,TYPEAREA
from hdc.person p
where discharge='9' and typearea in ('1','3')
AND TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) > 100
group by p.hospcode) as st
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.HOSPCODE
ORDER BY st.hospcode DESC



);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_age100_a;
CREATE TABLE person_age100_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_age100_a;

INSERT INTO person_age100_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p
join hdc.chospital c on c.hoscode=p.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(p.pid) as y_cases
from hdc.person p
join hdc.chospital c on c.hoscode=p.HOSPCODE
where discharge='9' and typearea in ('1','3')
AND TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) > 100
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);



 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `person_double`
-- ----------------------------
DROP PROCEDURE IF EXISTS `person_double`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `person_double`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS person_double_t;
CREATE TABLE person_double_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',

hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ1',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล1',
name varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อบุคคล1',
typearea VARCHAR(3) NOT NULL DEFAULT '' COMMENT 'TYPE AREA 1',
D_UPDATE1 datetime COMMENT 'วันที่ปรับปรุง1',
hospcode2 varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ2',
pid2 VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล2',
name2 varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อบุคคล2',
typearea2 VARCHAR(3) NOT NULL DEFAULT '' COMMENT 'TYPE AREA 2',
D_UPDATE2 datetime COMMENT 'วันที่ปรับปรุง2',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_double_t;

INSERT INTO person_double_t
(
hospcode,pid,name,typearea,D_UPDATE1,hospcode2,pid2,name2,typearea2,D_UPDATE2
)

( 

select h1.hoscode,p1.pid,concat(p1.name,' ',p1.lname) as name1,
p1.typearea ,p1.D_UPDATE,h2.hoscode, p2.pid,
concat(p2.name,' ',p2.lname)as name2, p2.typearea ,p2.D_UPDATE
from hdc.person p1 
left outer join  hdc.person p2 on p2.cid=p1.cid and  p1.hospcode <> p2.hospcode and p2.typearea in ('1', '3')  
left outer join hdc.chospital h1 on p1.hospcode=h1.hoscode
left outer join hdc.chospital h2 on p2.hospcode=h2.hoscode
where p1.discharge = '9' and p1.typearea in ('1', '3') and p2.cid is not null 
and (p1.nation ='099' or p2.nation ='099')
order by p1.hospcode




);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS person_double_s;
CREATE TABLE person_double_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(9) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_double_s;

INSERT INTO person_double_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.person 
where TYPEAREA in (1,3) and NATION='099' and discharge<>'1' and cid is not null
GROUP BY HOSPCODE) nd
LEFT JOIN
(select p1.hospcode ,count(p1.pid) as y_cases
from hdc.person p1 
left outer join  hdc.person p2 on p2.cid=p1.cid and  p1.hospcode <> p2.hospcode and p2.typearea in ('1', '3')  
left outer join hdc.chospital h1 on p1.hospcode=h1.hoscode
left outer join hdc.chospital h2 on p2.hospcode=h2.hoscode
where p1.discharge = '9'  and p1.typearea in ('1', '3') and p2.cid is not null 
and (p1.nation ='099' or p2.nation ='099')
group by p1.hospcode)as st
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.hospcode
order by st.y_cases DESC
);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS person_double_a;
CREATE TABLE person_double_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_double_a;

INSERT INTO person_double_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p
join hdc.chospital c on c.hoscode=p.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where TYPEAREA in (1,3) and NATION='099' and discharge<>'1' and cid is not null
GROUP BY c.distcode) nd
left JOIN 
(select h1.distcode,count(p1.pid) as y_cases
from hdc.person p1
left outer join  hdc.person p2 on p2.cid=p1.cid and  p1.hospcode <> p2.hospcode and p2.typearea in ('1', '3')  
left outer join hdc.chospital h1 on p1.hospcode=h1.hoscode
left outer join hdc.chospital h2 on p2.hospcode=h2.hoscode
where p1.discharge = '9' and p1.typearea in ('1', '3') and p2.cid is not null 
and (p1.nation ='099' or p2.nation ='099')
#AND p1.D_UPDATE BETWEEN @start_d AND @end_d  
group by h1.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `person_falsesex`
-- ----------------------------
DROP PROCEDURE IF EXISTS `person_falsesex`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `person_falsesex`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
##copy คำสั่งรัน 3 59process จังหวัดท่านมาใส่ในช่วงนี้##
#SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
#SET @b_year:= YEAR(CURRENT_TIMESTAMP);
#SET @start_d:=concat(@b_year-1,'1001');
#SET @end_d:=concat(@b_year,'0930');

#############################################################
DROP TABLE IF EXISTS tmp_person_falsesex_t;
CREATE TABLE tmp_person_falsesex_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
cid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'เลขที่บัตรประชาชน',
pprename VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'คำนำหน้า',
cprename VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'คำนำหน้า',
fullname VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'ชื่อนามสกุล',
sex VARCHAR(1) NOT NULL DEFAULT '' COMMENT 'เพศ',
typearea varchar(5) NOT NULL DEFAULT '' COMMENT 'สถานะบุคคล',
d_update varchar(15) NOT NULL DEFAULT '' COMMENT 'วันเดือนปีที่ปรับปรุงข้อมูล',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE tmp_person_falsesex_t;

INSERT INTO tmp_person_falsesex_t
(
hospcode,hosname,pid,cid,pprename,cprename,fullname,sex,typearea,d_update
)

( 
select hospcode,ch.hosname,pid,cid,p.prename,c.prename,concat(p.NAME,' ', p.lname)AS fullname,sex,typearea,d_update from hdc.person p
left join hdc.cprename c on c.id_prename=p.PRENAME
left join hdc.chospital ch on ch.hoscode=p.hospcode
where nation ='099' AND ((p.prename in ('001','003')) OR ((p.prename like '7%' or p.prename like '8%' or p.prename like '9%') and p.prename <>'863'))
group by hospcode,pid


);
#############################################################


 #Routine body goes here...
DROP TABLE IF EXISTS person_falsesex_t;
CREATE TABLE person_falsesex_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
cid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'เลขที่บัตรประชาชน',
pprename VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'คำนำหน้า',
cprename VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'คำนำหน้า',
fullname VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'ชื่อนามสกุล',
sex VARCHAR(1) NOT NULL DEFAULT '' COMMENT 'เพศ',
typearea varchar(5) NOT NULL DEFAULT '' COMMENT 'สถานะบุคคล',
d_update varchar(15) NOT NULL DEFAULT '' COMMENT 'วันเดือนปีที่ปรับปรุงข้อมูล',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_falsesex_t;

INSERT INTO person_falsesex_t
(
hospcode,hosname,pid,cid,pprename,cprename,fullname,sex,typearea,d_update
)

( 
select hospcode,ch.hosname,pid,cid,p.prename,c.prename,concat(p.NAME,' ', p.lname)AS fullname,sex,typearea,d_update from hdc.person p
left join hdc.cprename c on c.id_prename=p.PRENAME
left join hdc.chospital ch on ch.hoscode=p.hospcode
where nation ='099' and sex <>'1' AND ((p.prename in ('001','003')) OR ((p.prename like '7%' or p.prename like '8%' or p.prename like '9%') and p.prename <>'863'))
group by hospcode,pid

);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_falsesex_s;
CREATE TABLE person_falsesex_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนข้อผิดพลาด',
percent VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละข้อผิดพลาด',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_falsesex_s;

INSERT INTO person_falsesex_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode ,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /nd.pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from tmp_person_falsesex_t 
GROUP BY HOSPCODE) AS nd
LEFT JOIN
(select hospcode,count(pid) as y_cases from person_falsesex_t
group by hospcode)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
ORDER BY st.y_cases DESC


);



#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_falsesex_a;
CREATE TABLE person_falsesex_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(10) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนข้อผิดพลาด',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละข้อผิดพลาด',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_falsesex_a;

INSERT INTO person_falsesex_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT s.distcode,ca.ampurname,
SUM(s.total_pid) AS total_pid,
IFNULL(SUM(s.y_cases),0) AS y_cases,
round((IFNULL(SUM(s.y_cases),0) /SUM(s.total_pid))*100,2) AS percent
FROM person_falsesex_s s
LEFT JOIN hdc.campur ca ON ca.ampurcodefull = s.distcode AND ca.changwatcode=@province
GROUP BY s.distcode
ORDER BY y_cases DESC

);




#################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `person_lnamenothai`
-- ----------------------------
DROP PROCEDURE IF EXISTS `person_lnamenothai`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `person_lnamenothai`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS person_lnamenothai_t;
CREATE TABLE person_lnamenothai_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
cid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'เลขประจำตัว',
name varchar(5) NOT NULL DEFAULT '' COMMENT 'ชื่อ',
lname varchar(5) NOT NULL DEFAULT '' COMMENT 'สกุล',
nation varchar(20) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
typearea varchar(5) NOT NULL DEFAULT '' COMMENT 'TYPE AREA',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_lnamenothai_t;

INSERT INTO person_lnamenothai_t
(
hospcode,hosname,cid,name,lname,nation,typearea
)

( 
select p.hospcode,c.hosname,p.cid,p.`NAME`,p.lname,p.nation,p.typearea 
from hdc.service s
left outer join hdc.chospital c on c.hoscode=s.hospcode
inner join hdc.person p on p.pid=s.pid and s.hospcode=p.hospcode
where (p.cid like '07%' or p.cid like '007%') 
and p.nation='099'  
and ( p.lname like 'เขมร%' or p.lname like 'พม่%' or p.lname like 'กะ%' or p.lname like 'ลา%' )and p.race='099' 
and p.TYPEAREA in ('1','3')
order by p.hospcode desc


);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS person_lnamenothai_s;
CREATE TABLE person_lnamenothai_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(9) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_lnamenothai_s;

INSERT INTO person_lnamenothai_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode ,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.person GROUP BY HOSPCODE) nd
LEFT JOIN
(select p.hospcode,count(p.cid) as y_cases
from hdc.service s
inner join hdc.person p on p.pid=s.pid and s.hospcode=p.hospcode
where (p.cid like '07%' or p.cid like '007%') 
and p.nation='099'  
and ( p.lname like 'เขมร%' or p.lname like 'พม่%' or p.lname like 'กะ%' or p.lname like 'ลา%' )and p.race='099' 
and p.TYPEAREA in ('1','3')
group by p.hospcode
)as st
on nd.hospcode=st.hospcode
left outer join hdc.chospital c on c.hoscode=nd.hospcode
ORDER BY st.hospcode



);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_lnamenothai_a;
CREATE TABLE person_lnamenothai_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_lnamenothai_a;

INSERT INTO person_lnamenothai_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p
join hdc.chospital c on c.hoscode=p.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(p.cid) as y_cases
from hdc.service s
join hdc.chospital c on c.hoscode=s.HOSPCODE
inner join hdc.person p on p.pid=s.pid and s.hospcode=p.hospcode
where (p.cid like '07%' or p.cid like '007%') 
and p.nation='099'  
and ( p.lname like 'เขมร%' or p.lname like 'พม่%' or p.lname like 'กะ%' or p.lname like 'ลา%' )and p.race='099' 
and p.TYPEAREA in ('1','3') 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `person_nocid_13`
-- ----------------------------
DROP PROCEDURE IF EXISTS `person_nocid_13`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `person_nocid_13`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
#############################################################
DROP TABLE IF EXISTS tmp_person_nocid_13_t;
CREATE TABLE tmp_person_nocid_13_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
cid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'เลขที่บัตรประชาชน',
fullname VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'ชื่อนามสกุล',
nation varchar(5) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
typearea varchar(5) NOT NULL DEFAULT '' COMMENT 'TYPE AREA',
discharge varchar(1) NOT NULL DEFAULT '' COMMENT 'สถานะการจำหน่าย',
d_update varchar(15) NOT NULL DEFAULT '' COMMENT 'วันเดือนปีที่ปรับปรุงข้อมูล',
total_service varchar(5) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้งที่มารับบริการ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE tmp_person_nocid_13_t;

INSERT INTO tmp_person_nocid_13_t
(
hospcode,hosname,pid,cid,fullname,nation,typearea,discharge,d_update,total_service
)

( 
select p.hospcode,c.hosname,p.pid,p.cid,concat(p.NAME,' ',p.lname)AS fullname,nation,typearea,p.discharge,p.d_update,count(distinct s.seq) as total_service  from hdc.person p
left join hdc.service s on s.hospcode=p.hospcode and s.pid=p.pid
left join hdc.chospital c on c.hoscode=p.hospcode
where s.date_serv BETWEEN @start_d AND @end_d and p.discharge='9' and p.nation='099'
group by p.hospcode,p.cid
order by p.hospcode


);
#############################################################


 #Routine body goes here...
DROP TABLE IF EXISTS person_nocid_13_t;
CREATE TABLE person_nocid_13_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
cid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'เลขที่บัตรประชาชน',
fullname VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'ชื่อนามสกุล',
nation varchar(5) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
typearea varchar(5) NOT NULL DEFAULT '' COMMENT 'สถานะบุคคล',
discharge varchar(1) NOT NULL DEFAULT '' COMMENT 'สถานะการจำหน่าย',
d_update varchar(15) NOT NULL DEFAULT '' COMMENT 'วันเดือนปีที่ปรับปรุงข้อมูล',
total_service varchar(5) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้งที่มารับบริการ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_nocid_13_t;

INSERT INTO person_nocid_13_t
(
hospcode,hosname,pid,cid,fullname,nation,typearea,discharge,d_update,total_service
)

( 
select p.hospcode,c.hosname,p.pid,p.cid,concat(p.NAME,' ',p.lname)AS fullname,nation,typearea,p.discharge,p.d_update,count(distinct s.seq) as total_service  from hdc.person p
left join hdc.service s on s.hospcode=p.hospcode and s.pid=p.pid
left join hdc.chospital c on c.hoscode=p.hospcode
where s.date_serv BETWEEN @start_d AND @end_d and p.discharge='9' and p.nation='099' and ((length(p.cid) <13) OR (p.typearea in ('1','3')and p.cid like '0%'))
group by p.hospcode,p.cid
order by p.hospcode


);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_nocid_13_s;
CREATE TABLE person_nocid_13_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_cid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนข้อผิดพลาด',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละข้อผิดพลาด',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_nocid_13_s;

INSERT INTO person_nocid_13_s
(
hospcode,hosname,distcode,total_cid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode ,nd.cid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /nd.cid)*100,2) as percent
FROM
(SELECT hospcode,count(cid) as cid from tmp_person_nocid_13_t 
GROUP BY HOSPCODE) AS nd
LEFT JOIN
(select hospcode,count(cid) as y_cases from person_nocid_13_t
group by hospcode)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
ORDER BY st.y_cases DESC


);



#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_nocid_13_a;
CREATE TABLE person_nocid_13_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_cid varchar(10) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนข้อผิดพลาด',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละข้อผิดพลาด',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_nocid_13_a;

INSERT INTO person_nocid_13_a
(
distcode,ampurname,total_cid,y_cases,percent
)

( 

SELECT s.distcode,ca.ampurname,
SUM(s.total_cid) AS total_cid,
IFNULL(SUM(s.y_cases),0) AS y_cases,
round((IFNULL(SUM(s.y_cases),0) /SUM(s.total_cid))*100,2) AS percent
FROM person_nocid_13_s s
LEFT JOIN hdc.campur ca ON ca.ampurcodefull = s.distcode AND ca.changwatcode=@province
GROUP BY s.distcode
ORDER BY y_cases DESC

);




#################################
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `person_nodeath`
-- ----------------------------
DROP PROCEDURE IF EXISTS `person_nodeath`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `person_nodeath`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS person_nodeath_t;
CREATE TABLE person_nodeath_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
hn VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'HN',
death_input varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการที่บันทึกตาย',
ddeath date COMMENT 'วันเสียชีวิต',
cdeath_a varchar(5) NOT NULL DEFAULT '' COMMENT 'วินิจฉัย',
hospdeath varchar(5) NOT NULL DEFAULT '' COMMENT 'สถานที่เสียชีวิต',
typearea varchar(2) NOT NULL DEFAULT '' COMMENT 'TYPE AREA',
statuss varchar(15) NOT NULL DEFAULT '' COMMENT 'สถานะบุคคล',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_nodeath_t;

INSERT INTO person_nodeath_t
(
hospcode,pid,fullname,hn,death_input,ddeath,cdeath_a,hospdeath,typearea,statuss
)

( 

select h.hoscode,p.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.hn,x.hospcode as death_input,
x.ddeath,
x.CDEATH_A,
x.hospdeath,typearea,
case  when  discharge = '9' then 'ยังมีชีวิต' else discharge end as statuss 
from hdc.person p 
inner join (select p.cid,d.ddeath,d.CDEATH_A,d.hospcode,d.hospdeath from hdc.person p
inner join hdc.death d on d.hospcode=p.hospcode and d.pid=p.pid
where d.ddeath is not null and d.CDEATH_A <>'' group by p.cid )x on p.cid=x.cid
join hdc.chospital h on h.hoscode=p.hospcode
where p.discharge='9' and p.TYPEAREA in ('1','3')
order by p.hospcode

);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_nodeath_s;
CREATE TABLE person_nodeath_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_nodeath_s;

INSERT INTO person_nodeath_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(p.pid) as pid FROM hdc.person p where p.discharge = '9' and p.TYPEAREA in ('1','3') GROUP BY HOSPCODE) nd
LEFT JOIN
(select p.hospcode, count(p.pid) as y_cases 
from hdc.person p 
inner join (select p.cid,d.ddeath,d.CDEATH_A,d.hospcode,d.hospdeath from hdc.person p
inner join hdc.death d on d.hospcode=p.hospcode and d.pid=p.pid
where d.ddeath is not null and d.CDEATH_A <>'' group by p.cid )x on p.cid=x.cid
where p.discharge = '9' and p.TYPEAREA in ('1','3')
group by p.hospcode
)as st 
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.hospcode
order by st.y_cases desc

);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_nodeath_a;
CREATE TABLE person_nodeath_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_nodeath_a;

INSERT INTO person_nodeath_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p
join hdc.chospital c on c.hoscode=p.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where p.discharge='9' and TYPEAREA in ('1','3') GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(p.pid) as y_cases
from hdc.person p 
inner join (select p.cid,d.ddeath,d.CDEATH_A,d.hospcode,d.hospdeath from hdc.person p
inner join hdc.death d on d.hospcode=p.hospcode and d.pid=p.pid
where d.ddeath is not null and d.CDEATH_A <>'' group by p.cid )x on p.cid=x.cid
join hdc.chospital c on c.hoscode=p.HOSPCODE
where p.discharge='9' and p.TYPEAREA in ('1','3')
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `person_nohome`
-- ----------------------------
DROP PROCEDURE IF EXISTS `person_nohome`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `person_nohome`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
#############################################################
DROP TABLE IF EXISTS tmp_person_nohome_t;
CREATE TABLE tmp_person_nohome_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'รหัสบ้าน(person)',
pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
cid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'เลขที่บัตรประชาชน',
fullname VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'ชื่อนามสกุล',
nation varchar(5) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
typearea varchar(5) NOT NULL DEFAULT '' COMMENT 'TYPE AREA',
housetype varchar(1) NOT NULL DEFAULT '' COMMENT 'ประเภทที่อยู่',
hhid varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสบ้าน(home)',
village varchar(5) NOT NULL DEFAULT '' COMMENT 'หมู่ที่',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE tmp_person_nohome_t;

INSERT INTO tmp_person_nohome_t
(
hospcode,hid,pid,cid,fullname,nation,typearea,housetype,hhid,village
)

( 
SELECT
 p.hospcode,
 p.hid AS 'รหัสบัาน (HID)',
 p.pid AS 'รหัสประจำตัว (PID)',
 concat(LEFT (p.cid, 8), 'xxxxx')AS cid,
 concat(p. NAME, ' ', p.lname)AS fullname,
 p.nation,
 p.typearea,
 h.housetype,
 h.hid AS hhid,
 h.village
FROM
 hdc.person p
 LEFT OUTER JOIN hdc.home h ON p.hospcode = h.hospcode
 AND p.hid = h.hid
WHERE
 p.nation = '099'
 AND p.typearea IN('1', '2', '3')
 AND p.discharge = '9'
GROUP BY
 p.hospcode,
 p.cid
ORDER BY
 p.hospcode


);
#############################################################


 #Routine body goes here...
DROP TABLE IF EXISTS person_nohome_t;
CREATE TABLE person_nohome_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'รหัสบ้าน(person)',
pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
cid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'เลขที่บัตรประชาชน',
fullname VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'ชื่อนามสกุล',
nation varchar(5) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
typearea varchar(5) NOT NULL DEFAULT '' COMMENT 'TypeArea',
housetype varchar(1) NOT NULL DEFAULT '' COMMENT 'ประเภทที่อยู่',
hhid varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสบ้าน(home)',
village varchar(5) NOT NULL DEFAULT '' COMMENT 'หมู่ที่',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_nohome_t;

INSERT INTO person_nohome_t
(
hospcode,hid,pid,cid,fullname,nation,typearea,housetype,hhid,village
)

( 
SELECT
 p.hospcode,
 p.hid AS 'รหัสบัาน (HID)',
 p.pid AS 'รหัสประจำตัว (PID)',
 concat(LEFT (p.cid, 8), 'xxxxx')AS cid,
 concat(p. NAME, ' ', p.lname)AS fullname,
 p.nation,
 p.typearea,
 h.housetype,
 h.hid AS hhid,
 h.village
FROM
 hdc.person p
 LEFT OUTER JOIN hdc.home h ON p.hospcode = h.hospcode
 AND p.hid = h.hid
WHERE
 p.nation = '099'
 AND p.typearea IN('1', '2', '3')
 AND p.discharge = '9'
 AND(
  h.hid IS NULL
  OR h.housetype IS NULL
  OR h.housetype = '0'
 )
GROUP BY
 p.hospcode,
 p.cid
ORDER BY
 p.hospcode


);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_nohome_s;
CREATE TABLE person_nohome_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_cid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนข้อผิดพลาด',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละข้อผิดพลาด',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_nohome_s;

INSERT INTO person_nohome_s
(
hospcode,hosname,distcode,total_cid,y_cases,percent
)

( 
SELECT nd.hospcode,h.hosname,concat(@province,h.distcode) as distcode ,nd.cid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /nd.cid)*100,2) as percent
FROM
(SELECT hospcode,count(cid) as cid from tmp_person_nohome_t 
GROUP BY HOSPCODE) AS nd
LEFT JOIN
(select hospcode,count(cid) as y_cases from person_nohome_t
group by hospcode)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
ORDER BY st.y_cases DESC


);



#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_nohome_a;
CREATE TABLE person_nohome_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_cid varchar(10) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนข้อผิดพลาด',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละข้อผิดพลาด',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_nohome_a;

INSERT INTO person_nohome_a
(
distcode,ampurname,total_cid,y_cases,percent
)

( 

SELECT s.distcode,ca.ampurname,
SUM(s.total_cid) AS total_cid,
IFNULL(SUM(s.y_cases),0) AS y_cases,
round((IFNULL(SUM(s.y_cases),0) /SUM(s.total_cid))*100,2) AS percent
FROM person_nohome_s s
LEFT JOIN hdc.campur ca ON ca.ampurcodefull = s.distcode AND ca.changwatcode=@province
GROUP BY s.distcode
ORDER BY y_cases DESC

);




#################################
 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `person_notcid`
-- ----------------------------
DROP PROCEDURE IF EXISTS `person_notcid`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `person_notcid`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS person_notcid_t;
CREATE TABLE person_notcid_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
cid varchar(13) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
name varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ',
lname varchar(100) NOT NULL DEFAULT '' COMMENT 'สกุล',
sex varchar(2) NOT NULL DEFAULT '' COMMENT 'เพศ',
nation varchar(3) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
typearea varchar(2) NOT NULL DEFAULT '' COMMENT 'TYPE AREA',


PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_notcid_t;

INSERT INTO person_notcid_t
(
hospcode,cid,pid,name,lname,sex,nation,typearea
)

( 

select p.hospcode, p.cid, p.pid, name, lname, sex, nation, typearea
from hdc.person  p
join hdc.service s on s.HOSPCODE=p.HOSPCODE and p.pid=s.pid
where cid like '0%' and nation='099' and typearea in (1,3)
and (lname like '%พม่า%' or lname like 'เขมร' or lname like 'กัมพูชา' or lname like 'ลาว')
group by p.hospcode, p.cid, p.pid

);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS person_notcid_s;
CREATE TABLE person_notcid_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_notcid_s;

INSERT INTO person_notcid_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode ,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(DISTINCT pid) as pid from hdc.person GROUP BY HOSPCODE) nd
LEFT JOIN
(select p.hospcode, count(DISTINCT p.pid) as y_cases
from hdc.person  p
join hdc.service s on s.HOSPCODE=p.HOSPCODE and p.pid=s.pid
where cid like '0%' and nation='099' and typearea in (1,3)
and (lname like '%พม่า%' or lname like 'เขมร' or lname like 'กัมพูชา' or lname like 'ลาว')
group by p.hospcode)as st
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.HOSPCODE
ORDER BY st.y_cases DESC


);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS person_notcid_a;
CREATE TABLE person_notcid_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_notcid_a;

INSERT INTO person_notcid_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p
join hdc.chospital c on c.hoscode=p.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(DISTINCT p.pid) as y_cases
from hdc.person p
join hdc.service s on s.HOSPCODE=p.HOSPCODE and p.pid=s.pid
join hdc.chospital c on c.hoscode=p.HOSPCODE
where cid like '0%' and nation='099' and typearea in (1,3)
and (lname like '%พม่า%' or lname like 'เขมร' or lname like 'กัมพูชา' or lname like 'ลาว')
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `person_notthaitype`
-- ----------------------------
DROP PROCEDURE IF EXISTS `person_notthaitype`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `person_notthaitype`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS person_notthaitype_t;
CREATE TABLE person_notthaitype_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
hn VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'HN',
nation varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสสัญชาติ',
nationname varchar(25) NOT NULL DEFAULT '' COMMENT 'ชื่อสัญชาติ',
typearea varchar(5) NOT NULL DEFAULT '' COMMENT 'TYPE AREA',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_notthaitype_t;

INSERT INTO person_notthaitype_t
(
hospcode,pid,fullname,hn,nation,nationname,typearea
)

( 

select hospcode,pid,concat(`NAME`,' ',LNAME)as fullname,hn,nation,nationname,typearea
from hdc.person 
left join hdc.chospital on hoscode=hospcode
left join hdc.cnation on nationcode=nation
where nation!='099' and typearea in ('1','3') and discharge ='9'
order by hospcode desc

);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_notthaitype_s;
CREATE TABLE person_notthaitype_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_notthaitype_s;

INSERT INTO person_notthaitype_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.cid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /cid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as cid from hdc.person 
where typearea in ('1','3') and discharge ='9' GROUP BY HOSPCODE) nd
LEFT JOIN
(select hospcode,count(pid) as y_cases
from person_notthaitype_t p
group by hospcode
order by hospcode desc
)as st
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.hospcode
ORDER BY nd.hospcode
);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_notthaitype_a;
CREATE TABLE person_notthaitype_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_notthaitype_a;

INSERT INTO person_notthaitype_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.cid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /cid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(pid) as cid FROM hdc.person p
inner join hdc.chospital c on c.hoscode=p.HOSPCODE
inner join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where typearea in ('1','3') and discharge ='9'
GROUP BY c.distcode) nd
LEFT JOIN 
(select c.distcode,count(pid) as y_cases
from person_notthaitype_t p
left join hdc.chospital c on c.hoscode=p.HOSPCODE
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `person_notypearea`
-- ----------------------------
DROP PROCEDURE IF EXISTS `person_notypearea`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `person_notypearea`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS person_notypearea_t;
CREATE TABLE person_notypearea_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
typearea varchar(3) NOT NULL DEFAULT '' COMMENT 'TYPE AREA',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_notypearea_t;

INSERT INTO person_notypearea_t
(
hospcode,hosname,pid,fullname,typearea
)

( 

select p.hospcode, h.hosname, pid,concat(`NAME`,' ',LNAME)as fullname,typearea
from hdc.person p
join hdc.chospital h on h.hoscode=p.hospcode
where 
typearea not in ('1','2','3','4','5')
order by hospcode asc

);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS person_notypearea_s;
CREATE TABLE person_notypearea_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ)',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_notypearea_s;

INSERT INTO person_notypearea_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.HOSPCODE,c.hosname,concat(@province,c.distcode) as distcode,nd.Total_PID,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /Total_PID)*100,2) as percent
FROM
(SELECT HOSPCODE,count(PID) as Total_PID FROM hdc.person GROUP BY HOSPCODE) nd
LEFT JOIN
(select p.hospcode,count(p.PID) as y_cases
from hdc.person p
LEFT JOIN hdc.chospital c on c.hoscode=p.HOSPCODE
where typearea not in ('1','2','3','4','5')
group by hospcode) as st
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.hospcode
order by st.hospcode
);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS person_notypearea_a;
CREATE TABLE person_notypearea_a (

distcode varchar(10) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',

PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_notypearea_a;

INSERT INTO person_notypearea_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.person p
join hdc.chospital c on c.hoscode=p.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(p.pid) as y_cases
from hdc.person p
join hdc.chospital c on c.hoscode=p.HOSPCODE
where typearea not in ('1','2','3','4','5')
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `person_service_death`
-- ----------------------------
DROP PROCEDURE IF EXISTS `person_service_death`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `person_service_death`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);




DROP TABLE if  EXISTS tmp_person_service_death;
CREATE TABLE if not EXISTS tmp_person_service_death
REPLACE select p.hospcode,c.hosname,p.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.hn,d.ddeath,s.date_serv,d.cdeath_a,d.cdeath
from hdc.service s
INNER JOIN hdc.person p on p.pid=s.pid and s.hospcode=p.hospcode
INNER JOIN hdc.death d on d.pid=p.pid and d.hospcode =p.hospcode
left join hdc.chospital c on c.hoscode=s.HOSPCODE
where s.date_serv BETWEEN @start_d AND @end_d ;



###########################################################################################################################################
#Routine body goes here...
DROP TABLE IF EXISTS person_service_death_t;
CREATE TABLE person_service_death_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
hn varchar(30) NOT NULL DEFAULT '' COMMENT 'เลขผู้ป่วยนอก',
ddeath varchar(30) NOT NULL DEFAULT '' COMMENT 'วันเสียชีวิต',
date_serv date COMMENT 'วันรับบริการ',
cdeath_a varchar(10) NOT NULL DEFAULT '' COMMENT 'สาเหตุการตาย_a',
cdeath varchar(10) NOT NULL DEFAULT '' COMMENT 'สาเหตุการตาย',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_service_death_t;

INSERT INTO person_service_death_t
(
hospcode,hosname,pid,fullname,hn,ddeath,date_serv,cdeath_a,cdeath
)

( 

select s.hospcode,s.hosname,s.pid,s.fullname,s.hn,s.ddeath,s.date_serv,s.cdeath_a,s.cdeath
from tmp_person_service_death s
where DATEDIFF(s.date_serv,s.ddeath) > 7


);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS person_service_death_s;
CREATE TABLE person_service_death_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_service_death_s;

INSERT INTO person_service_death_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,c.hosname,distcode,count(pid) as pid 
from tmp_person_service_death s
LEFT JOIN hdc.chospital c on c.hoscode=s.HOSPCODE
GROUP BY HOSPCODE) nd
left JOIN
(select s.hospcode,count(s.pid) as y_cases 
from tmp_person_service_death s
where DATEDIFF(s.date_serv,s.ddeath) > 7 
group by s.hospcode
)as st
on nd.hospcode=st.hospcode
order by st.y_cases DESC
);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS person_service_death_a;
CREATE TABLE person_service_death_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE person_service_death_a;

INSERT INTO person_service_death_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM tmp_person_service_death s
join hdc.chospital c on c.hoscode=s.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from tmp_person_service_death s
join hdc.chospital c on c.hoscode=s.HOSPCODE
where DATEDIFF(s.date_serv,s.ddeath) > 7 
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);



 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `postnatal_after`
-- ----------------------------
DROP PROCEDURE IF EXISTS `postnatal_after`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postnatal_after`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS postnatal_after_t;
CREATE TABLE postnatal_after_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
gravida varchar(5) NOT NULL DEFAULT '' COMMENT 'ครรภ์ที่',
bdate date COMMENT 'วันที่คลอด',
ppcare date COMMENT 'วันเยี่ยมหลังคลอด',
provider varchar(10) NOT NULL DEFAULT '' COMMENT 'ผู้ให้บริการ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE postnatal_after_t;

INSERT INTO postnatal_after_t
(
hospcode,hosname,pid,fullname,gravida,bdate,ppcare,provider
)

( 
select p.hospcode,c.hosname,p.pid,concat(pe.`NAME`,' ',pe.LNAME)as fullname,p.gravida,p.bdate,p.ppcare,p.provider
from hdc.postnatal p
left join hdc.person pe on pe.hospcode=p.hospcode and pe.pid=p.pid
left outer join hdc.chospital c on c.hoscode=p.HOSPCODE
where (bdate=ppcare or gravida='' or ppresult='')
AND p.bdate BETWEEN @start_d AND @end_d
order by p.hospcode

);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS postnatal_after_s;
CREATE TABLE postnatal_after_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE postnatal_after_s;

INSERT INTO postnatal_after_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid from hdc.postnatal 
where bdate BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select p.hospcode,count(p.pid) as y_cases
from hdc.postnatal p
where (bdate=ppcare or gravida='' or ppresult='')
AND p.bdate BETWEEN @start_d AND @end_d  
group by p.hospcode)as st
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.hospcode
order by st.y_cases DESC

);




#################################

 #Routine body goes here...
DROP TABLE IF EXISTS postnatal_after_a;
CREATE TABLE postnatal_after_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE postnatal_after_a;

INSERT INTO postnatal_after_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(p.pid) as pid FROM hdc.postnatal p
join hdc.chospital c on c.hoscode=p.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where p.bdate BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(p.pid) as y_cases
from hdc.postnatal p
join hdc.chospital c on c.hoscode=p.HOSPCODE
where (bdate=ppcare or gravida='' or ppresult='')
AND p.bdate BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `procedure_opd_procedcode`
-- ----------------------------
DROP PROCEDURE IF EXISTS `procedure_opd_procedcode`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_opd_procedcode`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################

DROP TABLE if  EXISTS tmp_procedure_opd_procedcode;
CREATE TABLE if not EXISTS tmp_procedure_opd_procedcode
REPLACE select s.hospcode, h.hosname,h.distcode, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname, s.date_serv, s.procedcode
from hdc.procedure_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where h.hostype in ('03','18')
and s.date_serv BETWEEN @start_d AND @end_d
order by h.hoscode, p.pid, s.date_serv ;



DROP TABLE IF EXISTS procedure_opd_procedcode_t;
CREATE TABLE procedure_opd_procedcode_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
procedcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสหัตถการ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE procedure_opd_procedcode_t;

INSERT INTO procedure_opd_procedcode_t
(
hospcode,hosname,pid,fullname,date_serv,procedcode
)

( 
select s.hospcode, s.hosname, s.pid,fullname, s.date_serv, s.procedcode
from tmp_procedure_opd_procedcode s
where length(s.procedcode) < 7
order by s.hospcode, s.pid, s.date_serv
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS procedure_opd_procedcode_s;
CREATE TABLE procedure_opd_procedcode_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE procedure_opd_procedcode_s;

INSERT INTO procedure_opd_procedcode_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,distcode,count(pid) as pid FROM tmp_procedure_opd_procedcode
GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from tmp_procedure_opd_procedcode s
where length(s.procedcode) < 7
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
join hdc.chospital c on c.hoscode=nd.hospcode
order by st.y_cases DESC


);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS procedure_opd_procedcode_a;
CREATE TABLE procedure_opd_procedcode_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE procedure_opd_procedcode_a;

INSERT INTO procedure_opd_procedcode_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT p.distcode,ca.ampurname,count(p.pid) as pid FROM tmp_procedure_opd_procedcode p
join hdc.campur ca on ca.ampurcode = p.distcode and ca.changwatcode=@province
GROUP BY p.distcode) nd
left JOIN 
(select p.distcode,count(p.pid) as y_cases
from tmp_procedure_opd_procedcode p
where length(p.procedcode) < 7
group by p.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `procedure_opd_serviceprice`
-- ----------------------------
DROP PROCEDURE IF EXISTS `procedure_opd_serviceprice`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure_opd_serviceprice`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################



DROP TABLE if  EXISTS tmp_procedure_opd_serviceprice;
CREATE TABLE if not EXISTS tmp_procedure_opd_serviceprice
REPLACE select s.hospcode, h.hosname,h.distcode, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname, s.date_serv, s.procedcode, s.serviceprice
from hdc.procedure_opd s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where s.procedcode not in (SELECT * FROM procedure_no_price) and s.date_serv BETWEEN @start_d AND @end_d ;






DROP TABLE IF EXISTS procedure_opd_serviceprice_t;
CREATE TABLE procedure_opd_serviceprice_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
procedcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสหัตถการ',
serviceprice varchar(15) NOT NULL DEFAULT '' COMMENT 'ราคาค่าหัตถการ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE procedure_opd_serviceprice_t;

INSERT INTO procedure_opd_serviceprice_t
(
hospcode,hosname,pid,fullname,date_serv,procedcode,serviceprice
)

( 
select s.hospcode, s.hosname, s.pid,fullname, s.date_serv, s.procedcode, s.serviceprice
from tmp_procedure_opd_serviceprice s
where s.serviceprice ='0'
order by s.hospcode, s.pid, s.date_serv
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS procedure_opd_serviceprice_s;
CREATE TABLE procedure_opd_serviceprice_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE procedure_opd_serviceprice_s;

INSERT INTO procedure_opd_serviceprice_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,c.hosname,concat(@province,c.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM tmp_procedure_opd_serviceprice GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from tmp_procedure_opd_serviceprice s
where s.procedcode not in  (SELECT * FROM procedure_no_price) and s.serviceprice ='0'
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
left join hdc.chospital c on c.hoscode=nd.hospcode
order by st.y_cases DESC  

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS procedure_opd_serviceprice_a;
CREATE TABLE procedure_opd_serviceprice_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE procedure_opd_serviceprice_a;

INSERT INTO procedure_opd_serviceprice_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,ca.ampurname,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT p.distcode,count(p.pid) as pid FROM tmp_procedure_opd_serviceprice p
 GROUP BY distcode) nd
right JOIN
(select p.distcode,count(p.pid) as y_cases
from tmp_procedure_opd_serviceprice p
where p.procedcode not in  (SELECT * FROM procedure_no_price) and p.serviceprice ='0'
group by p.distcode
)as st 
on nd.distcode=st.distcode
join hdc.campur ca on ca.ampurcode = nd.distcode and ca.changwatcode=@province
order by st.y_cases DESC  


);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `service_after_dupdate`
-- ----------------------------
DROP PROCEDURE IF EXISTS `service_after_dupdate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `service_after_dupdate`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS service_after_dupdate_t;
CREATE TABLE service_after_dupdate_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
d_update varchar(20) NOT NULL DEFAULT '' COMMENT 'วันที่ปรับปรุงข้อมูล',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_after_dupdate_t;

INSERT INTO service_after_dupdate_t
(
hospcode,hosname,pid,fullname,date_serv,d_update
)

( 
select s.hospcode, h.hosname, s.pid, concat(p.`NAME`,' ',p.LNAME)as fullname, s.date_serv, s.d_update
from hdc.service s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where s.date_serv > s.d_update
AND s.date_serv BETWEEN @start_d AND @end_d
order by  h.hoscode, p.pid, s.date_serv
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS service_after_dupdate_s;
CREATE TABLE service_after_dupdate_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_after_dupdate_s;

INSERT INTO service_after_dupdate_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT h.hoscode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.service
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode, count(s.pid) as y_cases 
from hdc.service s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where s.date_serv > s.d_update
AND s.date_serv BETWEEN @start_d AND @end_d 
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS service_after_dupdate_a;
CREATE TABLE service_after_dupdate_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_after_dupdate_a;

INSERT INTO service_after_dupdate_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.service s
join hdc.chospital c on c.hoscode=s.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.service s
join hdc.chospital c on c.hoscode=s.HOSPCODE
where s.date_serv > s.d_update
AND s.date_serv BETWEEN @start_d AND @end_d   
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `service_before_birth`
-- ----------------------------
DROP PROCEDURE IF EXISTS `service_before_birth`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `service_before_birth`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS service_before_birth_t;
CREATE TABLE service_before_birth_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
service_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียน service',
person_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียน person',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
birth date COMMENT 'วันเกิด',
date_serv date COMMENT 'วันที่รับบริการ',
typearea varchar(5) NOT NULL DEFAULT '' COMMENT 'สถานะ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_before_birth_t;

INSERT INTO service_before_birth_t
(
hospcode,hosname,service_pid,person_pid,fullname,birth,date_serv,typearea
)

( 

select s.hospcode,hosname,s.pid as service_pid,p.pid as person_pid,concat(p.`NAME`,' ',p.LNAME)as fullname,p.birth,s.date_serv,p.typearea  
from hdc.service s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
LEFT JOIN hdc.chospital c on c.hoscode=s.HOSPCODE
where s.date_serv < p.birth
AND DATE_SERV BETWEEN @start_d AND @end_d 
order by s.hospcode



);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS service_before_birth_s;
CREATE TABLE service_before_birth_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_before_birth_s;

INSERT INTO service_before_birth_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT h.hoscode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid 
from hdc.service 
where DATE_SERV BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(p.pid) as y_cases
from hdc.service s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where s.date_serv < p.birth
AND DATE_SERV BETWEEN @start_d AND @end_d 
group by  s.hospcode)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC

);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS service_before_birth_a;
CREATE TABLE service_before_birth_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_before_birth_a;

INSERT INTO service_before_birth_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.service s
join hdc.chospital c on c.hoscode=s.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.service s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital c on c.hoscode=s.HOSPCODE
where s.date_serv < p.birth
AND s.DATE_SERV BETWEEN @start_d AND @end_d  
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc

);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `service_sell`
-- ----------------------------
DROP PROCEDURE IF EXISTS `service_sell`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `service_sell`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS service_sell_t;
CREATE TABLE service_sell_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
cost varchar(15)  COMMENT 'ราคาทุน',
price varchar(15)  COMMENT 'ราคาขาย',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_sell_t;

INSERT INTO service_sell_t
(
hospcode,hosname,pid,fullname,date_serv,cost,price
)

( 
select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname,s.date_serv, s.cost, s.price
from hdc.service s
LEFT JOIN (SELECT * from hdc.diagnosis_opd 
where  DIAGTYPE=1 AND date_serv BETWEEN @start_d AND @end_d ) d on d.HOSPCODE=s.HOSPCODE and d.PID=s.PID and d.SEQ=s.SEQ and d.DATE_SERV=s.DATE_SERV
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
join hdc.chospital h on h.hoscode=s.hospcode
where (s.price = 0 or s.price < s.cost) and d.DIAGCODE not in (select code from diag_no_price)
and s.date_serv BETWEEN @start_d AND @end_d
order by h.hoscode, p.pid, s.date_serv
);




#################################


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS service_sell_s;
CREATE TABLE service_sell_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_sell_s;

INSERT INTO service_sell_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT h.hoscode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT hospcode,count(pid) as pid FROM hdc.service 
where date_serv BETWEEN @start_d AND @end_d GROUP BY HOSPCODE) nd
LEFT JOIN
(select s.hospcode,count(s.pid) as y_cases
from hdc.service s
LEFT JOIN (SELECT * from hdc.diagnosis_opd 
where  DIAGTYPE=1 AND date_serv BETWEEN @start_d AND @end_d ) d on d.HOSPCODE=s.HOSPCODE and d.PID=s.PID and d.SEQ=s.SEQ and d.DATE_SERV=s.DATE_SERV
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
where (s.price = 0 or s.price < s.cost) and d.DIAGCODE not in (select code from diag_no_price)
AND s.date_serv BETWEEN @start_d AND @end_d 
group by s.hospcode
)as st 
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC    

);




#################################


################################

 #Routine body goes here...
DROP TABLE IF EXISTS service_sell_a;
CREATE TABLE service_sell_a (

distcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_sell_a;

INSERT INTO service_sell_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.service s
join hdc.chospital c on c.hoscode=s.HOSPCODE
join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where s.DATE_SERV BETWEEN @start_d AND @end_d
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.service s
LEFT JOIN (SELECT * from hdc.diagnosis_opd 
where  DIAGTYPE=1 AND date_serv BETWEEN @start_d AND @end_d ) d on d.HOSPCODE=s.HOSPCODE and d.PID=s.PID and d.SEQ=s.SEQ and d.DATE_SERV=s.DATE_SERV
join hdc.chospital c on c.hoscode=s.HOSPCODE
where (s.price = 0 or s.price < s.cost) and d.DIAGCODE not in (select code from diag_no_price)
AND s.date_serv BETWEEN @start_d AND @end_d   
group by c.distcode
)as st 
on nd.distcode=st.distcode
order by st.y_cases desc


);


 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `service_send`
-- ----------------------------
DROP PROCEDURE IF EXISTS `service_send`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `service_send`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
BEGIN 
IF(s_runtime IS NOT NULL AND  e_runtime IS NOT NULL) THEN
set @start_d := s_runtime; /* วันที่เกิด ของแฟ้ม labor ,วันจำหน่ายของแฟ้ม admission*/
set @end_d := e_runtime;
ELSE 
UPDATE sys_log
SET log_status='conf_runtime_err'
WHERE procedure_name=procedure_name ;
END IF;

SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
DROP TABLE IF EXISTS service_send_t;
CREATE TABLE service_send_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
date_serv date COMMENT 'วันที่รับบริการ',
referouthosp varchar(5)  COMMENT 'สถานที่ส่งผู้ป่วยไป',
causeout varchar(1)  COMMENT 'สาเหตุการส่งต่อ',

PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_send_t;

INSERT INTO service_send_t
(
hospcode,hosname,pid,fullname,date_serv,referouthosp,causeout
)

( 
select s.hospcode,c.hosname,s.PID,concat(p.`NAME`,' ',p.LNAME)as fullname,s.DATE_SERV,s.REFEROUTHOSP,s.CAUSEOUT
from hdc.service s
left join hdc.person p on p.hospcode=s.hospcode and p.pid=s.pid
left outer join hdc.chospital c on c.hoscode=s.HOSPCODE
where s.date_serv BETWEEN @start_d AND @end_d  and typeout=3
and (isnull(s.referouthosp) or isnull(s.causeout))
ORDER BY s.HOSPCODE
);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS service_send_s;
CREATE TABLE service_send_s (
id int(15) NOT NULL AUTO_INCREMENT,
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้งที่มารับบริการ',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_send_s;

INSERT INTO service_send_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 


SELECT h.hoscode,h.hosname,concat(@province,h.distcode) as distcode,nd.pid,IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(select s.hospcode,count(s.PID) as pid from hdc.service s
where date_serv BETWEEN @start_d AND @end_d and typeout=3 
GROUP BY s.HOSPCODE) nd
left JOIN
(select s.hospcode,count(s.pid) as y_cases		
from hdc.service s
where date_serv BETWEEN @start_d AND @end_d  and typeout=3
and (isnull(referouthosp) or isnull(causeout))
group by s.hospcode)as st
on nd.hospcode=st.hospcode
LEFT JOIN hdc.chospital h on h.hoscode=nd.hospcode
order by st.y_cases DESC


);




#################################


 #Routine body goes here...
DROP TABLE IF EXISTS service_send_a;
CREATE TABLE service_send_a (

distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE service_send_a;

INSERT INTO service_send_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 



SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent
FROM
(SELECT c.distcode,ca.ampurname,count(s.pid) as pid FROM hdc.service s
RIGHT join hdc.chospital c on c.hoscode=s.HOSPCODE
left join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
where date_serv BETWEEN @start_d AND @end_d and TYPEOUT=3
GROUP BY c.distcode) nd
left JOIN 
(select c.distcode,count(s.pid) as y_cases
from hdc.service s
left join hdc.chospital c on c.hoscode=s.hospcode
where date_serv BETWEEN @start_d AND @end_d  and typeout=3
and (isnull(referouthosp) or isnull(causeout))
group by c.distcode)as st
on nd.distcode=st.distcode
order by st.y_cases DESC




);

 

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sys_Notifications`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sys_Notifications`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sys_Notifications`()
BEGIN
DECLARE x, c, tcount, tid, chktable, error  INT;
DECLARE str, t, ycolumn, totalcolumn, tpercent,ydata, hospcode, tgroup, err_table, err_info  VARCHAR(255);
DECLARE tcolumn LONGTEXT;
SET x = 1;SET error=0;
SET c = 0;
SET str =  '';
SET tcolumn='';
SET t='';
SET tcount=( select count(report_id) from sys_report WHERE menu_group <> 'qof' AND menu_group <> 'qofcentral' AND active =1);

SET @s = CONCAT('DROP TABLE IF EXISTS sys_Notifications');
		PREPARE stmt FROM @s;
		EXECUTE stmt;

CREATE TABLE sys_Notifications ( snt_id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
hospcode VARCHAR(5) NULL,
distcode VARCHAR(4) NULL,
hmain VARCHAR(5) NULL,
report_id INT(5),
report_group VARCHAR(15) NULL,
y_cases INT(5) ,
total INT(5) ,
percent FLOAT(5)   );
TRUNCATE TABLE sys_Notifications;
SET @s = CONCAT('DROP TABLE IF EXISTS sys_Notifications_err');
            PREPARE stmt FROM @s;
            EXECUTE stmt;
CREATE TABLE sys_Notifications_err ( snt_id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
procedure_name VARCHAR(40) NULL,
run_table VARCHAR(40) NULL,
total VARCHAR(5) NULL,
run VARCHAR(5) NULL,
err_info VARCHAR(100) NULL,
log_status VARCHAR(10) NULL  );
TRUNCATE TABLE sys_Notifications_err;
WHILE x  <= tcount DO
SET t=( select s_table from sys_report  where  menu_group <> 'qof' AND menu_group <> 'qofcentral' AND active =1 LIMIT c,1);
SET tid=( select report_id from sys_report WHERE s_table=t and menu_group <> 'qof' AND menu_group <> 'qofcentral');
SET tgroup=( select menu_group from sys_report WHERE s_table=t and menu_group <> 'qof' AND menu_group <> 'qofcentral');
SET chktable=(SELECT TABLE_EXISTS(t) as _exists);
IF  chktable  <> 0 THEN
SET ycolumn=(SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA`='eh' AND `TABLE_NAME`=t AND COLUMN_NAME LIKE 'y_%');
SET totalcolumn=(SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS`
 WHERE `TABLE_SCHEMA`='eh' AND `TABLE_NAME`=t AND COLUMN_NAME LIKE 'total%' );


SET @str=CONCAT('
INSERT IGNORE INTO sys_Notifications (hospcode, distcode, hmain, report_id, report_group, y_cases, total, percent)
( SELECT s.hospcode, s.distcode, IF(c.hmain is null,s.hospcode,c.hmain),', '"', tid,'", ', '"', tgroup, '", ', ycolumn, ', ',totalcolumn,', (',ycolumn,' / ',totalcolumn,')*100 AS percent FROM ', t,' s LEFT JOIN hdc.cmastercup c on s.hospcode=c.hsub);
');
     PREPARE stmt1 FROM @str; 
     EXECUTE stmt1; 
     DEALLOCATE PREPARE stmt1;
ELSE
SET error=error+1;SET err_info=CONCAT('TableName ', t, ' Is Not in db');
INSERT INTO sys_Notifications_err (procedure_name, run_table, total, run, err_info, log_status)
 VALUES ('sys_Notifications', t,tcount, c, err_info, 'error');
END IF;
SET c = x;
SET  x = x + 1;
END WHILE;

IF(error=0)THEN
INSERT INTO sys_Notifications_err (procedure_name, total, run, log_status) VALUES ('sys_Notifications',tcount, c, 'complete');
END IF;



END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sys_process`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sys_process`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sys_process`()
BEGIN 

DECLARE x, c, pcount, error, C_report, C_runing, C_all, chk_table  INT;
DECLARE str, procedure_name, err_table, err_info  VARCHAR(255);
SET @province:=(SELECT province_config FROM sys_config LIMIT 1);

SET C_report=(SELECT count(report_id) FROM sys_report WHERE active >0)-1;
SET chk_table=(SELECT TABLE_EXISTS('sys_log') as _exists);
IF (chk_table >0) THEN
SET @C_syslog=(SELECT count(s_id) FROM sys_log );
SET C_runing=(SELECT running_process FROM sys_log ORDER BY s_id DESC LIMIT 1);
SET C_all=(SELECT all_process FROM sys_log ORDER BY s_id DESC LIMIT 1)-1;
IF(C_runing=(C_all)+1) THEN
SET @create_syslog:=1;
END IF;
IF(@C_syslog>0 AND C_runing!=C_all) THEN

#SET C_report=C_all-C_runing;
SET c=C_runing-1;
SET x=C_runing;
ELSE
SET @create_syslog:=1;
END IF;
ELSE
SET @create_syslog:=1;
END IF;

IF (@create_syslog=1) THEN
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE sys_log ( s_id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
procedure_names VARCHAR(40) NULL,
d_run VARCHAR(10) NULL,
s_time VARCHAR(8) NULL,
e_time VARCHAR(8) NULL,
conf_runtime INT(5) NULL,
all_process VARCHAR(5) NULL,
running_process VARCHAR(5) NULL,
err_info VARCHAR(100) NULL,
log_status VARCHAR(30) NULL  );
TRUNCATE TABLE `sys_log`;
SET x = 1;
SET c=0;
END IF;


SET error=0;
WHILE x  <= C_report+1 DO
SET @d_run=CURRENT_DATE() ;
SET @t_run=CURRENT_TIME();
SET procedure_name=(SELECT report_procedure FROM sys_report WHERE active >0 LIMIT c,1);
SET @report_id:=(SELECT report_id FROM sys_report WHERE report_procedure=procedure_name);
SET @actives:=(SELECT active FROM sys_report WHERE report_procedure=procedure_name);
SET @menu_group:=(SELECT menu_group FROM sys_report WHERE report_procedure=procedure_name);
SET @run_rg:=(SELECT run_id FROM sys_config_runtime WHERE run_rid=@report_id AND run_gid=@menu_group);
SET @runtime_id:=@run_rg;

IF (@run_rg IS NULL) THEN
SET @run_rid:=(SELECT run_id FROM sys_config_runtime WHERE run_rid=@report_id);
SET @runtime_id:=@run_rid;

IF (@run_rid IS NULL) THEN
SET @run_gid:=(SELECT run_id FROM sys_config_runtime WHERE run_gid=@menu_group AND run_rid IS NULL);
SET @runtime_id:=@run_gid;

IF (@run_rg IS NULL AND @run_rid IS NULL AND @run_gid IS NULL) THEN
SET @run_gid:=(SELECT run_id FROM sys_config_runtime WHERE run_gid ='root');
SET @runtime_id:=@run_gid;

END IF;

END IF;

END IF;

IF (@run_rg > 0) THEN
SET @s_run:=(SELECT s_runtime FROM sys_config_runtime WHERE run_id=@run_rg);
SET @e_run:=(SELECT e_runtime FROM sys_config_runtime WHERE run_id=@run_rg);
ELSEIF (@run_rid > 0) THEN
SET @s_run:=(SELECT s_runtime FROM sys_config_runtime WHERE run_id=@run_rid);
SET @e_run:=(SELECT e_runtime FROM sys_config_runtime WHERE run_id=@run_rid);
ELSEIF (@run_gid > 0) THEN
SET @s_run:=(SELECT s_runtime FROM sys_config_runtime WHERE run_id=@run_gid);
SET @e_run:=(SELECT e_runtime FROM sys_config_runtime WHERE run_id=@run_gid);
END IF;

IF (@actives = 1) THEN
INSERT INTO sys_log (procedure_names, d_run, s_time, conf_runtime, all_process, running_process)
 VALUES (procedure_name, @d_run, @t_run, @runtime_id, C_report+1, x);

SET @s = CONCAT('CALL ', procedure_name,'(',"'",@s_run,"', '",@e_run,"','",procedure_name,"')");
		PREPARE stmt FROM @s;
		EXECUTE stmt;
ELSEIF (@actives=2) THEN
INSERT INTO sys_log (procedure_names, d_run, s_time, conf_runtime, all_process, running_process)
 VALUES (procedure_name, @d_run, @t_run, @runtime_id, C_report+1, x);

SET @s = CONCAT('CALL ', procedure_name,'()');
		PREPARE stmt FROM @s;
		EXECUTE stmt;
END IF;

SET @t_run='';
SET c = x;
SET  x = x + 1;
END WHILE;




END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sys_runprocess_one`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sys_runprocess_one`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sys_runprocess_one`(IN procedure_name VARCHAR(100))
BEGIN 

#SET procedure_name=(SELECT report_procedure FROM sys_report WHERE active =1 AND report_procedure=procedure_name);
SET @report_id:=(SELECT report_id FROM sys_report WHERE report_procedure=procedure_name);
SET @menu_group:=(SELECT menu_group FROM sys_report WHERE report_procedure=procedure_name);
SET @run_rg:=(SELECT run_id FROM sys_config_runtime WHERE run_rid=@report_id AND run_gid=@menu_group);
SET @runtime_id:=@run_rg;

IF (@run_rg IS NULL) THEN
SET @run_rid:=(SELECT run_id FROM sys_config_runtime WHERE run_rid=@report_id);
SET @runtime_id:=@run_rid;

IF (@run_rid IS NULL) THEN
SET @run_gid:=(SELECT run_id FROM sys_config_runtime WHERE run_gid=@menu_group AND run_rid IS NULL);
SET @runtime_id:=@run_gid;

IF (@run_rg IS NULL AND @run_rid IS NULL AND @run_gid IS NULL) THEN
SET @run_gid:=(SELECT run_id FROM sys_config_runtime WHERE run_gid ='root');
SET @runtime_id:=@run_gid;

END IF;

END IF;

END IF;

IF (@run_rg > 0) THEN
SET @s_run:=(SELECT s_runtime FROM sys_config_runtime WHERE run_id=@run_rg);
SET @e_run:=(SELECT e_runtime FROM sys_config_runtime WHERE run_id=@run_rg);
ELSEIF (@run_rid > 0) THEN
SET @s_run:=(SELECT s_runtime FROM sys_config_runtime WHERE run_id=@run_rid);
SET @e_run:=(SELECT e_runtime FROM sys_config_runtime WHERE run_id=@run_rid);
ELSEIF (@run_gid > 0) THEN
SET @s_run:=(SELECT s_runtime FROM sys_config_runtime WHERE run_id=@run_gid);
SET @e_run:=(SELECT e_runtime FROM sys_config_runtime WHERE run_id=@run_gid);
END IF;



#SET @province:=(SELECT province_config FROM sys_config LIMIT 1);
###########################################################################################################################################
SET @chk_log:=(SELECT COUNT(s_id) AS result FROM sys_log WHERE procedure_names=procedure_name LIMIT 1 );
IF (@chk_log < 1) THEN
SET @d_run=CURRENT_DATE() ;
SET @t_run=CURRENT_TIME();
INSERT INTO sys_log (procedure_names, d_run, s_time, conf_runtime, all_process, running_process)
 VALUES (procedure_name, @d_run, @t_run, @runtime_id, 'm', 'm');
ELSE
UPDATE sys_log
SET s_time=CURRENT_TIME(),log_status='complete_m'
WHERE procedure_names=procedure_name ;
END IF; 

IF(procedure_name='t_person_cid_notin13') THEN
SET @s = CONCAT('CALL ', procedure_name);
		PREPARE stmt FROM @s;
		EXECUTE stmt;
ELSE
SET @s = CONCAT('CALL ', procedure_name,'(',"'",@s_run,"', '",@e_run,"','",procedure_name,"')");
		PREPARE stmt FROM @s;
		EXECUTE stmt;
END IF; 
################################################################################


END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `TABLE_EXISTS`
-- ----------------------------
DROP FUNCTION IF EXISTS `TABLE_EXISTS`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `TABLE_EXISTS`(_table_name VARCHAR(45)) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE _exists  TINYINT(1) DEFAULT 0;

    SELECT COUNT(*) INTO _exists
    FROM information_schema.tables 
    WHERE table_schema =  DATABASE()
    AND table_name =  _table_name;

    RETURN _exists;

END
;;
DELIMITER ;

-- ----------------------------
-- Indexes structure for table `sys_report`
-- ----------------------------
CREATE INDEX `source_table` ON `sys_report`(`s_table`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sys_report`
-- ----------------------------
ALTER TABLE `sys_report` AUTO_INCREMENT=10070;
