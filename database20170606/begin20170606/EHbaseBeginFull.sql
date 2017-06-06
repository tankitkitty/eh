/*
Navicat MySQL Data Transfer

Source Server         : HDC
Source Server Version : 50615
Source Host           : 203.157.151.20:3306
Source Database       : eh_begin

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2017-06-06 11:26:04
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `auth_assignment`
-- ----------------------------
DROP TABLE IF EXISTS `auth_assignment`;
CREATE TABLE `auth_assignment` (
`item_name`  varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL ,
`user_id`  varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL ,
`created_at`  int(11) NULL DEFAULT NULL ,
PRIMARY KEY (`item_name`, `user_id`),
FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_unicode_ci

;

-- ----------------------------
-- Records of auth_assignment
-- ----------------------------
BEGIN;
INSERT INTO `auth_assignment` VALUES ('ผู้ดูแลระบบ', '536', '1452505231');
COMMIT;

-- ----------------------------
-- Table structure for `auth_item`
-- ----------------------------
DROP TABLE IF EXISTS `auth_item`;
CREATE TABLE `auth_item` (
`name`  varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL ,
`type`  int(11) NOT NULL ,
`description`  text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL ,
`rule_name`  varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL ,
`data`  text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL ,
`created_at`  int(11) NULL DEFAULT NULL ,
`updated_at`  int(11) NULL DEFAULT NULL ,
PRIMARY KEY (`name`),
FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_unicode_ci

;

-- ----------------------------
-- Records of auth_item
-- ----------------------------
BEGIN;
INSERT INTO `auth_item` VALUES ('/*', '2', null, null, null, '1452504911', '1452504911'), ('/report/*', '2', null, null, null, '1452504959', '1452504959'), ('/report/report/calldocs', '2', null, null, null, '1477020229', '1477020229'), ('/report/report/chk', '2', null, null, null, '1452506311', '1452506311'), ('/report/report/index', '2', null, null, null, '1452506495', '1452506495'), ('/report/report/runreport1', '2', null, null, null, '1452504869', '1452504869'), ('/report/report/runreport2', '2', null, null, null, '1452504875', '1452504875'), ('/report/report/runreport3', '2', null, null, null, '1453696196', '1453696196'), ('/user/*', '2', null, null, null, '1452504951', '1452504951'), ('/user/registration/register', '2', null, null, null, '1452508225', '1452508225'), ('/user/security/login', '2', null, null, null, '1452504938', '1452504938'), ('/user/security/logout', '2', null, null, null, '1452504940', '1452504940'), ('ADMIN', '2', null, null, null, '1452504894', '1452504997'), ('admin_cup', '2', null, null, null, '1452505038', '1452505038'), ('pcu', '2', null, null, null, '1452505096', '1452505096'), ('province', '2', null, null, null, '1495510923', '1495510923'), ('ผู้ดูแลระดับจังหวัด', '1', null, null, null, '1494995491', '1494995491'), ('ผู้ดูแลระบบ', '1', null, null, null, '1452505116', '1452505116'), ('ผู้ดูแลระบบระดับ cup', '1', null, null, null, '1452505173', '1452505173'), ('หน่วยบริการ', '1', null, null, null, '1452505187', '1452505187');
COMMIT;

-- ----------------------------
-- Table structure for `auth_item_child`
-- ----------------------------
DROP TABLE IF EXISTS `auth_item_child`;
CREATE TABLE `auth_item_child` (
`parent`  varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL ,
`child`  varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL ,
PRIMARY KEY (`parent`, `child`),
FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_unicode_ci

;

-- ----------------------------
-- Records of auth_item_child
-- ----------------------------
BEGIN;
INSERT INTO `auth_item_child` VALUES ('ADMIN', '/*'), ('admin_cup', '/report/report/calldocs'), ('pcu', '/report/report/calldocs'), ('province', '/report/report/calldocs'), ('admin_cup', '/report/report/chk'), ('pcu', '/report/report/chk'), ('province', '/report/report/chk'), ('admin_cup', '/report/report/index'), ('pcu', '/report/report/index'), ('province', '/report/report/index'), ('province', '/report/report/runreport1'), ('admin_cup', '/report/report/runreport2'), ('province', '/report/report/runreport2'), ('pcu', '/report/report/runreport3'), ('province', '/report/report/runreport3'), ('ผู้ดูแลระบบ', '/user/*'), ('admin_cup', '/user/security/login'), ('pcu', '/user/security/login'), ('province', '/user/security/login'), ('admin_cup', '/user/security/logout'), ('pcu', '/user/security/logout'), ('province', '/user/security/logout'), ('ผู้ดูแลระบบ', 'ADMIN'), ('ผู้ดูแลระบบระดับ cup', 'admin_cup'), ('หน่วยบริการ', 'pcu'), ('ผู้ดูแลระดับจังหวัด', 'province');
COMMIT;

-- ----------------------------
-- Table structure for `auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `auth_rule`;
CREATE TABLE `auth_rule` (
`name`  varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL ,
`data`  text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL ,
`created_at`  int(11) NULL DEFAULT NULL ,
`updated_at`  int(11) NULL DEFAULT NULL ,
PRIMARY KEY (`name`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_unicode_ci

;

-- ----------------------------
-- Records of auth_rule
-- ----------------------------
BEGIN;
COMMIT;

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
-- Table structure for `l_icd101`
-- ----------------------------
DROP TABLE IF EXISTS `l_icd101`;
CREATE TABLE `l_icd101` (
`CODE`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`VALID`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`DESC_R`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`SEX`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`PTYPE`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`start_date`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`end_date`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL 
)
ENGINE=MyISAM
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of l_icd101
-- ----------------------------
BEGIN;
INSERT INTO `l_icd101` VALUES ('A00', 'F', 'Cholera', '', '', '25510101', '99999999'), ('A01', 'F', 'Typhoid and paratyphoid fevers', '', '', '25510101', '99999999'), ('A02', 'F', 'Other salmonella infections', '', '', '25510101', '99999999'), ('A03', 'F', 'Shigellosis', '', '', '25510101', '99999999'), ('A04', 'F', 'Other bacterial intestinal infections', '', '', '25510101', '99999999'), ('A05', 'F', 'Other bacterial foodborne intoxications', '', '', '25510101', '99999999'), ('A06', 'F', 'Amoebiasis', '', '', '25510101', '99999999'), ('A07', 'F', 'Other protozoal intestinal diseases', '', '', '25510101', '99999999'), ('A08', 'F', 'Viral and other specified intestinal infections', '', '', '25510101', '99999999'), ('A15', 'F', 'Respiratory tuberculosis, bacteriologically and histologically confirmed', '', '', '25510101', '99999999'), ('A16', 'F', 'Respiratory tuberculosis, not confirmed bacteriologically or histologically', '', '', '25510101', '99999999'), ('A17', 'F', 'Tuberculosis of nervous system', '', '', '25510101', '99999999'), ('A18', 'F', 'Tuberculosis of other organs', '', '', '25510101', '99999999'), ('A19', 'F', 'Miliary tuberculosis', '', '', '25510101', '99999999'), ('A20', 'F', 'Plague', '', '', '25510101', '99999999'), ('A21', 'F', 'Tularaemia', '', '', '25510101', '99999999'), ('A22', 'F', 'Anthrax', '', '', '25510101', '99999999'), ('A23', 'F', 'Brucellosis', '', '', '25510101', '99999999'), ('A24', 'F', 'Glanders and melioidosis', '', '', '25510101', '99999999'), ('A25', 'F', 'Rat-bite fevers', '', '', '25510101', '99999999'), ('A26', 'F', 'Erysipeloid', '', '', '25510101', '99999999'), ('A27', 'F', 'Leptospirosis', '', '', '25510101', '99999999'), ('A28', 'F', 'Other zoonotic bacterial diseases, not elsewhere classified', '', '', '25510101', '99999999'), ('A30', 'F', 'Leprosy [Hansen\'s disease]', '', '', '25510101', '99999999'), ('A31', 'F', 'Infection due to other mycobacteria', '', '', '25510101', '99999999'), ('A32', 'F', 'Listeriosis', '', '', '25510101', '99999999'), ('A36', 'F', 'Diphtheria', '', '', '25510101', '99999999'), ('A37', 'F', 'Whooping cough', '', '', '25510101', '99999999'), ('A39', 'F', 'Meningococcal infection', '', '', '25510101', '99999999'), ('A40', 'F', 'Streptococcal septicaemia', '', '', '25510101', '99999999'), ('A41', 'F', 'Other septicaemia', '', '', '25510101', '99999999'), ('A42', 'F', 'Actinomycosis', '', '', '25510101', '99999999'), ('A43', 'F', 'Nocardiosis', '', '', '25510101', '99999999'), ('A44', 'F', 'Bartonellosis', '', '', '25510101', '99999999'), ('A48', 'F', 'Other bacterial diseases, not elsewhere classified', '', '', '25510101', '99999999'), ('A49', 'F', 'Bacterial infection of unspecified site', '', '', '25510101', '99999999'), ('A50', 'F', 'Congenital syphilis', '', '', '25510101', '99999999'), ('A51', 'F', 'Early syphilis', '', '', '25510101', '99999999'), ('A52', 'F', 'Late syphilis', '', '', '25510101', '99999999'), ('A53', 'F', 'Other and unspecified syphilis', '', '', '25510101', '99999999'), ('A54', 'F', 'Gonococcal infection', '', '', '25510101', '99999999'), ('A56', 'F', 'Other sexually transmitted chlamydial diseases', '', '', '25510101', '99999999'), ('A59', 'F', 'Trichomoniasis', '', '', '25510101', '99999999'), ('A60', 'F', 'Anogenital herpesviral [herpes simplex] infections', '', '', '25510101', '99999999'), ('A63', 'F', 'Other predominantly sexually transmitted diseases, not elsewhere classified', '', '', '25510101', '99999999'), ('A66', 'F', 'Yaws', '', '', '25510101', '99999999'), ('A67', 'F', 'Pinta [carate]', '', '', '25510101', '99999999'), ('A68', 'F', 'Relapsing fevers', '', '', '25510101', '99999999'), ('A69', 'F', 'Other spirochaetal infections', '', '', '25510101', '99999999'), ('A71', 'F', 'Trachoma', '', '', '25510101', '99999999'), ('A74', 'F', 'Other diseases caused by chlamydiae', '', '', '25510101', '99999999'), ('A75', 'F', 'Typhus fever', '', '', '25510101', '99999999'), ('A77', 'F', 'Spotted fever [tick-borne rickettsioses]', '', '', '25510101', '99999999'), ('A79', 'F', 'Other rickettsioses', '', '', '25510101', '99999999'), ('A80', 'F', 'Acute poliomyelitis', '', '', '25510101', '99999999'), ('A81', 'F', 'Slow virus infections of central nervous system', '', '', '25510101', '99999999'), ('A82', 'F', 'Rabies', '', '', '25510101', '99999999'), ('A83', 'F', 'Mosquito-borne viral encephalitis', '', '', '25510101', '99999999'), ('A84', 'F', 'Tick-borne viral encephalitis', '', '', '25510101', '99999999'), ('A85', 'F', 'Other viral encephalitis, not elsewhere classified', '', '', '25510101', '99999999'), ('A87', 'F', 'Viral meningitis', '', '', '25510101', '99999999'), ('A88', 'F', 'Other viral infections of the central nervous system, not elsewhere classified', '', '', '25510101', '99999999'), ('A92', 'F', 'Other mosquito-borne viral fevers', '', '', '25510101', '99999999'), ('A93', 'F', 'Other arthropod-borne viral fevers, not elsewhere classified', '', '', '25510101', '99999999'), ('A95', 'F', 'Yellow fever', '', '', '25510101', '99999999'), ('A96', 'F', 'Arenaviral haemorrhagic fever', '', '', '25510101', '99999999'), ('A98', 'F', 'Other viral haemorrhagic fevers, not elsewhere classified', '', '', '25510101', '99999999'), ('B00', 'F', 'Herpesviral [herpes simplex] infections', '', '', '25510101', '99999999'), ('B01', 'F', 'Varicella [chickenpox]', '', '', '25510101', '99999999'), ('B02', 'F', 'Zoster [herpes zoster]', '', '', '25510101', '99999999'), ('B05', 'F', 'Measles', '', '', '25510101', '99999999'), ('B06', 'F', 'Rubella [German measles]', '', '', '25510101', '99999999'), ('B08', 'F', 'Other viral infections characterized by skin and mucous membrane lesions, not elsewhere', '', '', '25510101', '99999999'), ('B15', 'F', 'Acute hepatitis A', '', '', '25510101', '99999999'), ('B16', 'F', 'Acute hepatitis B', '', '', '25510101', '99999999'), ('B17', 'F', 'Other acute viral hepatitis', '', '', '25510101', '99999999'), ('B18', 'F', 'Chronic viral hepatitis', '', '', '25510101', '99999999'), ('B19', 'F', 'Unspecified viral hepatitis', '', '', '25510101', '99999999'), ('B20', 'F', 'HIV disease resulting in infectious and parasitic diseases', '', '', '25510101', '25551130'), ('B21', 'F', 'HIV disease resulting in malignant neoplasms', '', '', '25510101', '25551130'), ('B22', 'F', 'HIV disease resulting in other specified diseases', '', '', '25510101', '25551130'), ('B23', 'F', 'HIV disease resulting in other conditions', '', '', '25510101', '25551130'), ('B25', 'F', 'Cytomegaloviral disease', '', '', '25510101', '99999999'), ('B26', 'F', 'Mumps', '', '', '25510101', '99999999'), ('B27', 'F', 'Infectious mononucleosis', '', '', '25510101', '99999999'), ('B30', 'F', 'Viral conjunctivitis', '', '', '25510101', '99999999'), ('B33', 'F', 'Other viral diseases, not elsewhere classified', '', '', '25510101', '99999999'), ('B34', 'F', 'Viral infection of unspecified site', '', '', '25510101', '99999999'), ('B35', 'F', 'Dermatophytosis', '', '', '25510101', '99999999'), ('B36', 'F', 'Other superficial mycoses', '', '', '25510101', '99999999'), ('B37', 'F', 'Candidiasis', '', '', '25510101', '99999999'), ('B38', 'F', 'Coccidioidomycosis', '', '', '25510101', '99999999'), ('B39', 'F', 'Histoplasmosis', '', '', '25510101', '99999999'), ('B40', 'F', 'Blastomycosis', '', '', '25510101', '99999999'), ('B41', 'F', 'Paracoccidioidomycosis', '', '', '25510101', '99999999'), ('B42', 'F', 'Sporotrichosis', '', '', '25510101', '99999999'), ('B43', 'F', 'Chromomycosis and phaeomycotic abscess', '', '', '25510101', '99999999'), ('B44', 'F', 'Aspergillosis', '', '', '25510101', '99999999'), ('B45', 'F', 'Cryptococcosis', '', '', '25510101', '99999999'), ('B46', 'F', 'Zygomycosis', '', '', '25510101', '99999999'), ('B47', 'F', 'Mycetoma', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('B48', 'F', 'Other mycoses, not elsewhere classified', '', '', '25510101', '99999999'), ('B50', 'F', 'Plasmodium falciparum malaria', '', '', '25510101', '99999999'), ('B51', 'F', 'Plasmodium vivax malaria', '', '', '25510101', '99999999'), ('B52', 'F', 'Plasmodium malariae malaria', '', '', '25510101', '99999999'), ('B53', 'F', 'Other parasitologically confirmed malaria', '', '', '25510101', '99999999'), ('B55', 'F', 'Leishmaniasis', '', '', '25510101', '99999999'), ('B56', 'F', 'African trypanosomiasis', '', '', '25510101', '99999999'), ('B57', 'F', 'Chagas\' disease', '', '', '25510101', '99999999'), ('B58', 'F', 'Toxoplasmosis', '', '', '25510101', '99999999'), ('B60', 'F', 'Other protozoal diseases, not elsewhere classified', '', '', '25510101', '99999999'), ('B65', 'F', 'Schistosomiasis [bilharziasis]', '', '', '25510101', '99999999'), ('B66', 'F', 'Other fluke infections', '', '', '25510101', '99999999'), ('B67', 'F', 'Echinococcosis', '', '', '25510101', '99999999'), ('B68', 'F', 'Taeniasis', '', '', '25510101', '99999999'), ('B69', 'F', 'Cysticercosis', '', '', '25510101', '99999999'), ('B70', 'F', 'Diphyllobothriasis and sparganosis', '', '', '25510101', '99999999'), ('B71', 'F', 'Other cestode infections', '', '', '25510101', '99999999'), ('B74', 'F', 'Filariasis', '', '', '25510101', '99999999'), ('B76', 'F', 'Hookworm diseases', '', '', '25510101', '99999999'), ('B77', 'F', 'Ascariasis', '', '', '25510101', '99999999'), ('B78', 'F', 'Strongyloidiasis', '', '', '25510101', '99999999'), ('B81', 'F', 'Other intestinal helminthiases, not elsewhere classified', '', '', '25510101', '99999999'), ('B82', 'F', 'Unspecified intestinal parasitism', '', '', '25510101', '99999999'), ('B83', 'F', 'Other helminthiases', '', '', '25510101', '99999999'), ('B85', 'F', 'Pediculosis and phthiriasis', '', '', '25510101', '99999999'), ('B87', 'F', 'Myiasis', '', '', '25510101', '99999999'), ('B88', 'F', 'Other infestations', '', '', '25510101', '99999999'), ('B90', 'F', 'Sequelae of tuberculosis', '', '', '25510101', '99999999'), ('B94', 'F', 'Sequelae of other and unspecified infectious and parasitic diseases', '', '', '25510101', '99999999'), ('B95', 'F', 'Streptococcus and staphylococcus as the cause of diseases classified to other chapters', '', '', '25510101', '99999999'), ('B96', 'F', 'Other bacterial agents as the cause of diseases classified to other chapters', '', '', '25510101', '99999999'), ('B97', 'F', 'Viral agents as the cause of diseases classified to other chapters', '', '', '25510101', '99999999'), ('C00', 'F', 'Malignant neoplasm of lip', '', '', '25510101', '99999999'), ('C02', 'F', 'Malignant neoplasm of other and unspecified parts of tongue', '', '', '25510101', '99999999'), ('C03', 'F', 'Malignant neoplasm of gum', '', '', '25510101', '99999999'), ('C04', 'F', 'Malignant neoplasm of floor of mouth', '', '', '25510101', '99999999'), ('C05', 'F', 'Malignant neoplasm of palate', '', '', '25510101', '99999999'), ('C06', 'F', 'Malignant neoplasm of other and unspecified parts of mouth', '', '', '25510101', '99999999'), ('C08', 'F', 'Malignant neoplasm of other and unspecified major salivary glands', '', '', '25510101', '99999999'), ('C09', 'F', 'Malignant neoplasm of tonsil', '', '', '25510101', '99999999'), ('C10', 'F', 'Malignant neoplasm of oropharynx', '', '', '25510101', '99999999'), ('C11', 'F', 'Malignant neoplasm of nasopharynx', '', '', '25510101', '99999999'), ('C13', 'F', 'Malignant neoplasm of hypopharynx', '', '', '25510101', '99999999'), ('C14', 'F', 'Malignant neoplasm of other and ill-defined sites in the lip, oral cavity and pharynx', '', '', '25510101', '99999999'), ('C15', 'F', 'Malignant neoplasm of oesophagus', '', '', '25510101', '99999999'), ('C16', 'F', 'Malignant neoplasm of stomach', '', '', '25510101', '99999999'), ('C17', 'F', 'Malignant neoplasm of small intestine', '', '', '25510101', '99999999'), ('C18', 'F', 'Malignant neoplasm of colon', '', '', '25510101', '99999999'), ('C21', 'F', 'Malignant neoplasm of anus and anal canal', '', '', '25510101', '99999999'), ('C22', 'F', 'Malignant neoplasm of liver and intrahepatic bile ducts', '', '', '25510101', '99999999'), ('C24', 'F', 'Malignant neoplasm of other and unspecified parts of biliary tract', '', '', '25510101', '99999999'), ('C25', 'F', 'Malignant neoplasm of pancreas', '', '', '25510101', '99999999'), ('C26', 'F', 'Malignant neoplasm of other and ill-defined digestive organs', '', '', '25510101', '99999999'), ('C30', 'F', 'Malignant neoplasm of nasal cavity and middle ear', '', '', '25510101', '99999999'), ('C31', 'F', 'Malignant neoplasm of accessory sinuses', '', '', '25510101', '99999999'), ('C32', 'F', 'Malignant neoplasm of larynx', '', '', '25510101', '99999999'), ('C34', 'F', 'Malignant neoplasm of bronchus and lung', '', '', '25510101', '99999999'), ('C38', 'F', 'Malignant neoplasm of heart, mediastinum and pleura', '', '', '25510101', '99999999'), ('C39', 'F', 'Malignant neoplasm of other and ill-defined sites in the respiratory system and intrathoracic', '', '', '25510101', '99999999'), ('C40', 'F', 'Malignant neoplasm of bone and articular cartilage of limbs', '', '', '25510101', '99999999'), ('C41', 'F', 'Malignant neoplasm of bone and articular cartilage of other and unspecified sites', '', '', '25510101', '99999999'), ('C43', 'F', 'Malignant melanoma of skin', '', '', '25510101', '99999999'), ('C44', 'F', 'Other malignant neoplasms of skin', '', '', '25510101', '99999999'), ('C45', 'F', 'Mesothelioma', '', '', '25510101', '99999999'), ('C46', 'F', 'Kaposi\'s sarcoma', '', '', '25510101', '99999999'), ('C47', 'F', 'Malignant neoplasm of peripheral nerves and autonomic nervous system', '', '', '25510101', '99999999'), ('C48', 'F', 'Malignant neoplasm of retroperitoneum and peritoneum', '', '', '25510101', '99999999'), ('C49', 'F', 'Malignant neoplasm of other connective and soft tissue', '', '', '25510101', '99999999'), ('C50', 'F', 'Malignant neoplasm of breast', '', '', '25510101', '99999999'), ('C51', 'F', 'Malignant neoplasm of vulva', '', '', '25510101', '99999999'), ('C53', 'F', 'Malignant neoplasm of cervix uteri', '', '', '25510101', '99999999'), ('C54', 'F', 'Malignant neoplasm of corpus uteri', '', '', '25510101', '99999999'), ('C57', 'F', 'Malignant neoplasm of other and unspecified female genital organs', '', '', '25510101', '99999999'), ('C60', 'F', 'Malignant neoplasm of penis', '', '', '25510101', '99999999'), ('C62', 'F', 'Malignant neoplasm of testis', '', '', '25510101', '99999999'), ('C63', 'F', 'Malignant neoplasm of other and unspecified male genital organs', '', '', '25510101', '99999999'), ('C67', 'F', 'Malignant neoplasm of bladder', '', '', '25510101', '99999999'), ('C68', 'F', 'Malignant neoplasm of other and unspecified urinary organs', '', '', '25510101', '99999999'), ('C69', 'F', 'Malignant neoplasm of eye and adnexa', '', '', '25510101', '99999999'), ('C70', 'F', 'Malignant neoplasm of meninges', '', '', '25510101', '99999999'), ('C71', 'F', 'Malignant neoplasm of brain', '', '', '25510101', '99999999'), ('C72', 'F', 'Malignant neoplasm of spinal cord, cranial nerves and other parts of central nervous', '', '', '25510101', '99999999'), ('C74', 'F', 'Malignant neoplasm of adrenal gland', '', '', '25510101', '99999999'), ('C75', 'F', 'Malignant neoplasm of other endocrine glands and related structures', '', '', '25510101', '99999999'), ('C76', 'F', 'Malignant neoplasm of other and ill-defined sites', '', '', '25510101', '99999999'), ('C77', 'F', 'Secondary and unspecified malignant neoplasm of lymph nodes', '', '', '25510101', '99999999'), ('C78', 'F', 'Secondary malignant neoplasm of respiratory and digestive organs', '', '', '25510101', '99999999'), ('C79', 'F', 'Secondary malignant neoplasm of other sites', '', '', '25510101', '99999999'), ('C81', 'F', 'Hodgkin\'s disease', '', '', '25510101', '99999999'), ('C82', 'F', 'Follicular [nodular] non-Hodgkin\'s lymphoma', '', '', '25510101', '99999999'), ('C83', 'F', 'Diffuse non-Hodgkin\'s lymphoma', '', '', '25510101', '99999999'), ('C84', 'F', 'Peripheral and cutaneous T-cell lymphomas', '', '', '25510101', '99999999'), ('C85', 'F', 'Other and unspecified types of non-Hodgkin\'s lymphoma', '', '', '25510101', '99999999'), ('C88', 'F', 'Malignant immunoproliferative diseases', '', '', '25510101', '99999999'), ('C90', 'F', 'Multiple myeloma and malignant plasma cell neoplasms', '', '', '25510101', '99999999'), ('C91', 'F', 'Lymphoid leukaemia', '', '', '25510101', '99999999'), ('C92', 'F', 'Myeloid leukaemia', '', '', '25510101', '99999999'), ('C93', 'F', 'Monocytic leukaemia', '', '', '25510101', '99999999'), ('C94', 'F', 'Other leukaemias of specified cell type', '', '', '25510101', '99999999'), ('C95', 'F', 'Leukaemia of unspecified cell type', '', '', '25510101', '99999999'), ('C96', 'F', 'Other and unspecified malignant neoplasms of lymphoid, haematopoietic and related tissue', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('D00', 'F', 'Carcinoma in situ of oral cavity, oesophagus and stomach', '', '', '25510101', '99999999'), ('D01', 'F', 'Carcinoma in situ of other and unspecified digestive organs', '', '', '25510101', '99999999'), ('D02', 'F', 'Carcinoma in situ of middle ear and respiratory system', '', '', '25510101', '99999999'), ('D03', 'F', 'Melanoma in situ', '', '', '25510101', '99999999'), ('D04', 'F', 'Carcinoma in situ of skin', '', '', '25510101', '99999999'), ('D05', 'F', 'Carcinoma in situ of breast', '', '', '25510101', '99999999'), ('D06', 'F', 'Carcinoma in situ of cervix uteri', '', '', '25510101', '99999999'), ('D07', 'F', 'Carcinoma in situ of other and unspecified genital organs', '', '', '25510101', '99999999'), ('D09', 'F', 'Carcinoma in situ of other and unspecified sites', '', '', '25510101', '99999999'), ('D10', 'F', 'Benign neoplasm of mouth and pharynx', '', '', '25510101', '99999999'), ('D11', 'F', 'Benign neoplasm of major salivary glands', '', '', '25510101', '99999999'), ('D12', 'F', 'Benign neoplasm of colon, rectum, anus and anal canal', '', '', '25510101', '99999999'), ('D13', 'F', 'Benign neoplasm of other and ill-defined parts of digestive system', '', '', '25510101', '99999999'), ('D14', 'F', 'Benign neoplasm of middle ear and respiratory system', '', '', '25510101', '99999999'), ('D15', 'F', 'Benign neoplasm of other and unspecified intrathoracic organs', '', '', '25510101', '99999999'), ('D16', 'F', 'Benign neoplasm of bone and articular cartilage', '', '', '25510101', '99999999'), ('D17', 'F', 'Benign lipomatous neoplasm', '', '', '25510101', '99999999'), ('D18', 'F', 'Haemangioma and lymphangioma, any site', '', '', '25510101', '99999999'), ('D19', 'F', 'Benign neoplasm of mesothelial tissue', '', '', '25510101', '99999999'), ('D20', 'F', 'Benign neoplasm of soft tissue of retroperitoneum and peritoneum', '', '', '25510101', '99999999'), ('D21', 'F', 'Other benign neoplasms of connective and other soft tissue', '', '', '25510101', '99999999'), ('D22', 'F', 'Melanocytic naevi', '', '', '25510101', '99999999'), ('D23', 'F', 'Other benign neoplasms of skin', '', '', '25510101', '99999999'), ('D25', 'F', 'Leiomyoma of uterus', '', '', '25510101', '99999999'), ('D26', 'F', 'Other benign neoplasms of uterus', '', '', '25510101', '99999999'), ('D28', 'F', 'Benign neoplasm of other and unspecified female genital organs', '', '', '25510101', '99999999'), ('D29', 'F', 'Benign neoplasm of male genital organs', '', '', '25510101', '99999999'), ('D30', 'F', 'Benign neoplasm of urinary organs', '', '', '25510101', '99999999'), ('D31', 'F', 'Benign neoplasm of eye and adnexa', '', '', '25510101', '99999999'), ('D32', 'F', 'Benign neoplasm of meninges', '', '', '25510101', '99999999'), ('D33', 'F', 'Benign neoplasm of brain and other parts of central nervous system', '', '', '25510101', '99999999'), ('D35', 'F', 'Benign neoplasm of other and unspecified endocrine glands', '', '', '25510101', '99999999'), ('D36', 'F', 'Benign neoplasm of other and unspecified sites', '', '', '25510101', '99999999'), ('D37', 'F', 'Neoplasm of uncertain or unknown behaviour of oral cavity and digestive organs', '', '', '25510101', '99999999'), ('D38', 'F', 'Neoplasm of uncertain or unknown behaviour of middle ear and respiratory and intrathoracic organs', '', '', '25510101', '99999999'), ('D39', 'F', 'Neoplasm of uncertain or unknown behaviour of female genital organs', '', '', '25510101', '99999999'), ('D40', 'F', 'Neoplasm of uncertain or unknown behaviour of male genital organs', '', '', '25510101', '99999999'), ('D41', 'F', 'Neoplasm of uncertain or unknown behaviour of urinary organs', '', '', '25510101', '99999999'), ('D42', 'F', 'Neoplasm of uncertain or unknown behaviour of meninges', '', '', '25510101', '99999999'), ('D43', 'F', 'Neoplasm of uncertain or unknown behaviour of brain and central nervous system', '', '', '25510101', '99999999'), ('D44', 'F', 'Neoplasm of uncertain or unknown behaviour of endocrine glands', '', '', '25510101', '99999999'), ('D46', 'F', 'Myelodysplastic syndromes', '', '', '25510101', '99999999'), ('D47', 'F', 'Other neoplasms of uncertain or unknown behaviour of lymphoid, haematopoietic and related tissue', '', '', '25510101', '99999999'), ('D48', 'F', 'Neoplasm of uncertain or unknown behaviour of other and unspecified sites', '', '', '25510101', '99999999'), ('D50', 'F', 'Iron deficiency anaemia', '', '', '25510101', '99999999'), ('D51', 'F', 'Vitamin B12 deficiency anaemia', '', '', '25510101', '99999999'), ('D52', 'F', 'Folate deficiency anaemia', '', '', '25510101', '99999999'), ('D53', 'F', 'Other nutritional anaemias', '', '', '25510101', '99999999'), ('D55', 'F', 'Anaemia due to enzyme disorders', '', '', '25510101', '99999999'), ('D56', 'F', 'Thalassaemia', '', '', '25510101', '99999999'), ('D57', 'F', 'Sickle-cell disorders', '', '', '25510101', '99999999'), ('D58', 'F', 'Other hereditary haemolytic anaemias', '', '', '25510101', '99999999'), ('D59', 'F', 'Acquired haemolytic anaemia', '', '', '25510101', '99999999'), ('D60', 'F', 'Acquired pure red cell aplasia [erythroblastopenia]', '', '', '25510101', '99999999'), ('D61', 'F', 'Other aplastic anaemias', '', '', '25510101', '99999999'), ('D63', 'F', 'Anaemia in chronic diseases classified elsewhere', '', '', '25510101', '99999999'), ('D64', 'F', 'Other anaemias', '', '', '25510101', '99999999'), ('D68', 'F', 'Other coagulation defects', '', '', '25510101', '99999999'), ('D69', 'F', 'Purpura and other haemorrhagic conditions', '', '', '25510101', '99999999'), ('D72', 'F', 'Other disorders of white blood cells', '', '', '25510101', '99999999'), ('D73', 'F', 'Diseases of spleen', '', '', '25510101', '99999999'), ('D74', 'F', 'Methaemoglobinaemia', '', '', '25510101', '99999999'), ('D75', 'F', 'Other diseases of blood and blood-forming organs', '', '', '25510101', '99999999'), ('D76', 'F', 'Certain diseases involving lymphoreticular tissue and reticulohistiocytic system', '', '', '25510101', '99999999'), ('D80', 'F', 'Immunodeficiency with predominantly antibody defects', '', '', '25510101', '99999999'), ('D81', 'F', 'Combined immunodeficiencies', '', '', '25510101', '99999999'), ('D82', 'F', 'Immunodeficiency associated with other major defects', '', '', '25510101', '99999999'), ('D83', 'F', 'Common variable immunodeficiency', '', '', '25510101', '99999999'), ('D84', 'F', 'Other immunodeficiencies', '', '', '25510101', '99999999'), ('D86', 'F', 'Sarcoidosis', '', '', '25510101', '99999999'), ('D89', 'F', 'Other disorders involving the immune mechanism, not elsewhere classified', '', '', '25510101', '99999999'), ('E00', 'F', 'Congenital iodine-deficiency syndrome', '', '', '25510101', '99999999'), ('E01', 'F', 'Iodine-deficiency-related thyroid disorders and allied conditions', '', '', '25510101', '99999999'), ('E03', 'F', 'Other hypothyroidism', '', '', '25510101', '99999999'), ('E04', 'F', 'Other nontoxic goitre', '', '', '25510101', '99999999'), ('E05', 'F', 'Thyrotoxicosis [hyperthyroidism]', '', '', '25510101', '99999999'), ('E06', 'F', 'Thyroiditis', '', '', '25510101', '99999999'), ('E07', 'F', 'Other disorders of thyroid', '', '', '25510101', '99999999'), ('E10', 'F', 'Insulin-dependent diabetes mellitus', '', '', '25510101', '99999999'), ('E11', 'F', 'Non-insulin-dependent diabetes mellitus', '', '', '25510101', '99999999'), ('E12', 'F', 'Malnutrition-related diabetes mellitus', '', '', '25510101', '99999999'), ('E13', 'F', 'Other specified diabetes mellitus', '', '', '25510101', '99999999'), ('E14', 'F', 'Unspecified diabetes mellitus', '', '', '25510101', '99999999'), ('E16', 'F', 'Other disorders of pancreatic internal secretion', '', '', '25510101', '99999999'), ('E20', 'F', 'Hypoparathyroidism', '', '', '25510101', '99999999'), ('E21', 'F', 'Hyperparathyroidism and other disorders of parathyroid gland', '', '', '25510101', '99999999'), ('E22', 'F', 'Hyperfunction of pituitary gland', '', '', '25510101', '99999999'), ('E23', 'F', 'Hypofunction and other disorders of pituitary gland', '', '', '25510101', '99999999'), ('E24', 'F', 'Cushing\'s syndrome', '', '', '25510101', '99999999'), ('E25', 'F', 'Adrenogenital disorders', '', '', '25510101', '99999999'), ('E26', 'F', 'Hyperaldosteronism', '', '', '25510101', '99999999'), ('E27', 'F', 'Other disorders of adrenal gland', '', '', '25510101', '99999999'), ('E28', 'F', 'Ovarian dysfunction', '', '', '25510101', '99999999'), ('E29', 'F', 'Testicular dysfunction', '', '', '25510101', '99999999'), ('E30', 'F', 'Disorders of puberty, not elsewhere classified', '', '', '25510101', '99999999'), ('E31', 'F', 'Polyglandular dysfunction', '', '', '25510101', '99999999'), ('E32', 'F', 'Diseases of thymus', '', '', '25510101', '99999999'), ('E34', 'F', 'Other endocrine disorders', '', '', '25510101', '99999999'), ('E35', 'F', 'Disorders of endocrine glands in diseases classified elsewhere', '', '', '25510101', '99999999'), ('E44', 'F', 'Protein-energy malnutrition of moderate and mild degree', '', '', '25510101', '99999999'), ('E50', 'F', 'Vitamin A deficiency', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('E51', 'F', 'Thiamine deficiency', '', '', '25510101', '99999999'), ('E53', 'F', 'Deficiency of other B group vitamins', '', '', '25510101', '99999999'), ('E55', 'F', 'Vitamin D deficiency', '', '', '25510101', '99999999'), ('E56', 'F', 'Other vitamin deficiencies', '', '', '25510101', '99999999'), ('E61', 'F', 'Deficiency of other nutrient elements', '', '', '25510101', '99999999'), ('E63', 'F', 'Other nutritional deficiencies', '', '', '25510101', '99999999'), ('E64', 'F', 'Sequelae of malnutrition and other nutritional deficiencies', '', '', '25510101', '99999999'), ('E66', 'F', 'Obesity', '', '', '25510101', '99999999'), ('E67', 'F', 'Other hyperalimentation', '', '', '25510101', '99999999'), ('E70', 'F', 'Disorders of aromatic amino-acid metabolism', '', '', '25510101', '99999999'), ('E71', 'F', 'Disorders of branched-chain amino-acid metabolism and fatty-acid metabolism', '', '', '25510101', '99999999'), ('E72', 'F', 'Other disorders of amino-acid metabolism', '', '', '25510101', '99999999'), ('E73', 'F', 'Lactose intolerance', '', '', '25510101', '99999999'), ('E74', 'F', 'Other disorders of carbohydrate metabolism', '', '', '25510101', '99999999'), ('E75', 'F', 'Disorders of sphingolipid metabolism and other lipid storage disorders', '', '', '25510101', '99999999'), ('E76', 'F', 'Disorders of glycosaminoglycan metabolism', '', '', '25510101', '99999999'), ('E77', 'F', 'Disorders of glycoprotein metabolism', '', '', '25510101', '99999999'), ('E78', 'F', 'Disorders of lipoprotein metabolism and other lipidaemias', '', '', '25510101', '99999999'), ('E79', 'F', 'Disorders of purine and pyrimidine metabolism', '', '', '25510101', '99999999'), ('E80', 'F', 'Disorders of porphyrin and bilirubin metabolism', '', '', '25510101', '99999999'), ('E83', 'F', 'Disorders of mineral metabolism', '', '', '25510101', '99999999'), ('E84', 'F', 'Cystic fibrosis', '', '', '25510101', '99999999'), ('E85', 'F', 'Amyloidosis', '', '', '25510101', '99999999'), ('E87', 'F', 'Other disorders of fluid, electrolyte and acid-base balance', '', '', '25510101', '99999999'), ('E88', 'F', 'Other metabolic disorders', '', '', '25510101', '99999999'), ('E89', 'F', 'Postprocedural endocrine and metabolic disorders, not elsewhere classified', '', '', '25510101', '99999999'), ('F00', 'F', 'Dementia in Alzheimer\'s disease (G30.-+)', '', '', '25510101', '99999999'), ('F01', 'F', 'Vascular dementia', '', '', '25510101', '99999999'), ('F02', 'F', 'Dementia in other diseases classified elsewhere', '', '', '25510101', '99999999'), ('F05', 'F', 'Delirium, not induced by alcohol and other psychoactive substances', '', '', '25510101', '99999999'), ('F06', 'F', 'Other mental disorders due to brain damage and dysfunction and to physical disease', '', '', '25510101', '99999999'), ('F07', 'F', 'Personality and behavioural disorders due to brain disease, damage and dysfunction', '', '', '25510101', '99999999'), ('F10', 'F', 'Mental and behavioral disorders due to use of alcohol', '', '', '25510101', '99999999'), ('F11', 'F', 'Mental and behavioral disorders due to use of opioids', '', '', '25510101', '99999999'), ('F12', 'F', 'Mental and behavioral disorders due to use of cannabinoids', '', '', '25510101', '99999999'), ('F13', 'F', 'Mental and behavioral disorders due to use of sedatives or hypnotics', '', '', '25510101', '99999999'), ('F14', 'F', 'Mental and behavioral disorders due to use of cocaine', '', '', '25510101', '99999999'), ('F15', 'F', 'Mental and behavioral disorders due to use of other stimulants including caffeine', '', '', '25510101', '99999999'), ('F16', 'F', 'Mental and behavioral disorders due to use of hallucinogens', '', '', '25510101', '99999999'), ('F17', 'F', 'Mental and behavioral disorders due to use of tobacco', '', '', '25510101', '99999999'), ('F18', 'F', 'Mental and behavioral disorders due to use of volatile solvents', '', '', '25510101', '99999999'), ('F19', 'F', 'Mental and behavioral disorders due to use of multiple drug use and use of other psychoactive substances', '', '', '25510101', '99999999'), ('F20', 'F', 'Schizophrenia', '', '', '25510101', '99999999'), ('F22', 'F', 'Persistent delusional disorders', '', '', '25510101', '99999999'), ('F23', 'F', 'Acute and transient psychotic disorders', '', '', '25510101', '99999999'), ('F25', 'F', 'Schizoaffective disorders', '', '', '25510101', '99999999'), ('F30', 'F', 'Manic episode', '', '', '25510101', '99999999'), ('F31', 'F', 'Bipolar affective disorder', '', '', '25510101', '99999999'), ('F32', 'F', 'Depressive episodes', '', '', '25510101', '99999999'), ('F33', 'F', 'Recurrent depressive disorder', '', '', '25510101', '99999999'), ('F34', 'F', 'Persistent mood [affective] disorders', '', '', '25510101', '99999999'), ('F38', 'F', 'Other mood [affective] disorders', '', '', '25510101', '99999999'), ('F40', 'F', 'Phobic anxiety disorders', '', '', '25510101', '99999999'), ('F41', 'F', 'Other anxiety disorders', '', '', '25510101', '99999999'), ('F42', 'F', 'Obsessive-compulsive disorder', '', '', '25510101', '99999999'), ('F43', 'F', 'Reaction to severe stress, and adjustment disorders', '', '', '25510101', '99999999'), ('F44', 'F', 'Dissociative [conversion] disorders', '', '', '25510101', '99999999'), ('F45', 'F', 'Somatoform disorders', '', '', '25510101', '99999999'), ('F48', 'F', 'Other neurotic disorders', '', '', '25510101', '99999999'), ('F50', 'F', 'Eating disorders', '', '', '25510101', '99999999'), ('F51', 'F', 'Nonorganic sleep disorders', '', '', '25510101', '99999999'), ('F52', 'F', 'Sexual dysfunction, not caused by organic disorder or disease', '', '', '25510101', '99999999'), ('F53', 'F', 'Mental and behavioural disorders associated with the puerperium, not elsewhere classified', '', '', '25510101', '99999999'), ('F60', 'F', 'Specific personality disorders', '', '', '25510101', '99999999'), ('F62', 'F', 'Enduring personality changes, not attributable to brain damage and disease', '', '', '25510101', '99999999'), ('F63', 'F', 'Habit and impulse disorders', '', '', '25510101', '99999999'), ('F64', 'F', 'Gender identity disorders', '', '', '25510101', '99999999'), ('F65', 'F', 'Disorders of sexual preference', '', '', '25510101', '99999999'), ('F66', 'F', 'Psychological and behavioural disorders associated with sexual development and orientation', '', '', '25510101', '99999999'), ('F68', 'F', 'Other disorders of adult personality and behaviour', '', '', '25510101', '99999999'), ('F70', 'F', 'Mild mental retardation', '', '', '25510101', '99999999'), ('F71', 'F', 'Moderate mental retardation', '', '', '25510101', '99999999'), ('F72', 'F', 'Severe mental retardation', '', '', '25510101', '99999999'), ('F73', 'F', 'Profound mental retardation', '', '', '25510101', '99999999'), ('F78', 'F', 'Other mental retardation', '', '', '25510101', '99999999'), ('F79', 'F', 'Unspecified mental retardation', '', '', '25510101', '99999999'), ('F80', 'F', 'Specific developmental disorders of speech and language', '', '', '25510101', '99999999'), ('F81', 'F', 'Specific developmental disorders of scholastic skills', '', '', '25510101', '99999999'), ('F84', 'F', 'Pervasive developmental disorders', '', '', '25510101', '99999999'), ('F90', 'F', 'Hyperkinetic disorders', '', '', '25510101', '99999999'), ('F91', 'F', 'Conduct disorders', '', '', '25510101', '99999999'), ('F92', 'F', 'Mixed disorders of conduct and emotions', '', '', '25510101', '99999999'), ('F93', 'F', 'Emotional disorders with onset specific to childhood', '', '', '25510101', '99999999'), ('F94', 'F', 'Disorders of social functioning with onset specific to childhood and adolescence', '', '', '25510101', '99999999'), ('F95', 'F', 'Tic disorders', '', '', '25510101', '99999999'), ('F98', 'F', 'Other behavioural and emotional disorders with onset usually occurring in childhood and adolescence', '', '', '25510101', '99999999'), ('G00', 'F', 'Bacterial meningitis, not elsewhere classified', '', '', '25510101', '99999999'), ('G02', 'F', 'Meningitis in other infectious and parasitic diseases classified elsewhere', '', '', '25510101', '99999999'), ('G03', 'F', 'Meningitis due to other and unspecified causes', '', '', '25510101', '99999999'), ('G04', 'F', 'Encephalitis, myelitis and encephalomyelitis', '', '', '25510101', '99999999'), ('G05', 'F', 'Encephalitis, myelitis and encephalomyelitis in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G06', 'F', 'Intracranial and intraspinal abscess and granuloma', '', '', '25510101', '99999999'), ('G11', 'F', 'Hereditary ataxia', '', '', '25510101', '99999999'), ('G12', 'F', 'Spinal muscular atrophy and related syndromes', '', '', '25510101', '99999999'), ('G13', 'F', 'Systemic atrophies primarily affecting central nervous system in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G21', 'F', 'Secondary parkinsonism', '', '', '25510101', '99999999'), ('G23', 'F', 'Other degenerative diseases of the basal ganglia', '', '', '25510101', '99999999'), ('G24', 'F', 'Dystonia', '', '', '25510101', '99999999'), ('G25', 'F', 'Other extrapyramidal and movement disorders', '', '', '25510101', '99999999'), ('G30', 'F', 'Alzheimer\'s disease', '', '', '25510101', '99999999'), ('G31', 'F', 'Other degenerative diseases of nervous system, not elsewhere classified', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('G32', 'F', 'Other degenerative disorders of nervous system in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G36', 'F', 'Other acute disseminated demyelination', '', '', '25510101', '99999999'), ('G37', 'F', 'Other demyelinating diseases of central nervous system', '', '', '25510101', '99999999'), ('G40', 'F', 'Epilepsy', '', '', '25510101', '99999999'), ('G41', 'F', 'Status epilepticus', '', '', '25510101', '99999999'), ('G43', 'F', 'Migraine', '', '', '25510101', '99999999'), ('G44', 'F', 'Other headache syndromes', '', '', '25510101', '99999999'), ('G45', 'F', 'Transient cerebral ischaemic attacks and related syndromes', '', '', '25510101', '99999999'), ('G46', 'F', 'Vascular syndromes of brain in cerebrovascular diseases (I60-I67+)', '', '', '25510101', '99999999'), ('G47', 'F', 'Sleep disorders', '', '', '25510101', '99999999'), ('G50', 'F', 'Disorders of trigeminal nerve', '', '', '25510101', '99999999'), ('G51', 'F', 'Facial nerve disorders', '', '', '25510101', '99999999'), ('G52', 'F', 'Disorders of other cranial nerves', '', '', '25510101', '99999999'), ('G53', 'F', 'Cranial nerve disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G54', 'F', 'Nerve root and plexus disorders', '', '', '25510101', '99999999'), ('G55', 'F', 'Nerve root and plexus compressions in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G56', 'F', 'Mononeuropathies of upper limb', '', '', '25510101', '99999999'), ('G57', 'F', 'Mononeuropathies of lower limb', '', '', '25510101', '99999999'), ('G58', 'F', 'Other mononeuropathies', '', '', '25510101', '99999999'), ('G59', 'F', 'Mononeuropathy in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G60', 'F', 'Hereditary and idiopathic neuropathy', '', '', '25510101', '99999999'), ('G61', 'F', 'Inflammatory polyneuropathy', '', '', '25510101', '99999999'), ('G62', 'F', 'Other polyneuropathies', '', '', '25510101', '99999999'), ('G63', 'F', 'Polyneuropathy in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G70', 'F', 'Myasthenia gravis and other myoneural disorders', '', '', '25510101', '99999999'), ('G71', 'F', 'Primary disorders of muscles', '', '', '25510101', '99999999'), ('G72', 'F', 'Other myopathies', '', '', '25510101', '99999999'), ('G73', 'F', 'Disorders of myoneural junction and muscle in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G80', 'F', 'Infantile cerebral palsy', '', '', '25510101', '99999999'), ('G81', 'F', 'Hemiplegia', '', '', '25510101', '99999999'), ('G82', 'F', 'Paraplegia and tetraplegia', '', '', '25510101', '99999999'), ('G83', 'F', 'Other paralytic syndromes', '', '', '25510101', '99999999'), ('G90', 'F', 'Disorders of autonomic nervous system', '', '', '25510101', '99999999'), ('G91', 'F', 'Hydrocephalus', '', '', '25510101', '99999999'), ('G93', 'F', 'Other disorders of brain', '', '', '25510101', '99999999'), ('G94', 'F', 'Other disorders of brain in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G95', 'F', 'Other diseases of spinal cord', '', '', '25510101', '99999999'), ('G96', 'F', 'Other disorders of central nervous system', '', '', '25510101', '99999999'), ('G97', 'F', 'Postprocedural disorders of nervous system, not elsewhere classified', '', '', '25510101', '99999999'), ('G99', 'F', 'Other disorders of nervous system in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H00', 'F', 'Hordeolum and chalazion', '', '', '25510101', '99999999'), ('H01', 'F', 'Other inflammation of eyelid', '', '', '25510101', '99999999'), ('H02', 'F', 'Other disorders of eyelid', '', '', '25510101', '99999999'), ('H03', 'F', 'Disorders of eyelid in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H04', 'F', 'Disorders of lacrimal system', '', '', '25510101', '99999999'), ('H05', 'F', 'Disorders of orbit', '', '', '25510101', '99999999'), ('H06', 'F', 'Disorders of lacrimal system and orbit in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H10', 'F', 'Conjunctivitis', '', '', '25510101', '99999999'), ('H11', 'F', 'Other disorders of conjunctiva', '', '', '25510101', '99999999'), ('H13', 'F', 'Disorders of conjunctiva in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H15', 'F', 'Disorders of sclera', '', '', '25510101', '99999999'), ('H16', 'F', 'Keratitis', '', '', '25510101', '99999999'), ('H17', 'F', 'Corneal scars and opacities', '', '', '25510101', '99999999'), ('H18', 'F', 'Other disorders of cornea', '', '', '25510101', '99999999'), ('H19', 'F', 'Disorders of sclera and cornea in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H20', 'F', 'Iridocyclitis', '', '', '25510101', '99999999'), ('H21', 'F', 'Other disorders of iris and ciliary body', '', '', '25510101', '99999999'), ('H22', 'F', 'Disorders of iris and ciliary body in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H25', 'F', 'Senile cataract', '', '', '25510101', '99999999'), ('H26', 'F', 'Other cataract', '', '', '25510101', '99999999'), ('H27', 'F', 'Other disorders of lens', '', '', '25510101', '99999999'), ('H28', 'F', 'Cataract and other disorders of lens in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H30', 'F', 'Chorioretinal inflammation', '', '', '25510101', '99999999'), ('H31', 'F', 'Other disorders of choroid', '', '', '25510101', '99999999'), ('H32', 'F', 'Chorioretinal disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H33', 'F', 'Retinal detachments and breaks', '', '', '25510101', '99999999'), ('H34', 'F', 'Retinal vascular occlusions', '', '', '25510101', '99999999'), ('H35', 'F', 'Other retinal disorders', '', '', '25510101', '99999999'), ('H36', 'F', 'Retinal disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H40', 'F', 'Glaucoma', '', '', '25510101', '99999999'), ('H42', 'F', 'Glaucoma in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H43', 'F', 'Disorders of vitreous body', '', '', '25510101', '99999999'), ('H44', 'F', 'Disorders of globe', '', '', '25510101', '99999999'), ('H45', 'F', 'Disorders of vitreous body and globe in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H47', 'F', 'Other disorders of optic [2nd] nerve and visual pathways', '', '', '25510101', '99999999'), ('H48', 'F', 'Disorders of optic [2nd] nerve and visual pathways in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H49', 'F', 'Paralytic strabismus', '', '', '25510101', '99999999'), ('H50', 'F', 'Other strabismus', '', '', '25510101', '99999999'), ('H51', 'F', 'Other disorders of binocular movement', '', '', '25510101', '99999999'), ('H52', 'F', 'Disorders of refraction and accommodation', '', '', '25510101', '99999999'), ('H53', 'F', 'Visual disturbances', '', '', '25510101', '99999999'), ('H54', 'F', 'Blindness and low vision', '', '', '25510101', '99999999'), ('H57', 'F', 'Other disorders of eye and adnexa', '', '', '25510101', '99999999'), ('H58', 'F', 'Other disorders of eye and adnexa in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H59', 'F', 'Post procedure disorder of eye and adnexa, not elsewhere classified', '', '', '25510101', '99999999'), ('H60', 'F', 'Otitis externa', '', '', '25510101', '99999999'), ('H61', 'F', 'Other disorders of external ear', '', '', '25510101', '99999999'), ('H62', 'F', 'Disorders of external ear in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H65', 'F', 'Nonsuppurative otitis media', '', '', '25510101', '99999999'), ('H66', 'F', 'Suppurative and unspecified otitis media', '', '', '25510101', '99999999'), ('H67', 'F', 'Otitis media in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H68', 'F', 'Eustachian salpingitis and obstruction', '', '', '25510101', '99999999'), ('H69', 'F', 'Other disorders of Eustachian tube', '', '', '25510101', '99999999'), ('H70', 'F', 'Mastoiditis and related conditions', '', '', '25510101', '99999999'), ('H72', 'F', 'Perforation of tympanic membrane', '', '', '25510101', '99999999'), ('H73', 'F', 'Other disorders of tympanic membrane', '', '', '25510101', '99999999'), ('H74', 'F', 'Other disorders of middle ear and mastoid', '', '', '25510101', '99999999'), ('H75', 'F', 'Other disorders of middle ear and mastoid in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H80', 'F', 'Otosclerosis', '', '', '25510101', '99999999'), ('H81', 'F', 'Disorders of vestibular function', '', '', '25510101', '99999999'), ('H83', 'F', 'Other diseases of inner ear', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('H90', 'F', 'Conductive and sensorineural hearing loss', '', '', '25510101', '99999999'), ('H91', 'F', 'Other hearing loss', '', '', '25510101', '99999999'), ('H92', 'F', 'Otalgia and effusion of ear', '', '', '25510101', '99999999'), ('H93', 'F', 'Other disorders of ear, not elsewhere classified', '', '', '25510101', '99999999'), ('H94', 'F', 'Other disorders of ear in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H95', 'F', 'Postprocedural disorders of ear and mastoid process, not elsewhere classified', '', '', '25510101', '99999999'), ('I01', 'F', 'Rheumatic fever with heart involvement', '', '', '25510101', '99999999'), ('I02', 'F', 'Rheumatic chorea', '', '', '25510101', '99999999'), ('I05', 'F', 'Rheumatic mitral valve diseases', '', '', '25510101', '99999999'), ('I06', 'F', 'Rheumatic aortic valve diseases', '', '', '25510101', '99999999'), ('I07', 'F', 'Rheumatic tricuspid valve diseases', '', '', '25510101', '99999999'), ('I08', 'F', 'Multiple valve diseases', '', '', '25510101', '99999999'), ('I09', 'F', 'Other rheumatic heart diseases', '', '', '25510101', '99999999'), ('I11', 'F', 'Hypertensive heart disease', '', '', '25510101', '99999999'), ('I12', 'F', 'Hypertensive renal disease', '', '', '25510101', '99999999'), ('I13', 'F', 'Hypertensive heart and renal disease', '', '', '25510101', '99999999'), ('I15', 'F', 'Secondary hypertension', '', '', '25510101', '99999999'), ('I20', 'F', 'Angina pectoris', '', '', '25510101', '99999999'), ('I21', 'F', 'Acute myocardial infarction', '', '', '25510101', '99999999'), ('I22', 'F', 'Subsequent myocardial infarction', '', '', '25510101', '99999999'), ('I23', 'F', 'Certain current complications following acute myocardial infarction', '', '', '25510101', '99999999'), ('I24', 'F', 'Other acute ischaemic heart diseases', '', '', '25510101', '99999999'), ('I25', 'F', 'Chronic ischaemic heart disease', '', '', '25510101', '99999999'), ('I26', 'F', 'Pulmonary embolism', '', '', '25510101', '99999999'), ('I27', 'F', 'Other pulmonary heart diseases', '', '', '25510101', '99999999'), ('I28', 'F', 'Other diseases of pulmonary vessels', '', '', '25510101', '99999999'), ('I30', 'F', 'Acute pericarditis', '', '', '25510101', '99999999'), ('I31', 'F', 'Other diseases of pericardium', '', '', '25510101', '99999999'), ('I32', 'F', 'Pericarditis in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I33', 'F', 'Acute and subacute endocarditis', '', '', '25510101', '99999999'), ('I34', 'F', 'Nonrheumatic mitral valve disorders', '', '', '25510101', '99999999'), ('I35', 'F', 'Nonrheumatic aortic valve disorders', '', '', '25510101', '99999999'), ('I36', 'F', 'Nonrheumatic tricuspid valve disorders', '', '', '25510101', '99999999'), ('I37', 'F', 'Pulmonary valve disorders', '', '', '25510101', '99999999'), ('I39', 'F', 'Endocarditis and heart valve disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I40', 'F', 'Acute myocarditis', '', '', '25510101', '99999999'), ('I41', 'F', 'Myocarditis in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I42', 'F', 'Cardiomyopathy', '', '', '25510101', '99999999'), ('I43', 'F', 'Cardiomyopathy in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I44', 'F', 'Atrioventricular and left bundle-branch block', '', '', '25510101', '99999999'), ('I45', 'F', 'Other conduction disorders', '', '', '25510101', '99999999'), ('I46', 'F', 'Cardiac arrest', '', '', '25510101', '99999999'), ('I47', 'F', 'Paroxysmal tachycardia', '', '', '25510101', '99999999'), ('I49', 'F', 'Other cardiac arrhythmias', '', '', '25510101', '99999999'), ('I50', 'F', 'Heart failure', '', '', '25510101', '99999999'), ('I51', 'F', 'Complications and ill-defined descriptions of heart disease', '', '', '25510101', '99999999'), ('I52', 'F', 'Other heart disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I60', 'F', 'Subarachnoid haemorrhage', '', '', '25510101', '99999999'), ('I61', 'F', 'Intracerebral haemorrhage', '', '', '25510101', '99999999'), ('I62', 'F', 'Other nontraumatic intracranial haemorrhage', '', '', '25510101', '99999999'), ('I63', 'F', 'Cerebral infarction', '', '', '25510101', '99999999'), ('I65', 'F', 'Occlusion and stenosis of precerebral arteries, not resulting in cerebral infarction', '', '', '25510101', '99999999'), ('I66', 'F', 'Occlusion and stenosis of cerebral arteries, not resulting in cerebral infarction', '', '', '25510101', '99999999'), ('I67', 'F', 'Other cerebrovascular diseases', '', '', '25510101', '99999999'), ('I68', 'F', 'Cerebrovascular disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I69', 'F', 'Sequelae of cerebrovascular disease', '', '', '25510101', '99999999'), ('I70', 'F', 'Atherosclerosis', '', '', '25510101', '99999999'), ('I71', 'F', 'Aortic aneurysm and dissection', '', '', '25510101', '99999999'), ('I72', 'F', 'Other aneurysm', '', '', '25510101', '99999999'), ('I73', 'F', 'Other peripheral vascular diseases', '', '', '25510101', '99999999'), ('I74', 'F', 'Arterial embolism and thrombosis', '', '', '25510101', '99999999'), ('I77', 'F', 'Other disorders of arteries and arterioles', '', '', '25510101', '99999999'), ('I78', 'F', 'Diseases of capillaries', '', '', '25510101', '99999999'), ('I79', 'F', 'Disorders of arteries, arterioles and capillaries in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I80', 'F', 'Phlebitis and thrombophlebitis', '', '', '25510101', '99999999'), ('I82', 'F', 'Other venous embolism and thrombosis', '', '', '25510101', '99999999'), ('I83', 'F', 'Varicose veins of lower extremities', '', '', '25510101', '99999999'), ('I84', 'F', 'Haemorrhoids', '', '', '25510101', '99999999'), ('I85', 'F', 'Oesophageal varices', '', '', '25510101', '99999999'), ('I86', 'F', 'Varicose veins of other sites', '', '', '25510101', '99999999'), ('I87', 'F', 'Other disorders of veins', '', '', '25510101', '99999999'), ('I88', 'F', 'Nonspecific lymphadenitis', '', '', '25510101', '99999999'), ('I89', 'F', 'Other noninfective disorders of lymphatic vessels and lymph nodes', '', '', '25510101', '99999999'), ('I95', 'F', 'Hypotension', '', '', '25510101', '99999999'), ('I97', 'F', 'Postprocedural disorders of circulatory system, not elsewhere classified', '', '', '25510101', '99999999'), ('I98', 'F', 'Other disorders of circulatory system in diseases classified elsewhere', '', '', '25510101', '99999999'), ('J01', 'F', 'Acute sinusitis', '', '', '25510101', '99999999'), ('J02', 'F', 'Acute pharyngitis', '', '', '25510101', '99999999'), ('J03', 'F', 'Acute tonsillitis', '', '', '25510101', '99999999'), ('J04', 'F', 'Acute laryngitis and tracheitis', '', '', '25510101', '99999999'), ('J05', 'F', 'Acute obstructive laryngitis [croup] and epiglottitis', '', '', '25510101', '99999999'), ('J06', 'F', 'Acute upper respiratory infections of multiple or unspecified sites', '', '', '25510101', '99999999'), ('J10', 'F', 'Influenza due to identified influenza virus', '', '', '25510101', '99999999'), ('J11', 'F', 'Influenza, virus not identified', '', '', '25510101', '99999999'), ('J12', 'F', 'Viral pneumonia, not elsewhere classified', '', '', '25510101', '99999999'), ('J15', 'F', 'Bacterial pneumonia, not elsewhere classified', '', '', '25510101', '99999999'), ('J16', 'F', 'Pneumonia due to other infectious organisms, not elsewhere classified', '', '', '25510101', '99999999'), ('J17', 'F', 'Pneumonia in diseases classified elsewhere', '', '', '25510101', '99999999'), ('J18', 'F', 'Pneumonia, organism unspecified', '', '', '25510101', '99999999'), ('J20', 'F', 'Acute bronchitis', '', '', '25510101', '99999999'), ('J21', 'F', 'Acute bronchiolitis', '', '', '25510101', '99999999'), ('J30', 'F', 'Vasomotor and allergic rhinitis', '', '', '25510101', '99999999'), ('J31', 'F', 'Chronic rhinitis, nasopharyngitis and pharyngitis', '', '', '25510101', '99999999'), ('J32', 'F', 'Chronic sinusitis', '', '', '25510101', '99999999'), ('J33', 'F', 'Nasal polyp', '', '', '25510101', '99999999'), ('J34', 'F', 'Other disorders of nose and nasal sinuses', '', '', '25510101', '99999999'), ('J35', 'F', 'Chronic diseases of tonsils and adenoids', '', '', '25510101', '99999999'), ('J37', 'F', 'Chronic laryngitis and laryngotracheitis', '', '', '25510101', '99999999'), ('J38', 'F', 'Diseases of vocal cords and larynx, not elsewhere classified', '', '', '25510101', '99999999'), ('J39', 'F', 'Other diseases of upper respiratory tract', '', '', '25510101', '99999999'), ('J41', 'F', 'Simple and mucopurulent chronic bronchitis', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('J43', 'F', 'Emphysema', '', '', '25510101', '99999999'), ('J44', 'F', 'Other chronic obstructive pulmonary disease', '', '', '25510101', '99999999'), ('J45', 'F', 'Asthma', '', '', '25510101', '99999999'), ('J62', 'F', 'Pneumoconiosis due to dust containing silica', '', '', '25510101', '99999999'), ('J63', 'F', 'Pneumoconiosis due to other inorganic dusts', '', '', '25510101', '99999999'), ('J66', 'F', 'Airway disease due to specific organic dust', '', '', '25510101', '99999999'), ('J67', 'F', 'Hypersensitivity pneumonitis due to organic dust', '', '', '25510101', '99999999'), ('J68', 'F', 'Respiratory conditions due to inhalation of chemicals, gases, fumes and vapours', '', '', '25510101', '99999999'), ('J69', 'F', 'Pneumonitis due to solids and liquids', '', '', '25510101', '99999999'), ('J70', 'F', 'Respiratory conditions due to other external agents', '', '', '25510101', '99999999'), ('J84', 'F', 'Other interstitial pulmonary diseases', '', '', '25510101', '99999999'), ('J85', 'F', 'Abscess of lung and mediastinum', '', '', '25510101', '99999999'), ('J86', 'F', 'Pyothorax', '', '', '25510101', '99999999'), ('J92', 'F', 'Pleural plaque', '', '', '25510101', '99999999'), ('J93', 'F', 'Pneumothorax', '', '', '25510101', '99999999'), ('J94', 'F', 'Other pleural conditions', '', '', '25510101', '99999999'), ('J95', 'F', 'Postprocedural respiratory disorders, not elsewhere classified', '', '', '25510101', '99999999'), ('J96', 'F', 'Respiratory failure, not elsewhere classified', '', '', '25510101', '99999999'), ('J98', 'F', 'Other respiratory disorders', '', '', '25510101', '99999999'), ('J99', 'F', 'Respiratory disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('K00', 'F', 'Disorders of tooth development and eruption', '', '', '25510101', '99999999'), ('K01', 'F', 'Embedded and impacted teeth', '', '', '25510101', '99999999'), ('K02', 'F', 'Dental caries', '', '', '25510101', '99999999'), ('K03', 'F', 'Other diseases of hard tissues of teeth', '', '', '25510101', '99999999'), ('K04', 'F', 'Diseases of pulp and periapical tissues', '', '', '25510101', '99999999'), ('K05', 'F', 'Gingivitis and periodontal diseases', '', '', '25510101', '99999999'), ('K06', 'F', 'Other disorders of gingiva and edentulous alveolar ridge', '', '', '25510101', '99999999'), ('K07', 'F', 'Dentofacial anomalies [including malocclusion]', '', '', '25510101', '99999999'), ('K08', 'F', 'Other disorders of teeth and supporting structures', '', '', '25510101', '99999999'), ('K09', 'F', 'Cysts of oral region, not elsewhere classified', '', '', '25510101', '99999999'), ('K10', 'F', 'Other diseases of jaws', '', '', '25510101', '99999999'), ('K11', 'F', 'Diseases of salivary glands', '', '', '25510101', '99999999'), ('K12', 'F', 'Stomatitis and related lesions', '', '', '25510101', '99999999'), ('K13', 'F', 'Other diseases of lip and oral mucosa', '', '', '25510101', '99999999'), ('K14', 'F', 'Diseases of tongue', '', '', '25510101', '99999999'), ('K21', 'F', 'Gastro-oesophageal reflux disease', '', '', '25510101', '99999999'), ('K22', 'F', 'Other diseases of oesophagus', '', '', '25510101', '99999999'), ('K23', 'F', 'Disorders of oesophagus in diseases classified elsewhere', '', '', '25510101', '99999999'), ('K25', 'F', 'Gastric ulcer', '', '', '25510101', '99999999'), ('K26', 'F', 'Duodenal ulcer', '', '', '25510101', '99999999'), ('K27', 'F', 'Peptic ulcer, site unspecified', '', '', '25510101', '99999999'), ('K28', 'F', 'Gastrojejunal ulcer', '', '', '25510101', '99999999'), ('K29', 'F', 'Gastritis and duodenitis', '', '', '25510101', '99999999'), ('K31', 'F', 'Other diseases of stomach and duodenum', '', '', '25510101', '99999999'), ('K35', 'F', 'Acute appendicitis', '', '', '25510101', '99999999'), ('K38', 'F', 'Other diseases of appendix', '', '', '25510101', '99999999'), ('K40', 'F', 'Inguinal hernia', '', '', '25510101', '99999999'), ('K41', 'F', 'Femoral hernia', '', '', '25510101', '99999999'), ('K42', 'F', 'Umbilical hernia', '', '', '25510101', '99999999'), ('K43', 'F', 'Ventral hernia', '', '', '25510101', '99999999'), ('K44', 'F', 'Diaphragmatic hernia', '', '', '25510101', '99999999'), ('K45', 'F', 'Other abdominal hernia', '', '', '25510101', '99999999'), ('K46', 'F', 'Unspecified abdominal hernia', '', '', '25510101', '99999999'), ('K50', 'F', 'Crohn\'s disease [regional enteritis]', '', '', '25510101', '99999999'), ('K51', 'F', 'Ulcerative colitis', '', '', '25510101', '99999999'), ('K52', 'F', 'Other noninfective gastroenteritis and colitis', '', '', '25510101', '99999999'), ('K55', 'F', 'Vascular disorders of intestine', '', '', '25510101', '99999999'), ('K56', 'F', 'Paralytic ileus and intestinal obstruction without hernia', '', '', '25510101', '99999999'), ('K57', 'F', 'Diverticular disease of intestine', '', '', '25510101', '99999999'), ('K58', 'F', 'Irritable bowel syndrome', '', '', '25510101', '99999999'), ('K59', 'F', 'Other functional intestinal disorders', '', '', '25510101', '99999999'), ('K60', 'F', 'Fissure and fistula of anal and rectal regions', '', '', '25510101', '99999999'), ('K61', 'F', 'Abscess of anal and rectal regions', '', '', '25510101', '99999999'), ('K62', 'F', 'Other diseases of anus and rectum', '', '', '25510101', '99999999'), ('K63', 'F', 'Other diseases of intestine', '', '', '25510101', '99999999'), ('K65', 'F', 'Peritonitis', '', '', '25510101', '99999999'), ('K66', 'F', 'Other disorders of peritoneum', '', '', '25510101', '99999999'), ('K67', 'F', 'Disorders of peritoneum in infectious diseases classified elsewhere', '', '', '25510101', '99999999'), ('K70', 'F', 'Alcoholic liver disease', '', '', '25510101', '99999999'), ('K71', 'F', 'Toxic liver disease', '', '', '25510101', '99999999'), ('K72', 'F', 'Hepatic failure, not elsewhere classified', '', '', '25510101', '99999999'), ('K73', 'F', 'Chronic hepatitis, not elsewhere classified', '', '', '25510101', '99999999'), ('K74', 'F', 'Fibrosis and cirrhosis of liver', '', '', '25510101', '99999999'), ('K75', 'F', 'Other inflammatory liver diseases', '', '', '25510101', '99999999'), ('K76', 'F', 'Other diseases of liver', '', '', '25510101', '99999999'), ('K77', 'F', 'Liver disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('K80', 'F', 'Cholelithiasis', '', '', '25510101', '99999999'), ('K81', 'F', 'Cholecystitis', '', '', '25510101', '99999999'), ('K82', 'F', 'Other diseases of gallbladder', '', '', '25510101', '99999999'), ('K83', 'F', 'Other diseases of biliary tract', '', '', '25510101', '99999999'), ('K85', 'F', 'Acute pancreatitis', '', '', '25510101', '99999999'), ('K86', 'F', 'Other diseases of pancreas', '', '', '25510101', '99999999'), ('K87', 'F', 'Disorders of gallbladder, biliary tract and pancreas in diseases classified elsewhere', '', '', '25510101', '99999999'), ('K90', 'F', 'Intestinal malabsorption', '', '', '25510101', '99999999'), ('K91', 'F', 'Postprocedural disorders of digestive system, not elsewhere classified', '', '', '25510101', '99999999'), ('K92', 'F', 'Other diseases of digestive system', '', '', '25510101', '99999999'), ('K93', 'F', 'Disorders of other digestive organs in diseases classified elsewhere', '', '', '25510101', '99999999'), ('L01', 'F', 'Impetigo', '', '', '25510101', '99999999'), ('L02', 'F', 'Cutaneous abscess, furuncle and carbuncle', '', '', '25510101', '99999999'), ('L03', 'F', 'Cellulitis', '', '', '25510101', '99999999'), ('L04', 'F', 'Acute lymphadenitis', '', '', '25510101', '99999999'), ('L05', 'F', 'Pilonidal cyst', '', '', '25510101', '99999999'), ('L08', 'F', 'Other local infections of skin and subcutaneous tissue', '', '', '25510101', '99999999'), ('L10', 'F', 'Pemphigus', '', '', '25510101', '99999999'), ('L11', 'F', 'Other acantholytic disorders', '', '', '25510101', '99999999'), ('L12', 'F', 'Pemphigoid', '', '', '25510101', '99999999'), ('L13', 'F', 'Other bullous disorders', '', '', '25510101', '99999999'), ('L20', 'F', 'Atopic dermatitis', '', '', '25510101', '99999999'), ('L21', 'F', 'Seborrhoeic dermatitis', '', '', '25510101', '99999999'), ('L23', 'F', 'Allergic contact dermatitis', '', '', '25510101', '99999999'), ('L24', 'F', 'Irritant contact dermatitis', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('L25', 'F', 'Unspecified contact dermatitis', '', '', '25510101', '99999999'), ('L27', 'F', 'Dermatitis due to substances taken internally', '', '', '25510101', '99999999'), ('L28', 'F', 'Lichen simplex chronicus and prurigo', '', '', '25510101', '99999999'), ('L29', 'F', 'Pruritus', '', '', '25510101', '99999999'), ('L30', 'F', 'Other dermatitis', '', '', '25510101', '99999999'), ('L40', 'F', 'Psoriasis', '', '', '25510101', '99999999'), ('L41', 'F', 'Parapsoriasis', '', '', '25510101', '99999999'), ('L43', 'F', 'Lichen planus', '', '', '25510101', '99999999'), ('L44', 'F', 'Other papulosquamous disorders', '', '', '25510101', '99999999'), ('L50', 'F', 'Urticaria', '', '', '25510101', '99999999'), ('L51', 'F', 'Erythema multiforme', '', '', '25510101', '99999999'), ('L53', 'F', 'Other erythematous conditions', '', '', '25510101', '99999999'), ('L54', 'F', 'Erythema in diseases classified elsewhere', '', '', '25510101', '99999999'), ('L55', 'F', 'Sunburn', '', '', '25510101', '99999999'), ('L56', 'F', 'Other acute skin changes due to ultraviolet radiation', '', '', '25510101', '99999999'), ('L57', 'F', 'Skin changes due to chronic exposure to nonionizing radiation', '', '', '25510101', '99999999'), ('L58', 'F', 'Radiodermatitis', '', '', '25510101', '99999999'), ('L59', 'F', 'Other disorders of skin and subcutaneous tissue related to radiation', '', '', '25510101', '99999999'), ('L60', 'F', 'Nail disorders', '', '', '25510101', '99999999'), ('L62', 'F', 'Nail disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('L63', 'F', 'Alopecia areata', '', '', '25510101', '99999999'), ('L64', 'F', 'Androgenic alopecia', '', '', '25510101', '99999999'), ('L65', 'F', 'Other nonscarring hair loss', '', '', '25510101', '99999999'), ('L66', 'F', 'Cicatricial alopecia [scarring hair loss]', '', '', '25510101', '99999999'), ('L67', 'F', 'Hair colour and hair shaft abnormalities', '', '', '25510101', '99999999'), ('L68', 'F', 'Hypertrichosis', '', '', '25510101', '99999999'), ('L70', 'F', 'Acne', '', '', '25510101', '99999999'), ('L71', 'F', 'Rosacea', '', '', '25510101', '99999999'), ('L72', 'F', 'Follicular cysts of skin and subcutaneous tissue', '', '', '25510101', '99999999'), ('L73', 'F', 'Other follicular disorders', '', '', '25510101', '99999999'), ('L74', 'F', 'Eccrine sweat disorders', '', '', '25510101', '99999999'), ('L75', 'F', 'Apocrine sweat disorders', '', '', '25510101', '99999999'), ('L81', 'F', 'Other disorders of pigmentation', '', '', '25510101', '99999999'), ('L85', 'F', 'Other epidermal thickening', '', '', '25510101', '99999999'), ('L87', 'F', 'Transepidermal elimination disorders', '', '', '25510101', '99999999'), ('L90', 'F', 'Atrophic disorders of skin', '', '', '25510101', '99999999'), ('L91', 'F', 'Hypertrophic disorders of skin', '', '', '25510101', '99999999'), ('L92', 'F', 'Granulomatous disorders of skin and subcutaneous tissue', '', '', '25510101', '99999999'), ('L93', 'F', 'Lupus erythematosus', '', '', '25510101', '99999999'), ('L94', 'F', 'Other localized connective tissue disorders', '', '', '25510101', '99999999'), ('L95', 'F', 'Vasculitis limited to skin, not elsewhere classified', '', '', '25510101', '99999999'), ('L98', 'F', 'Other disorders of skin and subcutaneous tissue, not elsewhere classified', '', '', '25510101', '99999999'), ('L99', 'F', 'Other disorders of skin and subcutaneous tissue in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M00', 'F', 'Pyogenic arthritis', '', '', '25510101', '99999999'), ('M01', 'F', 'Direct infections of joint in infectious and parasitic diseases classified elsewhere', '', '', '25510101', '99999999'), ('M02', 'F', 'Reactive arthropathies', '', '', '25510101', '99999999'), ('M03', 'F', 'Postinfective and reactive arthropathies in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M05', 'F', 'Seropositive rheumatoid arthritis', '', '', '25510101', '99999999'), ('M06', 'F', 'Other rheumatoid arthritis', '', '', '25510101', '99999999'), ('M07', 'F', 'Psoriatic and enteropathic arthropathies', '', '', '25510101', '99999999'), ('M08', 'F', 'Juvenile arthritis', '', '', '25510101', '99999999'), ('M09', 'F', 'Juvenile arthritis in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M10', 'F', 'Gout', '', '', '25510101', '99999999'), ('M11', 'F', 'Other crystal arthropathies', '', '', '25510101', '99999999'), ('M12', 'F', 'Other specific arthropathies', '', '', '25510101', '99999999'), ('M13', 'F', 'Other arthritis', '', '', '25510101', '99999999'), ('M14', 'F', 'Arthropathies in other diseases classified elsewhere', '', '', '25510101', '99999999'), ('M15', 'F', 'Polyarthrosis', '', '', '25510101', '99999999'), ('M16', 'F', 'Coxarthrosis [arthrosis of hip]', '', '', '25510101', '99999999'), ('M17', 'F', 'Gonarthrosis [arthrosis of knee]', '', '', '25510101', '99999999'), ('M18', 'F', 'Arthrosis of first carpometacarpal joint', '', '', '25510101', '99999999'), ('M19', 'F', 'Other arthrosis', '', '', '25510101', '99999999'), ('M20', 'F', 'Acquired deformities of fingers and toes', '', '', '25510101', '99999999'), ('M21', 'F', 'Other acquired deformities of limbs', '', '', '25510101', '99999999'), ('M22', 'F', 'Disorders of patella', '', '', '25510101', '99999999'), ('M23', 'F', 'Internal derangement of knee', '', '', '25510101', '99999999'), ('M24', 'F', 'Other specific joint derangements', '', '', '25510101', '99999999'), ('M25', 'F', 'Other joint disorders, not elsewhere classified', '', '', '25510101', '99999999'), ('M30', 'F', 'Polyarteritis nodosa and related conditions', '', '', '25510101', '99999999'), ('M31', 'F', 'Other necrotizing vasculopathies', '', '', '25510101', '99999999'), ('M32', 'F', 'Systemic lupus erythematosus', '', '', '25510101', '99999999'), ('M33', 'F', 'Dermatopolymyositis', '', '', '25510101', '99999999'), ('M34', 'F', 'Systemic sclerosis', '', '', '25510101', '99999999'), ('M35', 'F', 'Other systemic involvement of connective tissue', '', '', '25510101', '99999999'), ('M36', 'F', 'Systemic disorders of connective tissue in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M40', 'F', 'Kyphosis and lordosis', '', '', '25510101', '99999999'), ('M41', 'F', 'Scoliosis', '', '', '25510101', '99999999'), ('M42', 'F', 'Spinal osteochondrosis', '', '', '25510101', '99999999'), ('M43', 'F', 'Other deforming dorsopathies', '', '', '25510101', '99999999'), ('M46', 'F', 'Other inflammatory spondylopathies', '', '', '25510101', '99999999'), ('M47', 'F', 'Spondylosis', '', '', '25510101', '99999999'), ('M48', 'F', 'Other spondylopathies', '', '', '25510101', '99999999'), ('M49', 'F', 'Spondylopathies in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M50', 'F', 'Cervical disc disorders', '', '', '25510101', '99999999'), ('M51', 'F', 'Other intervertebral disc disorders', '', '', '25510101', '99999999'), ('M53', 'F', 'Other dorsopathies, not elsewhere classified', '', '', '25510101', '99999999'), ('M54', 'F', 'Dorsalgia', '', '', '25510101', '99999999'), ('M60', 'F', 'Myositis', '', '', '25510101', '99999999'), ('M61', 'F', 'Calcification and ossification of muscle', '', '', '25510101', '99999999'), ('M62', 'F', 'Other disorders of muscle', '', '', '25510101', '99999999'), ('M63', 'F', 'Disorders of muscle in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M65', 'F', 'Synovitis and tenosynovitis', '', '', '25510101', '99999999'), ('M66', 'F', 'Spontaneous rupture of synovium and tendon', '', '', '25510101', '99999999'), ('M67', 'F', 'Other disorders of synovium and tendon', '', '', '25510101', '99999999'), ('M68', 'F', 'Disorders of synovium and tendon in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M70', 'F', 'Soft tissue disorders related to use, overuse and pressure', '', '', '25510101', '99999999'), ('M71', 'F', 'Other bursopathies', '', '', '25510101', '99999999'), ('M72', 'F', 'Fibroblastic disorders', '', '', '25510101', '99999999'), ('M73', 'F', 'Soft tissue disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M75', 'F', 'Shoulder lesions', '', '', '25510101', '99999999'), ('M76', 'F', 'Enthesopathies of lower limb, excluding foot', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('M77', 'F', 'Other enthesopathies', '', '', '25510101', '99999999'), ('M79', 'F', 'Other soft tissue disorders, not elsewhere classified', '', '', '25510101', '99999999'), ('CODE', 'VALID', 'DESC_R', 'SEX', 'PTYPE', 'start_date', 'end_date'), ('A00', 'F', 'Cholera', '', '', '25510101', '99999999'), ('A01', 'F', 'Typhoid and paratyphoid fevers', '', '', '25510101', '99999999'), ('A02', 'F', 'Other salmonella infections', '', '', '25510101', '99999999'), ('A03', 'F', 'Shigellosis', '', '', '25510101', '99999999'), ('A04', 'F', 'Other bacterial intestinal infections', '', '', '25510101', '99999999'), ('A05', 'F', 'Other bacterial foodborne intoxications', '', '', '25510101', '99999999'), ('A06', 'F', 'Amoebiasis', '', '', '25510101', '99999999'), ('A07', 'F', 'Other protozoal intestinal diseases', '', '', '25510101', '99999999'), ('A08', 'F', 'Viral and other specified intestinal infections', '', '', '25510101', '99999999'), ('A15', 'F', 'Respiratory tuberculosis, bacteriologically and histologically confirmed', '', '', '25510101', '99999999'), ('A16', 'F', 'Respiratory tuberculosis, not confirmed bacteriologically or histologically', '', '', '25510101', '99999999'), ('A17', 'F', 'Tuberculosis of nervous system', '', '', '25510101', '99999999'), ('A18', 'F', 'Tuberculosis of other organs', '', '', '25510101', '99999999'), ('A19', 'F', 'Miliary tuberculosis', '', '', '25510101', '99999999'), ('A20', 'F', 'Plague', '', '', '25510101', '99999999'), ('A21', 'F', 'Tularaemia', '', '', '25510101', '99999999'), ('A22', 'F', 'Anthrax', '', '', '25510101', '99999999'), ('A23', 'F', 'Brucellosis', '', '', '25510101', '99999999'), ('A24', 'F', 'Glanders and melioidosis', '', '', '25510101', '99999999'), ('A25', 'F', 'Rat-bite fevers', '', '', '25510101', '99999999'), ('A26', 'F', 'Erysipeloid', '', '', '25510101', '99999999'), ('A27', 'F', 'Leptospirosis', '', '', '25510101', '99999999'), ('A28', 'F', 'Other zoonotic bacterial diseases, not elsewhere classified', '', '', '25510101', '99999999'), ('A30', 'F', 'Leprosy [Hansen\'s disease]', '', '', '25510101', '99999999'), ('A31', 'F', 'Infection due to other mycobacteria', '', '', '25510101', '99999999'), ('A32', 'F', 'Listeriosis', '', '', '25510101', '99999999'), ('A36', 'F', 'Diphtheria', '', '', '25510101', '99999999'), ('A37', 'F', 'Whooping cough', '', '', '25510101', '99999999'), ('A39', 'F', 'Meningococcal infection', '', '', '25510101', '99999999'), ('A40', 'F', 'Streptococcal septicaemia', '', '', '25510101', '99999999'), ('A41', 'F', 'Other septicaemia', '', '', '25510101', '99999999'), ('A42', 'F', 'Actinomycosis', '', '', '25510101', '99999999'), ('A43', 'F', 'Nocardiosis', '', '', '25510101', '99999999'), ('A44', 'F', 'Bartonellosis', '', '', '25510101', '99999999'), ('A48', 'F', 'Other bacterial diseases, not elsewhere classified', '', '', '25510101', '99999999'), ('A49', 'F', 'Bacterial infection of unspecified site', '', '', '25510101', '99999999'), ('A50', 'F', 'Congenital syphilis', '', '', '25510101', '99999999'), ('A51', 'F', 'Early syphilis', '', '', '25510101', '99999999'), ('A52', 'F', 'Late syphilis', '', '', '25510101', '99999999'), ('A53', 'F', 'Other and unspecified syphilis', '', '', '25510101', '99999999'), ('A54', 'F', 'Gonococcal infection', '', '', '25510101', '99999999'), ('A56', 'F', 'Other sexually transmitted chlamydial diseases', '', '', '25510101', '99999999'), ('A59', 'F', 'Trichomoniasis', '', '', '25510101', '99999999'), ('A60', 'F', 'Anogenital herpesviral [herpes simplex] infections', '', '', '25510101', '99999999'), ('A63', 'F', 'Other predominantly sexually transmitted diseases, not elsewhere classified', '', '', '25510101', '99999999'), ('A66', 'F', 'Yaws', '', '', '25510101', '99999999'), ('A67', 'F', 'Pinta [carate]', '', '', '25510101', '99999999'), ('A68', 'F', 'Relapsing fevers', '', '', '25510101', '99999999'), ('A69', 'F', 'Other spirochaetal infections', '', '', '25510101', '99999999'), ('A71', 'F', 'Trachoma', '', '', '25510101', '99999999'), ('A74', 'F', 'Other diseases caused by chlamydiae', '', '', '25510101', '99999999'), ('A75', 'F', 'Typhus fever', '', '', '25510101', '99999999'), ('A77', 'F', 'Spotted fever [tick-borne rickettsioses]', '', '', '25510101', '99999999'), ('A79', 'F', 'Other rickettsioses', '', '', '25510101', '99999999'), ('A80', 'F', 'Acute poliomyelitis', '', '', '25510101', '99999999'), ('A81', 'F', 'Slow virus infections of central nervous system', '', '', '25510101', '99999999'), ('A82', 'F', 'Rabies', '', '', '25510101', '99999999'), ('A83', 'F', 'Mosquito-borne viral encephalitis', '', '', '25510101', '99999999'), ('A84', 'F', 'Tick-borne viral encephalitis', '', '', '25510101', '99999999'), ('A85', 'F', 'Other viral encephalitis, not elsewhere classified', '', '', '25510101', '99999999'), ('A87', 'F', 'Viral meningitis', '', '', '25510101', '99999999'), ('A88', 'F', 'Other viral infections of the central nervous system, not elsewhere classified', '', '', '25510101', '99999999'), ('A92', 'F', 'Other mosquito-borne viral fevers', '', '', '25510101', '99999999'), ('A93', 'F', 'Other arthropod-borne viral fevers, not elsewhere classified', '', '', '25510101', '99999999'), ('A95', 'F', 'Yellow fever', '', '', '25510101', '99999999'), ('A96', 'F', 'Arenaviral haemorrhagic fever', '', '', '25510101', '99999999'), ('A98', 'F', 'Other viral haemorrhagic fevers, not elsewhere classified', '', '', '25510101', '99999999'), ('B00', 'F', 'Herpesviral [herpes simplex] infections', '', '', '25510101', '99999999'), ('B01', 'F', 'Varicella [chickenpox]', '', '', '25510101', '99999999'), ('B02', 'F', 'Zoster [herpes zoster]', '', '', '25510101', '99999999'), ('B05', 'F', 'Measles', '', '', '25510101', '99999999'), ('B06', 'F', 'Rubella [German measles]', '', '', '25510101', '99999999'), ('B08', 'F', 'Other viral infections characterized by skin and mucous membrane lesions, not elsewhere', '', '', '25510101', '99999999'), ('B15', 'F', 'Acute hepatitis A', '', '', '25510101', '99999999'), ('B16', 'F', 'Acute hepatitis B', '', '', '25510101', '99999999'), ('B17', 'F', 'Other acute viral hepatitis', '', '', '25510101', '99999999'), ('B18', 'F', 'Chronic viral hepatitis', '', '', '25510101', '99999999'), ('B19', 'F', 'Unspecified viral hepatitis', '', '', '25510101', '99999999'), ('B20', 'F', 'HIV disease resulting in infectious and parasitic diseases', '', '', '25510101', '25551130'), ('B21', 'F', 'HIV disease resulting in malignant neoplasms', '', '', '25510101', '25551130'), ('B22', 'F', 'HIV disease resulting in other specified diseases', '', '', '25510101', '25551130'), ('B23', 'F', 'HIV disease resulting in other conditions', '', '', '25510101', '25551130'), ('B25', 'F', 'Cytomegaloviral disease', '', '', '25510101', '99999999'), ('B26', 'F', 'Mumps', '', '', '25510101', '99999999'), ('B27', 'F', 'Infectious mononucleosis', '', '', '25510101', '99999999'), ('B30', 'F', 'Viral conjunctivitis', '', '', '25510101', '99999999'), ('B33', 'F', 'Other viral diseases, not elsewhere classified', '', '', '25510101', '99999999'), ('B34', 'F', 'Viral infection of unspecified site', '', '', '25510101', '99999999'), ('B35', 'F', 'Dermatophytosis', '', '', '25510101', '99999999'), ('B36', 'F', 'Other superficial mycoses', '', '', '25510101', '99999999'), ('B37', 'F', 'Candidiasis', '', '', '25510101', '99999999'), ('B38', 'F', 'Coccidioidomycosis', '', '', '25510101', '99999999'), ('B39', 'F', 'Histoplasmosis', '', '', '25510101', '99999999'), ('B40', 'F', 'Blastomycosis', '', '', '25510101', '99999999'), ('B41', 'F', 'Paracoccidioidomycosis', '', '', '25510101', '99999999'), ('B42', 'F', 'Sporotrichosis', '', '', '25510101', '99999999'), ('B43', 'F', 'Chromomycosis and phaeomycotic abscess', '', '', '25510101', '99999999'), ('B44', 'F', 'Aspergillosis', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('B45', 'F', 'Cryptococcosis', '', '', '25510101', '99999999'), ('B46', 'F', 'Zygomycosis', '', '', '25510101', '99999999'), ('B47', 'F', 'Mycetoma', '', '', '25510101', '99999999'), ('B48', 'F', 'Other mycoses, not elsewhere classified', '', '', '25510101', '99999999'), ('B50', 'F', 'Plasmodium falciparum malaria', '', '', '25510101', '99999999'), ('B51', 'F', 'Plasmodium vivax malaria', '', '', '25510101', '99999999'), ('B52', 'F', 'Plasmodium malariae malaria', '', '', '25510101', '99999999'), ('B53', 'F', 'Other parasitologically confirmed malaria', '', '', '25510101', '99999999'), ('B55', 'F', 'Leishmaniasis', '', '', '25510101', '99999999'), ('B56', 'F', 'African trypanosomiasis', '', '', '25510101', '99999999'), ('B57', 'F', 'Chagas\' disease', '', '', '25510101', '99999999'), ('B58', 'F', 'Toxoplasmosis', '', '', '25510101', '99999999'), ('B60', 'F', 'Other protozoal diseases, not elsewhere classified', '', '', '25510101', '99999999'), ('B65', 'F', 'Schistosomiasis [bilharziasis]', '', '', '25510101', '99999999'), ('B66', 'F', 'Other fluke infections', '', '', '25510101', '99999999'), ('B67', 'F', 'Echinococcosis', '', '', '25510101', '99999999'), ('B68', 'F', 'Taeniasis', '', '', '25510101', '99999999'), ('B69', 'F', 'Cysticercosis', '', '', '25510101', '99999999'), ('B70', 'F', 'Diphyllobothriasis and sparganosis', '', '', '25510101', '99999999'), ('B71', 'F', 'Other cestode infections', '', '', '25510101', '99999999'), ('B74', 'F', 'Filariasis', '', '', '25510101', '99999999'), ('B76', 'F', 'Hookworm diseases', '', '', '25510101', '99999999'), ('B77', 'F', 'Ascariasis', '', '', '25510101', '99999999'), ('B78', 'F', 'Strongyloidiasis', '', '', '25510101', '99999999'), ('B81', 'F', 'Other intestinal helminthiases, not elsewhere classified', '', '', '25510101', '99999999'), ('B82', 'F', 'Unspecified intestinal parasitism', '', '', '25510101', '99999999'), ('B83', 'F', 'Other helminthiases', '', '', '25510101', '99999999'), ('B85', 'F', 'Pediculosis and phthiriasis', '', '', '25510101', '99999999'), ('B87', 'F', 'Myiasis', '', '', '25510101', '99999999'), ('B88', 'F', 'Other infestations', '', '', '25510101', '99999999'), ('B90', 'F', 'Sequelae of tuberculosis', '', '', '25510101', '99999999'), ('B94', 'F', 'Sequelae of other and unspecified infectious and parasitic diseases', '', '', '25510101', '99999999'), ('B95', 'F', 'Streptococcus and staphylococcus as the cause of diseases classified to other chapters', '', '', '25510101', '99999999'), ('B96', 'F', 'Other bacterial agents as the cause of diseases classified to other chapters', '', '', '25510101', '99999999'), ('B97', 'F', 'Viral agents as the cause of diseases classified to other chapters', '', '', '25510101', '99999999'), ('C00', 'F', 'Malignant neoplasm of lip', '', '', '25510101', '99999999'), ('C02', 'F', 'Malignant neoplasm of other and unspecified parts of tongue', '', '', '25510101', '99999999'), ('C03', 'F', 'Malignant neoplasm of gum', '', '', '25510101', '99999999'), ('C04', 'F', 'Malignant neoplasm of floor of mouth', '', '', '25510101', '99999999'), ('C05', 'F', 'Malignant neoplasm of palate', '', '', '25510101', '99999999'), ('C06', 'F', 'Malignant neoplasm of other and unspecified parts of mouth', '', '', '25510101', '99999999'), ('C08', 'F', 'Malignant neoplasm of other and unspecified major salivary glands', '', '', '25510101', '99999999'), ('C09', 'F', 'Malignant neoplasm of tonsil', '', '', '25510101', '99999999'), ('C10', 'F', 'Malignant neoplasm of oropharynx', '', '', '25510101', '99999999'), ('C11', 'F', 'Malignant neoplasm of nasopharynx', '', '', '25510101', '99999999'), ('C13', 'F', 'Malignant neoplasm of hypopharynx', '', '', '25510101', '99999999'), ('C14', 'F', 'Malignant neoplasm of other and ill-defined sites in the lip, oral cavity and pharynx', '', '', '25510101', '99999999'), ('C15', 'F', 'Malignant neoplasm of oesophagus', '', '', '25510101', '99999999'), ('C16', 'F', 'Malignant neoplasm of stomach', '', '', '25510101', '99999999'), ('C17', 'F', 'Malignant neoplasm of small intestine', '', '', '25510101', '99999999'), ('C18', 'F', 'Malignant neoplasm of colon', '', '', '25510101', '99999999'), ('C21', 'F', 'Malignant neoplasm of anus and anal canal', '', '', '25510101', '99999999'), ('C22', 'F', 'Malignant neoplasm of liver and intrahepatic bile ducts', '', '', '25510101', '99999999'), ('C24', 'F', 'Malignant neoplasm of other and unspecified parts of biliary tract', '', '', '25510101', '99999999'), ('C25', 'F', 'Malignant neoplasm of pancreas', '', '', '25510101', '99999999'), ('C26', 'F', 'Malignant neoplasm of other and ill-defined digestive organs', '', '', '25510101', '99999999'), ('C30', 'F', 'Malignant neoplasm of nasal cavity and middle ear', '', '', '25510101', '99999999'), ('C31', 'F', 'Malignant neoplasm of accessory sinuses', '', '', '25510101', '99999999'), ('C32', 'F', 'Malignant neoplasm of larynx', '', '', '25510101', '99999999'), ('C34', 'F', 'Malignant neoplasm of bronchus and lung', '', '', '25510101', '99999999'), ('C38', 'F', 'Malignant neoplasm of heart, mediastinum and pleura', '', '', '25510101', '99999999'), ('C39', 'F', 'Malignant neoplasm of other and ill-defined sites in the respiratory system and intrathoracic', '', '', '25510101', '99999999'), ('C40', 'F', 'Malignant neoplasm of bone and articular cartilage of limbs', '', '', '25510101', '99999999'), ('C41', 'F', 'Malignant neoplasm of bone and articular cartilage of other and unspecified sites', '', '', '25510101', '99999999'), ('C43', 'F', 'Malignant melanoma of skin', '', '', '25510101', '99999999'), ('C44', 'F', 'Other malignant neoplasms of skin', '', '', '25510101', '99999999'), ('C45', 'F', 'Mesothelioma', '', '', '25510101', '99999999'), ('C46', 'F', 'Kaposi\'s sarcoma', '', '', '25510101', '99999999'), ('C47', 'F', 'Malignant neoplasm of peripheral nerves and autonomic nervous system', '', '', '25510101', '99999999'), ('C48', 'F', 'Malignant neoplasm of retroperitoneum and peritoneum', '', '', '25510101', '99999999'), ('C49', 'F', 'Malignant neoplasm of other connective and soft tissue', '', '', '25510101', '99999999'), ('C50', 'F', 'Malignant neoplasm of breast', '', '', '25510101', '99999999'), ('C51', 'F', 'Malignant neoplasm of vulva', '', '', '25510101', '99999999'), ('C53', 'F', 'Malignant neoplasm of cervix uteri', '', '', '25510101', '99999999'), ('C54', 'F', 'Malignant neoplasm of corpus uteri', '', '', '25510101', '99999999'), ('C57', 'F', 'Malignant neoplasm of other and unspecified female genital organs', '', '', '25510101', '99999999'), ('C60', 'F', 'Malignant neoplasm of penis', '', '', '25510101', '99999999'), ('C62', 'F', 'Malignant neoplasm of testis', '', '', '25510101', '99999999'), ('C63', 'F', 'Malignant neoplasm of other and unspecified male genital organs', '', '', '25510101', '99999999'), ('C67', 'F', 'Malignant neoplasm of bladder', '', '', '25510101', '99999999'), ('C68', 'F', 'Malignant neoplasm of other and unspecified urinary organs', '', '', '25510101', '99999999'), ('C69', 'F', 'Malignant neoplasm of eye and adnexa', '', '', '25510101', '99999999'), ('C70', 'F', 'Malignant neoplasm of meninges', '', '', '25510101', '99999999'), ('C71', 'F', 'Malignant neoplasm of brain', '', '', '25510101', '99999999'), ('C72', 'F', 'Malignant neoplasm of spinal cord, cranial nerves and other parts of central nervous', '', '', '25510101', '99999999'), ('C74', 'F', 'Malignant neoplasm of adrenal gland', '', '', '25510101', '99999999'), ('C75', 'F', 'Malignant neoplasm of other endocrine glands and related structures', '', '', '25510101', '99999999'), ('C76', 'F', 'Malignant neoplasm of other and ill-defined sites', '', '', '25510101', '99999999'), ('C77', 'F', 'Secondary and unspecified malignant neoplasm of lymph nodes', '', '', '25510101', '99999999'), ('C78', 'F', 'Secondary malignant neoplasm of respiratory and digestive organs', '', '', '25510101', '99999999'), ('C79', 'F', 'Secondary malignant neoplasm of other sites', '', '', '25510101', '99999999'), ('C81', 'F', 'Hodgkin\'s disease', '', '', '25510101', '99999999'), ('C82', 'F', 'Follicular [nodular] non-Hodgkin\'s lymphoma', '', '', '25510101', '99999999'), ('C83', 'F', 'Diffuse non-Hodgkin\'s lymphoma', '', '', '25510101', '99999999'), ('C84', 'F', 'Peripheral and cutaneous T-cell lymphomas', '', '', '25510101', '99999999'), ('C85', 'F', 'Other and unspecified types of non-Hodgkin\'s lymphoma', '', '', '25510101', '99999999'), ('C88', 'F', 'Malignant immunoproliferative diseases', '', '', '25510101', '99999999'), ('C90', 'F', 'Multiple myeloma and malignant plasma cell neoplasms', '', '', '25510101', '99999999'), ('C91', 'F', 'Lymphoid leukaemia', '', '', '25510101', '99999999'), ('C92', 'F', 'Myeloid leukaemia', '', '', '25510101', '99999999'), ('C93', 'F', 'Monocytic leukaemia', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('C94', 'F', 'Other leukaemias of specified cell type', '', '', '25510101', '99999999'), ('C95', 'F', 'Leukaemia of unspecified cell type', '', '', '25510101', '99999999'), ('C96', 'F', 'Other and unspecified malignant neoplasms of lymphoid, haematopoietic and related tissue', '', '', '25510101', '99999999'), ('D00', 'F', 'Carcinoma in situ of oral cavity, oesophagus and stomach', '', '', '25510101', '99999999'), ('D01', 'F', 'Carcinoma in situ of other and unspecified digestive organs', '', '', '25510101', '99999999'), ('D02', 'F', 'Carcinoma in situ of middle ear and respiratory system', '', '', '25510101', '99999999'), ('D03', 'F', 'Melanoma in situ', '', '', '25510101', '99999999'), ('D04', 'F', 'Carcinoma in situ of skin', '', '', '25510101', '99999999'), ('D05', 'F', 'Carcinoma in situ of breast', '', '', '25510101', '99999999'), ('D06', 'F', 'Carcinoma in situ of cervix uteri', '', '', '25510101', '99999999'), ('D07', 'F', 'Carcinoma in situ of other and unspecified genital organs', '', '', '25510101', '99999999'), ('D09', 'F', 'Carcinoma in situ of other and unspecified sites', '', '', '25510101', '99999999'), ('D10', 'F', 'Benign neoplasm of mouth and pharynx', '', '', '25510101', '99999999'), ('D11', 'F', 'Benign neoplasm of major salivary glands', '', '', '25510101', '99999999'), ('D12', 'F', 'Benign neoplasm of colon, rectum, anus and anal canal', '', '', '25510101', '99999999'), ('D13', 'F', 'Benign neoplasm of other and ill-defined parts of digestive system', '', '', '25510101', '99999999'), ('D14', 'F', 'Benign neoplasm of middle ear and respiratory system', '', '', '25510101', '99999999'), ('D15', 'F', 'Benign neoplasm of other and unspecified intrathoracic organs', '', '', '25510101', '99999999'), ('D16', 'F', 'Benign neoplasm of bone and articular cartilage', '', '', '25510101', '99999999'), ('D17', 'F', 'Benign lipomatous neoplasm', '', '', '25510101', '99999999'), ('D18', 'F', 'Haemangioma and lymphangioma, any site', '', '', '25510101', '99999999'), ('D19', 'F', 'Benign neoplasm of mesothelial tissue', '', '', '25510101', '99999999'), ('D20', 'F', 'Benign neoplasm of soft tissue of retroperitoneum and peritoneum', '', '', '25510101', '99999999'), ('D21', 'F', 'Other benign neoplasms of connective and other soft tissue', '', '', '25510101', '99999999'), ('D22', 'F', 'Melanocytic naevi', '', '', '25510101', '99999999'), ('D23', 'F', 'Other benign neoplasms of skin', '', '', '25510101', '99999999'), ('D25', 'F', 'Leiomyoma of uterus', '', '', '25510101', '99999999'), ('D26', 'F', 'Other benign neoplasms of uterus', '', '', '25510101', '99999999'), ('D28', 'F', 'Benign neoplasm of other and unspecified female genital organs', '', '', '25510101', '99999999'), ('D29', 'F', 'Benign neoplasm of male genital organs', '', '', '25510101', '99999999'), ('D30', 'F', 'Benign neoplasm of urinary organs', '', '', '25510101', '99999999'), ('D31', 'F', 'Benign neoplasm of eye and adnexa', '', '', '25510101', '99999999'), ('D32', 'F', 'Benign neoplasm of meninges', '', '', '25510101', '99999999'), ('D33', 'F', 'Benign neoplasm of brain and other parts of central nervous system', '', '', '25510101', '99999999'), ('D35', 'F', 'Benign neoplasm of other and unspecified endocrine glands', '', '', '25510101', '99999999'), ('D36', 'F', 'Benign neoplasm of other and unspecified sites', '', '', '25510101', '99999999'), ('D37', 'F', 'Neoplasm of uncertain or unknown behaviour of oral cavity and digestive organs', '', '', '25510101', '99999999'), ('D38', 'F', 'Neoplasm of uncertain or unknown behaviour of middle ear and respiratory and intrathoracic organs', '', '', '25510101', '99999999'), ('D39', 'F', 'Neoplasm of uncertain or unknown behaviour of female genital organs', '', '', '25510101', '99999999'), ('D40', 'F', 'Neoplasm of uncertain or unknown behaviour of male genital organs', '', '', '25510101', '99999999'), ('D41', 'F', 'Neoplasm of uncertain or unknown behaviour of urinary organs', '', '', '25510101', '99999999'), ('D42', 'F', 'Neoplasm of uncertain or unknown behaviour of meninges', '', '', '25510101', '99999999'), ('D43', 'F', 'Neoplasm of uncertain or unknown behaviour of brain and central nervous system', '', '', '25510101', '99999999'), ('D44', 'F', 'Neoplasm of uncertain or unknown behaviour of endocrine glands', '', '', '25510101', '99999999'), ('D46', 'F', 'Myelodysplastic syndromes', '', '', '25510101', '99999999'), ('D47', 'F', 'Other neoplasms of uncertain or unknown behaviour of lymphoid, haematopoietic and related tissue', '', '', '25510101', '99999999'), ('D48', 'F', 'Neoplasm of uncertain or unknown behaviour of other and unspecified sites', '', '', '25510101', '99999999'), ('D50', 'F', 'Iron deficiency anaemia', '', '', '25510101', '99999999'), ('D51', 'F', 'Vitamin B12 deficiency anaemia', '', '', '25510101', '99999999'), ('D52', 'F', 'Folate deficiency anaemia', '', '', '25510101', '99999999'), ('D53', 'F', 'Other nutritional anaemias', '', '', '25510101', '99999999'), ('D55', 'F', 'Anaemia due to enzyme disorders', '', '', '25510101', '99999999'), ('D56', 'F', 'Thalassaemia', '', '', '25510101', '99999999'), ('D57', 'F', 'Sickle-cell disorders', '', '', '25510101', '99999999'), ('D58', 'F', 'Other hereditary haemolytic anaemias', '', '', '25510101', '99999999'), ('D59', 'F', 'Acquired haemolytic anaemia', '', '', '25510101', '99999999'), ('D60', 'F', 'Acquired pure red cell aplasia [erythroblastopenia]', '', '', '25510101', '99999999'), ('D61', 'F', 'Other aplastic anaemias', '', '', '25510101', '99999999'), ('D63', 'F', 'Anaemia in chronic diseases classified elsewhere', '', '', '25510101', '99999999'), ('D64', 'F', 'Other anaemias', '', '', '25510101', '99999999'), ('D68', 'F', 'Other coagulation defects', '', '', '25510101', '99999999'), ('D69', 'F', 'Purpura and other haemorrhagic conditions', '', '', '25510101', '99999999'), ('D72', 'F', 'Other disorders of white blood cells', '', '', '25510101', '99999999'), ('D73', 'F', 'Diseases of spleen', '', '', '25510101', '99999999'), ('D74', 'F', 'Methaemoglobinaemia', '', '', '25510101', '99999999'), ('D75', 'F', 'Other diseases of blood and blood-forming organs', '', '', '25510101', '99999999'), ('D76', 'F', 'Certain diseases involving lymphoreticular tissue and reticulohistiocytic system', '', '', '25510101', '99999999'), ('D80', 'F', 'Immunodeficiency with predominantly antibody defects', '', '', '25510101', '99999999'), ('D81', 'F', 'Combined immunodeficiencies', '', '', '25510101', '99999999'), ('D82', 'F', 'Immunodeficiency associated with other major defects', '', '', '25510101', '99999999'), ('D83', 'F', 'Common variable immunodeficiency', '', '', '25510101', '99999999'), ('D84', 'F', 'Other immunodeficiencies', '', '', '25510101', '99999999'), ('D86', 'F', 'Sarcoidosis', '', '', '25510101', '99999999'), ('D89', 'F', 'Other disorders involving the immune mechanism, not elsewhere classified', '', '', '25510101', '99999999'), ('E00', 'F', 'Congenital iodine-deficiency syndrome', '', '', '25510101', '99999999'), ('E01', 'F', 'Iodine-deficiency-related thyroid disorders and allied conditions', '', '', '25510101', '99999999'), ('E03', 'F', 'Other hypothyroidism', '', '', '25510101', '99999999'), ('E04', 'F', 'Other nontoxic goitre', '', '', '25510101', '99999999'), ('E05', 'F', 'Thyrotoxicosis [hyperthyroidism]', '', '', '25510101', '99999999'), ('E06', 'F', 'Thyroiditis', '', '', '25510101', '99999999'), ('E07', 'F', 'Other disorders of thyroid', '', '', '25510101', '99999999'), ('E10', 'F', 'Insulin-dependent diabetes mellitus', '', '', '25510101', '99999999'), ('E11', 'F', 'Non-insulin-dependent diabetes mellitus', '', '', '25510101', '99999999'), ('E12', 'F', 'Malnutrition-related diabetes mellitus', '', '', '25510101', '99999999'), ('E13', 'F', 'Other specified diabetes mellitus', '', '', '25510101', '99999999'), ('E14', 'F', 'Unspecified diabetes mellitus', '', '', '25510101', '99999999'), ('E16', 'F', 'Other disorders of pancreatic internal secretion', '', '', '25510101', '99999999'), ('E20', 'F', 'Hypoparathyroidism', '', '', '25510101', '99999999'), ('E21', 'F', 'Hyperparathyroidism and other disorders of parathyroid gland', '', '', '25510101', '99999999'), ('E22', 'F', 'Hyperfunction of pituitary gland', '', '', '25510101', '99999999'), ('E23', 'F', 'Hypofunction and other disorders of pituitary gland', '', '', '25510101', '99999999'), ('E24', 'F', 'Cushing\'s syndrome', '', '', '25510101', '99999999'), ('E25', 'F', 'Adrenogenital disorders', '', '', '25510101', '99999999'), ('E26', 'F', 'Hyperaldosteronism', '', '', '25510101', '99999999'), ('E27', 'F', 'Other disorders of adrenal gland', '', '', '25510101', '99999999'), ('E28', 'F', 'Ovarian dysfunction', '', '', '25510101', '99999999'), ('E29', 'F', 'Testicular dysfunction', '', '', '25510101', '99999999'), ('E30', 'F', 'Disorders of puberty, not elsewhere classified', '', '', '25510101', '99999999'), ('E31', 'F', 'Polyglandular dysfunction', '', '', '25510101', '99999999'), ('E32', 'F', 'Diseases of thymus', '', '', '25510101', '99999999'), ('E34', 'F', 'Other endocrine disorders', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('E35', 'F', 'Disorders of endocrine glands in diseases classified elsewhere', '', '', '25510101', '99999999'), ('E44', 'F', 'Protein-energy malnutrition of moderate and mild degree', '', '', '25510101', '99999999'), ('E50', 'F', 'Vitamin A deficiency', '', '', '25510101', '99999999'), ('E51', 'F', 'Thiamine deficiency', '', '', '25510101', '99999999'), ('E53', 'F', 'Deficiency of other B group vitamins', '', '', '25510101', '99999999'), ('E55', 'F', 'Vitamin D deficiency', '', '', '25510101', '99999999'), ('E56', 'F', 'Other vitamin deficiencies', '', '', '25510101', '99999999'), ('E61', 'F', 'Deficiency of other nutrient elements', '', '', '25510101', '99999999'), ('E63', 'F', 'Other nutritional deficiencies', '', '', '25510101', '99999999'), ('E64', 'F', 'Sequelae of malnutrition and other nutritional deficiencies', '', '', '25510101', '99999999'), ('E66', 'F', 'Obesity', '', '', '25510101', '99999999'), ('E67', 'F', 'Other hyperalimentation', '', '', '25510101', '99999999'), ('E70', 'F', 'Disorders of aromatic amino-acid metabolism', '', '', '25510101', '99999999'), ('E71', 'F', 'Disorders of branched-chain amino-acid metabolism and fatty-acid metabolism', '', '', '25510101', '99999999'), ('E72', 'F', 'Other disorders of amino-acid metabolism', '', '', '25510101', '99999999'), ('E73', 'F', 'Lactose intolerance', '', '', '25510101', '99999999'), ('E74', 'F', 'Other disorders of carbohydrate metabolism', '', '', '25510101', '99999999'), ('E75', 'F', 'Disorders of sphingolipid metabolism and other lipid storage disorders', '', '', '25510101', '99999999'), ('E76', 'F', 'Disorders of glycosaminoglycan metabolism', '', '', '25510101', '99999999'), ('E77', 'F', 'Disorders of glycoprotein metabolism', '', '', '25510101', '99999999'), ('E78', 'F', 'Disorders of lipoprotein metabolism and other lipidaemias', '', '', '25510101', '99999999'), ('E79', 'F', 'Disorders of purine and pyrimidine metabolism', '', '', '25510101', '99999999'), ('E80', 'F', 'Disorders of porphyrin and bilirubin metabolism', '', '', '25510101', '99999999'), ('E83', 'F', 'Disorders of mineral metabolism', '', '', '25510101', '99999999'), ('E84', 'F', 'Cystic fibrosis', '', '', '25510101', '99999999'), ('E85', 'F', 'Amyloidosis', '', '', '25510101', '99999999'), ('E87', 'F', 'Other disorders of fluid, electrolyte and acid-base balance', '', '', '25510101', '99999999'), ('E88', 'F', 'Other metabolic disorders', '', '', '25510101', '99999999'), ('E89', 'F', 'Postprocedural endocrine and metabolic disorders, not elsewhere classified', '', '', '25510101', '99999999'), ('F00', 'F', 'Dementia in Alzheimer\'s disease (G30.-+)', '', '', '25510101', '99999999'), ('F01', 'F', 'Vascular dementia', '', '', '25510101', '99999999'), ('F02', 'F', 'Dementia in other diseases classified elsewhere', '', '', '25510101', '99999999'), ('F05', 'F', 'Delirium, not induced by alcohol and other psychoactive substances', '', '', '25510101', '99999999'), ('F06', 'F', 'Other mental disorders due to brain damage and dysfunction and to physical disease', '', '', '25510101', '99999999'), ('F07', 'F', 'Personality and behavioural disorders due to brain disease, damage and dysfunction', '', '', '25510101', '99999999'), ('F10', 'F', 'Mental and behavioral disorders due to use of alcohol', '', '', '25510101', '99999999'), ('F11', 'F', 'Mental and behavioral disorders due to use of opioids', '', '', '25510101', '99999999'), ('F12', 'F', 'Mental and behavioral disorders due to use of cannabinoids', '', '', '25510101', '99999999'), ('F13', 'F', 'Mental and behavioral disorders due to use of sedatives or hypnotics', '', '', '25510101', '99999999'), ('F14', 'F', 'Mental and behavioral disorders due to use of cocaine', '', '', '25510101', '99999999'), ('F15', 'F', 'Mental and behavioral disorders due to use of other stimulants including caffeine', '', '', '25510101', '99999999'), ('F16', 'F', 'Mental and behavioral disorders due to use of hallucinogens', '', '', '25510101', '99999999'), ('F17', 'F', 'Mental and behavioral disorders due to use of tobacco', '', '', '25510101', '99999999'), ('F18', 'F', 'Mental and behavioral disorders due to use of volatile solvents', '', '', '25510101', '99999999'), ('F19', 'F', 'Mental and behavioral disorders due to use of multiple drug use and use of other psychoactive substances', '', '', '25510101', '99999999'), ('F20', 'F', 'Schizophrenia', '', '', '25510101', '99999999'), ('F22', 'F', 'Persistent delusional disorders', '', '', '25510101', '99999999'), ('F23', 'F', 'Acute and transient psychotic disorders', '', '', '25510101', '99999999'), ('F25', 'F', 'Schizoaffective disorders', '', '', '25510101', '99999999'), ('F30', 'F', 'Manic episode', '', '', '25510101', '99999999'), ('F31', 'F', 'Bipolar affective disorder', '', '', '25510101', '99999999'), ('F32', 'F', 'Depressive episodes', '', '', '25510101', '99999999'), ('F33', 'F', 'Recurrent depressive disorder', '', '', '25510101', '99999999'), ('F34', 'F', 'Persistent mood [affective] disorders', '', '', '25510101', '99999999'), ('F38', 'F', 'Other mood [affective] disorders', '', '', '25510101', '99999999'), ('F40', 'F', 'Phobic anxiety disorders', '', '', '25510101', '99999999'), ('F41', 'F', 'Other anxiety disorders', '', '', '25510101', '99999999'), ('F42', 'F', 'Obsessive-compulsive disorder', '', '', '25510101', '99999999'), ('F43', 'F', 'Reaction to severe stress, and adjustment disorders', '', '', '25510101', '99999999'), ('F44', 'F', 'Dissociative [conversion] disorders', '', '', '25510101', '99999999'), ('F45', 'F', 'Somatoform disorders', '', '', '25510101', '99999999'), ('F48', 'F', 'Other neurotic disorders', '', '', '25510101', '99999999'), ('F50', 'F', 'Eating disorders', '', '', '25510101', '99999999'), ('F51', 'F', 'Nonorganic sleep disorders', '', '', '25510101', '99999999'), ('F52', 'F', 'Sexual dysfunction, not caused by organic disorder or disease', '', '', '25510101', '99999999'), ('F53', 'F', 'Mental and behavioural disorders associated with the puerperium, not elsewhere classified', '', '', '25510101', '99999999'), ('F60', 'F', 'Specific personality disorders', '', '', '25510101', '99999999'), ('F62', 'F', 'Enduring personality changes, not attributable to brain damage and disease', '', '', '25510101', '99999999'), ('F63', 'F', 'Habit and impulse disorders', '', '', '25510101', '99999999'), ('F64', 'F', 'Gender identity disorders', '', '', '25510101', '99999999'), ('F65', 'F', 'Disorders of sexual preference', '', '', '25510101', '99999999'), ('F66', 'F', 'Psychological and behavioural disorders associated with sexual development and orientation', '', '', '25510101', '99999999'), ('F68', 'F', 'Other disorders of adult personality and behaviour', '', '', '25510101', '99999999'), ('F70', 'F', 'Mild mental retardation', '', '', '25510101', '99999999'), ('F71', 'F', 'Moderate mental retardation', '', '', '25510101', '99999999'), ('F72', 'F', 'Severe mental retardation', '', '', '25510101', '99999999'), ('F73', 'F', 'Profound mental retardation', '', '', '25510101', '99999999'), ('F78', 'F', 'Other mental retardation', '', '', '25510101', '99999999'), ('F79', 'F', 'Unspecified mental retardation', '', '', '25510101', '99999999'), ('F80', 'F', 'Specific developmental disorders of speech and language', '', '', '25510101', '99999999'), ('F81', 'F', 'Specific developmental disorders of scholastic skills', '', '', '25510101', '99999999'), ('F84', 'F', 'Pervasive developmental disorders', '', '', '25510101', '99999999'), ('F90', 'F', 'Hyperkinetic disorders', '', '', '25510101', '99999999'), ('F91', 'F', 'Conduct disorders', '', '', '25510101', '99999999'), ('F92', 'F', 'Mixed disorders of conduct and emotions', '', '', '25510101', '99999999'), ('F93', 'F', 'Emotional disorders with onset specific to childhood', '', '', '25510101', '99999999'), ('F94', 'F', 'Disorders of social functioning with onset specific to childhood and adolescence', '', '', '25510101', '99999999'), ('F95', 'F', 'Tic disorders', '', '', '25510101', '99999999'), ('F98', 'F', 'Other behavioural and emotional disorders with onset usually occurring in childhood and adolescence', '', '', '25510101', '99999999'), ('G00', 'F', 'Bacterial meningitis, not elsewhere classified', '', '', '25510101', '99999999'), ('G02', 'F', 'Meningitis in other infectious and parasitic diseases classified elsewhere', '', '', '25510101', '99999999'), ('G03', 'F', 'Meningitis due to other and unspecified causes', '', '', '25510101', '99999999'), ('G04', 'F', 'Encephalitis, myelitis and encephalomyelitis', '', '', '25510101', '99999999'), ('G05', 'F', 'Encephalitis, myelitis and encephalomyelitis in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G06', 'F', 'Intracranial and intraspinal abscess and granuloma', '', '', '25510101', '99999999'), ('G11', 'F', 'Hereditary ataxia', '', '', '25510101', '99999999'), ('G12', 'F', 'Spinal muscular atrophy and related syndromes', '', '', '25510101', '99999999'), ('G13', 'F', 'Systemic atrophies primarily affecting central nervous system in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G21', 'F', 'Secondary parkinsonism', '', '', '25510101', '99999999'), ('G23', 'F', 'Other degenerative diseases of the basal ganglia', '', '', '25510101', '99999999'), ('G24', 'F', 'Dystonia', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('G25', 'F', 'Other extrapyramidal and movement disorders', '', '', '25510101', '99999999'), ('G30', 'F', 'Alzheimer\'s disease', '', '', '25510101', '99999999'), ('G31', 'F', 'Other degenerative diseases of nervous system, not elsewhere classified', '', '', '25510101', '99999999'), ('G32', 'F', 'Other degenerative disorders of nervous system in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G36', 'F', 'Other acute disseminated demyelination', '', '', '25510101', '99999999'), ('G37', 'F', 'Other demyelinating diseases of central nervous system', '', '', '25510101', '99999999'), ('G40', 'F', 'Epilepsy', '', '', '25510101', '99999999'), ('G41', 'F', 'Status epilepticus', '', '', '25510101', '99999999'), ('G43', 'F', 'Migraine', '', '', '25510101', '99999999'), ('G44', 'F', 'Other headache syndromes', '', '', '25510101', '99999999'), ('G45', 'F', 'Transient cerebral ischaemic attacks and related syndromes', '', '', '25510101', '99999999'), ('G46', 'F', 'Vascular syndromes of brain in cerebrovascular diseases (I60-I67+)', '', '', '25510101', '99999999'), ('G47', 'F', 'Sleep disorders', '', '', '25510101', '99999999'), ('G50', 'F', 'Disorders of trigeminal nerve', '', '', '25510101', '99999999'), ('G51', 'F', 'Facial nerve disorders', '', '', '25510101', '99999999'), ('G52', 'F', 'Disorders of other cranial nerves', '', '', '25510101', '99999999'), ('G53', 'F', 'Cranial nerve disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G54', 'F', 'Nerve root and plexus disorders', '', '', '25510101', '99999999'), ('G55', 'F', 'Nerve root and plexus compressions in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G56', 'F', 'Mononeuropathies of upper limb', '', '', '25510101', '99999999'), ('G57', 'F', 'Mononeuropathies of lower limb', '', '', '25510101', '99999999'), ('G58', 'F', 'Other mononeuropathies', '', '', '25510101', '99999999'), ('G59', 'F', 'Mononeuropathy in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G60', 'F', 'Hereditary and idiopathic neuropathy', '', '', '25510101', '99999999'), ('G61', 'F', 'Inflammatory polyneuropathy', '', '', '25510101', '99999999'), ('G62', 'F', 'Other polyneuropathies', '', '', '25510101', '99999999'), ('G63', 'F', 'Polyneuropathy in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G70', 'F', 'Myasthenia gravis and other myoneural disorders', '', '', '25510101', '99999999'), ('G71', 'F', 'Primary disorders of muscles', '', '', '25510101', '99999999'), ('G72', 'F', 'Other myopathies', '', '', '25510101', '99999999'), ('G73', 'F', 'Disorders of myoneural junction and muscle in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G80', 'F', 'Infantile cerebral palsy', '', '', '25510101', '99999999'), ('G81', 'F', 'Hemiplegia', '', '', '25510101', '99999999'), ('G82', 'F', 'Paraplegia and tetraplegia', '', '', '25510101', '99999999'), ('G83', 'F', 'Other paralytic syndromes', '', '', '25510101', '99999999'), ('G90', 'F', 'Disorders of autonomic nervous system', '', '', '25510101', '99999999'), ('G91', 'F', 'Hydrocephalus', '', '', '25510101', '99999999'), ('G93', 'F', 'Other disorders of brain', '', '', '25510101', '99999999'), ('G94', 'F', 'Other disorders of brain in diseases classified elsewhere', '', '', '25510101', '99999999'), ('G95', 'F', 'Other diseases of spinal cord', '', '', '25510101', '99999999'), ('G96', 'F', 'Other disorders of central nervous system', '', '', '25510101', '99999999'), ('G97', 'F', 'Postprocedural disorders of nervous system, not elsewhere classified', '', '', '25510101', '99999999'), ('G99', 'F', 'Other disorders of nervous system in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H00', 'F', 'Hordeolum and chalazion', '', '', '25510101', '99999999'), ('H01', 'F', 'Other inflammation of eyelid', '', '', '25510101', '99999999'), ('H02', 'F', 'Other disorders of eyelid', '', '', '25510101', '99999999'), ('H03', 'F', 'Disorders of eyelid in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H04', 'F', 'Disorders of lacrimal system', '', '', '25510101', '99999999'), ('H05', 'F', 'Disorders of orbit', '', '', '25510101', '99999999'), ('H06', 'F', 'Disorders of lacrimal system and orbit in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H10', 'F', 'Conjunctivitis', '', '', '25510101', '99999999'), ('H11', 'F', 'Other disorders of conjunctiva', '', '', '25510101', '99999999'), ('H13', 'F', 'Disorders of conjunctiva in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H15', 'F', 'Disorders of sclera', '', '', '25510101', '99999999'), ('H16', 'F', 'Keratitis', '', '', '25510101', '99999999'), ('H17', 'F', 'Corneal scars and opacities', '', '', '25510101', '99999999'), ('H18', 'F', 'Other disorders of cornea', '', '', '25510101', '99999999'), ('H19', 'F', 'Disorders of sclera and cornea in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H20', 'F', 'Iridocyclitis', '', '', '25510101', '99999999'), ('H21', 'F', 'Other disorders of iris and ciliary body', '', '', '25510101', '99999999'), ('H22', 'F', 'Disorders of iris and ciliary body in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H25', 'F', 'Senile cataract', '', '', '25510101', '99999999'), ('H26', 'F', 'Other cataract', '', '', '25510101', '99999999'), ('H27', 'F', 'Other disorders of lens', '', '', '25510101', '99999999'), ('H28', 'F', 'Cataract and other disorders of lens in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H30', 'F', 'Chorioretinal inflammation', '', '', '25510101', '99999999'), ('H31', 'F', 'Other disorders of choroid', '', '', '25510101', '99999999'), ('H32', 'F', 'Chorioretinal disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H33', 'F', 'Retinal detachments and breaks', '', '', '25510101', '99999999'), ('H34', 'F', 'Retinal vascular occlusions', '', '', '25510101', '99999999'), ('H35', 'F', 'Other retinal disorders', '', '', '25510101', '99999999'), ('H36', 'F', 'Retinal disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H40', 'F', 'Glaucoma', '', '', '25510101', '99999999'), ('H42', 'F', 'Glaucoma in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H43', 'F', 'Disorders of vitreous body', '', '', '25510101', '99999999'), ('H44', 'F', 'Disorders of globe', '', '', '25510101', '99999999'), ('H45', 'F', 'Disorders of vitreous body and globe in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H47', 'F', 'Other disorders of optic [2nd] nerve and visual pathways', '', '', '25510101', '99999999'), ('H48', 'F', 'Disorders of optic [2nd] nerve and visual pathways in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H49', 'F', 'Paralytic strabismus', '', '', '25510101', '99999999'), ('H50', 'F', 'Other strabismus', '', '', '25510101', '99999999'), ('H51', 'F', 'Other disorders of binocular movement', '', '', '25510101', '99999999'), ('H52', 'F', 'Disorders of refraction and accommodation', '', '', '25510101', '99999999'), ('H53', 'F', 'Visual disturbances', '', '', '25510101', '99999999'), ('H54', 'F', 'Blindness and low vision', '', '', '25510101', '99999999'), ('H57', 'F', 'Other disorders of eye and adnexa', '', '', '25510101', '99999999'), ('H58', 'F', 'Other disorders of eye and adnexa in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H59', 'F', 'Post procedure disorder of eye and adnexa, not elsewhere classified', '', '', '25510101', '99999999'), ('H60', 'F', 'Otitis externa', '', '', '25510101', '99999999'), ('H61', 'F', 'Other disorders of external ear', '', '', '25510101', '99999999'), ('H62', 'F', 'Disorders of external ear in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H65', 'F', 'Nonsuppurative otitis media', '', '', '25510101', '99999999'), ('H66', 'F', 'Suppurative and unspecified otitis media', '', '', '25510101', '99999999'), ('H67', 'F', 'Otitis media in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H68', 'F', 'Eustachian salpingitis and obstruction', '', '', '25510101', '99999999'), ('H69', 'F', 'Other disorders of Eustachian tube', '', '', '25510101', '99999999'), ('H70', 'F', 'Mastoiditis and related conditions', '', '', '25510101', '99999999'), ('H72', 'F', 'Perforation of tympanic membrane', '', '', '25510101', '99999999'), ('H73', 'F', 'Other disorders of tympanic membrane', '', '', '25510101', '99999999'), ('H74', 'F', 'Other disorders of middle ear and mastoid', '', '', '25510101', '99999999'), ('H75', 'F', 'Other disorders of middle ear and mastoid in diseases classified elsewhere', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('H80', 'F', 'Otosclerosis', '', '', '25510101', '99999999'), ('H81', 'F', 'Disorders of vestibular function', '', '', '25510101', '99999999'), ('H83', 'F', 'Other diseases of inner ear', '', '', '25510101', '99999999'), ('H90', 'F', 'Conductive and sensorineural hearing loss', '', '', '25510101', '99999999'), ('H91', 'F', 'Other hearing loss', '', '', '25510101', '99999999'), ('H92', 'F', 'Otalgia and effusion of ear', '', '', '25510101', '99999999'), ('H93', 'F', 'Other disorders of ear, not elsewhere classified', '', '', '25510101', '99999999'), ('H94', 'F', 'Other disorders of ear in diseases classified elsewhere', '', '', '25510101', '99999999'), ('H95', 'F', 'Postprocedural disorders of ear and mastoid process, not elsewhere classified', '', '', '25510101', '99999999'), ('I01', 'F', 'Rheumatic fever with heart involvement', '', '', '25510101', '99999999'), ('I02', 'F', 'Rheumatic chorea', '', '', '25510101', '99999999'), ('I05', 'F', 'Rheumatic mitral valve diseases', '', '', '25510101', '99999999'), ('I06', 'F', 'Rheumatic aortic valve diseases', '', '', '25510101', '99999999'), ('I07', 'F', 'Rheumatic tricuspid valve diseases', '', '', '25510101', '99999999'), ('I08', 'F', 'Multiple valve diseases', '', '', '25510101', '99999999'), ('I09', 'F', 'Other rheumatic heart diseases', '', '', '25510101', '99999999'), ('I11', 'F', 'Hypertensive heart disease', '', '', '25510101', '99999999'), ('I12', 'F', 'Hypertensive renal disease', '', '', '25510101', '99999999'), ('I13', 'F', 'Hypertensive heart and renal disease', '', '', '25510101', '99999999'), ('I15', 'F', 'Secondary hypertension', '', '', '25510101', '99999999'), ('I20', 'F', 'Angina pectoris', '', '', '25510101', '99999999'), ('I21', 'F', 'Acute myocardial infarction', '', '', '25510101', '99999999'), ('I22', 'F', 'Subsequent myocardial infarction', '', '', '25510101', '99999999'), ('I23', 'F', 'Certain current complications following acute myocardial infarction', '', '', '25510101', '99999999'), ('I24', 'F', 'Other acute ischaemic heart diseases', '', '', '25510101', '99999999'), ('I25', 'F', 'Chronic ischaemic heart disease', '', '', '25510101', '99999999'), ('I26', 'F', 'Pulmonary embolism', '', '', '25510101', '99999999'), ('I27', 'F', 'Other pulmonary heart diseases', '', '', '25510101', '99999999'), ('I28', 'F', 'Other diseases of pulmonary vessels', '', '', '25510101', '99999999'), ('I30', 'F', 'Acute pericarditis', '', '', '25510101', '99999999'), ('I31', 'F', 'Other diseases of pericardium', '', '', '25510101', '99999999'), ('I32', 'F', 'Pericarditis in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I33', 'F', 'Acute and subacute endocarditis', '', '', '25510101', '99999999'), ('I34', 'F', 'Nonrheumatic mitral valve disorders', '', '', '25510101', '99999999'), ('I35', 'F', 'Nonrheumatic aortic valve disorders', '', '', '25510101', '99999999'), ('I36', 'F', 'Nonrheumatic tricuspid valve disorders', '', '', '25510101', '99999999'), ('I37', 'F', 'Pulmonary valve disorders', '', '', '25510101', '99999999'), ('I39', 'F', 'Endocarditis and heart valve disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I40', 'F', 'Acute myocarditis', '', '', '25510101', '99999999'), ('I41', 'F', 'Myocarditis in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I42', 'F', 'Cardiomyopathy', '', '', '25510101', '99999999'), ('I43', 'F', 'Cardiomyopathy in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I44', 'F', 'Atrioventricular and left bundle-branch block', '', '', '25510101', '99999999'), ('I45', 'F', 'Other conduction disorders', '', '', '25510101', '99999999'), ('I46', 'F', 'Cardiac arrest', '', '', '25510101', '99999999'), ('I47', 'F', 'Paroxysmal tachycardia', '', '', '25510101', '99999999'), ('I49', 'F', 'Other cardiac arrhythmias', '', '', '25510101', '99999999'), ('I50', 'F', 'Heart failure', '', '', '25510101', '99999999'), ('I51', 'F', 'Complications and ill-defined descriptions of heart disease', '', '', '25510101', '99999999'), ('I52', 'F', 'Other heart disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I60', 'F', 'Subarachnoid haemorrhage', '', '', '25510101', '99999999'), ('I61', 'F', 'Intracerebral haemorrhage', '', '', '25510101', '99999999'), ('I62', 'F', 'Other nontraumatic intracranial haemorrhage', '', '', '25510101', '99999999'), ('I63', 'F', 'Cerebral infarction', '', '', '25510101', '99999999'), ('I65', 'F', 'Occlusion and stenosis of precerebral arteries, not resulting in cerebral infarction', '', '', '25510101', '99999999'), ('I66', 'F', 'Occlusion and stenosis of cerebral arteries, not resulting in cerebral infarction', '', '', '25510101', '99999999'), ('I67', 'F', 'Other cerebrovascular diseases', '', '', '25510101', '99999999'), ('I68', 'F', 'Cerebrovascular disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I69', 'F', 'Sequelae of cerebrovascular disease', '', '', '25510101', '99999999'), ('I70', 'F', 'Atherosclerosis', '', '', '25510101', '99999999'), ('I71', 'F', 'Aortic aneurysm and dissection', '', '', '25510101', '99999999'), ('I72', 'F', 'Other aneurysm', '', '', '25510101', '99999999'), ('I73', 'F', 'Other peripheral vascular diseases', '', '', '25510101', '99999999'), ('I74', 'F', 'Arterial embolism and thrombosis', '', '', '25510101', '99999999'), ('I77', 'F', 'Other disorders of arteries and arterioles', '', '', '25510101', '99999999'), ('I78', 'F', 'Diseases of capillaries', '', '', '25510101', '99999999'), ('I79', 'F', 'Disorders of arteries, arterioles and capillaries in diseases classified elsewhere', '', '', '25510101', '99999999'), ('I80', 'F', 'Phlebitis and thrombophlebitis', '', '', '25510101', '99999999'), ('I82', 'F', 'Other venous embolism and thrombosis', '', '', '25510101', '99999999'), ('I83', 'F', 'Varicose veins of lower extremities', '', '', '25510101', '99999999'), ('I84', 'F', 'Haemorrhoids', '', '', '25510101', '99999999'), ('I85', 'F', 'Oesophageal varices', '', '', '25510101', '99999999'), ('I86', 'F', 'Varicose veins of other sites', '', '', '25510101', '99999999'), ('I87', 'F', 'Other disorders of veins', '', '', '25510101', '99999999'), ('I88', 'F', 'Nonspecific lymphadenitis', '', '', '25510101', '99999999'), ('I89', 'F', 'Other noninfective disorders of lymphatic vessels and lymph nodes', '', '', '25510101', '99999999'), ('I95', 'F', 'Hypotension', '', '', '25510101', '99999999'), ('I97', 'F', 'Postprocedural disorders of circulatory system, not elsewhere classified', '', '', '25510101', '99999999'), ('I98', 'F', 'Other disorders of circulatory system in diseases classified elsewhere', '', '', '25510101', '99999999'), ('J01', 'F', 'Acute sinusitis', '', '', '25510101', '99999999'), ('J02', 'F', 'Acute pharyngitis', '', '', '25510101', '99999999'), ('J03', 'F', 'Acute tonsillitis', '', '', '25510101', '99999999'), ('J04', 'F', 'Acute laryngitis and tracheitis', '', '', '25510101', '99999999'), ('J05', 'F', 'Acute obstructive laryngitis [croup] and epiglottitis', '', '', '25510101', '99999999'), ('J06', 'F', 'Acute upper respiratory infections of multiple or unspecified sites', '', '', '25510101', '99999999'), ('J10', 'F', 'Influenza due to identified influenza virus', '', '', '25510101', '99999999'), ('J11', 'F', 'Influenza, virus not identified', '', '', '25510101', '99999999'), ('J12', 'F', 'Viral pneumonia, not elsewhere classified', '', '', '25510101', '99999999'), ('J15', 'F', 'Bacterial pneumonia, not elsewhere classified', '', '', '25510101', '99999999'), ('J16', 'F', 'Pneumonia due to other infectious organisms, not elsewhere classified', '', '', '25510101', '99999999'), ('J17', 'F', 'Pneumonia in diseases classified elsewhere', '', '', '25510101', '99999999'), ('J18', 'F', 'Pneumonia, organism unspecified', '', '', '25510101', '99999999'), ('J20', 'F', 'Acute bronchitis', '', '', '25510101', '99999999'), ('J21', 'F', 'Acute bronchiolitis', '', '', '25510101', '99999999'), ('J30', 'F', 'Vasomotor and allergic rhinitis', '', '', '25510101', '99999999'), ('J31', 'F', 'Chronic rhinitis, nasopharyngitis and pharyngitis', '', '', '25510101', '99999999'), ('J32', 'F', 'Chronic sinusitis', '', '', '25510101', '99999999'), ('J33', 'F', 'Nasal polyp', '', '', '25510101', '99999999'), ('J34', 'F', 'Other disorders of nose and nasal sinuses', '', '', '25510101', '99999999'), ('J35', 'F', 'Chronic diseases of tonsils and adenoids', '', '', '25510101', '99999999'), ('J37', 'F', 'Chronic laryngitis and laryngotracheitis', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('J38', 'F', 'Diseases of vocal cords and larynx, not elsewhere classified', '', '', '25510101', '99999999'), ('J39', 'F', 'Other diseases of upper respiratory tract', '', '', '25510101', '99999999'), ('J41', 'F', 'Simple and mucopurulent chronic bronchitis', '', '', '25510101', '99999999'), ('J43', 'F', 'Emphysema', '', '', '25510101', '99999999'), ('J44', 'F', 'Other chronic obstructive pulmonary disease', '', '', '25510101', '99999999'), ('J45', 'F', 'Asthma', '', '', '25510101', '99999999'), ('J62', 'F', 'Pneumoconiosis due to dust containing silica', '', '', '25510101', '99999999'), ('J63', 'F', 'Pneumoconiosis due to other inorganic dusts', '', '', '25510101', '99999999'), ('J66', 'F', 'Airway disease due to specific organic dust', '', '', '25510101', '99999999'), ('J67', 'F', 'Hypersensitivity pneumonitis due to organic dust', '', '', '25510101', '99999999'), ('J68', 'F', 'Respiratory conditions due to inhalation of chemicals, gases, fumes and vapours', '', '', '25510101', '99999999'), ('J69', 'F', 'Pneumonitis due to solids and liquids', '', '', '25510101', '99999999'), ('J70', 'F', 'Respiratory conditions due to other external agents', '', '', '25510101', '99999999'), ('J84', 'F', 'Other interstitial pulmonary diseases', '', '', '25510101', '99999999'), ('J85', 'F', 'Abscess of lung and mediastinum', '', '', '25510101', '99999999'), ('J86', 'F', 'Pyothorax', '', '', '25510101', '99999999'), ('J92', 'F', 'Pleural plaque', '', '', '25510101', '99999999'), ('J93', 'F', 'Pneumothorax', '', '', '25510101', '99999999'), ('J94', 'F', 'Other pleural conditions', '', '', '25510101', '99999999'), ('J95', 'F', 'Postprocedural respiratory disorders, not elsewhere classified', '', '', '25510101', '99999999'), ('J96', 'F', 'Respiratory failure, not elsewhere classified', '', '', '25510101', '99999999'), ('J98', 'F', 'Other respiratory disorders', '', '', '25510101', '99999999'), ('J99', 'F', 'Respiratory disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('K00', 'F', 'Disorders of tooth development and eruption', '', '', '25510101', '99999999'), ('K01', 'F', 'Embedded and impacted teeth', '', '', '25510101', '99999999'), ('K02', 'F', 'Dental caries', '', '', '25510101', '99999999'), ('K03', 'F', 'Other diseases of hard tissues of teeth', '', '', '25510101', '99999999'), ('K04', 'F', 'Diseases of pulp and periapical tissues', '', '', '25510101', '99999999'), ('K05', 'F', 'Gingivitis and periodontal diseases', '', '', '25510101', '99999999'), ('K06', 'F', 'Other disorders of gingiva and edentulous alveolar ridge', '', '', '25510101', '99999999'), ('K07', 'F', 'Dentofacial anomalies [including malocclusion]', '', '', '25510101', '99999999'), ('K08', 'F', 'Other disorders of teeth and supporting structures', '', '', '25510101', '99999999'), ('K09', 'F', 'Cysts of oral region, not elsewhere classified', '', '', '25510101', '99999999'), ('K10', 'F', 'Other diseases of jaws', '', '', '25510101', '99999999'), ('K11', 'F', 'Diseases of salivary glands', '', '', '25510101', '99999999'), ('K12', 'F', 'Stomatitis and related lesions', '', '', '25510101', '99999999'), ('K13', 'F', 'Other diseases of lip and oral mucosa', '', '', '25510101', '99999999'), ('K14', 'F', 'Diseases of tongue', '', '', '25510101', '99999999'), ('K21', 'F', 'Gastro-oesophageal reflux disease', '', '', '25510101', '99999999'), ('K22', 'F', 'Other diseases of oesophagus', '', '', '25510101', '99999999'), ('K23', 'F', 'Disorders of oesophagus in diseases classified elsewhere', '', '', '25510101', '99999999'), ('K25', 'F', 'Gastric ulcer', '', '', '25510101', '99999999'), ('K26', 'F', 'Duodenal ulcer', '', '', '25510101', '99999999'), ('K27', 'F', 'Peptic ulcer, site unspecified', '', '', '25510101', '99999999'), ('K28', 'F', 'Gastrojejunal ulcer', '', '', '25510101', '99999999'), ('K29', 'F', 'Gastritis and duodenitis', '', '', '25510101', '99999999'), ('K31', 'F', 'Other diseases of stomach and duodenum', '', '', '25510101', '99999999'), ('K35', 'F', 'Acute appendicitis', '', '', '25510101', '99999999'), ('K38', 'F', 'Other diseases of appendix', '', '', '25510101', '99999999'), ('K40', 'F', 'Inguinal hernia', '', '', '25510101', '99999999'), ('K41', 'F', 'Femoral hernia', '', '', '25510101', '99999999'), ('K42', 'F', 'Umbilical hernia', '', '', '25510101', '99999999'), ('K43', 'F', 'Ventral hernia', '', '', '25510101', '99999999'), ('K44', 'F', 'Diaphragmatic hernia', '', '', '25510101', '99999999'), ('K45', 'F', 'Other abdominal hernia', '', '', '25510101', '99999999'), ('K46', 'F', 'Unspecified abdominal hernia', '', '', '25510101', '99999999'), ('K50', 'F', 'Crohn\'s disease [regional enteritis]', '', '', '25510101', '99999999'), ('K51', 'F', 'Ulcerative colitis', '', '', '25510101', '99999999'), ('K52', 'F', 'Other noninfective gastroenteritis and colitis', '', '', '25510101', '99999999'), ('K55', 'F', 'Vascular disorders of intestine', '', '', '25510101', '99999999'), ('K56', 'F', 'Paralytic ileus and intestinal obstruction without hernia', '', '', '25510101', '99999999'), ('K57', 'F', 'Diverticular disease of intestine', '', '', '25510101', '99999999'), ('K58', 'F', 'Irritable bowel syndrome', '', '', '25510101', '99999999'), ('K59', 'F', 'Other functional intestinal disorders', '', '', '25510101', '99999999'), ('K60', 'F', 'Fissure and fistula of anal and rectal regions', '', '', '25510101', '99999999'), ('K61', 'F', 'Abscess of anal and rectal regions', '', '', '25510101', '99999999'), ('K62', 'F', 'Other diseases of anus and rectum', '', '', '25510101', '99999999'), ('K63', 'F', 'Other diseases of intestine', '', '', '25510101', '99999999'), ('K65', 'F', 'Peritonitis', '', '', '25510101', '99999999'), ('K66', 'F', 'Other disorders of peritoneum', '', '', '25510101', '99999999'), ('K67', 'F', 'Disorders of peritoneum in infectious diseases classified elsewhere', '', '', '25510101', '99999999'), ('K70', 'F', 'Alcoholic liver disease', '', '', '25510101', '99999999'), ('K71', 'F', 'Toxic liver disease', '', '', '25510101', '99999999'), ('K72', 'F', 'Hepatic failure, not elsewhere classified', '', '', '25510101', '99999999'), ('K73', 'F', 'Chronic hepatitis, not elsewhere classified', '', '', '25510101', '99999999'), ('K74', 'F', 'Fibrosis and cirrhosis of liver', '', '', '25510101', '99999999'), ('K75', 'F', 'Other inflammatory liver diseases', '', '', '25510101', '99999999'), ('K76', 'F', 'Other diseases of liver', '', '', '25510101', '99999999'), ('K77', 'F', 'Liver disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('K80', 'F', 'Cholelithiasis', '', '', '25510101', '99999999'), ('K81', 'F', 'Cholecystitis', '', '', '25510101', '99999999'), ('K82', 'F', 'Other diseases of gallbladder', '', '', '25510101', '99999999'), ('K83', 'F', 'Other diseases of biliary tract', '', '', '25510101', '99999999'), ('K85', 'F', 'Acute pancreatitis', '', '', '25510101', '99999999'), ('K86', 'F', 'Other diseases of pancreas', '', '', '25510101', '99999999'), ('K87', 'F', 'Disorders of gallbladder, biliary tract and pancreas in diseases classified elsewhere', '', '', '25510101', '99999999'), ('K90', 'F', 'Intestinal malabsorption', '', '', '25510101', '99999999'), ('K91', 'F', 'Postprocedural disorders of digestive system, not elsewhere classified', '', '', '25510101', '99999999'), ('K92', 'F', 'Other diseases of digestive system', '', '', '25510101', '99999999'), ('K93', 'F', 'Disorders of other digestive organs in diseases classified elsewhere', '', '', '25510101', '99999999'), ('L01', 'F', 'Impetigo', '', '', '25510101', '99999999'), ('L02', 'F', 'Cutaneous abscess, furuncle and carbuncle', '', '', '25510101', '99999999'), ('L03', 'F', 'Cellulitis', '', '', '25510101', '99999999'), ('L04', 'F', 'Acute lymphadenitis', '', '', '25510101', '99999999'), ('L05', 'F', 'Pilonidal cyst', '', '', '25510101', '99999999'), ('L08', 'F', 'Other local infections of skin and subcutaneous tissue', '', '', '25510101', '99999999'), ('L10', 'F', 'Pemphigus', '', '', '25510101', '99999999'), ('L11', 'F', 'Other acantholytic disorders', '', '', '25510101', '99999999'), ('L12', 'F', 'Pemphigoid', '', '', '25510101', '99999999'), ('L13', 'F', 'Other bullous disorders', '', '', '25510101', '99999999'), ('L20', 'F', 'Atopic dermatitis', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('L21', 'F', 'Seborrhoeic dermatitis', '', '', '25510101', '99999999'), ('L23', 'F', 'Allergic contact dermatitis', '', '', '25510101', '99999999'), ('L24', 'F', 'Irritant contact dermatitis', '', '', '25510101', '99999999'), ('L25', 'F', 'Unspecified contact dermatitis', '', '', '25510101', '99999999'), ('L27', 'F', 'Dermatitis due to substances taken internally', '', '', '25510101', '99999999'), ('L28', 'F', 'Lichen simplex chronicus and prurigo', '', '', '25510101', '99999999'), ('L29', 'F', 'Pruritus', '', '', '25510101', '99999999'), ('L30', 'F', 'Other dermatitis', '', '', '25510101', '99999999'), ('L40', 'F', 'Psoriasis', '', '', '25510101', '99999999'), ('L41', 'F', 'Parapsoriasis', '', '', '25510101', '99999999'), ('L43', 'F', 'Lichen planus', '', '', '25510101', '99999999'), ('L44', 'F', 'Other papulosquamous disorders', '', '', '25510101', '99999999'), ('L50', 'F', 'Urticaria', '', '', '25510101', '99999999'), ('L51', 'F', 'Erythema multiforme', '', '', '25510101', '99999999'), ('L53', 'F', 'Other erythematous conditions', '', '', '25510101', '99999999'), ('L54', 'F', 'Erythema in diseases classified elsewhere', '', '', '25510101', '99999999'), ('L55', 'F', 'Sunburn', '', '', '25510101', '99999999'), ('L56', 'F', 'Other acute skin changes due to ultraviolet radiation', '', '', '25510101', '99999999'), ('L57', 'F', 'Skin changes due to chronic exposure to nonionizing radiation', '', '', '25510101', '99999999'), ('L58', 'F', 'Radiodermatitis', '', '', '25510101', '99999999'), ('L59', 'F', 'Other disorders of skin and subcutaneous tissue related to radiation', '', '', '25510101', '99999999'), ('L60', 'F', 'Nail disorders', '', '', '25510101', '99999999'), ('L62', 'F', 'Nail disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('L63', 'F', 'Alopecia areata', '', '', '25510101', '99999999'), ('L64', 'F', 'Androgenic alopecia', '', '', '25510101', '99999999'), ('L65', 'F', 'Other nonscarring hair loss', '', '', '25510101', '99999999'), ('L66', 'F', 'Cicatricial alopecia [scarring hair loss]', '', '', '25510101', '99999999'), ('L67', 'F', 'Hair colour and hair shaft abnormalities', '', '', '25510101', '99999999'), ('L68', 'F', 'Hypertrichosis', '', '', '25510101', '99999999'), ('L70', 'F', 'Acne', '', '', '25510101', '99999999'), ('L71', 'F', 'Rosacea', '', '', '25510101', '99999999'), ('L72', 'F', 'Follicular cysts of skin and subcutaneous tissue', '', '', '25510101', '99999999'), ('L73', 'F', 'Other follicular disorders', '', '', '25510101', '99999999'), ('L74', 'F', 'Eccrine sweat disorders', '', '', '25510101', '99999999'), ('L75', 'F', 'Apocrine sweat disorders', '', '', '25510101', '99999999'), ('L81', 'F', 'Other disorders of pigmentation', '', '', '25510101', '99999999'), ('L85', 'F', 'Other epidermal thickening', '', '', '25510101', '99999999'), ('L87', 'F', 'Transepidermal elimination disorders', '', '', '25510101', '99999999'), ('L90', 'F', 'Atrophic disorders of skin', '', '', '25510101', '99999999'), ('L91', 'F', 'Hypertrophic disorders of skin', '', '', '25510101', '99999999'), ('L92', 'F', 'Granulomatous disorders of skin and subcutaneous tissue', '', '', '25510101', '99999999'), ('L93', 'F', 'Lupus erythematosus', '', '', '25510101', '99999999'), ('L94', 'F', 'Other localized connective tissue disorders', '', '', '25510101', '99999999'), ('L95', 'F', 'Vasculitis limited to skin, not elsewhere classified', '', '', '25510101', '99999999'), ('L98', 'F', 'Other disorders of skin and subcutaneous tissue, not elsewhere classified', '', '', '25510101', '99999999'), ('L99', 'F', 'Other disorders of skin and subcutaneous tissue in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M00', 'F', 'Pyogenic arthritis', '', '', '25510101', '99999999'), ('M01', 'F', 'Direct infections of joint in infectious and parasitic diseases classified elsewhere', '', '', '25510101', '99999999'), ('M02', 'F', 'Reactive arthropathies', '', '', '25510101', '99999999'), ('M03', 'F', 'Postinfective and reactive arthropathies in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M05', 'F', 'Seropositive rheumatoid arthritis', '', '', '25510101', '99999999'), ('M06', 'F', 'Other rheumatoid arthritis', '', '', '25510101', '99999999'), ('M07', 'F', 'Psoriatic and enteropathic arthropathies', '', '', '25510101', '99999999'), ('M08', 'F', 'Juvenile arthritis', '', '', '25510101', '99999999'), ('M09', 'F', 'Juvenile arthritis in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M10', 'F', 'Gout', '', '', '25510101', '99999999'), ('M11', 'F', 'Other crystal arthropathies', '', '', '25510101', '99999999'), ('M12', 'F', 'Other specific arthropathies', '', '', '25510101', '99999999'), ('M13', 'F', 'Other arthritis', '', '', '25510101', '99999999'), ('M14', 'F', 'Arthropathies in other diseases classified elsewhere', '', '', '25510101', '99999999'), ('M15', 'F', 'Polyarthrosis', '', '', '25510101', '99999999'), ('M16', 'F', 'Coxarthrosis [arthrosis of hip]', '', '', '25510101', '99999999'), ('M17', 'F', 'Gonarthrosis [arthrosis of knee]', '', '', '25510101', '99999999'), ('M18', 'F', 'Arthrosis of first carpometacarpal joint', '', '', '25510101', '99999999'), ('M19', 'F', 'Other arthrosis', '', '', '25510101', '99999999'), ('M20', 'F', 'Acquired deformities of fingers and toes', '', '', '25510101', '99999999'), ('M21', 'F', 'Other acquired deformities of limbs', '', '', '25510101', '99999999'), ('M22', 'F', 'Disorders of patella', '', '', '25510101', '99999999'), ('M23', 'F', 'Internal derangement of knee', '', '', '25510101', '99999999'), ('M24', 'F', 'Other specific joint derangements', '', '', '25510101', '99999999'), ('M25', 'F', 'Other joint disorders, not elsewhere classified', '', '', '25510101', '99999999'), ('M30', 'F', 'Polyarteritis nodosa and related conditions', '', '', '25510101', '99999999'), ('M31', 'F', 'Other necrotizing vasculopathies', '', '', '25510101', '99999999'), ('M32', 'F', 'Systemic lupus erythematosus', '', '', '25510101', '99999999'), ('M33', 'F', 'Dermatopolymyositis', '', '', '25510101', '99999999'), ('M34', 'F', 'Systemic sclerosis', '', '', '25510101', '99999999'), ('M35', 'F', 'Other systemic involvement of connective tissue', '', '', '25510101', '99999999'), ('M36', 'F', 'Systemic disorders of connective tissue in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M40', 'F', 'Kyphosis and lordosis', '', '', '25510101', '99999999'), ('M41', 'F', 'Scoliosis', '', '', '25510101', '99999999'), ('M42', 'F', 'Spinal osteochondrosis', '', '', '25510101', '99999999'), ('M43', 'F', 'Other deforming dorsopathies', '', '', '25510101', '99999999'), ('M46', 'F', 'Other inflammatory spondylopathies', '', '', '25510101', '99999999'), ('M47', 'F', 'Spondylosis', '', '', '25510101', '99999999'), ('M48', 'F', 'Other spondylopathies', '', '', '25510101', '99999999'), ('M49', 'F', 'Spondylopathies in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M50', 'F', 'Cervical disc disorders', '', '', '25510101', '99999999'), ('M51', 'F', 'Other intervertebral disc disorders', '', '', '25510101', '99999999'), ('M53', 'F', 'Other dorsopathies, not elsewhere classified', '', '', '25510101', '99999999'), ('M54', 'F', 'Dorsalgia', '', '', '25510101', '99999999'), ('M60', 'F', 'Myositis', '', '', '25510101', '99999999'), ('M61', 'F', 'Calcification and ossification of muscle', '', '', '25510101', '99999999'), ('M62', 'F', 'Other disorders of muscle', '', '', '25510101', '99999999'), ('M63', 'F', 'Disorders of muscle in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M65', 'F', 'Synovitis and tenosynovitis', '', '', '25510101', '99999999'), ('M66', 'F', 'Spontaneous rupture of synovium and tendon', '', '', '25510101', '99999999'), ('M67', 'F', 'Other disorders of synovium and tendon', '', '', '25510101', '99999999'), ('M68', 'F', 'Disorders of synovium and tendon in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M70', 'F', 'Soft tissue disorders related to use, overuse and pressure', '', '', '25510101', '99999999'), ('M71', 'F', 'Other bursopathies', '', '', '25510101', '99999999'), ('M72', 'F', 'Fibroblastic disorders', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('M73', 'F', 'Soft tissue disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M75', 'F', 'Shoulder lesions', '', '', '25510101', '99999999'), ('M76', 'F', 'Enthesopathies of lower limb, excluding foot', '', '', '25510101', '99999999'), ('M77', 'F', 'Other enthesopathies', '', '', '25510101', '99999999'), ('M79', 'F', 'Other soft tissue disorders, not elsewhere classified', '', '', '25510101', '99999999'), ('M80', 'F', 'Osteoporosis with pathological fracture', '', '', '25510101', '99999999'), ('M81', 'F', 'Osteoporosis without pathological fracture', '', '', '25510101', '99999999'), ('M82', 'F', 'Osteoporosis in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M83', 'F', 'Adult osteomalacia', '', '', '25510101', '99999999'), ('M84', 'F', 'Disorders of continuity of bone', '', '', '25510101', '99999999'), ('M85', 'F', 'Other disorders of bone density and structure', '', '', '25510101', '99999999'), ('M86', 'F', 'Osteomyelitis', '', '', '25510101', '99999999'), ('M87', 'F', 'Osteonecrosis', '', '', '25510101', '99999999'), ('M88', 'F', 'Paget\'s disease of bone [osteitis deformans]', '', '', '25510101', '99999999'), ('M89', 'F', 'Other disorders of bone', '', '', '25510101', '99999999'), ('M90', 'F', 'Osteopathies in diseases classified elsewhere', '', '', '25510101', '99999999'), ('M91', 'F', 'Juvenile osteochondrosis of hip and pelvis', '', '', '25510101', '99999999'), ('M92', 'F', 'Other juvenile osteochondrosis', '', '', '25510101', '99999999'), ('M93', 'F', 'Other osteochondropathies', '', '', '25510101', '99999999'), ('M94', 'F', 'Other disorders of cartilage', '', '', '25510101', '99999999'), ('M95', 'F', 'Other acquired deformities of musculoskeletal system and connective tissue', '', '', '25510101', '99999999'), ('M96', 'F', 'Postprocedural musculoskeletal disorders, not elsewhere classified', '', '', '25510101', '99999999'), ('M99', 'F', 'Biomechanical lesions, not elsewhere classified', '', '', '25510101', '99999999'), ('N00', 'F', 'Acute nephritic syndrome', '', '', '25510101', '99999999'), ('N01', 'F', 'Rapidly progressive nephritic syndrome', '', '', '25510101', '99999999'), ('N02', 'F', 'Recurrent and persistent haematuria', '', '', '25510101', '99999999'), ('N03', 'F', 'Chronic nephritic syndrome', '', '', '25510101', '99999999'), ('N04', 'F', 'Nephrotic syndrome', '', '', '25510101', '99999999'), ('N05', 'F', 'Unspecified nephritic syndrome', '', '', '25510101', '99999999'), ('N06', 'F', 'Isolated proteinuria with specified morphological lesion', '', '', '25510101', '99999999'), ('N07', 'F', 'Hereditary nephropathy, not elsewhere classified', '', '', '25510101', '99999999'), ('N08', 'F', 'Glomerular disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('N11', 'F', 'Chronic tubulo-interstitial nephritis', '', '', '25510101', '99999999'), ('N13', 'F', 'Obstructive and reflux uropathy', '', '', '25510101', '99999999'), ('N14', 'F', 'Drug- and heavy-metal-induced tubulo-interstitial and tubular conditions', '', '', '25510101', '99999999'), ('N15', 'F', 'Other renal tubulo-interstitial diseases', '', '', '25510101', '99999999'), ('N16', 'F', 'Renal tubulo-interstitial disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('N17', 'F', 'Acute renal failure', '', '', '25510101', '99999999'), ('N18', 'F', 'Chronic renal failure', '', '', '25510101', '99999999'), ('N20', 'F', 'Calculus of kidney and ureter', '', '', '25510101', '99999999'), ('N21', 'F', 'Calculus of lower urinary tract', '', '', '25510101', '99999999'), ('N22', 'F', 'Calculus of urinary tract in diseases classified elsewhere', '', '', '25510101', '99999999'), ('N25', 'F', 'Disorders resulting from impaired renal tubular function', '', '', '25510101', '99999999'), ('N27', 'F', 'Small kidney of unknown cause', '', '', '25510101', '99999999'), ('N28', 'F', 'Other disorders of kidney and ureter, not elsewhere classified', '', '', '25510101', '99999999'), ('N29', 'F', 'Other disorders of kidney and ureter in diseases classified elsewhere', '', '', '25510101', '99999999'), ('N30', 'F', 'Cystitis', '', '', '25510101', '99999999'), ('N31', 'F', 'Neuromuscular dysfunction of bladder, not elsewhere classified', '', '', '25510101', '99999999'), ('N32', 'F', 'Other disorders of bladder', '', '', '25510101', '99999999'), ('N33', 'F', 'Bladder disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('N34', 'F', 'Urethritis and urethral syndrome', '', '', '25510101', '99999999'), ('N35', 'F', 'Urethral stricture', '', '', '25510101', '99999999'), ('N36', 'F', 'Other disorders of urethra', '', '', '25510101', '99999999'), ('N37', 'F', 'Urethral disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('N39', 'F', 'Other disorders of urinary system', '', '', '25510101', '99999999'), ('N41', 'F', 'Inflammatory diseases of prostate', '', '', '25510101', '99999999'), ('N42', 'F', 'Other disorders of prostate', '', '', '25510101', '99999999'), ('N43', 'F', 'Hydrocele and spermatocele', '', '', '25510101', '99999999'), ('N45', 'F', 'Orchitis and epididymitis', '', '', '25510101', '99999999'), ('N48', 'F', 'Other disorders of penis', '', '', '25510101', '99999999'), ('N49', 'F', 'Inflammatory disorders of male genital organs, not elsewhere classified', '', '', '25510101', '99999999'), ('N50', 'F', 'Other disorders of male genital organs', '', '', '25510101', '99999999'), ('N51', 'F', 'Disorders of male genital organs in diseases classified elsewhere', '', '', '25510101', '99999999'), ('N60', 'F', 'Benign mammary dysplasia', '', '', '25510101', '99999999'), ('N64', 'F', 'Other disorders of breast', '', '', '25510101', '99999999'), ('N70', 'F', 'Salpingitis and oophoritis', '', '', '25510101', '99999999'), ('N71', 'F', 'Inflammatory disease of uterus, except cervix', '', '', '25510101', '99999999'), ('N73', 'F', 'Other female pelvic inflammatory diseases', '', '', '25510101', '99999999'), ('N74', 'F', 'Female pelvic inflammatory disorders in diseases classified elsewhere', '', '', '25510101', '99999999'), ('N75', 'F', 'Diseases of Bartholin\'s gland', '', '', '25510101', '99999999'), ('N76', 'F', 'Other inflammation of vagina and vulva', '', '', '25510101', '99999999'), ('N77', 'F', 'Vulvovaginal ulceration and inflammation in diseases classified elsewhere', '', '', '25510101', '99999999'), ('N80', 'F', 'Endometriosis', '', '', '25510101', '99999999'), ('N81', 'F', 'Female genital prolapse', '', '', '25510101', '99999999'), ('N82', 'F', 'Fistulae involving female genital tract', '', '', '25510101', '99999999'), ('N83', 'F', 'Noninflammatory disorders of ovary, fallopian tube and broad ligament', '', '', '25510101', '99999999'), ('N84', 'F', 'Polyp of female genital tract', '', '', '25510101', '99999999'), ('N85', 'F', 'Other noninflammatory disorders of uterus, except cervix', '', '', '25510101', '99999999'), ('N87', 'F', 'Dysplasia of cervix uteri', '', '', '25510101', '99999999'), ('N88', 'F', 'Other noninflammatory disorders of cervix uteri', '', '', '25510101', '99999999'), ('N89', 'F', 'Other noninflammatory disorders of vagina', '', '', '25510101', '99999999'), ('N90', 'F', 'Other noninflammatory disorders of vulva and perineum', '', '', '25510101', '99999999'), ('N91', 'F', 'Absent, scanty and rare menstruation', '', '', '25510101', '99999999'), ('N92', 'F', 'Excessive, frequent and irregular menstruation', '', '', '25510101', '99999999'), ('N93', 'F', 'Other abnormal uterine and vaginal bleeding', '', '', '25510101', '99999999'), ('N94', 'F', 'Pain and other conditions associated with female genital organs and menstrual cycle', '', '', '25510101', '99999999'), ('N95', 'F', 'Menopausal and other perimenopausal disorders', '', '', '25510101', '99999999'), ('N97', 'F', 'Female infertility', '', '', '25510101', '99999999'), ('N98', 'F', 'Complications associated with artificial fertilization', '', '', '25510101', '99999999'), ('N99', 'F', 'Postprocedural disorders of the genitourinary system, not elsewhere classified', '', '', '25510101', '99999999'), ('O00', 'F', 'Ectopic pregnancy', '', '', '25510101', '99999999'), ('O01', 'F', 'Hydatidiform mole', '', '', '25510101', '99999999'), ('O02', 'F', 'Other abnormal products of conception', '', '', '25510101', '99999999'), ('O03', 'F', 'Spontaneous abortion', '', '', '25510101', '99999999'), ('O04', 'F', 'Medical abortion', '', '', '25510101', '99999999'), ('O05', 'F', 'Other abortion', '', '', '25510101', '99999999'), ('O06', 'F', 'Unspecified abortion', '', '', '25510101', '99999999'), ('O07', 'F', 'Failed attempted abortion', '', '', '25510101', '99999999'), ('O08', 'F', 'Complications following abortion and ectopic and molar pregnancy', '', '', '25510101', '99999999'), ('O10', 'F', 'Pre-existing hypertension complicating pregnancy, childbirth and the puerperium', '', '', '25510101', '99999999'), ('O12', 'F', 'Gestational [pregnancy-induced] oedema and proteinuria without hypertension', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('O14', 'F', 'Gestational [pregnancy-induced] hypertension with significant proteinuria', '', '', '25510101', '99999999'), ('O15', 'F', 'Eclampsia', '', '', '25510101', '99999999'), ('O20', 'F', 'Haemorrhage in early pregnancy', '', '', '25510101', '99999999'), ('O21', 'F', 'Excessive vomiting in pregnancy', '', '', '25510101', '99999999'), ('O22', 'F', 'Venous complications in pregnancy', '', '', '25510101', '99999999'), ('O23', 'F', 'Infections of genitourinary tract in pregnancy', '', '', '25510101', '99999999'), ('O24', 'F', 'Diabetes mellitus in pregnancy', '', '', '25510101', '99999999'), ('O26', 'F', 'Maternal care for other conditions predominantly related to pregnancy', '', '', '25510101', '99999999'), ('O28', 'F', 'Abnormal findings on antenatal screening of mother', '', '', '25510101', '99999999'), ('O29', 'F', 'Complications of anaesthesia during pregnancy', '', '', '25510101', '99999999'), ('O30', 'F', 'Multiple gestation', '', '', '25510101', '99999999'), ('O31', 'F', 'Complications specific to multiple gestation', '', '', '25510101', '99999999'), ('O32', 'F', 'Maternal care for known or suspected malpresentation of fetus', '', '', '25510101', '99999999'), ('O33', 'F', 'Maternal care for known or suspected disproportion', '', '', '25510101', '99999999'), ('O34', 'F', 'Maternal care for known or suspected abnormality of pelvic organs', '', '', '25510101', '99999999'), ('O35', 'F', 'Maternal care for known or suspected fetal abnormality and damage', '', '', '25510101', '99999999'), ('O36', 'F', 'Maternal care for other known or suspected fetal problems', '', '', '25510101', '99999999'), ('O41', 'F', 'Other disorders of amniotic fluid and membranes', '', '', '25510101', '99999999'), ('O42', 'F', 'Premature rupture of membranes', '', '', '25510101', '99999999'), ('O43', 'F', 'Placental disorders', '', '', '25510101', '99999999'), ('O44', 'F', 'Placenta praevia', '', '', '25510101', '99999999'), ('O45', 'F', 'Premature separation of placenta [abruptio placentae]', '', '', '25510101', '99999999'), ('O46', 'F', 'Antepartum haemorrhage, not elsewhere classified', '', '', '25510101', '99999999'), ('O47', 'F', 'False labour', '', '', '25510101', '99999999'), ('O60', 'F', 'Preterm labour', '', '', '25510101', '99999999'), ('O61', 'F', 'Failed induction of labour', '', '', '25510101', '99999999'), ('O62', 'F', 'Abnormalities of forces of labour', '', '', '25510101', '99999999'), ('O63', 'F', 'Long labour', '', '', '25510101', '99999999'), ('O64', 'F', 'Obstructed labour due to malposition and malpresentation of fetus', '', '', '25510101', '99999999'), ('O65', 'F', 'Obstructed labour due to maternal pelvic abnormality', '', '', '25510101', '99999999'), ('O66', 'F', 'Other obstructed labour', '', '', '25510101', '99999999'), ('O67', 'F', 'Labour and delivery complicated by intrapartum haemorrhage, not elsewhere classified', '', '', '25510101', '99999999'), ('O68', 'F', 'Labour and delivery complicated by fetal stress [distress]', '', '', '25510101', '99999999'), ('O69', 'F', 'Labour and delivery complicated by umbilical cord complications', '', '', '25510101', '99999999'), ('O70', 'F', 'Perineal laceration during delivery', '', '', '25510101', '99999999'), ('O71', 'F', 'Other obstetric trauma', '', '', '25510101', '99999999'), ('O72', 'F', 'Postpartum haemorrhage', '', '', '25510101', '99999999'), ('O73', 'F', 'Retained placenta and membranes, without haemorrhage', '', '', '25510101', '99999999'), ('O74', 'F', 'Complications of anaesthesia during labour and delivery', '', '', '25510101', '99999999'), ('O75', 'F', 'Other complications of labour and delivery, not elsewhere classified', '', '', '25510101', '99999999'), ('O80', 'F', 'Single spontaneous delivery', '', '', '25510101', '99999999'), ('O81', 'F', 'Single delivery by forceps and vacuum extractor', '', '', '25510101', '99999999'), ('O82', 'F', 'Single delivery by caesarean section', '', '', '25510101', '99999999'), ('O83', 'F', 'Other assisted single delivery', '', '', '25510101', '99999999'), ('O84', 'F', 'Multiple delivery', '', '', '25510101', '99999999'), ('O86', 'F', 'Other puerperal infections', '', '', '25510101', '99999999'), ('O87', 'F', 'Venous complications in the puerperium', '', '', '25510101', '99999999'), ('O88', 'F', 'Obstetric embolism', '', '', '25510101', '99999999'), ('O89', 'F', 'Complications of anaesthesia during the puerperium', '', '', '25510101', '99999999'), ('O90', 'F', 'Complications of the puerperium, not elsewhere classified', '', '', '25510101', '99999999'), ('O91', 'F', 'Infections of breast associated with childbirth', '', '', '25510101', '99999999'), ('O92', 'F', 'Other disorders of breast and lactation associated with childbirth', '', '', '25510101', '99999999'), ('O98', 'F', 'Maternal infectious and parasitic diseases classifiable elsewhere but complicating pregnancy, childbirth and the puerperium', '', '', '25510101', '99999999'), ('O99', 'F', 'Other maternal diseases classifiable elsewhere but complicating pregnancy, childbirth and the puerperium', '', '', '25510101', '99999999'), ('P00', 'F', 'Fetus and newborn affected by maternal conditions that may be unrelated to present pregnancy', '', '', '25510101', '99999999'), ('P01', 'F', 'Fetus and newborn affected by maternal complications of pregnancy', '', '', '25510101', '99999999'), ('P02', 'F', 'Fetus and newborn affected by complications of placenta, cord and membranes', '', '', '25510101', '99999999'), ('P03', 'F', 'Fetus and newborn affected by other complications of labour and delivery', '', '', '25510101', '99999999'), ('P04', 'F', 'Fetus and newborn affected by noxious influences transmitted via placenta or breast milk', '', '', '25510101', '99999999'), ('P05', 'F', 'Slow fetal growth and fetal malnutrition', '', '', '25510101', '99999999'), ('P07', 'F', 'Disorders related to short gestation and low birth weight, not elsewhere classified', '', '', '25510101', '99999999'), ('P08', 'F', 'Disorders related to long gestation and high birth weight', '', '', '25510101', '99999999'), ('P10', 'F', 'Intracranial laceration and haemorrhage due to birth injury', '', '', '25510101', '99999999'), ('P11', 'F', 'Other birth injuries to central nervous system', '', '', '25510101', '99999999'), ('P12', 'F', 'Birth injury to scalp', '', '', '25510101', '99999999'), ('P13', 'F', 'Birth injury to skeleton', '', '', '25510101', '99999999'), ('P14', 'F', 'Birth injury to peripheral nervous system', '', '', '25510101', '99999999'), ('P15', 'F', 'Other birth injuries', '', '', '25510101', '99999999'), ('P20', 'F', 'Intrauterine hypoxia', '', '', '25510101', '99999999'), ('P21', 'F', 'Birth asphyxia', '', '', '25510101', '99999999'), ('P22', 'F', 'Respiratory distress of newborn', '', '', '25510101', '99999999'), ('P23', 'F', 'Congenital pneumonia', '', '', '25510101', '99999999'), ('P24', 'F', 'Neonatal aspiration syndromes', '', '', '25510101', '99999999'), ('P25', 'F', 'Interstitial emphysema and related conditions originating in the perinatal period', '', '', '25510101', '99999999'), ('P26', 'F', 'Pulmonary haemorrhage originating in the perinatal period', '', '', '25510101', '99999999'), ('P27', 'F', 'Chronic respiratory disease originating in the perinatal period', '', '', '25510101', '99999999'), ('P28', 'F', 'Other respiratory conditions originating in the perinatal period', '', '', '25510101', '99999999'), ('P29', 'F', 'Cardiovascular disorders originating in the perinatal period', '', '', '25510101', '99999999'), ('P35', 'F', 'Congenital viral diseases', '', '', '25510101', '99999999'), ('P36', 'F', 'Bacterial sepsis of newborn', '', '', '25510101', '99999999'), ('P37', 'F', 'Other congenital infectious and parasitic diseases', '', '', '25510101', '99999999'), ('P39', 'F', 'Other infections specific to the perinatal period', '', '', '25510101', '99999999'), ('P50', 'F', 'Fetal blood loss', '', '', '25510101', '99999999'), ('P51', 'F', 'Umbilical haemorrhage of newborn', '', '', '25510101', '99999999'), ('P52', 'F', 'Intracranial nontraumatic haemorrhage of fetus and newborn', '', '', '25510101', '99999999'), ('P54', 'F', 'Other neonatal haemorrhages', '', '', '25510101', '99999999'), ('P55', 'F', 'Haemolytic disease of fetus and newborn', '', '', '25510101', '99999999'), ('P56', 'F', 'Hydrops fetalis due to haemolytic disease', '', '', '25510101', '99999999'), ('P57', 'F', 'Kernicterus', '', '', '25510101', '99999999'), ('P58', 'F', 'Neonatal jaundice due to other excessive haemolysis', '', '', '25510101', '99999999'), ('P59', 'F', 'Neonatal jaundice from other and unspecified causes', '', '', '25510101', '99999999'), ('P61', 'F', 'Other perinatal haematological disorders', '', '', '25510101', '99999999'), ('P70', 'F', 'Transitory disorders of carbohydrate metabolism specific to fetus and newborn', '', '', '25510101', '99999999'), ('P71', 'F', 'Transitory neonatal disorders of calcium and magnesium metabolism', '', '', '25510101', '99999999'), ('P72', 'F', 'Other transitory neonatal endocrine disorders', '', '', '25510101', '99999999'), ('P74', 'F', 'Other transitory neonatal electrolyte and metabolic disturbances', '', '', '25510101', '99999999'), ('P76', 'F', 'Other intestinal obstruction of newborn', '', '', '25510101', '99999999'), ('P78', 'F', 'Other perinatal digestive system disorders', '', '', '25510101', '99999999'), ('P80', 'F', 'Hypothermia of newborn', '', '', '25510101', '99999999'), ('P81', 'F', 'Other disturbances of temperature regulation of newborn', '', '', '25510101', '99999999'), ('P83', 'F', 'Other conditions of integument specific to fetus and newborn', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('P91', 'F', 'Other disturbances of cerebral status of newborn', '', '', '25510101', '99999999'), ('P92', 'F', 'Feeding problems of newborn', '', '', '25510101', '99999999'), ('P94', 'F', 'Disorders of muscle tone of newborn', '', '', '25510101', '99999999'), ('P96', 'F', 'Other conditions originating in the perinatal period', '', '', '25510101', '99999999'), ('Q00', 'F', 'Anencephaly and similar malformations', '', '', '25510101', '99999999'), ('Q01', 'F', 'Encephalocele', '', '', '25510101', '99999999'), ('Q03', 'F', 'Congenital hydrocephalus', '', '', '25510101', '99999999'), ('Q04', 'F', 'Other congenital malformations of brain', '', '', '25510101', '99999999'), ('Q05', 'F', 'Spina bifida', '', '', '25510101', '99999999'), ('Q06', 'F', 'Other congenital malformations of spinal cord', '', '', '25510101', '99999999'), ('Q07', 'F', 'Other congenital malformations of nervous system', '', '', '25510101', '99999999'), ('Q10', 'F', 'Congenital malformations of eyelid, lacrimal apparatus and orbit', '', '', '25510101', '99999999'), ('Q11', 'F', 'Anophthalmos, microphthalmos and macrophthalmos', '', '', '25510101', '99999999'), ('Q12', 'F', 'Congenital lens malformations', '', '', '25510101', '99999999'), ('Q13', 'F', 'Congenital malformations of anterior segment of eye', '', '', '25510101', '99999999'), ('Q14', 'F', 'Congenital malformations of posterior segment of eye', '', '', '25510101', '99999999'), ('Q15', 'F', 'Other congenital malformations of eye', '', '', '25510101', '99999999'), ('Q16', 'F', 'Congenital malformations of ear causing impairment of hearing', '', '', '25510101', '99999999'), ('Q17', 'F', 'Other congenital malformations of ear', '', '', '25510101', '99999999'), ('Q18', 'F', 'Other congenital malformations of face and neck', '', '', '25510101', '99999999'), ('Q20', 'F', 'Congenital malformations of cardiac chambers and connections', '', '', '25510101', '99999999'), ('Q21', 'F', 'Congenital malformations of cardiac septa', '', '', '25510101', '99999999'), ('Q22', 'F', 'Congenital malformations of pulmonary and tricuspid valves', '', '', '25510101', '99999999'), ('Q23', 'F', 'Congenital malformations of aortic and mitral valves', '', '', '25510101', '99999999'), ('Q24', 'F', 'Other congenital malformations of the heart', '', '', '25510101', '99999999'), ('Q25', 'F', 'Congenital malformations of great arteries', '', '', '25510101', '99999999'), ('Q26', 'F', 'Congenital malformations of great veins', '', '', '25510101', '99999999'), ('Q27', 'F', 'Other congenital malformations of peripheral vascular system', '', '', '25510101', '99999999'), ('Q28', 'F', 'Other congenital malformations of circulatory system', '', '', '25510101', '99999999'), ('Q30', 'F', 'Congenital malformations of nose', '', '', '25510101', '99999999'), ('Q31', 'F', 'Congenital malformations of larynx', '', '', '25510101', '99999999'), ('Q32', 'F', 'Congenital malformations of trachea and bronchus', '', '', '25510101', '99999999'), ('Q33', 'F', 'Congenital malformations of lung', '', '', '25510101', '99999999'), ('Q34', 'F', 'Other congenital malformations of respiratory system', '', '', '25510101', '99999999'), ('Q35', 'F', 'Cleft palate', '', '', '25510101', '99999999'), ('Q36', 'F', 'Cleft lip', '', '', '25510101', '99999999'), ('Q37', 'F', 'Cleft palate with cleft lip', '', '', '25510101', '99999999'), ('Q38', 'F', 'Other congenital malformations of tongue, mouth and pharynx', '', '', '25510101', '99999999'), ('Q39', 'F', 'Congenital malformations of oesophagus', '', '', '25510101', '99999999'), ('Q40', 'F', 'Other congenital malformations of upper alimentary tract', '', '', '25510101', '99999999'), ('Q41', 'F', 'Congenital absence, atresia and stenosis of small intestine', '', '', '25510101', '99999999'), ('Q42', 'F', 'Congenital absence, atresia and stenosis of large intestine', '', '', '25510101', '99999999'), ('Q43', 'F', 'Other congenital malformations of intestine', '', '', '25510101', '99999999'), ('Q44', 'F', 'Congenital malformations of gallbladder, bile ducts and liver', '', '', '25510101', '99999999'), ('Q45', 'F', 'Other congenital malformations of digestive system', '', '', '25510101', '99999999'), ('Q50', 'F', 'Congenital malformations of ovaries, fallopian tubes and broad ligaments', '', '', '25510101', '99999999'), ('Q51', 'F', 'Congenital malformations of uterus and cervix', '', '', '25510101', '99999999'), ('Q52', 'F', 'Other congenital malformations of female genitalia', '', '', '25510101', '99999999'), ('Q53', 'F', 'Undescended testicle', '', '', '25510101', '99999999'), ('Q54', 'F', 'Hypospadias', '', '', '25510101', '99999999'), ('Q55', 'F', 'Other congenital malformations of male genital organs', '', '', '25510101', '99999999'), ('Q56', 'F', 'Indeterminate sex and pseudohermaphroditism', '', '', '25510101', '99999999'), ('Q60', 'F', 'Renal agenesis and other reduction defects of kidney', '', '', '25510101', '99999999'), ('Q61', 'F', 'Cystic kidney disease', '', '', '25510101', '99999999'), ('Q62', 'F', 'Congenital obstructive defects of renal pelvis and congenital malformations of urete', '', '', '25510101', '99999999'), ('Q63', 'F', 'Other congenital malformations of kidney', '', '', '25510101', '99999999'), ('Q64', 'F', 'Other congenital malformations of urinary system', '', '', '25510101', '99999999'), ('Q65', 'F', 'Congenital deformities of hip', '', '', '25510101', '99999999'), ('Q66', 'F', 'Congenital deformities of feet', '', '', '25510101', '99999999'), ('Q67', 'F', 'Congenital musculoskeletal deformities of head, face, spine and chest', '', '', '25510101', '99999999'), ('Q68', 'F', 'Other congenital musculoskeletal deformities', '', '', '25510101', '99999999'), ('Q69', 'F', 'Polydactyly', '', '', '25510101', '99999999'), ('Q70', 'F', 'Syndactyly', '', '', '25510101', '99999999'), ('Q71', 'F', 'Reduction defects of upper limb', '', '', '25510101', '99999999'), ('Q72', 'F', 'Reduction defects of lower limb', '', '', '25510101', '99999999'), ('Q73', 'F', 'Reduction defects of unspecified limb', '', '', '25510101', '99999999'), ('Q74', 'F', 'Other congenital malformations of limb(s)', '', '', '25510101', '99999999'), ('Q75', 'F', 'Other congenital malformations of skull and face bones', '', '', '25510101', '99999999'), ('Q76', 'F', 'Congenital malformations of spine and bony thorax', '', '', '25510101', '99999999'), ('Q77', 'F', 'Osteochondrodysplasia with defects of growth of tubular bones and spine', '', '', '25510101', '99999999'), ('Q78', 'F', 'Other osteochondrodysplasias', '', '', '25510101', '99999999'), ('Q79', 'F', 'Congenital malformations of the musculoskeletal system, not elsewhere classified', '', '', '25510101', '99999999'), ('Q80', 'F', 'Congenital ichthyosis', '', '', '25510101', '99999999'), ('Q81', 'F', 'Epidermolysis bullosa', '', '', '25510101', '99999999'), ('Q82', 'F', 'Other congenital malformations of skin', '', '', '25510101', '99999999'), ('Q83', 'F', 'Congenital malformations of breast', '', '', '25510101', '99999999'), ('Q84', 'F', 'Other congenital malformations of integument', '', '', '25510101', '99999999'), ('Q85', 'F', 'Phakomatoses, not elsewhere classified', '', '', '25510101', '99999999'), ('Q86', 'F', 'Congenital malformation syndromes due to known exogenous causes, not elsewhere classified', '', '', '25510101', '99999999'), ('Q87', 'F', 'Other specified congenital malformation syndromes affecting multiple systems', '', '', '25510101', '99999999'), ('Q89', 'F', 'Other congenital malformations, not elsewhere classified', '', '', '25510101', '99999999'), ('Q90', 'F', 'Down\'s syndrome', '', '', '25510101', '99999999'), ('Q91', 'F', 'Edwards\' syndrome and Patau\'s syndrome', '', '', '25510101', '99999999'), ('Q92', 'F', 'Other trisomies and partial trisomies of the autosomes, not elsewhere classified', '', '', '25510101', '99999999'), ('Q93', 'F', 'Monosomies and deletions from the autosomes, not elsewhere classified', '', '', '25510101', '99999999'), ('Q95', 'F', 'Balanced rearrangements and structural markers, not elsewhere classified', '', '', '25510101', '99999999'), ('Q96', 'F', 'Turner\'s syndrome', '', '', '25510101', '99999999'), ('Q97', 'F', 'Other sex chromosome abnormalities, female phenotype, not elsewhere classified', '', '', '25510101', '99999999'), ('Q98', 'F', 'Other sex chromosome abnormalities, male phenotype, not elsewhere classified', '', '', '25510101', '99999999'), ('Q99', 'F', 'Other chromosome abnormalities, not elsewhere classified', '', '', '25510101', '99999999'), ('R00', 'F', 'Abnormalities of heart beat', '', '', '25510101', '99999999'), ('R01', 'F', 'Cardiac murmurs and other cardiac sounds', '', '', '25510101', '99999999'), ('R03', 'F', 'Abnormal blood-pressure reading, without diagnosis', '', '', '25510101', '99999999'), ('R04', 'F', 'Haemorrhage from respiratory passages', '', '', '25510101', '99999999'), ('R06', 'F', 'Abnormalities of breathing', '', '', '25510101', '99999999'), ('R07', 'F', 'Pain in throat and chest', '', '', '25510101', '99999999'), ('R09', 'F', 'Other symptoms and signs involving the circulatory and respiratory systems', '', '', '25510101', '99999999'), ('R10', 'F', 'Abdominal and pelvic pain', '', '', '25510101', '99999999'), ('R16', 'F', 'Hepatomegaly and splenomegaly, not elsewhere classified', '', '', '25510101', '99999999'), ('R19', 'F', 'Other symptoms and signs involving the digestive system and abdomen', '', '', '25510101', '99999999'), ('R20', 'F', 'Disturbances of skin sensation', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('R22', 'F', 'Localized swelling, mass and lump of skin and subcutaneous tissue', '', '', '25510101', '99999999'), ('R23', 'F', 'Other skin changes', '', '', '25510101', '99999999'), ('R25', 'F', 'Abnormal involuntary movements', '', '', '25510101', '99999999'), ('R26', 'F', 'Abnormalities of gait and mobility', '', '', '25510101', '99999999'), ('R27', 'F', 'Other lack of coordination', '', '', '25510101', '99999999'), ('R29', 'F', 'Other symptoms and signs involving the nervous and musculoskeletal systems', '', '', '25510101', '99999999'), ('R30', 'F', 'Pain associated with micturition', '', '', '25510101', '99999999'), ('R39', 'F', 'Other symptoms and signs involving the urinary system', '', '', '25510101', '99999999'), ('R40', 'F', 'Somnolence, stupor and coma', '', '', '25510101', '99999999'), ('R41', 'F', 'Other symptoms and signs involving cognitive functions and awareness', '', '', '25510101', '99999999'), ('R43', 'F', 'Disturbances of smell and taste', '', '', '25510101', '99999999'), ('R44', 'F', 'Other symptoms and signs involving general sensations and perceptions', '', '', '25510101', '99999999'), ('R45', 'F', 'Symptoms and signs involving emotional state', '', '', '25510101', '99999999'), ('R46', 'F', 'Symptoms and signs involving appearance and behaviour', '', '', '25510101', '99999999'), ('R47', 'F', 'Speech disturbances, not elsewhere classified', '', '', '25510101', '99999999'), ('R48', 'F', 'Dyslexia and other symbolic dysfunctions, not elsewhere classified', '', '', '25510101', '99999999'), ('R49', 'F', 'Voice disturbances', '', '', '25510101', '99999999'), ('R50', 'F', 'Fever of unknown origin', '', '', '25510101', '99999999'), ('R500', 'F', 'Fever with chills', '', '', '25510101', '99999999'), ('R501', 'F', 'Persistent fever', '', '', '25510101', '99999999'), ('R52', 'F', 'Pain, not elsewhere classified', '', '', '25510101', '99999999'), ('R56', 'F', 'Convulsions, not elsewhere classified', '', '', '25510101', '99999999'), ('R57', 'F', 'Shock, not elsewhere classified', '', '', '25510101', '99999999'), ('R59', 'F', 'Enlarged lymph nodes', '', '', '25510101', '99999999'), ('R60', 'F', 'Oedema, not elsewhere classified', '', '', '25510101', '99999999'), ('R61', 'F', 'Hyperhidrosis', '', '', '25510101', '99999999'), ('R62', 'F', 'Lack of expected normal physiological development', '', '', '25510101', '99999999'), ('R63', 'F', 'Symptoms and signs concerning food and fluid intake', '', '', '25510101', '99999999'), ('R68', 'F', 'Other general symptoms and signs', '', '', '25510101', '99999999'), ('R70', 'F', 'Elevated erythrocyte sedimentation rate and abnormality of plasma viscosity', '', '', '25510101', '99999999'), ('R73', 'F', 'Elevated blood glucose level', '', '', '25510101', '99999999'), ('R74', 'F', 'Abnormal serum enzyme levels', '', '', '25510101', '99999999'), ('R76', 'F', 'Other abnormal immunological findings in serum', '', '', '25510101', '99999999'), ('R77', 'F', 'Other abnormalities of plasma proteins', '', '', '25510101', '99999999'), ('R78', 'F', 'Findings of drugs and other substances, not normally found in blood', '', '', '25510101', '99999999'), ('R79', 'F', 'Other abnormal findings of blood chemistry', '', '', '25510101', '99999999'), ('R82', 'F', 'Other abnormal findings in urine', '', '', '25510101', '99999999'), ('R83', 'F', 'Abnormal findings in cerebrospinal fluid', '', '', '25510101', '99999999'), ('R84', 'F', 'Abnormal findings in specimens from respiratory organs and thorax', '', '', '25510101', '99999999'), ('R85', 'F', 'Abnormal findings in specimens from digestive organs and abdominal cavity', '', '', '25510101', '99999999'), ('R86', 'F', 'Abnormal findings in specimens from male genital organs', '', '', '25510101', '99999999'), ('R87', 'F', 'Abnormal finding in specimen from female genital organ', '', '', '25510101', '99999999'), ('R89', 'F', 'Abnormal findings in specimens from other organs, systems and tissues', '', '', '25510101', '99999999'), ('R90', 'F', 'Abnormal findings on diagnostic imaging of central nervous system', '', '', '25510101', '99999999'), ('R93', 'F', 'Abnormal findings on diagnostic imaging of other body structures', '', '', '25510101', '99999999'), ('R94', 'F', 'Abnormal results of function studies', '', '', '25510101', '99999999'), ('R96', 'F', 'Other sudden death, cause unknown', '', '', '25510101', '99999999'), ('S00', 'F', 'Superficial injury of head', '', '', '25510101', '99999999'), ('S01', 'F', 'Open wound of head', '', '', '25510101', '99999999'), ('S02', 'F', 'Fracture of skull and facial bones', '', '', '25510101', '99999999'), ('S03', 'F', 'Dislocation, sprain and strain of joints and ligaments of head', '', '', '25510101', '99999999'), ('S04', 'F', 'Injury of cranial nerves', '', '', '25510101', '99999999'), ('S05', 'F', 'Injury of eye and orbit', '', '', '25510101', '99999999'), ('S06', 'F', 'Intracranial injury', '', '', '25510101', '99999999'), ('S07', 'F', 'Crushing injury of head', '', '', '25510101', '99999999'), ('S08', 'F', 'Traumatic amputation of part of head', '', '', '25510101', '99999999'), ('S09', 'F', 'Other and unspecified injuries of head', '', '', '25510101', '99999999'), ('S10', 'F', 'Superficial injury of neck', '', '', '25510101', '99999999'), ('S11', 'F', 'Open wound of neck', '', '', '25510101', '99999999'), ('S12', 'F', 'Fracture of neck', '', '', '25510101', '99999999'), ('S13', 'F', 'Dislocation, sprain and strain of joints and ligaments at neck level', '', '', '25510101', '99999999'), ('S14', 'F', 'Injury of nerves and spinal cord at neck level', '', '', '25510101', '99999999'), ('S15', 'F', 'Injury of blood vessels at neck level', '', '', '25510101', '99999999'), ('S17', 'F', 'Crushing injury of neck', '', '', '25510101', '99999999'), ('S19', 'F', 'Other and unspecified injuries of neck', '', '', '25510101', '99999999'), ('S20', 'F', 'Superficial injury of thorax', '', '', '25510101', '99999999'), ('S21', 'F', 'Open wound of thorax', '', '', '25510101', '99999999'), ('S22', 'F', 'Fracture of rib(s), sternum and thoracic spine', '', '', '25510101', '99999999'), ('S23', 'F', 'Dislocation, sprain and strain of joints and ligaments of thorax', '', '', '25510101', '99999999'), ('S24', 'F', 'Injury of nerves and spinal cord at thorax level', '', '', '25510101', '99999999'), ('S25', 'F', 'Injury of blood vessels of thorax', '', '', '25510101', '99999999'), ('S26', 'F', 'Injury of heart', '', '', '25510101', '99999999'), ('S27', 'F', 'Injury of other and unspecified intrathoracic organs', '', '', '25510101', '99999999'), ('S28', 'F', 'Crushing injury of thorax and traumatic amputation of part of thorax', '', '', '25510101', '99999999'), ('S29', 'F', 'Other and unspecified injuries of thorax', '', '', '25510101', '99999999'), ('S30', 'F', 'Superficial injury of abdomen, lower back and pelvis', '', '', '25510101', '99999999'), ('S31', 'F', 'Open wound of abdomen, lower back and pelvis', '', '', '25510101', '99999999'), ('S32', 'F', 'Fracture of lumbar spine and pelvis', '', '', '25510101', '99999999'), ('S33', 'F', 'Dislocation, sprain and strain of joints and ligaments of lumbar spine and pelvis', '', '', '25510101', '99999999'), ('S34', 'F', 'Injury of nerves and lumbar spinal cord at abdomen, lower back and pelvis level', '', '', '25510101', '99999999'), ('S35', 'F', 'Injury of blood vessels at abdomen, lower back and pelvis level', '', '', '25510101', '99999999'), ('S36', 'F', 'Injury of intra-abdominal organs', '', '', '25510101', '99999999'), ('S37', 'F', 'Injury of pelvic organs', '', '', '25510101', '99999999'), ('S38', 'F', 'Crushing injury and traumatic amputation of part of abdomen, lower back and pelvis', '', '', '25510101', '99999999'), ('S39', 'F', 'Other and unspecified injuries of abdomen, lower back and pelvis', '', '', '25510101', '99999999'), ('S40', 'F', 'Superficial injury of shoulder and upper arm', '', '', '25510101', '99999999'), ('S41', 'F', 'Open wound of shoulder and upper arm', '', '', '25510101', '99999999'), ('S42', 'F', 'Fracture of shoulder and upper arm', '', '', '25510101', '99999999'), ('S43', 'F', 'Dislocation, sprain and strain of joints and ligaments of shoulder girdle', '', '', '25510101', '99999999'), ('S44', 'F', 'Injury of nerves at shoulder and upper arm level', '', '', '25510101', '99999999'), ('S45', 'F', 'Injury of blood vessels at shoulder and upper arm level', '', '', '25510101', '99999999'), ('S46', 'F', 'Injury of muscle and tendon at shoulder and upper arm level', '', '', '25510101', '99999999'), ('S48', 'F', 'Traumatic amputation of shoulder and upper arm', '', '', '25510101', '99999999'), ('S49', 'F', 'Other and unspecified injuries of shoulder and upper arm', '', '', '25510101', '99999999'), ('S50', 'F', 'Superficial injury of forearm', '', '', '25510101', '99999999'), ('S51', 'F', 'Open wound of forearm', '', '', '25510101', '99999999'), ('S52', 'F', 'Fracture of forearm', '', '', '25510101', '99999999'), ('S53', 'F', 'Dislocation, sprain and strain of joints and ligaments of elbow', '', '', '25510101', '99999999'), ('S54', 'F', 'Injury of nerves at forearm level', '', '', '25510101', '99999999'), ('S55', 'F', 'Injury of blood vessels at forearm level', '', '', '25510101', '99999999'), ('S56', 'F', 'Injury of muscle and tendon at forearm level', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('S57', 'F', 'Crushing injury of forearm', '', '', '25510101', '99999999'), ('S58', 'F', 'Traumatic amputation of forearm', '', '', '25510101', '99999999'), ('S59', 'F', 'Other and unspecified injuries of forearm', '', '', '25510101', '99999999'), ('S60', 'F', 'Superficial injury of wrist and hand', '', '', '25510101', '99999999'), ('S61', 'F', 'Open wound of wrist and hand', '', '', '25510101', '99999999'), ('S62', 'F', 'Fracture at wrist and hand level', '', '', '25510101', '99999999'), ('S63', 'F', 'Dislocation, sprain and strain of joints and ligaments at wrist and hand level', '', '', '25510101', '99999999'), ('S64', 'F', 'Injury of nerves at wrist and hand level', '', '', '25510101', '99999999'), ('S65', 'F', 'Injury of blood vessels at wrist and hand level', '', '', '25510101', '99999999'), ('S66', 'F', 'Injury of muscle and tendon at wrist and hand level', '', '', '25510101', '99999999'), ('S67', 'F', 'Crushing injury of wrist and hand', '', '', '25510101', '99999999'), ('S68', 'F', 'Traumatic amputation at wrist and hand', '', '', '25510101', '99999999'), ('S69', 'F', 'Other and unspecified injuries of wrist and hand', '', '', '25510101', '99999999'), ('S70', 'F', 'Superficial injury of hip and thigh', '', '', '25510101', '99999999'), ('S71', 'F', 'Open wound of hip and thigh', '', '', '25510101', '99999999'), ('S72', 'F', 'Fracture of femur', '', '', '25510101', '99999999'), ('S73', 'F', 'Dislocation, sprain and strain of joint and ligaments of hip', '', '', '25510101', '99999999'), ('S74', 'F', 'Injury of nerves at hip and thigh level', '', '', '25510101', '99999999'), ('S75', 'F', 'Injury of blood vessels at hip and thigh level', '', '', '25510101', '99999999'), ('S76', 'F', 'Injury of muscle and tendon at hip and thigh level', '', '', '25510101', '99999999'), ('S77', 'F', 'Crushing injury of hip and thigh', '', '', '25510101', '99999999'), ('S78', 'F', 'Traumatic amputation of hip and thigh', '', '', '25510101', '99999999'), ('S79', 'F', 'Other and unspecified injuries of hip and thigh', '', '', '25510101', '99999999'), ('S80', 'F', 'Superficial injury of lower leg', '', '', '25510101', '99999999'), ('S81', 'F', 'Open wound of lower leg', '', '', '25510101', '99999999'), ('S82', 'F', 'Fracture of lower leg, including ankle', '', '', '25510101', '99999999'), ('S83', 'F', 'Dislocation, sprain and strain of joints and ligaments of knee', '', '', '25510101', '99999999'), ('S84', 'F', 'Injury of nerves at lower leg level', '', '', '25510101', '99999999'), ('S85', 'F', 'Injury of blood vessels at lower leg level', '', '', '25510101', '99999999'), ('S86', 'F', 'Injury of muscle and tendon at lower leg level', '', '', '25510101', '99999999'), ('S87', 'F', 'Crushing injury of lower leg', '', '', '25510101', '99999999'), ('S88', 'F', 'Traumatic amputation of lower leg', '', '', '25510101', '99999999'), ('S89', 'F', 'Other and unspecified injuries of lower leg', '', '', '25510101', '99999999'), ('S90', 'F', 'Superficial injury of ankle and foot', '', '', '25510101', '99999999'), ('S91', 'F', 'Open wound of ankle and foot', '', '', '25510101', '99999999'), ('S92', 'F', 'Fracture of foot, except ankle', '', '', '25510101', '99999999'), ('S93', 'F', 'Dislocation, sprain and strain of joints and ligaments at ankle and foot level', '', '', '25510101', '99999999'), ('S94', 'F', 'Injury of nerves at ankle and foot level', '', '', '25510101', '99999999'), ('S95', 'F', 'Injury of blood vessels at ankle and foot level', '', '', '25510101', '99999999'), ('S96', 'F', 'Injury of muscle and tendon at ankle and foot level', '', '', '25510101', '99999999'), ('S97', 'F', 'Crushing injury of ankle and foot', '', '', '25510101', '99999999'), ('S98', 'F', 'Traumatic amputation of ankle and foot', '', '', '25510101', '99999999'), ('S99', 'F', 'Other and unspecified injuries of ankle and foot', '', '', '25510101', '99999999'), ('T00', 'F', 'Superficial injuries involving multiple body regions', '', '', '25510101', '99999999'), ('T01', 'F', 'Open wounds involving multiple body regions', '', '', '25510101', '99999999'), ('T02', 'F', 'Fractures involving multiple body regions', '', '', '25510101', '99999999'), ('T03', 'F', 'Dislocations, sprains and strains involving multiple body regions', '', '', '25510101', '99999999'), ('T04', 'F', 'Crushing injuries involving multiple body regions', '', '', '25510101', '99999999'), ('T05', 'F', 'Traumatic amputations involving multiple body regions', '', '', '25510101', '99999999'), ('T06', 'F', 'Other injuries involving multiple body regions, not elsewhere classified', '', '', '25510101', '99999999'), ('T09', 'F', 'Other injuries of spine and trunk, level unspecified', '', '', '25510101', '99999999'), ('T11', 'F', 'Other injuries of upper limb, level unspecified', '', '', '25510101', '99999999'), ('T13', 'F', 'Other injuries of lower limb, level unspecified', '', '', '25510101', '99999999'), ('T14', 'F', 'Injury of unspecified body region', '', '', '25510101', '99999999'), ('T15', 'F', 'Foreign body on external eye', '', '', '25510101', '99999999'), ('T17', 'F', 'Foreign body in respiratory tract', '', '', '25510101', '99999999'), ('T18', 'F', 'Foreign body in alimentary tract', '', '', '25510101', '99999999'), ('T19', 'F', 'Foreign body in genitourinary tract', '', '', '25510101', '99999999'), ('T20', 'F', 'Burn and corrosion of head and neck', '', '', '25510101', '99999999'), ('T21', 'F', 'Burn and corrosion of trunk', '', '', '25510101', '99999999'), ('T22', 'F', 'Burn and corrosion of shoulder and upper limb, except wrist and hand', '', '', '25510101', '99999999'), ('T23', 'F', 'Burn and corrosion of wrist and hand', '', '', '25510101', '99999999'), ('T24', 'F', 'Burn and corrosion of hip and lower limb, except ankle and foot', '', '', '25510101', '99999999'), ('T25', 'F', 'Burn and corrosion of ankle and foot', '', '', '25510101', '99999999'), ('T26', 'F', 'Burn and corrosion confined to eye and adnexa', '', '', '25510101', '99999999'), ('T27', 'F', 'Burn and corrosion of respiratory tract', '', '', '25510101', '99999999'), ('T28', 'F', 'Burn and corrosion of other internal organs', '', '', '25510101', '99999999'), ('T29', 'F', 'Burns and corrosions of multiple body regions', '', '', '25510101', '99999999'), ('T30', 'F', 'Burn and corrosion, body region unspecified', '', '', '25510101', '99999999'), ('T31', 'F', 'Burns classified according to extent of body surface involved', '', '', '25510101', '99999999'), ('T32', 'F', 'Corrosions classified according to extent of body surface involved', '', '', '25510101', '99999999'), ('T33', 'F', 'Superficial frostbite', '', '', '25510101', '99999999'), ('T34', 'F', 'Frostbite with tissue necrosis', '', '', '25510101', '99999999'), ('T35', 'F', 'Frostbite involving multiple body regions and unspecified frostbite', '', '', '25510101', '99999999'), ('T36', 'F', 'Poisoning by systemic antibiotics', '', '', '25510101', '99999999'), ('T37', 'F', 'Poisoning by other systemic anti-infectives and antiparasitics', '', '', '25510101', '99999999'), ('T38', 'F', 'Poisoning by hormones and their synthetic substitutes and antagonists, not elsewhere classified', '', '', '25510101', '99999999'), ('T39', 'F', 'Poisoning by nonopioid analgesics, antipyretics and antirheumatics', '', '', '25510101', '99999999'), ('T40', 'F', 'Poisoning by narcotics and psychodysleptics [hallucinogens]', '', '', '25510101', '99999999'), ('T41', 'F', 'Poisoning by anaesthetics and therapeutic gases', '', '', '25510101', '99999999'), ('T42', 'F', 'Poisoning by antiepileptic, sedative-hypnotic and antiparkinsonism drugs', '', '', '25510101', '99999999'), ('T43', 'F', 'Poisoning by psychotropic drugs, not elsewhere classified', '', '', '25510101', '99999999'), ('T44', 'F', 'Poisoning by drugs primarily affecting the autonomic nervous system', '', '', '25510101', '99999999'), ('T45', 'F', 'Poisoning by primarily systemic and haematological agents, not elsewhere classified', '', '', '25510101', '99999999'), ('T46', 'F', 'Poisoning by agents primarily affecting the cardiovascular system', '', '', '25510101', '99999999'), ('T47', 'F', 'Poisoning by agents primarily affecting the gastrointestinal system', '', '', '25510101', '99999999'), ('T48', 'F', 'Poisoning by agents primarily acting on smooth and skeletal muscles and the respiratory system', '', '', '25510101', '99999999'), ('T49', 'F', 'Poisoning by topical agents primarily affecting skin and mucous membrane and by ophthalmological, otorhinolaryngological and dental drugs', '', '', '25510101', '99999999'), ('T50', 'F', 'Poisoning by diuretics and other and unspecified drugs, medicaments and biological substances', '', '', '25510101', '99999999'), ('T51', 'F', 'Toxic effect of alcohol', '', '', '25510101', '99999999'), ('T52', 'F', 'Toxic effect of organic solvents', '', '', '25510101', '99999999'), ('T53', 'F', 'Toxic effect of halogen derivatives of aliphatic and aromatic hydrocarbons', '', '', '25510101', '99999999'), ('T54', 'F', 'Toxic effect of corrosive substances', '', '', '25510101', '99999999'), ('T56', 'F', 'Toxic effect of metals', '', '', '25510101', '99999999'), ('T57', 'F', 'Toxic effect of other inorganic substances', '', '', '25510101', '99999999'), ('T59', 'F', 'Toxic effect of other gases, fumes and vapours', '', '', '25510101', '99999999'), ('T60', 'F', 'Toxic effect of pesticides', '', '', '25510101', '99999999'), ('T61', 'F', 'Toxic effect of noxious substances eaten as seafood', '', '', '25510101', '99999999'), ('T62', 'F', 'Toxic effect of other noxious substances eaten as food', '', '', '25510101', '99999999'), ('T63', 'F', 'Toxic effect of contact with venomous animals', '', '', '25510101', '99999999'), ('T65', 'F', 'Toxic effect of other and unspecified substances', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('T67', 'F', 'Effects of heat and light', '', '', '25510101', '99999999'), ('T69', 'F', 'Other effects of reduced temperature', '', '', '25510101', '99999999'), ('T70', 'F', 'Effects of air pressure and water pressure', '', '', '25510101', '99999999'), ('T73', 'F', 'Effects of other deprivation', '', '', '25510101', '99999999'), ('T74', 'F', 'Maltreatment syndromes', '', '', '25510101', '99999999'), ('T75', 'F', 'Effects of other external causes', '', '', '25510101', '99999999'), ('T78', 'F', 'Adverse effects, not elsewhere classified', '', '', '25510101', '99999999'), ('T79', 'F', 'Certain early complications of trauma, not elsewhere classified', '', '', '25510101', '99999999'), ('T80', 'F', 'Complications following infusion, transfusion and therapeutic injection', '', '', '25510101', '99999999'), ('T81', 'F', 'Complications of procedures, not elsewhere classified', '', '', '25510101', '99999999'), ('T82', 'F', 'Complications of cardiac and vascular prosthetic devices, implants and grafts', '', '', '25510101', '99999999'), ('T83', 'F', 'Complications of genitourinary prosthetic devices, implants and grafts', '', '', '25510101', '99999999'), ('T84', 'F', 'Complications of internal orthopaedic prosthetic devices, implants and grafts', '', '', '25510101', '99999999'), ('T85', 'F', 'Complications of other internal prosthetic devices, implants and grafts', '', '', '25510101', '99999999'), ('T86', 'F', 'Failure and rejection of transplanted organs and tissues', '', '', '25510101', '99999999'), ('T87', 'F', 'Complications peculiar to reattachment and amputation', '', '', '25510101', '99999999'), ('T88', 'F', 'Other complications of surgical and medical care, not elsewhere classified', '', '', '25510101', '99999999'), ('T90', 'F', 'Sequelae of injuries of head', '', '', '25510101', '99999999'), ('T91', 'F', 'Sequelae of injuries of neck and trunk', '', '', '25510101', '99999999'), ('T92', 'F', 'Sequelae of injuries of upper limb', '', '', '25510101', '99999999'), ('T93', 'F', 'Sequelae of injuries of lower limb', '', '', '25510101', '99999999'), ('T94', 'F', 'Sequelae of injuries involving multiple and unspecified body regions', '', '', '25510101', '99999999'), ('T95', 'F', 'Sequelae of burns, corrosions and frostbite', '', '', '25510101', '99999999'), ('T98', 'F', 'Sequelae of other and unspecified effects of external causes', '', '', '25510101', '99999999'), ('V01', 'F', 'Pedestrian injured in collision with pedal cycle', '', '', '25510101', '99999999'), ('V02', 'F', 'Pedestrian injured in collision with two- or three-wheeled motor vehicle', '', '', '25510101', '99999999'), ('V03', 'F', 'Pedestrian injured in collision with car, pick-up truck or van', '', '', '25510101', '99999999'), ('V04', 'F', 'Pedestrian injured in collision with heavy transport vehicle or bus', '', '', '25510101', '99999999'), ('V05', 'F', 'Pedestrian injured in collision with railway train or railway vehicle', '', '', '25510101', '99999999'), ('V06', 'F', 'Pedestrian injured in collision with other nonmotor vehicle', '', '', '25510101', '99999999'), ('V09', 'F', 'Pedestrian injured in other and unspecified transport accidents', '', '', '25510101', '99999999'), ('V10', 'F', 'Pedal cyclist injured in collision with pedestrian or animal', '', '', '25510101', '99999999'), ('V11', 'F', 'Pedal cyclist injured in collision with other pedal cycle', '', '', '25510101', '99999999'), ('V12', 'F', 'Pedal cyclist injured in collision with two- or three-wheeled motor vehicle', '', '', '25510101', '99999999'), ('V13', 'F', 'Pedal cyclist injured in collision with car, pick-up truck or van', '', '', '25510101', '99999999'), ('V14', 'F', 'Pedal cyclist injured in collision with heavy transport vehicle or bus', '', '', '25510101', '99999999'), ('V15', 'F', 'Pedal cyclist injured in collision with railway train or railway vehicle', '', '', '25510101', '99999999'), ('V16', 'F', 'Pedal cyclist injured in collision with other nonmotor vehicle', '', '', '25510101', '99999999'), ('V17', 'F', 'Pedal cyclist injured in collision with fixed or stationary object', '', '', '25510101', '99999999'), ('V18', 'F', 'Pedal cyclist injured in noncollision transport accident', '', '', '25510101', '99999999'), ('V19', 'F', 'Pedal cyclist injured in other and unspecified transport accidents', '', '', '25510101', '99999999'), ('V20', 'F', 'Motorcycle rider injured in collision with pedestrian or animal', '', '', '25510101', '99999999'), ('V21', 'F', 'Motorcycle rider injured in collision with pedal cycle', '', '', '25510101', '99999999'), ('V22', 'F', 'Motorcycle rider injured in collision with two- or three-wheeled motor vehicle', '', '', '25510101', '99999999'), ('V23', 'F', 'Motorcycle rider injured in collision with car, pick-up truck or van', '', '', '25510101', '99999999'), ('V24', 'F', 'Motorcycle rider injured in collision with heavy transport vehicle or bus', '', '', '25510101', '99999999'), ('V25', 'F', 'Motorcycle rider injured in collision with railway train or railway vehicle', '', '', '25510101', '99999999'), ('V26', 'F', 'Motorcycle rider injured in collision with other nonmotor vehicle', '', '', '25510101', '99999999'), ('V27', 'F', 'Motorcycle rider injured in collision with fixed or stationary object', '', '', '25510101', '99999999'), ('V28', 'F', 'Motorcycle rider injured in noncollision transport accident', '', '', '25510101', '99999999'), ('V29', 'F', 'Motorcycle rider injured in other and unspecified transport accidents', '', '', '25510101', '99999999'), ('V30', 'F', 'Occupant of three-wheeled motor vehicle injured in collision with pedestrian or anim', '', '', '25510101', '99999999'), ('V31', 'F', 'Occupant of three-wheeled motor vehicle injured in collision with pedal cycle', '', '', '25510101', '99999999'), ('V32', 'F', 'Occupant of three-wheeled motor vehicle injured in collision with two- or three-wheel', '', '', '25510101', '99999999'), ('V33', 'F', 'Occupant of three-wheeled motor vehicle injured in collision with car, pick-up truck or van', '', '', '25510101', '99999999'), ('V34', 'F', 'Occupant of three-wheeled motor vehicle injured in collision with heavy transport vehicle or bus', '', '', '25510101', '99999999'), ('V35', 'F', 'Occupant of three-wheeled motor vehicle injured in collision with railway train or railway vehicle', '', '', '25510101', '99999999'), ('V36', 'F', 'Occupant of three-wheeled motor vehicle injured in collision with other nonmotor vehicle', '', '', '25510101', '99999999'), ('V37', 'F', 'Occupant of three-wheeled motor vehicle injured in collision with fixed or stationary object', '', '', '25510101', '99999999'), ('V38', 'F', 'Occupant of three-wheeled motor vehicle injured in noncollision transport accident', '', '', '25510101', '99999999'), ('V39', 'F', 'Occupant of three-wheeled motor vehicle injured in other and unspecified transport accidents', '', '', '25510101', '99999999'), ('V40', 'F', 'Car occupant injured in collision with pedestrian or animal', '', '', '25510101', '99999999'), ('V41', 'F', 'Car occupant injured in collision with pedal cycle', '', '', '25510101', '99999999'), ('V42', 'F', 'Car occupant injured in collision with two- or three-wheeled motor vehicle', '', '', '25510101', '99999999'), ('V43', 'F', 'Car occupant injured in collision with car, pick-up truck or van', '', '', '25510101', '99999999'), ('V44', 'F', 'Car occupant injured in collision with heavy transport vehicle or bus', '', '', '25510101', '99999999'), ('V45', 'F', 'Car occupant injured in collision with railway train or railway vehicle', '', '', '25510101', '99999999'), ('V46', 'F', 'Car occupant injured in collision with other nonmotor vehicle', '', '', '25510101', '99999999'), ('V47', 'F', 'Car occupant injured in collision with fixed or stationary object', '', '', '25510101', '99999999'), ('V48', 'F', 'Car occupant injured in noncollision transport accident', '', '', '25510101', '99999999'), ('V49', 'F', 'Car occupant injured in other and unspecified transport accidents', '', '', '25510101', '99999999'), ('V50', 'F', 'Occupant of pick-up truck or van injured in collision with pedestrian or animal', '', '', '25510101', '99999999'), ('V51', 'F', 'Occupant of pick-up truck or van injured in collision with pedal cycle', '', '', '25510101', '99999999'), ('V52', 'F', 'Occupant of pick-up truck or van injured in collision with two- or three-wheeled motor vehicle', '', '', '25510101', '99999999'), ('V53', 'F', 'Occupant of pick-up truck or van injured in collision with car, pick-up truck or van', '', '', '25510101', '99999999'), ('V54', 'F', 'Occupant of pick-up truck or van injured in collision with heavy transport or bus', '', '', '25510101', '99999999'), ('V55', 'F', 'Occupant of pick-up truck or van injured in collision with railway train or railway vehicle', '', '', '25510101', '99999999'), ('V56', 'F', 'Occupant of pick-up truck or van injured in collision with other nonmotor vehicle', '', '', '25510101', '99999999'), ('V57', 'F', 'Occupant of pick-up truck or van injured in collision with fixed or stationary object', '', '', '25510101', '99999999'), ('V58', 'F', 'Occupant of pick-up truck or van injured in noncollision transport accident', '', '', '25510101', '99999999'), ('V59', 'F', 'Occupant of pick-up truck or van injured in other and unspecified transport accidents', '', '', '25510101', '99999999'), ('V60', 'F', 'Occupant of heavy transport vehicle injured in collision with pedestrian or animal', '', '', '25510101', '99999999'), ('V61', 'F', 'Occupant of heavy transport vehicle injured in collision with pedal cycle', '', '', '25510101', '99999999'), ('V62', 'F', 'Occupant of heavy transport vehicle injured in collision with two- or three-wheeled motor vehicle', '', '', '25510101', '99999999'), ('V63', 'F', 'Occupant of heavy transport vehicle injured in collision with car, pick-up truck or van', '', '', '25510101', '99999999'), ('V64', 'F', 'Occupant of heavy transport vehicle injured in collision with heavy transport or bus', '', '', '25510101', '99999999'), ('V65', 'F', 'Occupant of heavy transport vehicle injured in collision with railway train or railway vehicle', '', '', '25510101', '99999999'), ('V66', 'F', 'Occupant of heavy transport vehicle injured in collision with other nonmotor vehicle', '', '', '25510101', '99999999'), ('V67', 'F', 'Occupant of heavy transport vehicle injured in collision with fixed or stationary object', '', '', '25510101', '99999999'), ('V68', 'F', 'Occupant of heavy transport vehicle injured in noncollision transport accident', '', '', '25510101', '99999999'), ('V69', 'F', 'Occupant of heavy transport vehicle injured in other and unspecified transport accidents', '', '', '25510101', '99999999'), ('V70', 'F', 'Bus occupant injured in collision with pedestrian or animal', '', '', '25510101', '99999999'), ('V71', 'F', 'Bus occupant injured in collision with pedal cycle', '', '', '25510101', '99999999'), ('V72', 'F', 'Bus occupant injured in collision with two- or three-wheeled motor vehicle', '', '', '25510101', '99999999'), ('V73', 'F', 'Bus occupant injured in collision with car, pick-up truck or van', '', '', '25510101', '99999999'), ('V74', 'F', 'Bus occupant injured in collision with heavy transport vehicle or bus', '', '', '25510101', '99999999'), ('V75', 'F', 'Bus occupant injured in collision with railway train or railway vehicle', '', '', '25510101', '99999999'), ('V76', 'F', 'Bus occupant injured in collision with other nonmotor vehicle', '', '', '25510101', '99999999'), ('V77', 'F', 'Bus occupant injured in collision with fixed or stationary object', '', '', '25510101', '99999999'), ('V78', 'F', 'Bus occupant injured in noncollision transport accident', '', '', '25510101', '99999999'), ('V79', 'F', 'Bus occupant injured in other and unspecified transport accidents', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('V80', 'F', 'Animal-rider or occupant of animal-drawn vehicle injured in transport accident', '', '', '25510101', '99999999'), ('V81', 'F', 'Occupant of railway train or railway vehicle injured in transport accident', '', '', '25510101', '99999999'), ('V82', 'F', 'Occupant of streetcar injured in transport accident', '', '', '25510101', '99999999'), ('V83', 'F', 'Occupant of special vehicle mainly used on industrial premises injured in transport accident', '', '', '25510101', '99999999'), ('V84', 'F', 'Occupant of special vehicle mainly used in agriculture injured in transport accident', '', '', '25510101', '99999999'), ('V85', 'F', 'Occupant of special construction vehicle injured in transport accident', '', '', '25510101', '99999999'), ('V86', 'F', 'Occupant of special all-terrain or other motor vehicle designed primarily for off-road use, injured in transport accident', '', '', '25510101', '99999999'), ('V87', 'F', 'Traffic accident of specified type but victim\'s mode of transport unknown', '', '', '25510101', '99999999'), ('V88', 'F', 'Nontraffic accident of specified type but victim\'s mode of transport unknown', '', '', '25510101', '99999999'), ('V89', 'F', 'Motor- or nonmotor- vehicle accident, type of vehicle unspecified', '', '', '25510101', '99999999'), ('V91', 'F', 'Accident to watercraft causing other injury', '', '', '25510101', '99999999'), ('V92', 'F', 'Water-transport-related drowning and submersion without accident to watercraft', '', '', '25510101', '99999999'), ('V93', 'F', 'Accident on board watercraft without accident to watercraft, not causing drowning and submersion', '', '', '25510101', '99999999'), ('V94', 'F', 'Other and unspecified water transport accidents', '', '', '25510101', '99999999'), ('V95', 'F', 'Accident to powered aircraft causing injury to occupant', '', '', '25510101', '99999999'), ('V96', 'F', 'Accident to nonpowered aircraft causing injury to occupant', '', '', '25510101', '99999999'), ('V97', 'F', 'Other specified air transport accidents', '', '', '25510101', '99999999'), ('W00', 'F', 'Fall on same level involving ice and snow', '', '', '25510101', '99999999'), ('W01', 'F', 'Fall on same level from slipping, tripping and stumbling', '', '', '25510101', '99999999'), ('W02', 'F', 'Fall involving ice skates, skis, roller-skates or skateboards', '', '', '25510101', '99999999'), ('W03', 'F', 'Other fall on same level due to collision with, or pushing by, another person', '', '', '25510101', '99999999'), ('W04', 'F', 'Fall while being carried or supported by other persons', '', '', '25510101', '99999999'), ('W05', 'F', 'Fall involving wheelchair', '', '', '25510101', '99999999'), ('W06', 'F', 'Fall involving bed', '', '', '25510101', '99999999'), ('W07', 'F', 'Fall involving chair', '', '', '25510101', '99999999'), ('W08', 'F', 'Fall involving other furniture', '', '', '25510101', '99999999'), ('W09', 'F', 'Fall involving playground equipment', '', '', '25510101', '99999999'), ('W10', 'F', 'Fall on and from stairs and steps', '', '', '25510101', '99999999'), ('W11', 'F', 'Fall on and from ladder', '', '', '25510101', '99999999'), ('W12', 'F', 'Fall on and from scaffolding', '', '', '25510101', '99999999'), ('W13', 'F', 'Fall from, out of or through building or structure', '', '', '25510101', '99999999'), ('W14', 'F', 'Fall from tree', '', '', '25510101', '99999999'), ('W15', 'F', 'Fall from cliff', '', '', '25510101', '99999999'), ('W16', 'F', 'Diving or jumping into water causing injury other than drowning or submersion', '', '', '25510101', '99999999'), ('W17', 'F', 'Other fall from one level to another', '', '', '25510101', '99999999'), ('W18', 'F', 'Other fall on same level', '', '', '25510101', '99999999'), ('W19', 'F', 'Unspecified fall', '', '', '25510101', '99999999'), ('W20', 'F', 'Struck by thrown, projected or falling object', '', '', '25510101', '99999999'), ('W21', 'F', 'Striking against or struck by sports equipment', '', '', '25510101', '99999999'), ('W22', 'F', 'Striking against or struck by other objects', '', '', '25510101', '99999999'), ('W23', 'F', 'Caught, crushed, jammed or pinched in or between objects', '', '', '25510101', '99999999'), ('W24', 'F', 'Contact with lifting and transmission devices, not elsewhere classified', '', '', '25510101', '99999999'), ('W25', 'F', 'Contact with sharp glass', '', '', '25510101', '99999999'), ('W26', 'F', 'Contact with knife, sword or dagger', '', '', '25510101', '99999999'), ('W27', 'F', 'Contact with nonpowered hand tool', '', '', '25510101', '99999999'), ('W28', 'F', 'Contact with powered lawn-mower', '', '', '25510101', '99999999'), ('W29', 'F', 'Contact with other powered hand tools and household machinery', '', '', '25510101', '99999999'), ('W30', 'F', 'Contact with agricultural machinery', '', '', '25510101', '99999999'), ('W31', 'F', 'Contact with other and unspecified machinery', '', '', '25510101', '99999999'), ('W32', 'F', 'Handgun discharge', '', '', '25510101', '99999999'), ('W33', 'F', 'Rifle, shotgun and larger firearm discharge', '', '', '25510101', '99999999'), ('W34', 'F', 'Discharge from other and unspecified firearms', '', '', '25510101', '99999999'), ('W35', 'F', 'Explosion and rupture of boiler', '', '', '25510101', '99999999'), ('W36', 'F', 'Explosion and rupture of gas cylinder', '', '', '25510101', '99999999'), ('W37', 'F', 'Explosion and rupture of pressurized tyre, pipe or hose', '', '', '25510101', '99999999'), ('W38', 'F', 'Explosion and rupture of other specified pressurized devices', '', '', '25510101', '99999999'), ('W39', 'F', 'Discharge of firework', '', '', '25510101', '99999999'), ('W40', 'F', 'Explosion of other materials', '', '', '25510101', '99999999'), ('W41', 'F', 'Exposure to high-pressure jet', '', '', '25510101', '99999999'), ('W42', 'F', 'Exposure to noise', '', '', '25510101', '99999999'), ('W43', 'F', 'Exposure to vibration', '', '', '25510101', '99999999'), ('W44', 'F', 'Foreign body entering into or through eye or natural orifice', '', '', '25510101', '99999999'), ('W45', 'F', 'Foreign body or object entering through skin', '', '', '25510101', '99999999'), ('W46', 'F', 'Contact with hypodermic needle', '', '', '25510101', '99999999'), ('W49', 'F', 'Exposure to other and unspecified inanimate mechanical forces', '', '', '25510101', '99999999'), ('W50', 'F', 'Hit, struck, kicked, twisted, bitten or scratched by another person', '', '', '25510101', '99999999'), ('W51', 'F', 'Striking against or bumped into by another person', '', '', '25510101', '99999999'), ('W52', 'F', 'Crushed, pushed or stepped on by crowd or human stampede', '', '', '25510101', '99999999'), ('W53', 'F', 'Bitten by rat', '', '', '25510101', '99999999'), ('W54', 'F', 'Bitten or struck by dog', '', '', '25510101', '99999999'), ('W55', 'F', 'Bitten or struck by other mammals', '', '', '25510101', '99999999'), ('W56', 'F', 'Contact with marine animal', '', '', '25510101', '99999999'), ('W57', 'F', 'Bitten or stung by nonvenomous insect and other nonvenomous arthropods', '', '', '25510101', '99999999'), ('W58', 'F', 'Bitten or struck by crocodile or alligator', '', '', '25510101', '99999999'), ('W59', 'F', 'Bitten or crushed by other reptiles', '', '', '25510101', '99999999'), ('W60', 'F', 'Contact with plant thorns and spines and sharp leaves', '', '', '25510101', '99999999'), ('W64', 'F', 'Exposure to other and unspecified animate mechanical forces', '', '', '25510101', '99999999'), ('W65', 'F', 'Drowning and submersion while in bath-tub', '', '', '25510101', '99999999'), ('W66', 'F', 'Drowning and submersion following fall into bath-tub', '', '', '25510101', '99999999'), ('W67', 'F', 'Drowning and submersion while in swimming-pool', '', '', '25510101', '99999999'), ('W68', 'F', 'Drowning and submersion following fall into swimming-pool', '', '', '25510101', '99999999'), ('W69', 'F', 'Drowning and submersion while in natural water', '', '', '25510101', '99999999'), ('W70', 'F', 'Drowning and submersion following fall into natural water', '', '', '25510101', '99999999'), ('W73', 'F', 'Other specified drowning and submersion', '', '', '25510101', '99999999'), ('W74', 'F', 'Unspecified drowning and submersion', '', '', '25510101', '99999999'), ('W75', 'F', 'Accidental suffocation and strangulation in bed', '', '', '25510101', '99999999'), ('W76', 'F', 'Other accidental hanging and strangulation', '', '', '25510101', '99999999'), ('W77', 'F', 'Threat to breathing due to cave-in, falling earth and other substances', '', '', '25510101', '99999999'), ('W78', 'F', 'Inhalation of gastric contents', '', '', '25510101', '99999999'), ('W79', 'F', 'Inhalation and ingestion of food causing obstruction of respiratory tract', '', '', '25510101', '99999999'), ('W80', 'F', 'Inhalation and ingestion of other objects causing obstruction of respiratory tract', '', '', '25510101', '99999999'), ('W81', 'F', 'Confined to or trapped in a low-oxygen environment', '', '', '25510101', '99999999'), ('W83', 'F', 'Other specified threats to breathing', '', '', '25510101', '99999999'), ('W84', 'F', 'Unspecified threat to breathing', '', '', '25510101', '99999999'), ('W85', 'F', 'Exposure to electric transmission lines', '', '', '25510101', '99999999'), ('W86', 'F', 'Exposure to other specified electric current', '', '', '25510101', '99999999'), ('W87', 'F', 'Exposure to unspecified electric current', '', '', '25510101', '99999999'), ('W88', 'F', 'Exposure to ionizing radiation', '', '', '25510101', '99999999'), ('W89', 'F', 'Exposure to man-made visible and ultraviolet light', '', '', '25510101', '99999999'), ('W90', 'F', 'Exposure to other nonionizing radiation', '', '', '25510101', '99999999'), ('W91', 'F', 'Exposure to unspecified type of radiation', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('W92', 'F', 'Exposure to excessive heat of man-made origin', '', '', '25510101', '99999999'), ('W93', 'F', 'Exposure to excessive cold of man-made origin', '', '', '25510101', '99999999'), ('W94', 'F', 'Exposure to high and low air pressure and changes in air pressure', '', '', '25510101', '99999999'), ('W99', 'F', 'Exposure to other and unspecified man-made environmental factors', '', '', '25510101', '99999999'), ('X00', 'F', 'Exposure to uncontrolled fire in building or structure', '', '', '25510101', '99999999'), ('X01', 'F', 'Exposure to uncontrolled fire, not in building or structure', '', '', '25510101', '99999999'), ('X02', 'F', 'Exposure to controlled fire in building or structure', '', '', '25510101', '99999999'), ('X03', 'F', 'Exposure to controlled fire, not in building or structure', '', '', '25510101', '99999999'), ('X04', 'F', 'Exposure to ignition of highly flammable material', '', '', '25510101', '99999999'), ('X05', 'F', 'Exposure to ignition or melting of nightwear', '', '', '25510101', '99999999'), ('X06', 'F', 'Exposure to ignition or melting of other clothing and apparel', '', '', '25510101', '99999999'), ('X08', 'F', 'Exposure to other specified smoke, fire and flames', '', '', '25510101', '99999999'), ('X09', 'F', 'Exposure to unspecified smoke, fire and flames', '', '', '25510101', '99999999'), ('X10', 'F', 'Contact with hot drinks, food, fats and cooking oils', '', '', '25510101', '99999999'), ('X11', 'F', 'Contact with hot tap-water', '', '', '25510101', '99999999'), ('X12', 'F', 'Contact with other hot fluids', '', '', '25510101', '99999999'), ('X13', 'F', 'Contact with steam and hot vapours', '', '', '25510101', '99999999'), ('X14', 'F', 'Contact with hot air and gases', '', '', '25510101', '99999999'), ('X15', 'F', 'Contact with hot household appliances', '', '', '25510101', '99999999'), ('X16', 'F', 'Contact with hot heating appliances, radiators and pipes', '', '', '25510101', '99999999'), ('X17', 'F', 'Contact with hot engines, machinery and tools', '', '', '25510101', '99999999'), ('X18', 'F', 'Contact with other hot metals', '', '', '25510101', '99999999'), ('X19', 'F', 'Contact with other and unspecified heat and hot substances', '', '', '25510101', '99999999'), ('X20', 'F', 'Contact with venomous snakes and lizards', '', '', '25510101', '99999999'), ('X21', 'F', 'Contact with venomous spiders', '', '', '25510101', '99999999'), ('X22', 'F', 'Contact with scorpions', '', '', '25510101', '99999999'), ('X23', 'F', 'Contact with hornets, wasps and bees', '', '', '25510101', '99999999'), ('X24', 'F', 'Contact with centipedes and venomous millipedes (tropical)', '', '', '25510101', '99999999'), ('X25', 'F', 'Contact with other specified venomous arthropods', '', '', '25510101', '99999999'), ('X26', 'F', 'Contact with venomous marine animals and plants', '', '', '25510101', '99999999'), ('X27', 'F', 'Contact with other specified venomous animals', '', '', '25510101', '99999999'), ('X28', 'F', 'Contact with other specified venomous plants', '', '', '25510101', '99999999'), ('X29', 'F', 'Contact with unspecified venomous animal or plant', '', '', '25510101', '99999999'), ('X30', 'F', 'Exposure to excessive natural heat', '', '', '25510101', '99999999'), ('X31', 'F', 'Exposure to excessive natural cold', '', '', '25510101', '99999999'), ('X32', 'F', 'Exposure to sunlight', '', '', '25510101', '99999999'), ('X33', 'F', 'Victim of lightning', '', '', '25510101', '99999999'), ('X34', 'F', 'Victim of earthquake', '', '', '25510101', '99999999'), ('X35', 'F', 'Victim of volcanic eruption', '', '', '25510101', '99999999'), ('X36', 'F', 'Victim of avalanche, landslide and other earth movements', '', '', '25510101', '99999999'), ('X37', 'F', 'Victim of cataclysmic storm', '', '', '25510101', '99999999'), ('X38', 'F', 'Victim of flood', '', '', '25510101', '99999999'), ('X39', 'F', 'Exposure to other and unspecified forces of nature', '', '', '25510101', '99999999'), ('X40', 'F', 'Accidental poisoning by and exposure to nonopioid analgesics, antipyretics and antir', '', '', '25510101', '99999999'), ('X41', 'F', 'Accidental poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkin and psychotropic drugs, NEC', '', '', '25510101', '99999999'), ('X42', 'F', 'Accidental poisoning by and exposure to narcotics and psychodysleptics [hallucinogens], NEC', '', '', '25510101', '99999999'), ('X43', 'F', 'Accidental poisoning by and exposure to other drugs acting on the autonomic nervous system', '', '', '25510101', '99999999'), ('X44', 'F', 'Accidental poisoning by and exposure to other and unspecified drugs, medicaments and biological substances', '', '', '25510101', '99999999'), ('X45', 'F', 'Accidental poisoning by and exposure to alcohol', '', '', '25510101', '99999999'), ('X46', 'F', 'Accidental poisoning by and exposure to organic solvents and halogenated hydrocarbons and their vapours', '', '', '25510101', '99999999'), ('X47', 'F', 'Accidental poisoning by and exposure to other gases and vapours', '', '', '25510101', '99999999'), ('X48', 'F', 'Accidental poisoning by and exposure to pesticides', '', '', '25510101', '99999999'), ('X49', 'F', 'Accidental poisoning by and exposure to other and unspecified chemicals and noxious substances', '', '', '25510101', '99999999'), ('X50', 'F', 'Overexertion and strenuous or repetitive movements', '', '', '25510101', '99999999'), ('X51', 'F', 'Travel and motion', '', '', '25510101', '99999999'), ('X52', 'F', 'Prolonged stay in weightless environment', '', '', '25510101', '99999999'), ('X53', 'F', 'Lack of food', '', '', '25510101', '99999999'), ('X54', 'F', 'Lack of water', '', '', '25510101', '99999999'), ('X57', 'F', 'Unspecified privation', '', '', '25510101', '99999999'), ('X58', 'F', 'Exposure to other specified factors', '', '', '25510101', '99999999'), ('X59', 'F', 'Exposure to unspecified factor', '', '', '25510101', '99999999'), ('X60', 'F', 'Intentional self-poisoning by and exposure to nonopioid analgesics, antipyretics and antirheumatics', '', '', '25510101', '99999999'), ('X61', 'F', 'Intentional self-poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkin and psychotropic drugs, NEC:', '', '', '25510101', '99999999'), ('X62', 'F', 'Intentional self-poisoning by and exposure to narcotics and psychodysleptics [hallucinogens], NEC', '', '', '25510101', '99999999'), ('X63', 'F', 'Intentional self-poisoning by and exposure to other drugs acting on the autonomic nervous system', '', '', '25510101', '99999999'), ('X64', 'F', 'Intentional self-poisoning by and exposure to other and unspecified drugs, medicaments & biological substances', '', '', '25510101', '99999999'), ('X65', 'F', 'Intentional self-poisoning by and exposure to alcohol', '', '', '25510101', '99999999'), ('X66', 'F', 'Intentional self-poisoning by and exposure to organic solvents and halogenated hydrocarbons & their vapours', '', '', '25510101', '99999999'), ('X67', 'F', 'Intentional self-poisoning by and exposure to other gases and vapours', '', '', '25510101', '99999999'), ('X68', 'F', 'Intentional self-poisoning by and exposure to pesticides', '', '', '25510101', '99999999'), ('X69', 'F', 'Intentional self-poisoning by and exposure to other and unspecified chemicals and noxious substances', '', '', '25510101', '99999999'), ('X70', 'F', 'Intentional self-harm by hanging, strangulation and suffocation', '', '', '25510101', '99999999'), ('X71', 'F', 'Intentional self-harm by drowning and submersion', '', '', '25510101', '99999999'), ('X72', 'F', 'Intentional self-harm by handgun discharge', '', '', '25510101', '99999999'), ('X73', 'F', 'Intentional self-harm by rifle, shotgun and larger firearm discharge', '', '', '25510101', '99999999'), ('X74', 'F', 'Intentional self-harm by other and unspecified firearm discharge', '', '', '25510101', '99999999'), ('X75', 'F', 'Intentional self-harm by explosive material', '', '', '25510101', '99999999'), ('X76', 'F', 'Intentional self-harm by smoke, fire and flames', '', '', '25510101', '99999999'), ('X77', 'F', 'Intentional self-harm by steam, hot vapours and hot objects', '', '', '25510101', '99999999'), ('X78', 'F', 'Intentional self-harm by sharp object', '', '', '25510101', '99999999'), ('X79', 'F', 'Intentional self-harm by blunt object', '', '', '25510101', '99999999'), ('X80', 'F', 'Intentional self-harm by jumping from a high place', '', '', '25510101', '99999999'), ('X81', 'F', 'Intentional self-harm by jumping or lying before moving object', '', '', '25510101', '99999999'), ('X82', 'F', 'Intentional self-harm by crashing of motor vehicle', '', '', '25510101', '99999999'), ('X83', 'F', 'Intentional self-harm by other specified means', '', '', '25510101', '99999999'), ('X84', 'F', 'Intentional self-harm by unspecified means', '', '', '25510101', '99999999'), ('X85', 'F', 'Assault by drugs, medicaments and biological substances', '', '', '25510101', '99999999'), ('X86', 'F', 'Assault by corrosive substance', '', '', '25510101', '99999999'), ('X87', 'F', 'Assault by pesticides', '', '', '25510101', '99999999'), ('X88', 'F', 'Assault by gases and vapours', '', '', '25510101', '99999999'), ('X89', 'F', 'Assault by other specified chemicals and noxious substances', '', '', '25510101', '99999999'), ('X90', 'F', 'Assault by unspecified chemical or noxious substance', '', '', '25510101', '99999999'), ('X91', 'F', 'Assault by hanging, strangulation and suffocation', '', '', '25510101', '99999999'), ('X92', 'F', 'Assault by drowning and submersion', '', '', '25510101', '99999999'), ('X93', 'F', 'Assault by handgun discharge', '', '', '25510101', '99999999'), ('X94', 'F', 'Assault by rifle, shotgun and larger firearm discharge', '', '', '25510101', '99999999'), ('X95', 'F', 'Assault by other and unspecified firearm discharge', '', '', '25510101', '99999999'), ('X96', 'F', 'Assault by explosive material', '', '', '25510101', '99999999'), ('X97', 'F', 'Assault by smoke, fire and flames', '', '', '25510101', '99999999'), ('X98', 'F', 'Assault by steam, hot vapours and hot objects', '', '', '25510101', '99999999'), ('X99', 'F', 'Assault by sharp object', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('Y00', 'F', 'Assault by blunt object', '', '', '25510101', '99999999'), ('Y01', 'F', 'Assault by pushing from high place', '', '', '25510101', '99999999'), ('Y02', 'F', 'Assault by pushing or placing victim before moving object', '', '', '25510101', '99999999'), ('Y03', 'F', 'Assault by crashing of motor vehicle', '', '', '25510101', '99999999'), ('Y04', 'F', 'Assault by bodily force', '', '', '25510101', '99999999'), ('Y05', 'F', 'Sexual assault by bodily force', '', '', '25510101', '99999999'), ('Y06', 'F', 'Neglect and abandonment', '', '', '25510101', '99999999'), ('Y07', 'F', 'Other maltreatment syndromes', '', '', '25510101', '99999999'), ('Y08', 'F', 'Assault by other specified means', '', '', '25510101', '99999999'), ('Y09', 'F', 'Assault by unspecified means', '', '', '25510101', '99999999'), ('Y10', 'F', 'Poisoning by and exposure to nonopioid analgesics, antipyretics and antirheumatics, undetermined intent', '', '', '25510101', '99999999'), ('Y11', 'F', 'Poisoning by and exposure to antiepileptic, sedative-hypnotic, antiparkin and psychotropic drugs, NEC, undetermined intent', '', '', '25510101', '99999999'), ('Y12', 'F', 'Poisoning by and exposure to narcotics and psychodysleptics [hallucinogens], NEC, undetermined intent', '', '', '25510101', '99999999'), ('Y13', 'F', 'Poisoning by and exposure to other drugs acting on the autonomic nervous system, undetermined intent', '', '', '25510101', '99999999'), ('Y14', 'F', 'Poisoning by and exposure to other and unspecified drugs, medicaments and biological substances, undetermined intent', '', '', '25510101', '99999999'), ('Y15', 'F', 'Poisoning by and exposure to alcohol, undetermined intent', '', '', '25510101', '99999999'), ('Y16', 'F', 'Poisoning by and exposure to organic solvents and halogenated hydrocarbons and their vapours, undetermined intent', '', '', '25510101', '99999999'), ('Y17', 'F', 'Poisoning by and exposure to other gases and vapours, undetermined intent', '', '', '25510101', '99999999'), ('Y18', 'F', 'Poisoning by and exposure to pesticides, undetermined intent', '', '', '25510101', '99999999'), ('Y19', 'F', 'Poisoning by and exposure to other and unspecified chemicals and noxious substances, undetermined intent', '', '', '25510101', '99999999'), ('Y20', 'F', 'Hanging, strangulation and suffocation, undetermined intent', '', '', '25510101', '99999999'), ('Y21', 'F', 'Drowning and submersion, undetermined intent', '', '', '25510101', '99999999'), ('Y22', 'F', 'Handgun discharge, undetermined intent', '', '', '25510101', '99999999'), ('Y23', 'F', 'Rifle, shotgun and larger firearm discharge, undetermined intent', '', '', '25510101', '99999999'), ('Y24', 'F', 'Other and unspecified firearm discharge, undetermined intent', '', '', '25510101', '99999999'), ('Y25', 'F', 'Contact with explosive material, undetermined intent', '', '', '25510101', '99999999'), ('Y26', 'F', 'Exposure to smoke, fire and flames, undetermined intent', '', '', '25510101', '99999999'), ('Y27', 'F', 'Contact with steam, hot vapours and hot objects, undetermined intent', '', '', '25510101', '99999999'), ('Y28', 'F', 'Contact with sharp object, undetermined intent', '', '', '25510101', '99999999'), ('Y29', 'F', 'Contact with blunt object, undetermined intent', '', '', '25510101', '99999999'), ('Y30', 'F', 'Falling, jumping or pushed from a high place, undetermined intent', '', '', '25510101', '99999999'), ('Y31', 'F', 'Falling, lying or running before or into moving object, undetermined intent', '', '', '25510101', '99999999'), ('Y32', 'F', 'Crashing of motor vehicle, undetermined intent', '', '', '25510101', '99999999'), ('Y33', 'F', 'Other specified events, undetermined intent', '', '', '25510101', '99999999'), ('Y34', 'F', 'Unspecified event, undetermined intent', '', '', '25510101', '99999999'), ('Y35', 'F', 'Legal intervention', '', '', '25510101', '99999999'), ('Y36', 'F', 'Operations of war', '', '', '25510101', '99999999'), ('Y40', 'F', 'Systemic antibiotics', '', '', '25510101', '99999999'), ('Y41', 'F', 'Other systemic anti-infectives and antiparasitics', '', '', '25510101', '99999999'), ('Y42', 'F', 'Hormones and their synthetic substitutes and antagonists, not elsewhere classified', '', '', '25510101', '99999999'), ('Y43', 'F', 'Primarily systemic agents', '', '', '25510101', '99999999'), ('Y44', 'F', 'Agents primarily affecting blood constituents', '', '', '25510101', '99999999'), ('Y45', 'F', 'Analgesics, antipyretics and anti-inflammatory drugs', '', '', '25510101', '99999999'), ('Y46', 'F', 'Antiepileptics and antiparkinsonism drugs', '', '', '25510101', '99999999'), ('Y47', 'F', 'Sedatives, hypnotics and antianxiety drugs', '', '', '25510101', '99999999'), ('Y48', 'F', 'Anaesthetics and therapeutic gases', '', '', '25510101', '99999999'), ('Y49', 'F', 'Psychotropic drugs, not elsewhere classified', '', '', '25510101', '99999999'), ('Y50', 'F', 'Central nervous system stimulants, not elsewhere classified', '', '', '25510101', '99999999'), ('Y51', 'F', 'Drugs primarily affecting the autonomic nervous system', '', '', '25510101', '99999999'), ('Y52', 'F', 'Agents primarily affecting the cardiovascular system', '', '', '25510101', '99999999'), ('Y53', 'F', 'Agents primarily affecting the gastrointestinal system', '', '', '25510101', '99999999'), ('Y54', 'F', 'Agents primarily affecting water-balance and mineral and uric acid metabolism', '', '', '25510101', '99999999'), ('Y55', 'F', 'Agents primarily acting on smooth and skeletal muscles and the respiratory system', '', '', '25510101', '99999999'), ('Y56', 'F', 'Topical agents primarily affecting skin and mucous membrane, and opthalmological, otorhinolaryngological and dental drugs', '', '', '25510101', '99999999'), ('Y57', 'F', 'Other and unspecified drugs and medicaments', '', '', '25510101', '99999999'), ('Y58', 'F', 'Bacterial vaccines', '', '', '25510101', '99999999'), ('Y59', 'F', 'Other and unspecified vaccines and biological substances', '', '', '25510101', '99999999'), ('Y60', 'F', 'Unintentional cut, puncture, perforation or haemorrhage during surgical and medical care', '', '', '25510101', '99999999'), ('Y61', 'F', 'Foreign object accidentally left in body during surgical and medical care', '', '', '25510101', '99999999'), ('Y62', 'F', 'Failure of sterile precautions during surgical and medical care', '', '', '25510101', '99999999'), ('Y63', 'F', 'Failure in dosage during surgical and medical care', '', '', '25510101', '99999999'), ('Y64', 'F', 'Contaminated medical or biological substances', '', '', '25510101', '99999999'), ('Y65', 'F', 'Other misadventures during surgical and medical care', '', '', '25510101', '99999999'), ('Y70', 'F', 'Anaesthesiology devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y71', 'F', 'Cardiovascular devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y72', 'F', 'Otorhinolaryngological devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y73', 'F', 'Gastroenterology and urology devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y74', 'F', 'General hospital and personal-use devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y75', 'F', 'Neurological devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y76', 'F', 'Obstetric and gynaecological devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y77', 'F', 'Ophthalmic devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y78', 'F', 'Radiological devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y79', 'F', 'Orthopaedic devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y80', 'F', 'Physical medicine devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y81', 'F', 'General- and plastic-surgery devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y82', 'F', 'Other and unspecified medical devices associated with adverse incidents', '', '', '25510101', '99999999'), ('Y83', 'F', 'Surgical operation and other surgical procedures as the cause of abnormal reaction of the patient, or of later compli, without mention of misadventure', '', '', '25510101', '99999999'), ('Y84', 'F', 'Other medical procedures as the cause of abnormal reaction of the patient, or of later compli, without mention of misadventure at the time of the proc', '', '', '25510101', '99999999'), ('Y85', 'F', 'Sequelae of transport accidents', '', '', '25510101', '99999999'), ('Y87', 'F', 'Sequelae of intentional self-harm, assault and events of undetermined intent', '', '', '25510101', '99999999'), ('Y88', 'F', 'Sequelae with surgical and medical care as external cause', '', '', '25510101', '99999999'), ('Y89', 'F', 'Sequelae of other external causes', '', '', '25510101', '99999999'), ('Y90', 'F', 'Evidence of alcohol involvement determined by blood alcohol level', '', '', '25510101', '99999999'), ('Y91', 'F', 'Evidence of alcohol involvement determined by level of intoxication', '', '', '25510101', '99999999'), ('Z00', 'F', 'General examination and investigation of persons without complaint or reported diagnosis', '', '', '25510101', '99999999'), ('Z01', 'F', 'Other special examinations and investigations of persons without complaint or reported diagnosis', '', '', '25510101', '99999999'), ('Z02', 'F', 'Examination and encounter for administrative purposes', '', '', '25510101', '99999999'), ('Z03', 'F', 'Medical observation and evaluation for suspected diseases and conditions', '', '', '25510101', '99999999'), ('Z04', 'F', 'Examination and observation for other reasons', '', '', '25510101', '99999999'), ('Z08', 'F', 'Follow-up examination after treatment for malignant neoplasm', '', '', '25510101', '99999999'), ('Z09', 'F', 'Follow-up examination after treatment for conditions other than malignant neoplasms', '', '', '25510101', '99999999'), ('Z10', 'F', 'Routine general health check-up of defined subpopulation', '', '', '25510101', '99999999'), ('Z11', 'F', 'Special screening examination for infectious and parasitic diseases', '', '', '25510101', '99999999'), ('Z12', 'F', 'Special screening examination for neoplasms', '', '', '25510101', '99999999'), ('Z13', 'F', 'Special screening examination for other diseases and disorders', '', '', '25510101', '99999999'), ('Z20', 'F', 'Contact with and exposure to communicable diseases', '', '', '25510101', '99999999'), ('Z22', 'F', 'Carrier of infectious disease', '', '', '25510101', '99999999'), ('Z23', 'F', 'Need for immunization against single bacterial diseases', '', '', '25510101', '99999999'), ('Z24', 'F', 'Need for immunization against certain single viral diseases', '', '', '25510101', '99999999'), ('Z25', 'F', 'Need for immunization against other single viral diseases', '', '', '25510101', '99999999'), ('Z26', 'F', 'Need for immunization against other single infectious diseases', '', '', '25510101', '99999999');
INSERT INTO `l_icd101` VALUES ('Z27', 'F', 'Need for immunization against combinations of infectious diseases', '', '', '25510101', '99999999'), ('Z28', 'F', 'Immunization not carried out', '', '', '25510101', '99999999'), ('Z29', 'F', 'Need for other prophylactic measures', '', '', '25510101', '99999999'), ('Z30', 'F', 'Contraceptive management', '', '', '25510101', '99999999'), ('Z31', 'F', 'Procreative management', '', '', '25510101', '99999999'), ('Z32', 'F', 'Pregnancy examination and test', '', '', '25510101', '99999999'), ('Z34', 'F', 'Supervision of normal pregnancy', '', '', '25510101', '99999999'), ('Z35', 'F', 'Supervision of high-risk pregnancy', '', '', '25510101', '99999999'), ('Z36', 'F', 'Antenatal screening', '', '', '25510101', '99999999'), ('Z37', 'F', 'Outcome of delivery', '', '', '25510101', '99999999'), ('Z38', 'F', 'Liveborn infants according to place of birth', '', '', '25510101', '99999999'), ('Z39', 'F', 'Postpartum care and examination', '', '', '25510101', '99999999'), ('Z40', 'F', 'Prophylactic surgery', '', '', '25510101', '99999999'), ('Z41', 'F', 'Procedures for purposes other than remedying health state', '', '', '25510101', '99999999'), ('Z42', 'F', 'Follow-up care involving plastic surgery', '', '', '25510101', '99999999'), ('Z43', 'F', 'Attention to artificial openings', '', '', '25510101', '99999999'), ('Z44', 'F', 'Fitting and adjustment of external prosthetic device', '', '', '25510101', '99999999'), ('Z45', 'F', 'Adjustment and management of implanted device', '', '', '25510101', '99999999'), ('Z46', 'F', 'Fitting and adjustment of other devices', '', '', '25510101', '99999999'), ('Z47', 'F', 'Other orthopaedic follow-up care', '', '', '25510101', '99999999'), ('Z48', 'F', 'Other surgical follow-up care', '', '', '25510101', '99999999'), ('Z49', 'F', 'Care involving dialysis', '', '', '25510101', '99999999'), ('Z50', 'F', 'Care involving use of rehabilitation procedures', '', '', '25510101', '99999999'), ('Z51', 'F', 'Other medical care', '', '', '25510101', '99999999'), ('Z52', 'F', 'Donors of organs and tissues', '', '', '25510101', '99999999'), ('Z53', 'F', 'Persons encountering health services for specific procedures, not carried out', '', '', '25510101', '99999999'), ('Z54', 'F', 'Convalescence', '', '', '25510101', '99999999'), ('Z55', 'F', 'Problems related to education and literacy', '', '', '25510101', '99999999'), ('Z56', 'F', 'Problems related to employment and unemployment', '', '', '25510101', '99999999'), ('Z57', 'F', 'Occupational exposure to risk-factors', '', '', '25510101', '99999999'), ('Z58', 'F', 'Problems related to physical environment', '', '', '25510101', '99999999'), ('Z59', 'F', 'Problems related to housing and economic circumstances', '', '', '25510101', '99999999'), ('Z60', 'F', 'Problems related to social environment', '', '', '25510101', '99999999'), ('Z61', 'F', 'Problems related to negative life events in childhood', '', '', '25510101', '99999999'), ('Z62', 'F', 'Other problems related to upbringing', '', '', '25510101', '99999999'), ('Z63', 'F', 'Other problems related to primary support group, including family circumstances', '', '', '25510101', '99999999'), ('Z64', 'F', 'Problems related to certain psychosocial circumstances', '', '', '25510101', '99999999'), ('Z65', 'F', 'Problems related to other psychosocial circumstances', '', '', '25510101', '99999999'), ('Z70', 'F', 'Counselling related to sexual attitude, behaviour and orientation', '', '', '25510101', '99999999'), ('Z71', 'F', 'Persons encountering health services for other counselling and medical advice, not elsewhere classified', '', '', '25510101', '99999999'), ('Z72', 'F', 'Problems related to lifestyle', '', '', '25510101', '99999999'), ('Z73', 'F', 'Problems related to life-management difficulty', '', '', '25510101', '99999999'), ('Z74', 'F', 'Problems related to care-provider dependency', '', '', '25510101', '99999999'), ('Z75', 'F', 'Problems related to medical facilities and other health care', '', '', '25510101', '99999999'), ('Z76', 'F', 'Persons encountering health services in other circumstances', '', '', '25510101', '99999999'), ('Z80', 'F', 'Family history of malignant neoplasm', '', '', '25510101', '99999999'), ('Z81', 'F', 'Family history of mental and behavioural disorders', '', '', '25510101', '99999999'), ('Z82', 'F', 'Family history of certain disabilities and chronic diseases leading to disablement', '', '', '25510101', '99999999'), ('Z83', 'F', 'Family history of other specific disorders', '', '', '25510101', '99999999'), ('Z84', 'F', 'Family history of other conditions', '', '', '25510101', '99999999'), ('Z85', 'F', 'Personal history of malignant neoplasm', '', '', '25510101', '99999999'), ('Z86', 'F', 'Personal history of certain other diseases', '', '', '25510101', '99999999'), ('Z87', 'F', 'Personal history of other diseases and conditions', '', '', '25510101', '99999999'), ('Z88', 'F', 'Personal history of allergy to drugs, medicaments and biological substances', '', '', '25510101', '99999999'), ('Z89', 'F', 'Acquired absence of limb', '', '', '25510101', '99999999'), ('Z90', 'F', 'Acquired absence of organs, not elsewhere classified', '', '', '25510101', '99999999'), ('Z91', 'F', 'Personal history of risk-factors, not elsewhere classified', '', '', '25510101', '99999999'), ('Z92', 'F', 'Personal history of medical treatment', '', '', '25510101', '99999999'), ('Z93', 'F', 'Artificial opening status', '', '', '25510101', '99999999'), ('Z94', 'F', 'Transplanted organ and tissue status', '', '', '25510101', '99999999'), ('Z95', 'F', 'Presence of cardiac and vascular implants and grafts', '', '', '25510101', '99999999'), ('Z96', 'F', 'Presence of other functional implants', '', '', '25510101', '99999999'), ('Z97', 'F', 'Presence of other devices', '', '', '25510101', '99999999'), ('Z98', 'F', 'Other postsurgical states', '', '', '25510101', '99999999'), ('Z99', 'F', 'Dependence on enabling machines and devices, not elsewhere classified', '', '', '25510101', '99999999');
COMMIT;

-- ----------------------------
-- Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`name`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`parent`  int(11) NULL DEFAULT NULL ,
`route`  varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`order`  int(11) NULL DEFAULT NULL ,
`data`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`id`),
FOREIGN KEY (`parent`) REFERENCES `menu` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for `migration`
-- ----------------------------
DROP TABLE IF EXISTS `migration`;
CREATE TABLE `migration` (
`version`  varchar(180) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`apply_time`  int(11) NULL DEFAULT NULL ,
PRIMARY KEY (`version`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of migration
-- ----------------------------
BEGIN;
INSERT INTO `migration` VALUES ('m000000_000000_base', '1445180279'), ('m130524_201442_init', '1445180281'), ('m140506_102106_rbac_init', '1452246448'), ('m140602_111327_create_menu_table', '1452245565');
COMMIT;

-- ----------------------------
-- Table structure for `procedure_no_price`
-- ----------------------------
DROP TABLE IF EXISTS `procedure_no_price`;
CREATE TABLE `procedure_no_price` (
`code`  int(7) NOT NULL ,
PRIMARY KEY (`code`)
)
ENGINE=MyISAM
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of procedure_no_price
-- ----------------------------
BEGIN;
INSERT INTO `procedure_no_price` VALUES ('2330010'), ('2330011'), ('2330012'), ('2337099'), ('2338610'), ('2338611'), ('2377020'), ('2377021'), ('2377030'), ('2387021'), ('2387030');
COMMIT;

-- ----------------------------
-- Table structure for `sys_config`
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
`province_config`  varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`process`  char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`yearprocess`  year NULL DEFAULT NULL ,
`prov_name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`chk_update`  date NULL DEFAULT NULL ,
`version`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`active`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL 
)
ENGINE=MyISAM
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for `sys_config_runtime`
-- ----------------------------
DROP TABLE IF EXISTS `sys_config_runtime`;
CREATE TABLE `sys_config_runtime` (
`run_id`  int(11) NOT NULL AUTO_INCREMENT ,
`run_gid`  varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`run_rid`  int(9) NULL DEFAULT NULL ,
`s_runtime`  date NULL DEFAULT NULL ,
`e_runtime`  date NULL DEFAULT NULL ,
PRIMARY KEY (`run_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=2

;

-- ----------------------------
-- Records of sys_config_runtime
-- ----------------------------
BEGIN;
INSERT INTO `sys_config_runtime` VALUES ('1', 'root', null, '2016-10-01', '2017-09-30');
COMMIT;

-- ----------------------------
-- Table structure for `sys_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
`s_id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
`procedure_names`  varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`d_run`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`s_time`  varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`e_time`  varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`conf_runtime`  int(5) NULL DEFAULT NULL ,
`all_process`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`running_process`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`err_info`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`log_status`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`s_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=29

;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_log` VALUES ('1', 'anc_noperson', '2017-05-19', '22:30:00', '22:30:07', '1', '64', '1', null, 'complete'), ('2', 'newborn_noperson', '2017-05-19', '22:30:07', '22:30:07', '1', '64', '2', null, 'complete'), ('3', 'anc_falseresult', '2017-05-19', '22:30:07', '22:30:12', '1', '64', '3', null, 'complete'), ('4', 'postnatal_after', '2017-05-19', '22:30:12', '22:30:14', '1', '64', '4', null, 'complete'), ('5', 'anc_ga1_46', '2017-05-19', '22:30:14', '22:30:19', '1', '64', '5', null, 'complete'), ('6', 'anc_ppcare', '2017-05-19', '22:30:19', '22:30:21', '1', '64', '6', null, 'complete'), ('7', 'anc_gravida_not_as_labor', '2017-05-19', '22:30:21', '22:30:25', '1', '64', '7', null, 'complete'), ('8', 'labor_noperson', '2017-05-19', '22:30:25', '22:30:26', '1', '64', '8', null, 'complete'), ('9', 'labor_record', '2017-05-19', '22:30:26', '22:30:27', '1', '64', '9', null, 'complete'), ('10', 'labor_noanc', '2017-05-19', '22:30:27', '22:30:28', '1', '64', '10', null, 'complete'), ('11', 'labor_nonewborn', '2017-05-19', '22:30:28', '22:30:29', '1', '64', '11', null, 'complete'), ('12', 'newborn_admitweight', '2017-05-19', '22:30:29', '22:30:37', '1', '64', '12', null, 'complete'), ('13', 'newborn_bweight', '2017-05-19', '22:30:37', '22:30:37', '1', '64', '13', null, 'complete'), ('14', 'newborncare_falseresult', '2017-05-19', '22:30:37', '22:30:38', '1', '64', '14', null, 'complete'), ('15', 'newborncare_before', '2017-05-19', '22:30:38', '22:30:39', '1', '64', '15', null, 'complete'), ('16', 'newborncare_food', '2017-05-19', '22:30:39', '22:31:14', '1', '64', '16', null, 'complete'), ('17', 'person_notypearea', '2017-05-19', '22:31:14', '22:31:23', '1', '64', '17', null, 'complete'), ('18', 'chronicfu_amd', '2017-05-19', '22:31:23', '22:31:26', '1', '64', '18', null, 'complete'), ('19', 'labor_future', '2017-05-19', '22:31:26', '22:31:26', '1', '64', '19', null, 'complete'), ('20', 'person_notcid', '2017-05-19', '22:31:26', '22:31:53', '1', '64', '20', null, 'complete'), ('21', 'person_age100', '2017-05-19', '22:31:53', '22:32:33', '1', '64', '21', null, 'complete'), ('22', 'person_lnamenothai', '2017-05-19', '22:32:33', '22:32:43', '1', '64', '22', null, 'complete'), ('23', 'person_notthaitype', '2017-05-19', '22:32:43', '22:33:17', '1', '64', '23', null, 'complete'), ('24', 'person_nodeath', '2017-05-19', '22:33:17', '22:33:37', '1', '64', '24', null, 'complete'), ('25', 'ncdscreen_check', '2017-05-19', '22:33:37', '22:33:50', '1', '64', '25', null, 'complete'), ('26', 'ncdscreen_ht_false', '2017-05-19', '22:33:50', '22:34:06', '1', '64', '26', null, 'complete'), ('27', 'dental_workload', '2017-05-19', '22:34:06', null, '1', '64', '27', null, null), ('28', 'dental_workload', '2017-05-24', '22:30:00', null, '1', '66', '27', null, null);
COMMIT;

-- ----------------------------
-- Table structure for `sys_menu_group`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_group`;
CREATE TABLE `sys_menu_group` (
`muid`  int(11) NOT NULL AUTO_INCREMENT ,
`mucode`  varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`muname`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`muid`)
)
ENGINE=MyISAM
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=125

;

-- ----------------------------
-- Records of sys_menu_group
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu_group` VALUES ('1', 'person', 'ประชากร'), ('2', 'anc', 'อนามัยมารดา'), ('3', 'newborn', 'อนามัยทารก'), ('4', 'epi', 'วัคซีน'), ('5', 'chronicfu', 'ผู้ป่วยโรคเรื้อรัง'), ('6', 'ncdscreen', 'คัดกรองเบาหวานและความดัน'), ('7', 'dental', 'ทันตสุขภาพ'), ('8', 'service', 'ข้อมูลบริการผู้ป่วยนอก'), ('9', 'admission', 'ข้อมูลบริการผู้ป่วยใน'), ('10', 'procedure', 'ข้อมูลการให้บริการหัตถการ'), ('11', 'charge', 'ข้อมูลค่าใช้จ่ายของบริการ');
COMMIT;

-- ----------------------------
-- Table structure for `sys_Notifications`
-- ----------------------------
DROP TABLE IF EXISTS `sys_Notifications`;
CREATE TABLE `sys_Notifications` (
`snt_id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
`hospcode`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`distcode`  varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`hmain`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`report_id`  int(5) NULL DEFAULT NULL ,
`report_group`  varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`y_cases`  int(5) NULL DEFAULT NULL ,
`total`  int(5) NULL DEFAULT NULL ,
`percent`  float NULL DEFAULT NULL ,
PRIMARY KEY (`snt_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of sys_Notifications
-- ----------------------------
BEGIN;
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
-- Table structure for `token`
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token` (
`user_id`  int(11) NOT NULL ,
`code`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`created_at`  int(11) NOT NULL ,
`type`  smallint(6) NOT NULL ,
FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of token
-- ----------------------------
BEGIN;
INSERT INTO `token` VALUES ('536', 'lYUkWI7l8tFlr92akHX-vIElAdR1np3T', '1452508442', '0');
COMMIT;

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`username`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`email`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`password_hash`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`auth_key`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`confirmed_at`  int(11) NULL DEFAULT NULL ,
`unconfirmed_email`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`blocked_at`  int(11) NULL DEFAULT NULL ,
`registration_ip`  varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`created_at`  int(11) NOT NULL ,
`updated_at`  int(11) NOT NULL ,
`flags`  int(11) NOT NULL DEFAULT 0 ,
`level`  varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`hospcode`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=901

;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('536', 'admin', 'admin@nptadmin.com', '$2y$12$iBrZrfC2w6gb0oCqdFEiiuMSlfQaQ4GgFi/sCMMsJyll1PsYgdgeK', 'vEIC2kgSD84m0S94DwsxdZ9dlvwgnfYV', '1452508442', null, null, '::1', '1452508442', '1452508442', '0', '1', '1111'), ('900', 'region05', 'r5@moph.com', '$2y$12$5xuC6HC4pSIGMTNjb2WzBuvCfJUQsaN904KwrV6X55Qcq5JkUJQai', 'eUUP0xtP3JmJJrMX9gD6nSUsoETraM0n', '1494846414', null, null, '::1', '1494846414', '1494846414', '0', '01', '11');
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
-- Event structure for `eh_event`
-- ----------------------------
DROP EVENT IF EXISTS `eh_event`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `eh_event` ON SCHEDULE EVERY 24 HOUR STARTS '2016-01-09 22:30:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
/*
CALL person_notcid();
CALL person_age100();
CALL person_lnamenothai();
CALL person_notthaitype();
CALL person_nodeath();
CALL person_double();
CALL person_service_death();
CALL person_notypearea();

CALL anc_noperson();
CALL anc_falseresult();
CALL anc_falseservice();
CALL anc_ga1_46();
CALL anc_ppcare();
CALL anc_check();
CALL anc_resultall();
CALL anc_iodine();

CALL labor_noperson();
CALL labor_record();
CALL labor_noanc();
CALL labor_nonewborn();
CALL labor_future();

CALL newborn_admitweight();
CALL newborn_bweight();
CALL newborn_tsh();
CALL newborn_noperson();
CALL newborncare_after();
CALL newborncare_before();
CALL newborncare_food();

CALL ncdscreen_check();
CALL ncdscreen_ht_false();
CALL ncdscreen1_htdm_old();


CALL epi_noperson();
CALL epi_vaccine_nostandard();
CALL epi_bcg_BAbdate();
CALL epi_firstvaccine();
CALL epi_vaccine_BAbdate();
CALL epi_vaccine_in1year();
CALL epi_nocid();
CALL epi_vaccine_nostandardcenter();
CALL epi_vaccine_error();
CALL epi_vaccine_Bbdate();

CALL chronicfu_bp();
CALL chronicfu_retina_or_foot_not_hdc();

CALL service_before_birth();
CALL service_sell();
CALL service_after_dupdate();

CALL diagnosis_opd();
CALL diagnosis_opd_externalcause();
CALL diagnosis_opd_noexternalcause();
CALL diagnosis_opd_diagcode();

CALL procedure_opd_procedcode();
CALL procedure_opd_serviceprice();

CALL charge_opd_chargeitem();
CALL charge_opd_nochargeitem();
CALL charge_opd_nochargeitem_food();
CALL charge_opd_sell();

CALL admission_datetime_disch();
CALL admission_sell();

CALL chronicfu_amd();

CALL postnatal_after();



CALL dental_workload();
*/
CALL sys_process();
CALL sys_Notifications();

