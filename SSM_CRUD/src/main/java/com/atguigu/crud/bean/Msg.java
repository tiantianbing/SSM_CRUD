package com.atguigu.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @author zhao
 * @creat 2022--02--07  16:10
 */
public class Msg {
    //100表示成功，200表示失败
    private Integer code;
    private String message;
    private Map<String,Object> extend = new HashMap<>();

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMessage("处理成功");
        return msg;
    }
    public static Msg fail(){
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMessage("处理失败");
        return msg;
    }
    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }
}
