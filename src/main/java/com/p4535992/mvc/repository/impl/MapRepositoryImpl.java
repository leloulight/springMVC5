package com.p4535992.mvc.repository.impl;

import com.p4535992.mvc.repository.dao.MapRepository;
import org.openrdf.OpenRDFException;
import org.openrdf.query.*;
import org.openrdf.repository.RepositoryConnection;
import org.openrdf.repository.RepositoryException;
import org.openrdf.repository.http.HTTPRepository;
import org.openrdf.repository.sail.SailRepository;
import org.openrdf.sail.memory.MemoryStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import java.io.File;
import java.sql.*;

/**
 * Created by Marco on 11/06/2015.
 */
@Repository
@Scope("singleton")
public class MapRepositoryImpl implements MapRepository {


    private static String repositoryID;
    private static String dataDir;
    private org.openrdf.repository.RepositoryConnection repositoryConnection;
    private org.openrdf.repository.Repository repository;
    private static String sesameServer;

    @Autowired
    public MapRepositoryImpl(
            @Value("${sesameRepositoryID}") String repositoryID,
            @Value("${sesameDataDir}") String dataDir,
            @Value("${sesameServer}") String sesameServer){
        MapRepositoryImpl.repositoryID = repositoryID;
        MapRepositoryImpl.dataDir = dataDir;
        MapRepositoryImpl.sesameServer = sesameServer;
    }


    @Value("${db}")
    private String db;
    @Value("${url}")
    private String url;
    @Value("${user}")
    private String user;
    @Value("${pass}")
    private String pass;




    @Override
    public RepositoryConnection getSesameLocalConnection() {
        try {
            File dataDir2 = new File(dataDir + File.separator + repositoryID + File.separator);
            repository = new SailRepository( new MemoryStore(dataDir2) );
            repository.initialize();
            repositoryConnection = repository.getConnection();

        } catch (RepositoryException e) {
            e.printStackTrace();
        }
        return repositoryConnection;
    }

    @Override
    public RepositoryConnection getSesameRemoteConnection() {
        try {
            repository = new HTTPRepository(sesameServer, repositoryID);
            repository.initialize();
            repositoryConnection = repository.getConnection();
        } catch (RepositoryException e1) {
            e1.printStackTrace();
        }
        return repositoryConnection;
    }

    private String testCategoryHTML;

