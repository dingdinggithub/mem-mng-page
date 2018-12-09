package com.kevin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * @author 丁海峰
 * @DateTime 2018/11/30 23:30
 * @Description
 */
@Controller
public class PageController {

    @GetMapping(value = "page/{pagePath}")
    public String page(@PathVariable("pagePath") String pagePath, String module, Model model) {
        model.addAttribute("module", module);
        return pagePath;
    }

}
