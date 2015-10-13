package com.github.p4535992.mvc.controller;

import com.github.p4535992.mvc.object.model.site.Marker;
import com.github.p4535992.mvc.service.dao.MapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 4535992 on 11/06/2015.
 * @author 4535992.
 * @version 2015-07-02.
 */
@Controller
@PreAuthorize("hasRole('ROLE_USER')")
public class MapController {

    @Autowired
    MapService mapService;

    Marker marker;
    List<Marker> arrayMarker = new ArrayList<>();
    Integer indiceMarker = 0;

    /*@RequestMapping(value="/map",method= RequestMethod.GET)
    public String loadMap1(Model model){
        String html = mapService.getResponseHTMLString();
        return "riconciliazione2/mappa/map";
    }

    @RequestMapping(value="/map",method = RequestMethod.POST)
    public String result(@RequestParam(required=false, value="urlParam")String url,Model model){
        System.out.println("url: " + url);
        return "home";
    }*/

    @RequestMapping(value="/map",method= RequestMethod.GET)
    public String loadMap2(Model model){
        //String html = mapService.getResponseHTMLString();
        //Site siteForm = new Site();
        //model.addAttribute("siteForm",siteForm);
        if(!arrayMarker.isEmpty() && marker!=null){
            model.addAttribute("marker",marker);
            model.addAttribute("arrayMarker",arrayMarker);
            model.addAttribute("indiceMarker",indiceMarker);
            model.addAttribute("urlParam",null);
        }else{
            //arrayMarker.add(marker);
            model.addAttribute("marker",null);
            model.addAttribute("arrayMarker",null);
            model.addAttribute("urlParam",null);
        }
        return "riconciliazione2/mappa/leafletMap";
    }

    /*@RequestMapping(value="/map2",method = RequestMethod.POST)
    public String result2(@RequestParam(required=false, value="urlParam")String url){
        String[] splitter;
        if(url.contains(",")) {
            splitter = url.split(",");
            url = splitter[splitter.length];
        }

        System.out.println("url: " + url);
        marker = mapService.createMarkerFromGeoDocument(url);
        // = new Marker("City",url,"43.3555664", "11.0290384");
        //model.addAttribute("marker",marker); //no need is get from the HTTTP GET COMMAND
        arrayMarker.add(marker);
        indiceMarker++;
        return "redirect:/map2";
    }*/

    /*@RequestMapping(value="/map22",method = RequestMethod.POST)
    public String result3(
            @RequestParam(required=false, value="urlParam")String url,
            @ModelAttribute(value="markerParam")Marker markerFromJS){
        marker = null;
        System.out.println("url: " + url);
        //return to the loadMap2
        return "redirect:/map2";
        //return result2(url,model);
    }*/

    @RequestMapping(value="/map3",method = RequestMethod.POST)
    public String result4(@RequestParam(required=false, value="urlParam")String url,
                          @ModelAttribute(value="markerParam")Marker markerFromJS){
        String[] splitter;
        if(url.contains(",")) {
            splitter = url.split(",");
            url = splitter[0];
        }

        System.out.println("url: " + url);
        marker = mapService.createMarkerFromGeoDocument(url);
        // = new Marker("City",url,"43.3555664", "11.0290384");
        //model.addAttribute("marker",marker); //no need is get from the HTTTP GET COMMAND
        arrayMarker.add(marker);
        indiceMarker++;
        return "redirect:/map2";
    }

    @RequestMapping(value="/map4",method = RequestMethod.POST)
    public String result(@RequestParam(required=false, value="nameParam1")String name,
                         @RequestParam(required=false, value="latParam1")String lat,
                         @RequestParam(required=false, value="lngParam1")String lng,
                         @RequestParam(required=false, value="descriptionParam1")String description,
                         Model model){

        System.out.println("name: " + name +",lat:"+lat+",lng:"+lng+",description:"+description);
        return "home";
    }


    //----------------------------------------------
    //NEW METHOD
    //----------------------------------------------












}