END
;;
DELIMITER ;

-- ----------------------------
-- Indexes structure for table `auth_item`
-- ----------------------------
CREATE INDEX `rule_name` ON `auth_item`(`rule_name`) USING BTREE ;
CREATE INDEX `idx-auth_item-type` ON `auth_item`(`type`) USING BTREE ;

-- ----------------------------
-- Indexes structure for table `auth_item_child`
-- ----------------------------
CREATE INDEX `child` ON `auth_item_child`(`child`) USING BTREE ;

-- ----------------------------
-- Indexes structure for table `l_icd101`
-- ----------------------------
CREATE INDEX `CODE` ON `l_icd101`(`CODE`) USING BTREE ;

-- ----------------------------
-- Indexes structure for table `menu`
-- ----------------------------
CREATE INDEX `parent` ON `menu`(`parent`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `menu`
-- ----------------------------
ALTER TABLE `menu` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for `sys_config_runtime`
-- ----------------------------
ALTER TABLE `sys_config_runtime` AUTO_INCREMENT=2;

-- ----------------------------
-- Auto increment value for `sys_log`
-- ----------------------------
ALTER TABLE `sys_log` AUTO_INCREMENT=29;

-- ----------------------------
-- Auto increment value for `sys_menu_group`
-- ----------------------------
ALTER TABLE `sys_menu_group` AUTO_INCREMENT=125;

-- ----------------------------
-- Auto increment value for `sys_Notifications`
-- ----------------------------
ALTER TABLE `sys_Notifications` AUTO_INCREMENT=1;

-- ----------------------------
-- Indexes structure for table `sys_report`
-- ----------------------------
CREATE INDEX `source_table` ON `sys_report`(`s_table`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `sys_report`
-- ----------------------------
ALTER TABLE `sys_report` AUTO_INCREMENT=10070;

-- ----------------------------
-- Indexes structure for table `token`
-- ----------------------------
CREATE UNIQUE INDEX `token_unique` ON `token`(`user_id`, `code`, `type`) USING BTREE ;

-- ----------------------------
-- Indexes structure for table `user`
-- ----------------------------
CREATE UNIQUE INDEX `user_unique_email` ON `user`(`email`) USING BTREE ;
CREATE UNIQUE INDEX `user_unique_username` ON `user`(`username`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `user`
-- ----------------------------
ALTER TABLE `user` AUTO_INCREMENT=901;
