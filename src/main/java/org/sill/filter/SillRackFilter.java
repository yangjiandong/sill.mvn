package org.sill.filter;

import org.apache.commons.lang.StringUtils;
import org.jruby.rack.RackFilter;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;

public class SillRackFilter extends RackFilter {

  private Set<String> exclusions;

  @Override
  public void init(FilterConfig config) throws ServletException {
    super.init(config);
    String[] exclusionsStr = StringUtils.split(config.getInitParameter("exclusions"), ',');
    exclusions = new HashSet<String>(Arrays.asList(exclusionsStr));
  }

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    HttpServletRequest httpRequest = (HttpServletRequest)request;
    String requestURI = httpRequest.getRequestURI();
    int extIndex = requestURI.lastIndexOf('.');
    String fileExtension = extIndex != -1 ? requestURI.substring(extIndex + 1, requestURI.length()) : null;
    if (fileExtension == null || !exclusions.contains(fileExtension)) {
      super.doFilter(request, response, chain);
    } else {
      chain.doFilter(request, response);
    }
  }

}
