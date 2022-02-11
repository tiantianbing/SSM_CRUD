package com.atguigu.crud.service;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author zhao
 * @creat 2022--02--08  17:49
 */
@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;
    /**
     * 查找所有部门信息
     */
    public List<Department> getDepts(){
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
