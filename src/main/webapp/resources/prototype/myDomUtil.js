function getContentInput(idContainer){
    try {
        var elements = document.getElementById(idContainer).getElementsByTagName('input');
        var images = document.getElementById(idContainer).getElementsByTagName('img');
        var cats = [];
        for (var i = 0; i < elements.length; i++) {
            var sCat = {};
            var el = elements[i];
            var cat = {clazz: el.className, value: el.value, name: el.name, img: images[i].src};
            sCat[i] = cat;
            cats.push(sCat);
        }
        var json = {categories:cats};
        console.error(JSON.stringify(json));
    }catch(e){
        console.error(e.message);
    }
}

