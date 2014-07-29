function getParameter(name) {
  name = name.replace(/\[]/, "\\\[").replace(/[\]]/, "\\\]");
  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
  var results = regex.exec(window.location.search);
  if (results == null) return undefined;
  else return decodeURIComponent(results[1].replace(/\+/g, " "));
}
 var doc = null;
 $(document).ready(function() {
   var req = new XMLHttpRequest();
   var uri = getParameter('doc');
   if (! uri) uri = gon.scores.music_xml.url;
   req.open('GET', uri, true);
   req.onreadystatechange = function() {
     if (req.readyState != 4) return;
     doc = new Vex.Flow.Document(req.responseText);
     doc.getFormatter().setWidth(800).draw($("#viewer")[0]);
   };
   req.send(null);
 });
