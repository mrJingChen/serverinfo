-- 建库
DROP DATABASE IF EXISTS `server_ports`;
CREATE DATABASE `server_ports`;
USE `server_ports`;


DROP TABLE IF EXISTS t_server_info;

/*==============================================================*/
/* Table: t_server_info                                             */
/*==============================================================*/
CREATE TABLE t_server_info
(
   si_id                INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '服务信息主键ID',
   si_port       		SMALLINT UNSIGNED NOT NULL COMMENT '服务端口号',
   si_name				VARCHAR(64) NOT NULL COMMENT '服务名称',
   si_purpose			VARCHAR(256) NOT NULL DEFAULT '-' COMMENT '服务作用与说明',
   si_conf				VARCHAR(256) NOT NULL DEFAULT '-' COMMENT '服务核心配置路径',
   si_author			VARCHAR(16) NOT NULL DEFAULT 'admin' COMMENT '服务维护者',
   si_status			CHAR(2) NOT NULL DEFAULT '启用' COMMENT '服务当前状态（默认启用，停用）',
   si_create_time		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   si_update_time		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
   PRIMARY KEY (si_id)
);

ALTER TABLE t_server_info COMMENT '服务信息表';


/*==============================================================*/
-- 2.创建普通索引
CREATE INDEX i_si_port ON t_server_info (si_port);
CREATE INDEX i_si_name ON t_server_info (si_name);


