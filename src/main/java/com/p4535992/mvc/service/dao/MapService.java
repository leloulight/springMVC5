package com.p4535992.mvc.service.dao;

import org.openrdf.repository.RepositoryConnection;

import java.sql.Connection;

/**
 * Created by 4535992 on 11/06/2015.
 */
public interface MapService {

    RepositoryConnection getSesameLocalConnection();
    RepositoryConnection getSesameRemoteConnection();
    Connection getMySQLConnection();
    String getResponseHTMLString();
}
