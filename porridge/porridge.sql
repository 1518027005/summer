SET NAMES UTF8;
DROP DATABASE IF EXISTS porridge;
CREATE DATABASE porridge CHARSET=UTF8;
USE porridge;


/**粥品菜单导航**/
CREATE TABLE porridge_category(
  pcid INT PRIMARY KEY AUTO_INCREMENT,  #菜单导航编号
  pcname VARCHAR(32)                    #菜单导航名称
);

/**粥品表**/
CREATE TABLE porridges(
  pid INT PRIMARY KEY AUTO_INCREMENT,   #粥品编号
  pCategory_id INT,           #菜单导航编号
  pTitle VARCHAR(255),        #商品标题
  pDetails VARCHAR(255),      #商品描述
  pIngredient VARCHAR(255),   #商品食材
  pic VARCHAR(255),           #商品图片
  price DECIMAL(10,2),        #商品价格
  soldNum INT,                #月销数量
  pNum INT,                   #今日余量
  isDiscount BOOLEAN,         #是否促销中
  dStart DATETIME,            #折扣开始时间
  dEnd DATETIME,              #折扣结束时间
  dPrice DECIMAL(10,2),       #促销价格
  FOREIGN KEY(pCategory_id) REFERENCES porridge_category(pcid)
);

/**评价表**/
CREATE TABLE evaluate(
  eid INT PRIMARY KEY AUTO_INCREMENT,   #评价编号
  uname VARCHAR(32),                    #用户名
  eDetails VARCHAR(255),                #评价文字详情
  epic VARCHAR(255)                     #评价图片
);

/**用户个人信息**/
CREATE TABLE porridge_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,   #用户编号
  uname VARCHAR(32),                    #用户名
  phone VARCHAR(16),                    #手机号
  email VARCHAR(64),                    #邮箱
  upwd VARCHAR(32),                     #密码
  avatar VARCHAR(255),                  #头像图片路径
  gender VARCHAR(6),                    #性别  0-女  1-男
  isVIP  BOOLEAN                        #是否为会员
);

/**收货地址信息**/
CREATE TABLE receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                #用户编号
  uname VARCHAR(32),          #接收人姓名
  province VARCHAR(16),       #省
  city VARCHAR(16),           #市
  county VARCHAR(16),         #县
  address VARCHAR(255),       #详细地址
  phone VARCHAR(16),          #手机
  postcode VARCHAR(6),        #邮编
  is_default BOOLEAN,         #是否为当前用户的默认收货地址
  FOREIGN KEY(user_id) REFERENCES porridge_user(uid)
);

/**用户订单**/
CREATE TABLE user_order(
  oid INT PRIMARY KEY AUTO_INCREMENT,      #订单编号
  user_id INT,                  #用户编号
  porridge_id INT,              #粥品编号
  count INT,                    #购买数量
  preferential DECIMAL(10,2),   #优惠金额
  total DECIMAL(10,2),          #消费金额
  note   VARCHAR(255),          #订单备注
  status INT,                   #订单状态  1-等待付款  2-已接单  3-制作中  4-运输中  5-已取消  6-订单完成
  orderTtime DATETIME,          #下单时间
  payMethod INT,                #付款方式  1-支付宝    2-微信
  payTime DATETIME,             #付款时间
  finishTime DATETIME,          #订单完成时间
  FOREIGN KEY(user_id) REFERENCES porridge_user(uid),
  FOREIGN KEY(porridge_id) REFERENCES porridges(pid)
);

/**购物车条目**/
CREATE TABLE shoppingcar(
  sid INT PRIMARY KEY AUTO_INCREMENT,      #购物车编号
  user_id INT,                #用户编号
  porridge_id INT,            #商品编号
  pTitle VARCHAR(255),        #商品标题
  pic VARCHAR(255),           #商品图片
  price DECIMAL(10,2),        #商品价格
  count INT,                  #购买数量
  isChecked BOOLEAN,          #是否已勾选，确定购买
  FOREIGN KEY(user_id) REFERENCES porridge_user(uid),
  FOREIGN KEY(porridge_id) REFERENCES porridges(pid)
);

/****轮播广告商品图****/
CREATE TABLE carousel(
  cid INT PRIMARY KEY AUTO_INCREMENT,     #轮播图编号
  cimg VARCHAR(255)                       #轮播图路径
);


/******数据导入******/


INSERT INTO porridge_category VALUES
(NULL,'水果粥类'),
(NULL,'良品甜粥'),
(NULL,'生滚咸粥'),
(NULL,'海鲜粥类'),
(NULL,'主食小吃'),
(NULL,'优选套餐');


