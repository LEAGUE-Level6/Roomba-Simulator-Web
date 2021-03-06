/*
 * Copyright 2002-2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.example;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.codehaus.commons.compiler.CompileException;
import org.codehaus.janino.SimpleCompiler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.model.DriveDirect;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Controller
@SpringBootApplication
public class Main {

	@Value("${spring.datasource.url}")
	private String dbUrl;

	@Autowired
	private DataSource dataSource;

	public static void main(String[] args) throws Exception {
		SpringApplication.run(Main.class, args);
	}

	@RequestMapping("/")
	String index(@CookieValue(value = "maze", defaultValue = "level0") String maze) {
		System.out.println(maze);
		return "redirect:/maze/"+ maze;
	}
	
	@RequestMapping("/maze/{maze}")
	public String maze(HttpServletResponse response, @PathVariable("maze") String maze)
	{
		Cookie cookie = new Cookie("maze", maze);
		cookie.setMaxAge(365*24*60*60);
		cookie.setPath("/");
		response.addCookie(cookie);
		return "index";
	}

	@RequestMapping("/testjs")
	String testjs() {
		return "testjs";
	}

	@RequestMapping(path = "/runsim", method = RequestMethod.POST)
	ResponseEntity<String> runSimulation(@RequestBody String code) {
		System.out.println(code);
		SimpleCompiler compiler = new SimpleCompiler();
		try {
			compiler.cook(code);
		} catch (CompileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ClassLoader classloader = compiler.getClassLoader();
		try {
			Class<?> cl = classloader.loadClass("org.jointheleague.ecolban.cleverrobot.CleverRobot");
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		return ResponseEntity.ok("{'code':'" + code + "'}");
	}

	@RequestMapping(path = "/command")
	public @ResponseBody List<DriveDirect> command() {
		ArrayList<DriveDirect> commands = new ArrayList<>();
		commands.add(new DriveDirect());
		return commands;
	}

	@RequestMapping("/db")
	String db(Map<String, Object> model) {
		try (Connection connection = dataSource.getConnection()) {
			Statement stmt = connection.createStatement();
			stmt.executeUpdate("CREATE TABLE IF NOT EXISTS ticks (tick timestamp)");
			stmt.executeUpdate("INSERT INTO ticks VALUES (now())");
			ResultSet rs = stmt.executeQuery("SELECT tick FROM ticks");

			ArrayList<String> output = new ArrayList<String>();
			while (rs.next()) {
				output.add("Read from DB: " + rs.getTimestamp("tick"));
			}

			model.put("records", output);
			return "db";
		} catch (Exception e) {
			model.put("message", e.getMessage());
			return "error";
		}
	}

	@Bean
	public DataSource dataSource() throws SQLException {
		if (dbUrl == null || dbUrl.isEmpty()) {
			return new HikariDataSource();
		} else {
			HikariConfig config = new HikariConfig();
			config.setJdbcUrl(dbUrl);
			return new HikariDataSource(config);
		}
	}

}
