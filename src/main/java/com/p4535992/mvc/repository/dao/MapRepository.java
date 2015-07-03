package com.p4535992.mvc.repository.dao;

import com.p4535992.mvc.object.model.site.Marker;
import org.openrdf.repository.RepositoryConnection;

import java.sql.Connection;

/**
 * Created by 4535992 on 11/06/2015.
 */
public interface MapRepository {

    Marker createMarkerFromGeoDocument(String url);

    RepositoryConnection getSesameLocalConnection();
    RepositoryConnection getSesameRemoteConnection();
    Connection getMySQLConnection();
    String getResponseHTMLString();

}