INSERT INTO porridges VALUES
(NULL,1,'冰糖雪梨粥','冰糖雪梨粥是以大米、雪梨、冰糖为主料，蜜玫瑰为辅料的粥品','冰糖、雪梨、大米','../public/image/btxlz.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,1,'什锦水果粥','小朋友的最爱，清新爽口，解暑，营养健康','苹果、菠萝、香梨、火龙果','../public/image/sjsgz.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,1,'清新黄桃粥','营养美味，富含矿物质，酸甜可口','黄桃、大米','../public/image/qxhtz.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,1,'冰糖雪梨粥','冰糖雪梨粥是以大米、雪梨、冰糖为主料，蜜玫瑰为辅料的粥品','冰糖、雪梨、大米','../public/image/btxlz.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,1,'什锦水果粥','小朋友的最爱，清新爽口，解暑，营养健康','苹果、菠萝、香梨、火龙果','../public/image/sjsgz.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,1,'清新黄桃粥','营养美味，富含矿物质，酸甜可口','黄桃、大米','../public/image/qxhtz.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,2,'南瓜百合粥','运用最简单的制作手法,制作出滋润补体的清粥，营养丰富。具有清火,润肺,通便等功效','南瓜、百合、大米','../public/image/ngbhz.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,2,'薏米茯苓紫薯粥','薏米和紫薯的绝美搭配，既营养又美味，入口使人回味无穷','薏米、紫薯、大米','../public/image/ymzsz.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,2,'十谷米','十谷米意为五谷添加在一起熬制而成，将营养集中熬制','薏米、黑米、燕麦、红豆等','../public/image/sgm.png','10','1000','100',false,null,null,null),
(NULL,2,'八宝粥','具有健脾养胃，消滞减肥，益气安神的功效，可作为日常养生健美之食品','红豆、红枣、花生、黑米等','../public/image/bbz.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,3,'皮蛋瘦肉粥','口感顺滑,易消化,含的粗纤维成分,深受广大用户的喜爱','皮蛋、猪肉、大米','../public/image/pdszz.png','10','1000','100',false,null,null,null),
(NULL,3,'鸡肉粥','完全熟透、鲜嫩又不失嚼劲的鸡肉丝，配上麦米粥底，视觉味觉双层享受','鸡肉、枸杞、大米','../public/image/jzr.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,3,'皮蛋瘦肉粥','口感顺滑,易消化,含的粗纤维成分,深受广大用户的喜爱','皮蛋、猪肉、大米','../public/image/pdszz.png','10','1000','100',false,null,null,null),
(NULL,3,'鸡肉粥','完全熟透、鲜嫩又不失嚼劲的鸡肉丝，配上麦米粥底，视觉味觉双层享受','鸡肉、枸杞、大米','../public/image/jzr.png','10','1000','100',false,null,null,null),
(NULL,3,'皮蛋瘦肉粥','口感顺滑,易消化,含的粗纤维成分,深受广大用户的喜爱','皮蛋、猪肉、大米','../public/image/pdszz.png','10','1000','100',false,null,null,null),
(NULL,3,'鸡肉粥','完全熟透、鲜嫩又不失嚼劲的鸡肉丝，配上麦米粥底，视觉味觉双层享受','鸡肉、枸杞、大米','../public/image/jzr.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,4,'海鲜鲍鱼粥','营养价值高的鲍鱼，将熬煮好的谷米盛放在容器内，给人极高的食欲','鲍鱼、鲜虾、大米','../public/image/hxbyz.png','10','1000','100',false,null,null,null),
(NULL,4,'海参粥','海参晶莹剔透，剥好的饱满虾肉围绕香滑绵稠的麦米粥，色彩明亮，口感丰富','海参、虾肉、大米','../public/image/hsz.png','10','1000','100',false,null,null,null),
(NULL,4,'干贝虾仁粥','咸鲜 新鲜食材，生滚熬制，营养丰富','干贝、虾仁、鱼片等','../public/image/gbxrz.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,4,'海鲜鲍鱼粥','营养价值高的鲍鱼，将熬煮好的谷米盛放在容器内，给人极高的食欲','鲍鱼、鲜虾、大米','../public/image/hxbyz.png','10','1000','100',false,null,null,null),
(NULL,4,'海参粥','海参晶莹剔透，剥好的饱满虾肉围绕香滑绵稠的麦米粥，色彩明亮，口感丰富','海参、虾肉、大米','../public/image/hsz.png','10','1000','100',true,'2021-7-13','2021-8-5','8'),
(NULL,4,'干贝虾仁粥','咸鲜 新鲜食材，生滚熬制，营养丰富','干贝、虾仁、鱼片等','../public/image/gbxrz.png','10','1000','100',true,'2021-7-13','2021-8-5','8');


INSERT INTO evaluate VALUES
(1,'张三','冰糖雪梨粥太好喝了,还很实惠',NULL),
(2,'李四','八宝粥太好喝了,还很实惠',NULL),
(3,'田熊','海参粥太好喝了,还很实惠',NULL),
(4,'王二','干贝虾仁粥太好喝了,还很实惠',NULL);


INSERT INTO porridge_user VALUES
(NULL,'张三','15112345678','zhangsan@qq.com','123456','../public/user/user_1.jpg',1,true),
(NULL,'李四','15112345678','lisisi@qq.com','123456','../public/user/user_2.jpg',1,true),
(NULL,'田熊','15112345678','tianxiong@qq.com','123456','../public/user/user_1.jpg',1,false),
(NULL,'王二','15112345678','wanger@qq.com','123456','../public/user/user_1.jpg',1,false);


INSERT INTO receiver_address VALUES
(NULL,1,'张三','河南省','郑州市','金水区','河南省郑州市金水区芯互联大厦1601室','15112345678','450000',true),
(NULL,2,'李四','河南省','郑州市','金水区','河南省郑州市金水区芯互联大厦1602室','15122345678','450000',true),
(NULL,3,'田熊','河南省','郑州市','金水区','河南省郑州市金水区芯互联大厦1603室','15132345678','450000',true),
(NULL,4,'王二','河南省','郑州市','金水区','河南省郑州市金水区芯互联大厦1604室','15142345678','450000',true);


INSERT INTO user_order VALUES
(NULL,1,1,2,'4.00','16.00','餐具两双',6,'2021-07-14 10:00:00',1,'2021-07-14 10:00:00','2021-07-14 12:00:00');



INSERT INTO shoppingcar VALUES
(NULL,1,1,'冰糖雪梨粥','../public/image/btxlz.png',2,false);
