package com.atguigu.crud.test;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author zhao
 * @creat 2022--02--06  21:53
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-config.xml"})
public class MapperTest {
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testDeptMapper(){
        departmentMapper.insert(new Department(null,"开发部"));
        departmentMapper.insert(new Department(null,"测试部"));
    }
    @Test
    public void testEmpMapper(){
        employeeMapper.insertSelective(new Employee(null,"Tom","F","Tom@qq.com",2));
        //批量插入1000条记录
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String name = UUID.randomUUID().toString().substring(0,5);
            mapper.insertSelective(new Employee(null,name+i,"M",name+"@guigu.com",1));
        }
    }
}
