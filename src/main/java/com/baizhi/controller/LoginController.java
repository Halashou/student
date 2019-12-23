package com.baizhi.controller;

import com.baizhi.util.CpachaUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
@RequestMapping("login")
public class LoginController{
    @ResponseBody
    @RequestMapping("getCode")
    public String getCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        CpachaUtil cpachaUtil = new CpachaUtil();
        String generatorVCode = cpachaUtil.generatorVCode();
        request.getSession().setAttribute("code", generatorVCode);
        BufferedImage generatorRotateVCodeImage = cpachaUtil.generatorRotateVCodeImage(generatorVCode, true);
        ImageIO.write(generatorRotateVCodeImage, "gif", response.getOutputStream());
        return null;
    }
}
