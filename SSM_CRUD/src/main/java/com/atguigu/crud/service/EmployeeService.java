package com.atguigu.crud.service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author zhao
 * @creat 2022--02--06  22:20
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工信息
     * @return
     */
    public List<Employee> getAll(){
        //防止新增员工的id不按照顺序排列
        EmployeeExample example = new EmployeeExample();
        example.setOrderByClause("emp_id");
        List<Employee> emps = employeeMapper.selectByExampleWithDept(example);
        return emps;
    }

    /**
     * 新增员工信息
     * @param employee
     */
    public void addEmp(Employee employee){
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检验用户是否已经存在
     * @return
     */
    public boolean checkUser(String empName){
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 根据id查询员工信息
     * @param id
     * @return
     */
    public Employee getEmp(Integer id){
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 修改员工信息
     * @param employee
     */
    public void updateEmp(Employee employee){
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 根据id删除员工信息
     * @param id
     */
    public void deleteEmp(Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 根据id列表批量删除员工信息
     * @param ids
     */
    public void deleteEmps(List<Integer> ids){
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }

}
