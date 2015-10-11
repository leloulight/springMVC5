
var uploader = {
    // Get a list of marker with coordinates and a url href and put the marker on the map
    init: function () {
        init();
    }
};

function init(){
    var upload_button = function (el) {
        var uploader = document.getElementById(el);

        var handleFiles = function () {
            if(uploader.en)
            parseGtfs(this.files[0], {
                'shapes.txt': load_shapes
                //'stops.txt': load_stops
            });
        };

        uploader.addEventListener("change", handleFiles, false);
    };
}