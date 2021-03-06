package com.adj.controler;

import java.util.Map;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.adj.service.impl.musicSingletonImpl;
import com.fasterxml.jackson.databind.ObjectMapper;


/**
 * Created by Adj on 2018-3-23.
 */
@WebServlet("/getsong")
public class getsongServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String word, check,  p;
        try{
            word = request.getParameter("word");
        }catch (Exception e){
            word = "青花瓷";
        }
        try{
            p = request.getParameter("p");
        }catch (Exception e){
            p = "1";
        }
        try{
            check = request.getParameter("check");
        }catch (Exception e){
            check = "no";
        }

        Map<String,Object>[] result = musicSingletonImpl.getInstance().getSongs(word, p, check);

        ObjectMapper mapper = new ObjectMapper();
        String data = mapper.writeValueAsString(result);
        System.out.println(data);

        response.getWriter().print(data.toString());
    }
    public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {
        doPost(req,res) ;
    }

}