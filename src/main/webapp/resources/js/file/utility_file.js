  //File Type Validation
  function readSingleFile(evt) {
    //Retrieve the first (and only!) File from the FileList object
    var f = evt.target.files[0];
    if (!f) {
        alert("Failed to load file");
    } else if (!file.type.match('text.*')) {
		    alert(f.name + ' is not a valid text file.');
    } else {
      var r = new FileReader();
      //proceed with read…
	  r.onload = function(e) { 
            var contents = e.target.result;
	        alert( "Got the file.n" 
	              +"name: " + f.name + "n"
	              +"type: " + f.type + "n"
	              +"size: " + f.size + " bytesn"
	              + "starts with: " + contents.substr(1, contents.indexOf("n"))
	        );  
	      };
	      r.readAsText(f);
	    }
  }
  
  //Reading Multiple Files and Properties Using a Closure
  //
  // document.getElementById('fileinput').addEventListener('change', readMultipleFiles, false);
  function readMultipleFiles(evt) {
    //Retrieve all the files from the FileList object
    var files = evt.target.files;
    if (files) {
        for (var i=0, f; f=files[i]; i++) {
	          var r = new FileReader();
            r.onload = (function(f) {
                return function(e) {
                    var contents = e.target.result;
                    alert( "Got the file.n" 
                          +"name: " + f.name + "n"
                          +"type: " + f.type + "n"
                          +"size: " + f.size + " bytesn"
                          + "starts with: " + contents.substr(1, contents.indexOf("n"))
                    ); 
                };
            })(f);

            r.readAsText(f);
        }   
    } else {
	      alert("Failed to load files"); 
    }
  }

  function handleFiles2(evt) {
      alert("Compile handleFiles...");
      var f = evt.target.files[0];
      if (f.name.indexOf(".csv") > -1) {
          handleFilesCSV(evt);
      } else {
          handleFilesText(evt);
      }
      alert("...compiled handleFiles");
  }

  function  handleFilesText(evt){
      alert("Compile handleFilesText...");
      //var data = handleFileSelect(evt);
      //doPostOfContent(data);
      //uploadJqueryForm();
      uploadFormData(evt);
      alert("...compiled handleFilesText");
  }

  /** function utility for select multiple file
  *  http://www.html5rocks.com/en/tutorials/file/dndfiles/
  */
  function handleFileSelect(evt) {
      if (!browserSupportFileUpload()) {
          alert('The File APIs are not fully supported in this browser!');
      } else {
          var files = evt.target.files; // FileList object
          //var file = evt.target.files[0]; // singleFile
          // files is a FileList of File objects. List some properties.
          //var output = [];
          for (var i = 0, f; f = files[i]; i++) {
              /* output.push('<li><strong>', escape(f.name), '</strong> (', f.type || 'n/a', ') - ',
               f.size, ' bytes, last modified: ',
               f.lastModifiedDate ? f.lastModifiedDate.toLocaleDateString() : 'n/a',
               '</li>');*/
              // Only process csv files.
              //if (!f.type.match('.+(\.csv)$'))  continue;
              var reader = new FileReader();
              // Read in the image file as a data URL.
              //reader.readAsDataURL(f); //for image...
              reader.readAsText(f); // fir file text.
              // Closure to capture the file information.
              /*reader.onload = (function(theFile) {
               return function(e) {
               // Render thumbnail.
               var span = document.createElement('span');
               /!*span.innerHTML = ['<img class="thumb" src="', e.target.result,
               '" title="', escape(theFile.name), '"/>'].join('');*!/
               document.getElementById('list').insertBefore(span, null);
               };
               })(f);*/
              //for CSV...
              reader.onload = (function (event) {
                  var data = event.target.result;
                  //var data = $.csv.toArrays(event.target.result);
                  if (data && data.length > 0) {
                      alert('Imported -' + data.length + '- rows successfully!');
                      return data;
                  } else {
                      alert('No data to import!');
                  }
              });
              reader.onerror = function (event) {
                  alert('Unable to read ' + event.target.name);
              };
          }
      }//else
      //document.getElementById('list').innerHTML = '<ul>' + output.join('') + '</ul>';
  }

  /** function for get the content of a file e.g. readTextFile("file:///C:/your/path/to/file.txt");*/
  function readTextFile(file) {
      var rawFile = new XMLHttpRequest();
      try {
          rawFile.open("GET", file, false);
      }catch(e){
          rawFile.open("GET", "file:///"+file, false);
      }
      rawFile.onreadystatechange = function ()
      {
          if(rawFile.readyState === 4)
          {
              if(rawFile.status === 200 || rawFile.status == 0)
              {
                  var allText = rawFile.responseText;
                  alert(allText);
              }
          }
      };
      rawFile.send(null);
  }

  /**
   * http://stackoverflow.com/questions/21044798/how-to-use-formdata-for-ajax-file-upload
   */
  function doPostOfContent(data){
      //You can give to the formData all form for processing
      //var form = $('form')[0]; // You need to use standart javascript object here
      //var formData = new FormData(form);
      //or specify exact data for formdata
      //var formData = new FormData();
      //formData.append('section', 'general');
      //formData.append('action', 'previewImg');
      // Main magic with files here
      //formData.append('image', $('input[type=file]')[0].files[0]);

     /* data = new FormData();
      data.append('section', 'general');
      data.append('action', 'previewImg');
      data.append('image', $('input[type=file]')[0].files[0]);*/
      alert("doPostFile");
      var formData = new FormData($('form')[0]);
      alert("form data "+formData);
      $.ajax({
          url: '/fileupload',
          data: formData,
          // THIS MUST BE DONE FOR FILE UPLOADING
          processData: false,
          contentType: false,
          type: 'POST',
          success: function (data) {
              alert('Success: ' + data);
          },
          error: function(error) {
              alert('ERROR 1: ' + error.Message);
          }
      });
  }

  /**using FormData() object */
  function uploadFormData(evt){
      alert("Compile uploadFormData...");
      $('#result').html('');
      var oMyForm = new FormData();
      oMyForm.append("file", uploader.files[0]);
      var f = evt.target.files[0];
      var dataUrl = 'resources/file/'+ f.name;
      alert("nameTextFile:"+dataUrl);
      $.ajax({
          url: 'http://localhost:8181/fileupload',
          data: oMyForm,
          dataType: 'text',
          processData: false,
          contentType: false,
          type: 'POST',
          success: function(data){
              alert("SUCCESS");
              $('#result').html(data);
          },
          error: function(error) {
              alert('ERROR 1: ' + error.message);
          }
      });
  }

  /** using jquery.form.js */
  function uploadJqueryForm(){
      alert("Compile uploadJqueryForm...");
      $('#result').html('');

      $("#uploadForm").ajaxForm({
          success:function(data) {
              $('#result').html(data);
          },
          dataType:"text"
      }).submit();
  }




  
  