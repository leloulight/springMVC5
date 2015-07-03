package com.p4535992.mvc.controller;

import com.p4535992.mvc.object.model.site.Marker;
import com.p4535992.mvc.service.dao.MapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    @RequestMapping(value="/map",method= RequestMethod.GET)
    public String loadMap1(Model model){
        String html = mapService.getResponseHTMLString();
        return "riconciliazione2/mappa/map";
    }

    @RequestMapping(value="/map",method = RequestMethod.POST)
    public String result(@RequestParam(required=false, value="urlParam")String url,Model model){
        System.out.println("url: " + url);
        return "home";
    }

    @RequestMapping(value="/map2",method= RequestMethod.GET)
    public String loadMap2(Model model){
        //String html = mapService.getResponseHTMLString();
        //Site siteForm = new Site();
        //model.addAttribute("siteForm",siteForm);
        if(marker != null){
            model.addAttribute("marker",marker);
        }else{
            model.addAttribute("marker",null);
        }
        return "riconciliazione2/mappa/leafletMap";
    }

    @RequestMapping(value="/map2",method = RequestMethod.POST)
    public String result2(@RequestParam(required=false, value="urlParam")String url, Model model){
        System.out.println("url: " + url);
        marker = mapService.createMarkerFromGeoDocument(url);
        // = new Marker("City",url,"43.3555664", "11.0290384");
        //model.addAttribute("marker",marker);
        return "redirect:/map2";
    }

    @RequestMapping(value="/map22",method = RequestMethod.POST)
    public String result3(
            @RequestParam(required=false, value="urlParam")String url,
            @ModelAttribute(value="markerParam")Marker marker,
            Model model){

        System.out.println("url: " + url+",marker:"+marker.toString());
        //marker = new Marker("City",url,"43.3555664", "11.0290384");
        return "redirect:/map2";
    }













}
