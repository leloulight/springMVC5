package com.p4535992.mvc.repository.impl;

import com.p4535992.mvc.repository.dao.SesameRepository;
import org.openrdf.query.*;
import org.openrdf.repository.RepositoryConnection;
import org.openrdf.repository.RepositoryException;
import org.openrdf.repository.http.HTTPRepository;
import org.openrdf.repository.sail.SailRepository;
import org.openrdf.sail.memory.MemoryStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import java.io.File;

/**
 * Created by 4535992 on 10/06/2015.
 */
@Repository
public class SesameRepositoryImpl implements SesameRepository{

//    @Autowired
//    protected SesameConnectionFactory repositoryConnectionFactory;
//    @Autowired
//    protected SesameConnectionFactory repositoryManagerConnectionFactory;

    private static String repositoryID;
    private static String dataDir;
    private RepositoryConnection conn;

    @Autowired
    public SesameRepositoryImpl(@Value("${sesameRepositoryID}") String repositoryID,@Value("${sesameDataDir}")String dataDir){
        SesameRepositoryImpl.repositoryID = repositoryID;
        SesameRepositoryImpl.dataDir = dataDir;
    }

    @Override
    public RepositoryConnection getSesameConnection() {
        // Create a tuple query
        TupleQuery tupleQuery = null;
        try {
             /* String sesameServer = "http://localhost:8080/openrdf-sesame/";
                org.openrdf.repository.Repository repo = new HTTPRepository(sesameServer, repositoryID);
                try {
                    repo.initialize();
                    conn = repo.getConnection();
                } catch (RepositoryException e1) {
                    e1.printStackTrace();
                }*/

            File dataDir2 = new File(dataDir + repositoryID + File.separator);
            org.openrdf.repository.Repository repo = new SailRepository( new MemoryStore(dataDir2) );
            repo.initialize();
            conn = repo.getConnection();

        } catch (RepositoryException e) {
            e.printStackTrace();
        }catch(java.lang.NullPointerException e){
            System.err.println("No connection on the sesame server");

        } catch (Exception e) {
            if(e.getMessage().contains("No transaction active")){
                System.err.println("No connection on the sesame server");
                e.printStackTrace();
            }else{
                e.printStackTrace();
            }
        }
        return conn;
    }


    @Override
    public String getRepositoryID() {
        return repositoryID;
    }


    //APPUNTI JAVASCRIPT
    /*
    //JavaScript Code:
    var deleteWidgetId = new Array();
    //array created
    deleteWidgetId[0] = "a";
    //adding values
    deleteWidgetId[0] = "b";
    //action trigged
    $("#saveLayout").load("layout/saveLayout.action", { deleteWidgetId : deleteWidgetId }, function(response, status, xhr) { });

    //Java Code:(In controller class):
    @RequestMapping(value = "/saveLayout") public ModelAndView saveLayout(@RequestParam String[] deleteWidgetId) throws Exception {
     //here that if i try to use the deleteWidgetId it is giving null pointer exception
     }
    */
}
