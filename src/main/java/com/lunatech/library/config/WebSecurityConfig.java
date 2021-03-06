package com.lunatech.library.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.security.oauth2.resource.AuthoritiesExtractor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.authority.AuthorityUtils;

import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/*", // this will allow the frontend to come up
                "/src/resources/*",
                "/v2/api-docs", "/configuration/ui", "/swagger-resources/**", "/configuration/**", "/swagger-ui.html", "/webjars/**");

//        web.ignoring().antMatchers("/**");
    }

    @Bean
    public AuthoritiesExtractor authoritiesExtractor(
            @Value("#{'${security.allowed.domains}'.split(',')}") final List<String> allowedDomains) {

        return (Map<String, Object> map) -> {
            String[] emailparts =
                    ((String) map.get("email"))
                            .split("@");

            String emaildomain = Stream.of(emailparts)
                    .reduce((first, second) -> second).orElse("***__***");

            if (!allowedDomains.contains(emaildomain)) {
                throw new BadCredentialsException("Not an allowed domain");
            }
            return AuthorityUtils.commaSeparatedStringToAuthorityList("ROLE_USER");
        };
    }
}