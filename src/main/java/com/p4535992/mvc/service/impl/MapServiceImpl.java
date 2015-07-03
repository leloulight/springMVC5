package com.p4535992.mvc.service.impl;

import com.p4535992.mvc.object.model.site.Marker;
import com.p4535992.mvc.repository.dao.MapRepository;
import com.p4535992.mvc.service.dao.MapService;
import org.openrdf.repository.RepositoryConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Connection;

/**
 * Created by 4535992 on 11/06/2015.
 */
@Service
public class MapServiceImpl implements MapService{

    @Autowired
    MapRepository mapRepository;

    @Override
    public RepositoryConnection getSesameLocalConnection() {
        return mapRepository.getSesameLocalConnection();
    }

    @Override
    public RepositoryConnection getSesameRemoteConnection() {
        return mapRepository.getSesameRemoteConnection();
    }

    @Override
    public Connection getMySQLConnection() {
        return mapRepository.getMySQLConnection();
    }

    @Override
    public String getResponseHTMLString() {
        return mapRepository.getResponseHTMLString();
    }

    @Override
    public Marker createMarkerFromGeoDocument(String url){
        return mapRepository.createMarkerFromGeoDocument(url);
    }
}
