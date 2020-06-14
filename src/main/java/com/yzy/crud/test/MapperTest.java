package com.yzy.crud.test;

import com.yzy.crud.bean.Department;
import com.yzy.crud.bean.Employee;
import com.yzy.crud.dao.DepartmentMapper;
import com.yzy.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Random;
import java.util.UUID;


/**
 * 测试dao层的工作
 * 推荐Spring的项目使用Spring的单元测试，可自动注入我们需要的组件
 * 不过需要导入SpringTest模块
 *
 * @ContextConfiguration 指定Spring配置文件的位置
 * 直接Autowired要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD() {
        System.out.println("开始运行程序");
        /*
        //1.创建SpringIOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        //2.从容器中获取mapper
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
         */
//        System.out.println(departmentMapper);

//插入两个部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));

//        生成员工数据，测试员工插入
//        employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@atguigu.com",1));

//        批量插入多个员工，批量，使用可以执行批量操作的sqlSession

//        for(){
//            employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@atguigu.com",1));
//        }

//        批量添加
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 100; i++) {
            int deptId = new Random().nextInt(2) + 1;
            String uid = "臭猪"+(deptId%2==0?"兵":"妞")+UUID.randomUUID().toString().substring(0, 3)+"号";
            mapper.insertSelective(new Employee(null,uid,deptId%2==0?"M":"W",uid+"@qq.com",deptId));
        }

//        批量删除
//        for (int i = 0; i < 1001; i++) {
//            mapper.deleteByPrimaryKey(i);
//        }

//        int i = employeeMapper.deleteByPrimaryKey(1001);


        System.out.println("处理结束");


    }
}
