package com.atguigu.crud.controller;

/**
 * @author zhao
 * @creat 2022--02--06  22:21
 */

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;
    /**
     * 查询所有员工数据，分页实现
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pageNo",defaultValue = "1") Integer pageNo, Model model){
        //指定开始页码pageNo，每页记录数pageSize
        PageHelper.startPage(pageNo,5);
        //使用PageInfo封装查询后的结果,指定要连续显示的页数navigatePages
        List<Employee> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }

    /**
     * 显示所有员工信息
     * @param pageNo
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "pageNo",defaultValue = "1")Integer pageNo){
        //指定开始页码pageNo，每页记录数pageSize
        PageHelper.startPage(pageNo,5);
        //使用PageInfo封装查询后的结果,指定要连续显示的页数navigatePages
        List<Employee> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 新增员工信息
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg addEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败，应返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else {
            employeeService.addEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检验员工是否已经存在
     * @return
     */
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        //先进行用户名合法性的检验，再判断是否已经有该员工
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("check_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }
        boolean isExist = employeeService.checkUser(empName);
        if (isExist){
            return Msg.success();
        }else {
            return Msg.fail().add("check_msg","该员工已存在");
        }
    }

    /**
     * 根据id查询员工信息
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /**
     * 修改员工信息
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据id删除员工信息,批量删除或者单个删除
     * @param id 批量:1,2,3   单个:5
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("id") String id){
        ArrayList<Integer> ids = new ArrayList<>();
        if (id.contains(",")){
            //批量删除
            String[] strs = id.split(",");
            for (String s : strs) {
                ids.add(Integer.parseInt(s));
            }
            employeeService.deleteEmps(ids);
        }else {
            //单个删除
            employeeService.deleteEmp(Integer.parseInt(id));

        }
        return Msg.success();
    }
}
