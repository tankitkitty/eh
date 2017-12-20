/*
Navicat MySQL Data Transfer

Source Server         : HDC
Source Server Version : 50615
Source Host           : 203.157.151.20:3306
Source Database       : dev_eh

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2017-12-20 12:08:57
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Procedure structure for `anc_labor_sexage_invalid`
-- ----------------------------
DROP PROCEDURE IF EXISTS `anc_labor_sexage_invalid`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `anc_labor_sexage_invalid`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
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

DROP TABLE IF EXISTS anc_labor_sexage_invalid_t;
CREATE TABLE anc_labor_sexage_invalid_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
name varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ',
sex VARCHAR(1) NOT NULL DEFAULT '' COMMENT 'เพศ',
birth date COMMENT 'วันเกิด',
nation VARCHAR(3) NOT NULL DEFAULT '' COMMENT 'สัญชาติ',
anc_date date COMMENT 'วันรับบริการ',
age_anc varchar(3) NOT NULL DEFAULT '' COMMENT 'อายุ ณ วันที่รับบริการ ANC',
bdate date COMMENT 'วันคลอด',
age_labor varchar(3) NOT NULL DEFAULT '' COMMENT 'อายุ ณ วันคลอด',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_labor_sexage_invalid_t;
INSERT INTO anc_labor_sexage_invalid_t
(
hospcode,hosname,pid,name,sex,birth,nation,anc_date,age_anc,bdate,age_labor
)

( 
select a.hospcode, h.hosname, p.pid, p.name as name,
p.sex, p.birth, p.nation, min(a.date_serv) as anc_date, 
timestampdiff(year,p.birth,max(a.date_Serv)) as age_anc, l.bdate,
timestampdiff(year,p.birth,l.bdate) as age_labor 
from hdc.anc a
left join hdc.person p on p.hospcode=a.hospcode and a.pid=p.pid 
left join hdc.labor l on l.hospcode=p.hospcode and l.pid=p.pid
left join hdc.chospital h on h.hoscode=a.hospcode 
where p.nation='099' and (a.date_Serv > '2016-12-31' or  l.bdate between @start_d and @end_d ) 
and ( p.sex='1'  or ( timestampdiff(year,p.birth,a.date_serv) <11 and sex='2' )  
or ( timestampdiff(year,p.birth,a.date_Serv) >55 and sex='2' ) )
group by a.hospcode,a.pid,a.date_serv
order by a.hospcode,p.sex,l.bdate desc 
);

#################################
 #Routine body goes here...
DROP TABLE IF EXISTS anc_labor_sexage_invalid_s;
CREATE TABLE anc_labor_sexage_invalid_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_labor_sexage_invalid_s;
INSERT INTO anc_labor_sexage_invalid_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode, c.hosname, concat(@province,c.distcode) as distcode, 
nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent

FROM

	(select a.hospcode, count(a.pid)as pid 
	 from hdc.anc a
	 left join hdc.person p on p.hospcode=a.hospcode and a.pid=p.pid 
	 left join hdc.labor l on l.hospcode=p.hospcode and l.pid=p.pid
	 left join hdc.chospital h on h.hoscode=a.hospcode 
	 where p.nation='099' and (a.date_Serv > '2016-12-31' or  l.bdate between @start_d and @end_d )  
	 group by a.hospcode
	 order by a.hospcode,p.sex,a.date_serv desc) nd

LEFT JOIN

	(select a.hospcode, count(a.pid)as y_cases 
	 from hdc.anc a
	 left join hdc.person p on p.hospcode=a.hospcode and a.pid=p.pid 
	 left join hdc.labor l on l.hospcode=p.hospcode and l.pid=p.pid
	 left join hdc.chospital h on h.hoscode=a.hospcode 
	 where p.nation='099' and (a.date_Serv > '2016-12-31' or  l.bdate between @start_d and @end_d ) 
	 and ( p.sex='1'  or ( timestampdiff(year,p.birth,a.date_serv) <11 and sex='2' )  
	 or ( timestampdiff(year,p.birth,a.date_Serv) >55 and sex='2' ) )
	 group by a.hospcode
	 order by a.hospcode,p.sex,a.date_serv desc)as st

on nd.hospcode=st.hospcode
left outer join hdc.chospital c on c.hoscode=nd.HOSPCODE
order by st.y_cases DESC
);



################################
 #Routine body goes here...
DROP TABLE IF EXISTS anc_labor_sexage_invalid_a;
CREATE TABLE anc_labor_sexage_invalid_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนฝากครรภ์และคลอดทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE anc_labor_sexage_invalid_a;
INSERT INTO anc_labor_sexage_invalid_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,
nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent

FROM

(	select h.distcode, ca.ampurname, count(a.pid)as pid 
	 from hdc.anc a
	 left join hdc.person p on p.hospcode=a.hospcode and a.pid=p.pid 
	 left join hdc.labor l on l.hospcode=p.hospcode and l.pid=p.pid
	 left join hdc.chospital h on h.hoscode=a.hospcode 
	 join hdc.campur ca on ca.ampurcode = h.distcode and ca.changwatcode=@province
	 where p.nation='099' and (a.date_Serv > '2016-12-31' or  l.bdate between @start_d and @end_d ) 
	 group by h.distcode) nd

left JOIN 

(select h.distcode, count(a.pid)as y_cases 
	 from hdc.anc a
	 left join hdc.person p on p.hospcode=a.hospcode and a.pid=p.pid 
	 left join hdc.labor l on l.hospcode=p.hospcode and l.pid=p.pid
	 left join hdc.chospital h on h.hoscode=a.hospcode 
	 where p.nation='099' and (a.date_Serv > '2016-12-31' or  l.bdate between @start_d and @end_d ) 
	 and ( p.sex='1' or ( timestampdiff(year,p.birth,a.date_serv) <11 and sex='2' )  
	 or ( timestampdiff(year,p.birth,a.date_Serv) >55 and sex='2' ) )
	 group by h.distcode
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
chargelist varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสรายการค่าบริการ',
instype varchar(15) NOT NULL DEFAULT '' COMMENT 'สิทธิการรักษาที่เบิก',
cost varchar(15) NOT NULL DEFAULT '' COMMENT 'ราคาทุนของบริการ',
price varchar(15) NOT NULL DEFAULT '' COMMENT 'ค่าบริการทั้งหมด (ราคาขาย)',
PRIMARY KEY (id)

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE charge_opd_chargeitem_t;

INSERT INTO charge_opd_chargeitem_t
(
hospcode,hosname,pid,fullname,date_serv,chargeitem,CHARGELIST,INSTYPE,cost,price
)

( 
select s.hospcode, h.hosname, s.pid,concat(p.`NAME`,' ',p.LNAME)as fullname, s.date_serv, s.chargeitem ,s.CHARGELIST, s.INSTYPE
,s.cost, s.price
from hdc.charge_opd s
LEFT JOIN hdc.cchargeitem i on i.id_chargeitem=s.CHARGEITEM
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
-- Procedure structure for `chfu_BP_not_standard`
-- ----------------------------
DROP PROCEDURE IF EXISTS `chfu_BP_not_standard`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `chfu_BP_not_standard`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
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
DROP TABLE IF EXISTS chronic_bp_non_range_t;
CREATE TABLE chronic_bp_non_range_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
HOSPCODE varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
date_serv date COMMENT 'วันรับบริการ',
sbp VARCHAR(3) NOT NULL DEFAULT '' COMMENT 'ความดันโลหิต ซิสโตลิก',
dbp VARCHAR(3) NOT NULL DEFAULT '' COMMENT 'ความดันโลหิต ไดแอสโตลิก',
waist_cm VARCHAR(3) NOT NULL DEFAULT '' COMMENT 'รอบเอว',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronic_bp_non_range_t;
INSERT INTO chronic_bp_non_range_t
(
HOSPCODE,hosname,pid,date_serv,sbp,dbp,waist_cm
)

( 
select hospcode, h.hosname, pid, date_serv, sbp, dbp, waist_cm from hdc.chronicfu c 
left join hdc.chospital h on h.hoscode=c.hospcode 
where date_serv between @start_d and @end_d 
and sbp >0 and ( sbp<=dbp or sbp <50 or dbp <50  or sbp<dbp ) 
group by hospcode,pid,date_serv order by hospcode
);


 #################################
 #Routine body goes here...
DROP TABLE IF EXISTS chronic_bp_non_range_s;
CREATE TABLE chronic_bp_non_range_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนที่รับบริการทั้งหมด(ครั้ง)',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ (ครั้ง)',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronic_bp_non_range_s;
INSERT INTO chronic_bp_non_range_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode , 
nd.seq,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/seq)*100,2) as percent

 FROM 
  (select hospcode, h.hosname, count(pid)as y_cases 
	 from hdc.chronicfu c
	 left join hdc.chospital h on h.hoscode=c.hospcode
	 where date_serv between @start_d and @end_d and sbp<>'0' 
	 and sbp >0 and ( sbp<=dbp or sbp <50 or dbp <50  or sbp<dbp ) 
	 group by hospcode )as st

LEFT JOIN 

 (SELECT c.HOSPCODE,h.hosname,h.distcode ,COUNT(c.SEQ) as seq 
  from hdc.chronicfu c
	 left join hdc.chospital h on h.hoscode=c.hospcode
	 where date_serv between @start_d and @end_d 
	 group by hospcode ) nd  
	on nd.hospcode=st.hospcode 
  ORDER BY st.hospcode
);

#################################
 #Routine body goes here...
DROP TABLE IF EXISTS chronic_bp_non_range_a;
CREATE TABLE chronic_bp_non_range_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE chronic_bp_non_range_a;
INSERT INTO chronic_bp_non_range_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 

SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,
nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round(pid/(IFNULL(st.y_cases,0))*100,2) as percent

FROM
	(select h.distcode, ca.ampurname, count(pid)as pid 
	 from hdc.chronicfu c
	 left join hdc.chospital h on h.hoscode=c.hospcode
	 JOIN hdc.campur ca on ca.ampurcode = h.distcode and ca.changwatcode=@province
	 where date_serv between @start_d and @end_d and sbp<>'0' 
	 and sbp >0 and ( sbp<=dbp or sbp <50 or dbp <50  or sbp<dbp ) 
	 GROUP BY h.distcode) nd

left JOIN 

	(select h.distcode, count(seq)as y_cases 
	 from hdc.chronicfu c
	 left join hdc.chospital h on h.hoscode=c.hospcode
	 JOIN hdc.campur ca on ca.ampurcode = h.distcode and ca.changwatcode=@province
	 where date_serv between @start_d and @end_d 
	 group by h.distcode )as st 

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
-- Procedure structure for `dental_anc_KPI`
-- ----------------------------
DROP PROCEDURE IF EXISTS `dental_anc_KPI`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dental_anc_KPI`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
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

DROP TABLE IF EXISTS dental_anc_KPI_error_t;
CREATE TABLE dental_anc_KPI_error_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'หน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ผู้รับบริการ',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
typearea varchar(1) NOT NULL DEFAULT '' COMMENT 'สถานะพักอาศัย',
anc_date date COMMENT 'วันรับบริการANC',
dental_care date COMMENT 'วันตรวจฟัน',
bdate date COMMENT 'วันที่คลอด',
denttype varchar(3) NOT NULL DEFAULT '' COMMENT 'รหัสเป้าหมายDENTAL',
provider varchar(3) NOT NULL DEFAULT '' COMMENT 'ผู้ให้บริการ',
providertype varchar(2) NOT NULL DEFAULT '' COMMENT 'ประเภทบุคลากร',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE dental_anc_KPI_error_t;

INSERT INTO dental_anc_KPI_error_t
(
hospcode,hosname,pid,fullname,typearea,anc_date,dental_care,bdate,denttype,provider,providertype
)
( 
select d.hospcode, h.hosname, d.pid, concat(pe.name,' ',pe.lname)as fullname,  pe.typearea, 
min(a.date_Serv) as anc_date, d.date_Serv as dental_care, 
l.bdate, d.denttype, d.provider, p.providertype 
from hdc.dental d
left join hdc.person pe on pe.hospcode=d.hospcode and pe.pid=d.pid
left join hdc.anc a on a.hospcode=d.hospcode and d.pid=a.pid 
left join hdc.labor l on l.hospcode=d.hospcode and d.pid=l.pid 
left join hdc.provider p on p.provider=d.provider and p.hospcode=p.hospcode
left join hdc.chospital h on h.hoscode=d.hospcode 
where d.date_serv between @start_d and @end_d  and a.date_serv between @start_d and @end_d 
and   d.date_serv <l.bdate and d.date_Serv>=a.date_Serv and  d.denttype <>'1' 
and l.bdate between @start_d and @end_d 
group by d.hospcode,d.pid,d.seq,d.date_Serv
);

#########################
DROP TABLE IF EXISTS dental_anc_KPI_error_s;
CREATE TABLE dental_anc_KPI_error_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ', ##
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ', ##
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ', ##
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ', ##
total_provider VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด/คน', ##
y_cases varchar(2) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ', ##
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ', ##
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE dental_anc_KPI_error_s;

INSERT INTO dental_anc_KPI_error_s
(
hospcode,hosname,distcode,total_provider,y_cases,percent
)
( 
SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode , 
nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent

 FROM 
  
  (select d.hospcode,h.hosname, count(d.pid)as y_cases 
  from hdc.dental d
  inner join hdc.person pe on pe.hospcode=d.hospcode and pe.pid=d.pid
  inner join hdc.anc a on a.hospcode=d.hospcode and d.pid=a.pid 
  left join hdc.labor l on l.hospcode=d.hospcode and d.pid=l.pid 
  left join hdc.provider p on p.provider=d.provider and p.hospcode=p.hospcode
  left join hdc.chospital h on h.hoscode=d.hospcode 
  where d.date_serv between @start_d and @end_d  and a.date_serv between @start_d and @end_d 
  and   d.date_serv <=l.bdate and d.date_Serv>=a.date_Serv and  d.denttype <>'1' 
  and l.bdate between @start_d and @end_d 
  group by d.hospcode )as st

LEFT JOIN 

  (select d.hospcode,h.hosname,h.distcode, count(d.pid)as pid 
  from hdc.dental d
  inner join hdc.person pe on pe.hospcode=d.hospcode and pe.pid=d.pid
  inner join hdc.anc a on a.hospcode=d.hospcode and d.pid=a.pid 
  left join hdc.labor l on l.hospcode=d.hospcode and d.pid=l.pid 
  left join hdc.provider p on p.provider=d.provider and p.hospcode=p.hospcode
  left join hdc.chospital h on h.hoscode=d.hospcode 
  where d.date_serv between @start_d and @end_d and a.date_serv between @start_d and @end_d 
  and   d.date_serv <=l.bdate and d.date_Serv>=a.date_Serv  
  and l.bdate between @start_d and @end_d 
  group by d.hospcode ) nd  

on nd.hospcode=st.hospcode 
ORDER BY st.hospcode
);

########
DROP TABLE IF EXISTS dental_anc_KPI_error_a;
CREATE TABLE dental_anc_KPI_error_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ', ##
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ', ##
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนครั้ง', ##
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ', ##
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ', ##
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE dental_anc_KPI_error_a;

INSERT INTO dental_anc_KPI_error_a
(
distcode,ampurname,total_pid,y_cases,percent
)
( 
SELECT concat(@province,nd.distcode) as distcode ,st.ampurname as ampurname, 
nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent

 FROM 
  
  (select d.hospcode,h.hosname,h.distcode, ca.ampurname as ampurname, count(d.pid)as y_cases 
  from hdc.dental d
  inner join hdc.person pe on pe.hospcode=d.hospcode and pe.pid=d.pid
  inner join hdc.anc a on a.hospcode=d.hospcode and d.pid=a.pid 
  left join hdc.labor l on l.hospcode=d.hospcode and d.pid=l.pid 
  left join hdc.provider p on p.provider=d.provider and p.hospcode=p.hospcode
  left join hdc.chospital h on h.hoscode=d.hospcode 
	JOIN hdc.campur ca on ca.ampurcode = h.distcode and ca.changwatcode=@province
  where d.date_serv between @start_d and @end_d  and a.date_serv between @start_d and @end_d 
  and   d.date_serv <=l.bdate and d.date_Serv>=a.date_Serv and  d.denttype <>'1' 
  and l.bdate between @start_d and @end_d 
  group by h.distcode )as st

LEFT JOIN 

  (select d.hospcode,h.hosname,h.distcode, count(d.pid)as pid 
  from hdc.dental d
  inner join hdc.person pe on pe.hospcode=d.hospcode and pe.pid=d.pid
  inner join hdc.anc a on a.hospcode=d.hospcode and d.pid=a.pid 
  left join hdc.labor l on l.hospcode=d.hospcode and d.pid=l.pid 
  left join hdc.provider p on p.provider=d.provider and p.hospcode=p.hospcode
  left join hdc.chospital h on h.hoscode=d.hospcode 
  where d.date_serv between @start_d and @end_d and a.date_serv between @start_d and @end_d 
  and   d.date_serv <=l.bdate and d.date_Serv>=a.date_Serv  
  and l.bdate between @start_d and @end_d 
  group by h.distcode ) nd  

on nd.distcode=st.distcode 
ORDER BY st.y_cases desc
);

################################################################################

UPDATE sys_log
SET e_time=CURRENT_TIME(), log_status='complete'
WHERE procedure_names=procedure_name ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `labfu_choltg_invalid`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labfu_choltg_invalid`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labfu_choltg_invalid`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
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
DROP TABLE IF EXISTS labfu_choltg_invalid_t;
CREATE TABLE labfu_choltg_invalid_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid varchar(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-นามสกุล',
date_serv date COMMENT 'วันรับบริการ',
labcode VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'รหัสการตรวจทางห้องปฏิบัติการ',
labresult VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'ผล Lab',
remark VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'หมายเหตุ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_choltg_invalid_t;
INSERT INTO labfu_choltg_invalid_t
(
HOSPCODE,hosname,pid,fullname,date_serv,labcode,labresult,remark
)

( 
select  t.hospcode,h.hosname,p.pid,concat(p.name,' ',p.lname)as fullname, date_serv,t.labtest as labcode
,labresult,' ผลตรวจ??'  as remark 
from hdc.labfu t
inner  join hdc.person p on p.pid=t.pid and p.hospcode=t.hospcode
inner join hdc.clabtest_new n on n.code=t.labtest
join hdc.chospital h  on h.hoscode= t.hospcode
where t.date_serv between @start_d and @end_d and  ((labtest in('07','0541602') and
labresult not between 10 and 1000 )  or (labtest in('06','0546602')
and labresult not between 10 and 2000 ))
group by t.hospcode,t.pid,t.date_Serv,t.labtest
order by hospcode
);
 
#################################
 #Routine body goes here...
DROP TABLE IF EXISTS labfu_choltg_invalid_s;
CREATE TABLE labfu_choltg_invalid_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(4) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(7) NOT NULL DEFAULT '' COMMENT 'ตรวจทางห้องปฏิบัติการทั้งหมด',
y_cases VARCHAR(7) NOT NULL DEFAULT '' COMMENT 'ผลตรวจทางห้องปฏิบัติการผิดมาตรฐานทั้งหมด',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_choltg_invalid_s;
INSERT INTO labfu_choltg_invalid_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode , 
nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent

 FROM 
  
 (select t.hospcode,h.hosname, count(t.pid)as y_cases 
 from hdc.labfu t
 inner  join hdc.person p on p.pid=t.pid and p.hospcode=t.hospcode
 inner join hdc.clabtest_new n on n.code=t.labtest
 join hdc.chospital h  on h.hoscode= t.hospcode
 where t.date_serv between @start_d and @end_d and  ((labtest in('07','0541602') and
 labresult not between 10 and 1000 )  or (labtest in('06','0546602')
 and labresult not between 10 and 2000 ))
 group by t.hospcode
 order by hospcode)as st

LEFT JOIN 

 (select t.hospcode,h.hosname,h.distcode, count(t.pid)as pid 
 from hdc.labfu t
 inner  join hdc.person p on p.pid=t.pid and p.hospcode=t.hospcode
 inner join hdc.clabtest_new n on n.code=t.labtest
 join hdc.chospital h  on h.hoscode= t.hospcode
 where t.date_serv between @start_d and @end_d and  ((labtest in('07','0541602')  )  or (labtest in('06','0546602')))
 
 group by t.hospcode
 order by hospcode) nd  

on nd.hospcode=st.hospcode 
ORDER BY st.hospcode
);


#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labfu_choltg_invalid_a;
CREATE TABLE labfu_choltg_invalid_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(7) NOT NULL DEFAULT '' COMMENT 'ตรวจทางห้องปฏิบัติการทั้งหมด',
y_cases VARCHAR(7) NOT NULL DEFAULT '' COMMENT 'ผลตรวจทางห้องปฏิบัติการผิดมาตรฐานทั้งหมด',
percent VARCHAR(7) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_choltg_invalid_a;
INSERT INTO labfu_choltg_invalid_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 
SELECT concat(@province,nd.distcode) as distcode, st.ampurname as ampurname,
nd.pid, 
IFNULL(st.y_cases,0) as y_cases, 
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent

FROM 
    (select t.hospcode,h.hosname,h.distcode, ca.ampurname ,count(t.pid)as y_cases 
  from hdc.labfu t
  inner  join hdc.person p on p.pid=t.pid and p.hospcode=t.hospcode
  inner join hdc.clabtest_new n on n.code=t.labtest
  join hdc.chospital h  on h.hoscode= t.hospcode
  JOIN hdc.campur ca on ca.ampurcode = h.distcode and ca.changwatcode=@province
  where t.date_serv between @start_d and @end_d and  ((labtest in('07','0541602') and
  labresult not between 10 and 1000 )  or (labtest in('06','0546602')
  and labresult not between 10 and 2000 ))
  group by h.distcode )as st 

left JOIN

    (select t.hospcode,h.hosname,h.distcode, count(t.pid)as pid 
  from hdc.labfu t
  inner  join hdc.person p on p.pid=t.pid and p.hospcode=t.hospcode
  inner join hdc.clabtest_new n on n.code=t.labtest
  join hdc.chospital h  on h.hoscode= t.hospcode
  where t.date_serv between @start_d and @end_d and ((labtest in('07','0541602') 
   )  or (labtest in('06','0546602')
  ))
  group by h.distcode )as nd

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
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('11',' 0581902') AND l.labresult NOT BETWEEN '0.01' AND '25' 
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
where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('11',' 0581902') 
GROUP BY l.HOSPCODE) nd 
LEFT JOIN (SELECT l.HOSPCODE,ch.hosname,COUNT(distinct l.pid) as y_cases FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC FROM hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I15'  or CHRONIC BETWEEN 'N18' AND 'N189' and TYPEDISCH <>'02')c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST 
LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
WHERE l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('11',' 0581902') AND l.labresult NOT BETWEEN '0.01' AND '25' 
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
where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('11','0581902') 
GROUP BY c.distcode) nd 
left JOIN (SELECT ch.distcode,COUNT(DISTINCT l.pid) as y_cases 
FROM hdc.labfu l 
INNER JOIN (SELECT HOSPCODE,PID,CHRONIC from hdc.chronic 
WHERE CHRONIC BETWEEN 'E10' AND 'E149' OR CHRONIC BETWEEN 'I10' AND 'I15'  or CHRONIC BETWEEN 'N18' AND 'N189'   and TYPEDISCH <>'02') c ON l.PID = c.PID AND l.HOSPCODE = c.HOSPCODE 
LEFT JOIN hdc.clabtest lt on lt.id_labtest=l.LABTEST 
LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE 
where l.date_serv BETWEEN @start_d AND @end_d and l.labtest in ('11','0581902') AND l.labresult NOT BETWEEN '0.01' AND '25' 
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
-- Procedure structure for `labfu_labtest_not_standard`
-- ----------------------------
DROP PROCEDURE IF EXISTS `labfu_labtest_not_standard`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `labfu_labtest_not_standard`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
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
DROP TABLE IF EXISTS labfu_labtest_not_standard_t;
CREATE TABLE labfu_labtest_not_standard_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
HOSPCODE varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
labcode VARCHAR(2) NOT NULL DEFAULT '' COMMENT 'รหัสการตรวจทางห้องปฏิบัติการ',
min_dateserv date COMMENT 'วันเริ่มต้นบันทึกผลผิดพลาด',
max_dateserv date COMMENT 'วันที่ล่าสุดบันทึกผลผิดพลาด',
total VARCHAR(7) NOT NULL DEFAULT '' COMMENT 'บันทึกผลผิดพลาดทั้งหมด(ครั้ง)',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_labtest_not_standard_t;
INSERT INTO labfu_labtest_not_standard_t
(
HOSPCODE,hosname,labcode,min_dateserv,max_dateserv,total
)

( 
select hospcode,hosname,l.labtest as labcode,min(l.date_serv)as min_dateserv, MAX(l.date_serv)as max_dateserv, count(seq)  as total
from hdc.labfu l
left join hdc.clabtest cl on cl.id_labtest=l.LABTEST
left join hdc.clabtest_new ca on ca.`code`=l.LABTEST
left join hdc.chospital  h on h.hoscode=l.HOSPCODE
where l.date_serv between @start_d and @end_d and ( ( length(l.labtest)=7 and ca.code is null ) or length(l.labtest) <7)
group by l.hospcode
);


#################################
 #Routine body goes here...
DROP TABLE IF EXISTS labfu_labtest_not_standard_s;
CREATE TABLE labfu_labtest_not_standard_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(4) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(7) NOT NULL DEFAULT '' COMMENT 'ตรวจทางห้องปฏิบัติการทั้งหมด(ครั้ง)',
y_cases VARCHAR(7) NOT NULL DEFAULT '' COMMENT 'จำนวนเอ๊ะทั้งหมด(ครั้ง)',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_labtest_not_standard_s;
INSERT INTO labfu_labtest_not_standard_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode,nd.hosname,concat(@province,nd.distcode) as distcode , 
nd.seq,
IFNULL(st.y_cases,0) as y_cases,
round(seq/(IFNULL(st.y_cases,0))*100,2) as percent

 FROM 
  (SELECT l.HOSPCODE,ch.hosname,COUNT(l.seq) as y_cases 
  FROM hdc.labfu l 
  LEFT JOIN hdc.clabtest lt ON lt.id_labtest = l.LABTEST 
  LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
  left join hdc.clabtest_new ca on ca.`code`=l.LABTEST
  WHERE l.date_serv BETWEEN @start_d AND @end_d and 
  ( (length(l.labtest)=7 and ca.code is null)or length(l.labtest) <7 )   
  GROUP BY l.HOSPCODE)as st

LEFT JOIN 

 (SELECT l.HOSPCODE,ch.hosname,ch.distcode ,COUNT(l.seq) as seq 
  FROM hdc.labfu l 
	LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE 
  where l.date_serv BETWEEN @start_d AND @end_d 
  GROUP BY l.HOSPCODE) nd  
	on nd.hospcode=st.hospcode 
  ORDER BY st.hospcode
);

#################################

 #Routine body goes here...
DROP TABLE IF EXISTS labfu_labtest_not_standard_a;
CREATE TABLE labfu_labtest_not_standard_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid VARCHAR(7) NOT NULL DEFAULT '' COMMENT 'ตรวจทางห้องปฏิบัติการทั้งหมด(ครั้ง)',
y_cases VARCHAR(7) NOT NULL DEFAULT '' COMMENT 'จำนวนเอ๊ะทั้งหมด(ครั้ง)',
percent VARCHAR(7) NOT NULl DEFAULT '' COMMENT 'ร้อยละ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE labfu_labtest_not_standard_a;
INSERT INTO labfu_labtest_not_standard_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 
SELECT concat(@province,nd.distcode) as distcode, nd.ampurname as ampurname,
nd.seq AS total_pid, 
IFNULL(st.y_cases,0) as y_cases, 
round((IFNULL(st.y_cases,0)/seq)*100,2) as percent

FROM 
    (SELECT l.HOSPCODE,ch.hosname,ch.distcode, ca.ampurname ,COUNT(l.seq) as seq 
     FROM hdc.labfu l 
		 LEFT JOIN hdc.chospital ch on ch.hoscode=l.HOSPCODE 
		 JOIN hdc.campur ca on ca.ampurcode = ch.distcode and ca.changwatcode=@province 
     where l.date_serv BETWEEN @start_d AND @end_d 
     GROUP BY ch.distcode )as nd 

left JOIN

    (SELECT l.HOSPCODE, ch.hosname, ch.distcode, COUNT(l.seq) as y_cases 
    FROM hdc.labfu l 
    LEFT JOIN hdc.chospital ch ON ch.hoscode = l.HOSPCODE 
    left join hdc.clabtest_new ca on ca.`code`=l.LABTEST
    WHERE l.date_serv BETWEEN @start_d AND @end_d and 
    ((length(l.labtest)=7 and ca.code is null)or length(l.labtest) <7)   
    GROUP BY ch.distcode)as st
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
-- Procedure structure for `newborn_asphyxia_not_standard`
-- ----------------------------
DROP PROCEDURE IF EXISTS `newborn_asphyxia_not_standard`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `newborn_asphyxia_not_standard`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
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
DROP TABLE IF EXISTS newborn_asphyxia_t;
CREATE TABLE newborn_asphyxia_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
pid VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'ทะเบียนบุคคล',
fullname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อ-สกุล',
sex VARCHAR(120) NOT NULL DEFAULT '' COMMENT 'เพศ',
bdate date COMMENT 'วันที่คลอด',
bweight varchar(5) NOT NULL DEFAULT '' COMMENT 'น้ำหนักแรกเกิด',
asphyxia varchar(5) NOT NULL DEFAULT '' COMMENT 'สภาวการณ์ขาดออกซิเจน',
bhosp varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสสถานพยาบาลที่คลอด',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_asphyxia_t;
INSERT INTO newborn_asphyxia_t
(
HOSPCODE,hosname,PID,fullname,sex,bdate,bweight,asphyxia,bhosp
)

( 
select n.hospcode, hosname, n.pid, CONCAT(p.name,' ',p.lname)as fullname, p.sex, 
n.bdate, n.bweight, asphyxia, n.bhosp 
from hdc.newborn n
left join hdc.person p on p.pid=n.pid and p.hospcode=n.hospcode
left join hdc.chospital  h on h.hoscode=n.HOSPCODE
 where n.bdate between @start_d and @end_d  
and n.hospcode=n.bhosp and n.btype<> 6 
and n.bplace in (1,2 ) and n.bdoctor in (1,2,3) 
and n.bweight >2500 and (n. asphyxia <3 or n.asphyxia ='99')
order by n.hospcode,n.bdate desc
);


#################################
 #Routine body goes here...
DROP TABLE IF EXISTS newborn_asphyxia_s;
CREATE TABLE newborn_asphyxia_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_asphyxia_s;
INSERT INTO newborn_asphyxia_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode, c.hosname, concat(@province,c.distcode) as distcode, 
nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/pid)*100,2) as percent

FROM

	(SELECT hospcode,count(pid) as pid 
	from hdc.newborn n	
	where n.bdate between @start_d and @end_d
	GROUP BY HOSPCODE) nd

LEFT JOIN

	(select n.hospcode,count(n.pid) as y_cases
	from hdc.newborn n
	where n.bdate between @start_d and @end_d  
	and n.hospcode=n.bhosp and n.btype<> 6 
	and n.bplace in (1,2 ) and n.bdoctor in (1,2,3) 
	and n.bweight >2500 and (n. asphyxia <3 or n.asphyxia ='99') 
	group by n.hospcode)as st

on nd.hospcode=st.hospcode
left outer join hdc.chospital c on c.hoscode=nd.HOSPCODE
order by st.y_cases DESC
);


################################
 #Routine body goes here...
DROP TABLE IF EXISTS newborn_asphyxia_a;
CREATE TABLE newborn_asphyxia_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนทารก',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวนน้ำหนักผิดปกติ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE newborn_asphyxia_a;
INSERT INTO newborn_asphyxia_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,
nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent

FROM

	(SELECT c.distcode,ca.ampurname,count(n.pid) as pid 
	FROM hdc.newborn n
	join hdc.chospital c on c.hoscode=n.HOSPCODE
	join hdc.campur ca on ca.ampurcode = c.distcode and ca.changwatcode=@province
	where n.bdate BETWEEN @start_d AND @end_d  
	GROUP BY c.distcode) nd

left JOIN 

	(select c.distcode,count(n.pid) as y_cases
	from hdc.newborn n
	join hdc.chospital c on c.hoscode=n.HOSPCODE
	where n.bdate between @start_d and @end_d 
	and n.hospcode=n.bhosp and n.btype<> 6 
	and n.bplace in (1,2 ) and n.bdoctor in (1,2,3) 
	and n.bweight >2500 and (n. asphyxia <3 or n.asphyxia ='99')
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
cid varchar(13) NOT NULL DEFAULT '' COMMENT 'รหัสบุคคล',
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
-- Procedure structure for `provider_PHRs_poor_quality`
-- ----------------------------
DROP PROCEDURE IF EXISTS `provider_PHRs_poor_quality`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `provider_PHRs_poor_quality`(IN s_runtime date, IN e_runtime date, IN procedure_name VARCHAR(100))
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

DROP TABLE IF EXISTS provider_loss_quality_t;
CREATE TABLE provider_loss_quality_t (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
provider_code varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
start_dx date COMMENT 'วันที่เริ่มให้บริการ',
last_dx date COMMENT 'วันที่การให้บริการล่าสุด',
loss_quality_PHRs varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนข้อมูลการให้บริการที่เสียหาย',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE provider_loss_quality_t;
INSERT INTO provider_loss_quality_t
(
HOSPCODE,hosname,provider_code,start_dx,last_dx,loss_quality_PHRs
)

( 
select d.hospcode,h.hosname,d.provider as provider_code,
min(d.date_serv) as start_dx, max(d.date_serv) as last_dx,
count(d.seq) as loss_quality_PHRs  
from hdc.diagnosis_opd d
left join hdc.chospital h on h.hoscode=d.hospcode
left join hdc.provider p on p.hospcode=d.hospcode and d.provider=p.provider  
where diagtype='1' and d.date_serv between @start_d and @end_d and (d.provider is null)
group by hospcode,d.provider
having count(DISTINCT d.seq) >10
order by d.hospcode,loss_quality_PHRs desc
);



#################################
 #Routine body goes here...
DROP TABLE IF EXISTS provider_loss_quality_s;
CREATE TABLE provider_loss_quality_s (
id int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ',
hospcode varchar(5) NOT NULL DEFAULT '' COMMENT 'รหัสหน่วยบริการ',
hosname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่อหน่วยบริการ',
distcode varchar(15) NOT NULL DEFAULT '' COMMENT 'รหัสอำเภอ',
total_pid VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวนทั้งหมด',
y_cases VARCHAR(5) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent VARCHAR(5) NOT NULl DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE provider_loss_quality_s;
INSERT INTO provider_loss_quality_s
(
hospcode,hosname,distcode,total_pid,y_cases,percent
)

( 
SELECT nd.hospcode, c.hosname, concat(@province,c.distcode) as distcode, 
nd.total_provider,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0)/total_provider)*100,2) as percent

FROM

 ( select d.hospcode, count(distinct d.PROVIDER) as total_provider  
  from hdc.diagnosis_opd d
  left join hdc.chospital h on h.hoscode=d.hospcode
  left join hdc.provider p on p.hospcode=d.hospcode and d.provider=p.provider  
  where d.date_serv between @start_d and @end_d 
  group by hospcode
  having count(d.seq) >10 ) nd

LEFT JOIN

 (select d.hospcode, count(distinct d.PROVIDER) as y_cases  
  from hdc.diagnosis_opd d
  left join hdc.chospital h on h.hoscode=d.hospcode
  left join hdc.provider p on p.hospcode=d.hospcode and d.provider=p.provider  
  where diagtype='1' and d.date_serv between @start_d and @end_d and (d.provider is null)
  group by hospcode
  having count(d.seq) >10 )as st

on nd.hospcode=st.hospcode
left outer join hdc.chospital c on c.hoscode=nd.HOSPCODE
order by st.y_cases DESC
);


################################
 #Routine body goes here...
DROP TABLE IF EXISTS provider_loss_quality_a;
CREATE TABLE provider_loss_quality_a (
distcode varchar(15) NOT NULL DEFAULT '' COMMENT ' รหัสอำเภอ',
ampurname varchar(100) NOT NULL DEFAULT '' COMMENT 'ชื่ออำเภอ',
total_pid varchar(15) NOT NULL DEFAULT '' COMMENT 'จำนวนฝากครรภ์และคลอดทั้งหมด',
y_cases VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'จำนวน เอ๊ะ',
percent varchar(5) NOT NULL DEFAULT '' COMMENT 'ร้อยละ เอ๊ะ',
PRIMARY KEY (distcode)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

TRUNCATE TABLE provider_loss_quality_a;
INSERT INTO provider_loss_quality_a
(
distcode,ampurname,total_pid,y_cases,percent
)

( 
SELECT concat(@province,nd.distcode) as distcode,nd.ampurname,
nd.pid,
IFNULL(st.y_cases,0) as y_cases,
round((IFNULL(st.y_cases,0) /pid)*100,2) as percent

FROM

(		select h.distcode, ca.ampurname, count(distinct d.PROVIDER) as pid  
		from hdc.diagnosis_opd d
		left join hdc.chospital h on h.hoscode=d.hospcode
		left join hdc.provider p on p.hospcode=d.hospcode and d.provider=p.provider
		join hdc.campur ca on ca.ampurcode = h.distcode and ca.changwatcode=@province
		where d.date_serv between @start_d and @end_d 
		group by h.distcode
		having count(d.seq) >10 ) nd

left JOIN 

(		select h.distcode, count(distinct d.PROVIDER) as y_cases  
		from hdc.diagnosis_opd d
		left join hdc.chospital h on h.hoscode=d.hospcode
		left join hdc.provider p on p.hospcode=d.hospcode and d.provider=p.provider  
		where diagtype='1' and d.date_serv between @start_d and @end_d and (d.provider is null)
		group by h.distcode
		having count(d.seq) >10 )as st 

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