    @Override
    public Connection getMySQLConnection(){
        Connection conMySQL = null;
        Statement st = null;
        ResultSet rs = null;

        Connection conMySQL2 = null;
        Statement st2 = null;
        ResultSet rs2 = null;

        StringBuilder builder = new StringBuilder();
        try {
            // POPOLAZIONE DEI CHECKBOX DELLE SERVICE CATEGORY E DELLE SOTTOCATEGORIE
            String urlMySQL = url + db;
            String suser = user;
            String spass = pass;
            Class.forName("com.mysql.jdbc.Driver");
            conMySQL = DriverManager.getConnection(url + db, suser, spass);

            String query = "SELECT * FROM tbl_service_category ORDER BY ID ASC";

            // create the java statement
            st = conMySQL.createStatement();

            // execute the query, and get a java resultset
            rs = st.executeQuery(query);

            // iterate through the java resultset
            while (rs.next()) {
                String id = rs.getString("ID");
                String nome = rs.getString("NOME");
                String colore = rs.getString("COLORE");
                String en_name = rs.getString("EN_NAME");
                String classe = rs.getString("CLASS");

                builder.append("<input type='checkbox' name='" + en_name + "' value='" + en_name + "' class='macrocategory' /> <span class='" + classe + " macrocategory-label'>" + nome + "</span> <span class='toggle-subcategory' title='Mostra sottocategorie'>+</span>\n");
                builder.append("<div class='subcategory-content'>\n");

                conMySQL2 = DriverManager.getConnection(url + db, user, pass);

                String query2 = "SELECT * FROM tbl_service_subcategory WHERE IDCATEGORY = " + id + " ORDER BY ID ASC";

                // create the java statement
                st2 = conMySQL2.createStatement();

                // execute the query, and get a java resultset
                rs2 = st2.executeQuery(query2);

                // iterate through the java resultset
                while (rs2.next()) {
                    String sub_nome = rs2.getString("NOME");
                    String sub_en_name = rs2.getString("EN_NAME");
                    String sub_numero = rs2.getString("NUMERO");

                    builder.append("<input type='checkbox' name='" + sub_nome + "' value='" + sub_nome + "' class='sub_" + classe + " subcategory' />\n");
                    builder.append("<span class='" + classe + " subcategory-label'>" + sub_numero + "- " + sub_nome + "</span>\n");
                    builder.append("<br />\n");
                }
                builder.append("</div>\n");
                builder.append("<br />\n");

                st2.close();
                conMySQL2.close();
            }
            st.close();
            conMySQL.close();
        }catch(SQLException e){
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally{
            testCategoryHTML = builder.toString();
        }
        return conMySQL;
    }

    @Override
    public String getResponseHTMLString() {
        getMySQLConnection();
        return testCategoryHTML;
    }

    public String invokeMain(){
        getSesameRemoteConnection();
        StringBuilder builder = new StringBuilder();
        try {
            try {
                String queryString = "PREFIX :<http://www.disit.dinfo.unifi.it/SiiMobility#> " +
                        "SELECT DISTINCT ?serviceCategory WHERE { " +
                        "?service :serviceCategory ?serviceCategory . " +
                        "} " +
                        "ORDER BY ?serviceCategory ";

                //  out.println(queryString);
                TupleQuery tupleQuery = repositoryConnection.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
                TupleQueryResult result = tupleQuery.evaluate();
                try {
                    while (result.hasNext()) {
                        BindingSet bindingSet = result.next();
                        org.openrdf.model.Value valueOfServiceCategory = bindingSet.getValue("serviceCategory");
                        builder.append(
                                "<option value='" + valueOfServiceCategory.toString().replace("<http://www.w3.org/2001/XMLSchema#string>", "xsd:string")
                                        + "'>" + valueOfServiceCategory.toString() + "</option>\n");
                    }
                }
                finally {
                    result.close();
                }
            }
            finally {
                repositoryConnection.close();
            }
        }
        catch (OpenRDFException e) {
            // handle exception
            builder.append(e.getMessage());
        }
        return builder.toString();
    }

    public String invokeQuery(){
        getSesameRemoteConnection();
        StringBuilder builder = new StringBuilder();

//        String via = request.getParameter("via");
//        String tipo = request.getParameter("tipo");
        String tipo = "";
        String via ="";
        if (tipo == ""){
            tipo = "?serviceCategory";
        }
        else{
            tipo = tipo.toString();
        }
            String queryString =
                "PREFIX :<http://www.disit.dinfo.unifi.it/SiiMobility#>" +
                "PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>" +
                "PREFIX vcard:<http://www.w3.org/2006/vcard/ns#> ";
        try {
            try {
                if (tipo == "?serviceCategory"){
                    queryString = queryString + " SELECT DISTINCT ?orgName ?streetAddress ?serviceCategory WHERE { " +
                            " ?road :extendName '" + via.toUpperCase() + "'^^xsd:string . " +
                            " 	?service :isIn ?road . " +
                            " 	?road rdf:type :Road . " +
                            "  ?service vcard:organization-name ?orgName . " +
                            "  ?service vcard:street-address ?streetAddress . " +
                            "  ?service :serviceCategory " + tipo + " . " +
                            " } ";
                }
                else{
                    queryString = queryString + " SELECT DISTINCT ?orgName ?streetAddress WHERE { " +
                            " ?road :extendName '" + via.toUpperCase() + "'^^xsd:string . " +
                            " 	?service :isIn ?road . " +
                            " 	?road rdf:type :Road . " +
                            "  ?service vcard:organization-name ?orgName . " +
                            "  ?service vcard:street-address ?streetAddress . " +
                            "  ?service :serviceCategory " + tipo + " . " +
                            " } ";
                }
                TupleQuery tupleQuery = repositoryConnection.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
                TupleQueryResult result = tupleQuery.evaluate();
                try {
                    builder.append("<table>\n");
                    builder.append("<tr>\n");
                    builder.append("<td>Nome Servizio</td>\n");
                    builder.append("<td>Indirizzo</td>\n");
                    builder.append("<td>Tipo Servizio</td>\n");
                    builder.append("</tr>\n");

                    while (result.hasNext()) {

                        builder.append("<tr>\n");
                        BindingSet bindingSet = result.next();

                        org.openrdf.model.Value valueOfOrgName = bindingSet.getValue("orgName");
                        org.openrdf.model.Value valueOfStreetAddress = bindingSet.getValue("streetAddress");
                        org.openrdf.model.Value valueOfServiceCategory = null;
                        if (tipo == "?serviceCategory"){
                            valueOfServiceCategory = bindingSet.getValue("serviceCategory");
                        }


                        builder.append("<td>" + valueOfOrgName.toString() + "</td>\n");
                        builder.append("<td>" + valueOfStreetAddress.toString() + "</td>\n");
                        if (tipo == "?serviceCategory"){
                            builder.append("<td>" + valueOfServiceCategory.toString() + "</td>\n");
                        }
                        else{
                            builder.append("<td>" + tipo + "</td>\n");
                        }


                        builder.append("</tr>\n");
                    }
                    builder.append("</table>\n");

                }
                finally {
                    result.close();

                }
            } catch (RepositoryException|QueryEvaluationException|MalformedQueryException e) {
                e.printStackTrace();
            } finally {
                repositoryConnection.close();
            }
        }
        catch (OpenRDFException e) {
            // handle exception
            builder.append(e.getMessage());
        }
        return builder.toString();
    }


}
