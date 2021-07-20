// 加载Express模块
const express = require('express');

// 加载MySQL模块
const mysql = require('mysql');

// 加载bodyParser模块  post请求接收参数
const bodyParser = require('body-parser');

// 加载MD5模块  加密
const md5 = require('md5');

// 创建MySQL连接池
const pool = mysql.createPool({
  host: '127.0.0.1',   //MySQL服务器地址
  port: 3306,          //MySQL服务器端口号
  user: 'root',        //数据库用户的用户名
  password: '',        //数据库用户密码
  database: 'porridge',    //数据库名称
  connectionLimit: 20, //最大连接数
  charset: 'utf8'      //数据库服务器的编码方式
});

// 创建服务器对象
const server = express();

server.use(bodyParser.urlencoded({
  extended: false
}));


// 加载CORS模块
const cors = require('cors');

// 使用CORS中间件
server.use(cors({
  origin: ['http://localhost:8080', 'http://127.0.0.1:8080']
}));

// 获取所有porridge菜单导航分类的接口
server.get('/category', (req, res) => {
  // SQL语句以获取文章分类表的数据
  let sql = 'SELECT pcid,pcname FROM porridge_category ORDER BY pcid';
  // 执行SQL语句
  pool.query(sql, (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results });
  });
});

// 获取指定菜单导航分类下包含粥品数据的接口
server.get('/porridges', (req, res) => {
  // 获取客户端传递的pcid参数
  let pcid = req.query.pcid;

  // 查询sql语句
  let sql = 'SELECT pid,pTitle,pic,price,soldNum,pNum FROM porridges WHERE pCategory_id=?';

  pool.query(sql, [pcid], (error, results) => {
    if (error) throw error;
    res.send({ message: 'ok', code: 200, results: results[0] });
  });

});

// 获取特定粥品数据的接口
server.get('/detail', (req, res) => {
  //获取地址栏中的pid参数
  let pid = req.query.pid;

  // SQL查询
  let sql = "SELECT pid,pTitle,pDetails,pIngredient,pic,price,soldNum,pNum,isDiscount,dPrice FROM porridges WHERE pid=?";

  // 执行SQL查询
  pool.query(sql, [pid], (error, results) => {
    if (error) throw error;
    // 返回数据到客户端
    res.send({ message: 'ok', code: 200, result: results[0] });
  });

});

//用户注册接口

//用户注册接口
server.post('/register', (req, res) => {
  //console.log(md5('12345678'));
  // 获取用户名和密码信息
  let uname = req.body.uname;
  let upwd = req.body.upwd;
  //以uname为条件进行查找操作，以保证用户名的唯一性
  let sql = 'SELECT COUNT(uid) AS count FROM porridge_user WHERE uname=?';
  pool.query(sql, [uname], (error, results) => {
    if (error) throw error;
    let count = results[0].count;
    if (count == 0) {
      // 将用户的相关信息插入到数据表
      sql = 'INSERT porridge_user(uname,upwd) VALUES(?,MD5(?))';
      pool.query(sql, [uname, upwd], (error, results) => {
        if (error) throw error;
        res.send({ message: 'ok', code: 200 });
      })
    } else {
      res.send({ message: 'user exists', code: 201 });
    }
  });
});


// 用户登录接口
server.post('/login', (req, res) => {
  //获取用户名和密码信息
  let uname = req.body.uname;
  let upwd = req.body.upwd;
  // SQL语句
  let sql = 'SELECT * FROM porridge_user WHERE uname=? AND upwd=MD5(?)';
  pool.query(sql, [uname, upwd], (error, results) => {
    if (error) throw error;
    if(results.length == 0){ //登录失败
      res.send({message:'login failed',code:201});
    } else {                 //登录成功
      res.send({message:'ok',code:200,result:results[0]});
    }
  });

});


// 指定服务器对象监听的端口号
server.listen(3000, () => {
  console.log('server is running...');
});