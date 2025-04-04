package com.exadel.training.devops.docker;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller
{

    @GetMapping("/hello")
    public String hello()
    {
        return "Hello, World!";
    }

    @GetMapping("/devops-name")
    public String devopsName()
    {
        return System.getenv("DEVOPS_NAME");
    }

    @GetMapping("/goodbye")
    public String goodbye()
    {
        return "Goodbye, World!";
    }
}
