

function addEvent( obj, type, fn ) {
	if (obj.addEventListener)
		obj.addEventListener( type, fn, false );
	else if (obj.attachEvent) {
		obj["e"+type+fn] = fn;
		obj[type+fn] = function() { obj["e"+type+fn]( window.event ); }
		obj.attachEvent( "on"+type, obj[type+fn] );
	}
}

function old_browser() {
	var ie6 = document.all && /MSIE\s?6/.test(navigator.userAgent)
	var ie7 = document.all && /MSIE\s?7/.test(navigator.userAgent)
	var ie8 = document.all && /MSIE\s?8/.test(navigator.userAgent)
	var quirksmode = document.compatMode == "BackCompat"
	return ie6 || ((ie7 || ie8) && quirksmode)
}

var kundo = {
	get_fixed_style: function() {
		style = ""
		if (old_browser()) {
			style = "position: absolute;";
		}
		else {
			style = "position: fixed;";
		}
		return style
	},
	slug: "http://kundo.se/embed/landingpage/resihop?lang=sv",
	create_box: function() {
	    if (!document.getElementById("kundo_container")){
			var body = document.getElementsByTagName("body")[0];
			var kundo_container = document.createElement('div');
			kundo_container.id = "kundo_container"
			body.appendChild(kundo_container);

			kundo.create_overlay(kundo_container, body);
			kundo.create_frame(kundo_container);
		}
		else {
			document.getElementById("kundo_container").style.display = "block";
		}
	},
	create_overlay: function(kundo_container, body) {
		var style =
			"top: 0; bottom:0; min-height:600px; left: 0;" +
			"background: #000; filter: alpha(opacity=50); opacity: 0.5; z-index: 99999; width: 100%;";
		style += kundo.get_fixed_style()
		if (old_browser()) {
			var body_height = Math.max(document.body.clientHeight,
									   document.documentElement.clientHeight);
			style += "height:" + body_height + "px;";
		}
		kundo_container.innerHTML +=
			'<div id="kundo_overlay" style="' + style + '"></div>';
	},
	create_frame: function(kundo_container) {
		var style =
			"top: 44px; left: 50%; margin:0 0 0 378px; " +
			"height: 20px; width: 20px; cursor: pointer; z-index:100100;";
		style += kundo.get_fixed_style()
		kundo_container.innerHTML +=
			'<img title="StÃ¤ng" src="http://kundo.se/site_media/images/close.gif" alt="" ' +
			'id="kundo_close" style="' + style + '" onclick="kundo.hide_iframe()">';
		var iframeHTML = '        <iframe src="http://kundo.se/embed/landingpage/resihop?lang=sv" id="kundo_iframe" scrolling="no" frameborder="no"    style="background: white;    border: none;    height: 470px;    left: 50%;    margin-left: -358px;    position: fixed;    top: 40px;    width: 760px;    z-index: 100000;"></iframe>'
		if (old_browser()) {
			iframeHTML = iframeHTML.replace('position: fixed;','position:absolute !important;')
		}
		kundo_container.innerHTML += iframeHTML;
	},
	hide_iframe: function() {
		var element = document.getElementById("kundo_container");
		if (element) {
			element.parentNode.removeChild(element);
		}
	},

	check_close: function(e) {
		var evt = e || window.event;
		if (evt && evt.keyCode == 27) {
			kundo.hide_iframe();
		}
	}
}

addEvent(window, 'load', kundo.init)
addEvent(document, 'keydown', kundo.check_close)