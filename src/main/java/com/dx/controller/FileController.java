package com.dx.controller;

import com.dx.method.one.demo1;
import com.dx.method.two.Main;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @ClassName FileController
 * @Description 文件上传
 * @Author dx
 * @Date 2022/10/12 20:50
 */
@Controller
public class FileController {

    @PostMapping("/upload")
    public ModelAndView upload(MultipartFile file, String name) throws IOException {
        String path = "E:\\" + UUID.randomUUID().toString().replace("-", "") + file.getOriginalFilename();
        System.out.println("name:" + name);
        file.transferTo(new File(path));
        ModelAndView mav = new ModelAndView();
        if ("1".equals(name)) {
            demo1.start1(path);
            List<String> input = input("E:\\output.txt");
            mav.addObject("details", input);
            mav.addObject("method", "主程序-子程序软件体系结构");
            mav.setViewName("results");
            return mav;

        } else if ("2".equals(name)) {
            Main.start2(path);
            List<String> input = input("E:\\output.txt");
            mav.addObject("details", input);
            mav.addObject("method", "面向对象软件体系结构");
            mav.setViewName("results");
            return mav;

        } else if ("3".equals(name)) {
            com.dx.method.three.Main.start3(path);
            List<String> input = input("E:\\output.txt");
            mav.addObject("details", input);
            mav.addObject("method", "事件系统软件体系结构");
            mav.setViewName("results");
            return mav;

        } else if ("4".equals(name)) {
            com.dx.method.four.Main.start4(path);
            List<String> input = input("E:\\output.txt");
            mav.addObject("details", input);
            mav.addObject("method", "管道-过滤软件体系结构");
            mav.setViewName("results");
            return mav;

        }
        return null;

    }

    public List<String> input(String fileName) {
        BufferedReader inputFile = null;
        ArrayList<String> lineTxt = new ArrayList<String>();
        try {
            inputFile = new BufferedReader(new FileReader(fileName));
        } catch (Exception e) {
            e.printStackTrace();
        }
        String line;
        try {
            while ((line = inputFile.readLine()) != null) {
                lineTxt.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return lineTxt;
    }
}
