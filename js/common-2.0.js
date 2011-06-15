$(document).ready(function()
{	

//datmuväljare
	$('.when').jdPicker();

//sökresultat-interaktion.
	$('#searchresults tr.generals').hover(
		function()
		{
		 	$(this).addClass("highlight");
		 	$(this).next().addClass("highlight");
		},
		function()
		{
		 	$(this).removeClass("highlight");
		 	$(this).next().removeClass("highlight");
		}
	)
	$('#searchresults tr.details').hover(
		function()
		{
		 	$(this).addClass("highlight");
		 	$(this).prev().addClass("highlight");
		},
		function()
		{
		 	$(this).removeClass("highlight");
		 	$(this).prev().removeClass("highlight");
		}
	)

//lägger till kommentarer i fälten
	autoFill(".field");
	$('form').submit(function() {
		autoClear(".field");
	});

//öpnar och stänger sökresultaten.
	$('tr.details').hide();

	var lastMouseUp = 0, lastMouseDown = 0;
	$('tr.details').bind('mouseup mousedown', function(e){
    var ms = new Date().getTime();
    e.type == 'mousedown' ? lastMouseDown = ms : lastMouseUp = ms;   

    if(e.type != 'mousedown' && (Math.abs(lastMouseUp - lastMouseDown)  < 300))
		$(this).toggle();
	});
	
	$('tr.generals').click(
	function(){
			$(this).next().toggle();
	});
	

	
	//välj det första felaktiga meddelandet
	$('#' + $('.error:first').attr('for')).select().removeClass('help');
	curFocus = $('#' + $('.error:first').attr('for'));

	// tänd felmeddelande på den markerade rutan.
	$('.field').focus(function() {
	 	$('.' + $(this).attr("id")).addClass("visible");
	});

	 //ta bort röda ramar när man skriver	
	$('.field').keydown(function() {
		$(this).removeClass("input_error");
	});
	
	//errormessages
	//röda ramar
	$('.error').each(function() {
	    $('#' + $(this).attr('for')).addClass("input_error");
	});

	
	//populera fälten med texten i valbara listor
	$(".adress").click(function() {
		event.preventDefault();
    	$('#' + $(this).parent().parent().parent().attr('for')).val($(this).text());
    	$('#' + $(this).parent().parent().parent().attr('for')).removeClass("input_error");
    	$(this).parent().parent().parent().removeClass("visible");
	});
	
	//Ta bort felmarkering på datum när man väljer i listan 
	$(".selectable_day").click(function() {
    	$('#when').removeClass("input_error help");
    	$('.when').removeClass("visible");
	});	

	var curFocus;
    $(document).delegate('*','mousedown', function(){
        if ((this != curFocus) && // don't bother if this was the previous active element                
            ($(curFocus).is('.field')) && // if it was a .field that was blurred
            !($(this).is('.adress'))
        ) {
            $('.' + $(curFocus).attr("id")).removeClass("visible"); // take action based on the blurred element
        }

        curFocus = this; // log the newly focussed element for the next event
    });
    
	$('.field').bind('keydown',function(e){ 
		curFocus = this; // log the newly focussed element for the next event
		if(e.which==9){
            $('.' + $(curFocus).attr("id")).removeClass("visible"); // take action based on the blurred element
        }
	});
    
    //Kan bara skicka spar-data en gång!
    
    $('.addtrip').submit(function(){

	    $('input.button').attr('disabled', 'disabled');
	});

});

function autoClear(selector)
{
	jQuery(selector).each
	(function(){
		if (jQuery(this).val() == jQuery(this).attr("title"))
		{
			jQuery(this).val('');
		}
	});
}

function autoFill(selector)
{
	jQuery(selector).each
	(function(){
		if (jQuery(this).val() == "")
		{
			jQuery(this).val(jQuery(this).attr("title")).addClass("help");
		};
		jQuery(".trip").submit
		(function(){
			if (jQuery(this).val() == jQuery(this).attr("title"))
			{
				jQuery(this).val('');
			}
		});
	}).focus(
	function(){
		if (jQuery(this).val() == jQuery(this).attr("title"))
		{
			jQuery(this).val("").removeClass("help");
		}
	}).blur(
	function(){
		if (jQuery(this).val() == "")
		{
			jQuery(this).val(jQuery(this).attr("title")).addClass("help");
		}
	});
}


/*
jdPicker 1.0
Requires jQuery version: >= 1.2.6

2010 - ? -- Paul Da Silva, AMJ Groupe

Copyright (c) 2007-2008 Jonathan Leighton & Torchbox Ltd

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
jdPicker = (function($) {

function jdPicker(el, opts) {
	if (typeof(opts) != "object") opts = {};
	$.extend(this, jdPicker.DEFAULT_OPTS, opts);

	this.input = $(el);
	this.bindMethodsToObj("show", "hide", "hideIfClickOutside", "keydownHandler", "selectDate");

	this.build();
	this.selectDate();

	this.hide();
};
jdPicker.DEFAULT_OPTS = {
	month_names: ["Januari", "Februari", "Mars", "April", "Maj", "Juni", "Juli", "Augusti", "September", "Oktober", "November", "December"],
	short_month_names: ["Jan", "Feb", "Mar", "Apr", "Maj", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dec"],
	short_day_names: ["S", "M", "T", "O", "T", "F", "L"],
	error_out_of_range: "Det valda datumet är innan idag",
	selectable_days: [0, 1, 2, 3, 4, 5, 6],
	non_selectable: [],
	rec_non_selectable: [],
	start_of_week: 1,
	show_week: 1,
	select_week: 0,
	week_label: "",
	date_min: "",
	date_max: "",
	date_format: "YYYY-mm-dd"
};
jdPicker.prototype = {
	build: function() {

	this.wrapp = this.input.wrap('<div class="jdpicker_w">');


	switch (this.date_format){
		case "dd-mm-YYYY":
			this.reg = new RegExp(/^(\d{1,2})\/(\d{1,2})\/(\d{4})$/);
			this.date_decode = "new Date(matches[3], parseInt(matches[2]-1), matches[1]);";
			this.date_encode = 'this.strpad(date.getDate()) + "-" + this.strpad(date.getMonth()+1) + "-" + date.getFullYear();';
			this.date_encode_s = 'this.strpad(date.getDate()) + "-" + this.strpad(date.getMonth()+1)';
		break;
		case "FF dd YYYY":
			this.reg = new RegExp(/^([a-zA-Z]+) (\d{1,2}) (\d{4})$/);
			this.date_decode = "new Date(matches[3], this.indexFor(this.month_names, matches[1]), matches[2]);";
			this.date_encode = 'this.month_names[date.getMonth()] + " " + this.strpad(date.getDate()) + " " + date.getFullYear();';
			this.date_encode_s = 'this.month_names[date.getMonth()] + " " + this.strpad(date.getDate());';
		break;
		case "dd MM YYYY":
			this.reg = new RegExp(/^(\d{1,2}) ([a-zA-Z]{3}) (\d{4})$/);
			this.date_decode = "new Date(matches[3], this.indexFor(this.short_month_names, matches[2]), matches[1]);";
			this.date_encode = 'this.strpad(date.getDate()) + " " + this.short_month_names[date.getMonth()] + " " + date.getFullYear();';
			this.date_encode_s = 'this.strpad(date.getDate()) + " " + this.short_month_names[date.getMonth()];';
		break;
		case "MM dd YYYY":
			this.reg = new RegExp(/^([a-zA-Z]{3}) (\d{1,2}) (\d{4})$/);
			this.date_decode = "new Date(matches[3], this.indexFor(this.short_month_names, matches[1]), matches[2]);";
			this.date_encode = 'this.short_month_names[date.getMonth()] + " " + this.strpad(date.getDate()) + " " + date.getFullYear();';
			this.date_encode_s = 'this.short_month_names[date.getMonth()] + " " + this.strpad(date.getDate());';
		break;
		case "dd FF YYYY":
			this.reg = new RegExp(/^(\d{1,2}) ([a-zA-Z]+) (\d{4})$/);
			this.date_decode = "new Date(matches[3], this.indexFor(this.month_names, matches[2]), matches[1]);";
			this.date_encode = 'this.strpad(date.getDate()) + " " + this.month_names[date.getMonth()] + " " + date.getFullYear();';
			this.date_encode_s = 'this.strpad(date.getDate()) + " " + this.month_names[date.getMonth()];';
		break;
		case "YYYY-mm-dd":
		default:
			this.reg = new RegExp(/^(\d{4})\/(\d{1,2})\/(\d{1,2})$/);
			this.date_decode = "new Date(matches[1], parseInt(matches[2]-1), matches[3]);";
			this.date_encode = 'date.getFullYear() + "-" + this.strpad(date.getMonth()+1) + "-" + this.strpad(date.getDate());';
			this.date_encode_s = 'this.strpad(date.getMonth()+1) + "-" + this.strpad(date.getDate());';
		break;
	}

	if(this.date_max != "" && this.date_max.match(this.reg)){
		var matches = this.date_max.match(this.reg);
		this.date_max = eval(this.date_decode);
	}else
		this.date_max = "";

	if(this.date_min != "" && this.date_min.match(this.reg)){
		var matches = this.date_min.match(this.reg);
		this.date_min = eval(this.date_decode);
	}else
		this.date_min = "";

		var monthNav = $('<p class="month_nav">' +
			'<span class="button prev" title="[Page-Up]">&#171;</span>' +
			' <span class="month_name"></span> ' +
			'<span class="button next" title="[Page-Down]">&#187;</span>' +
			'</p>');

		this.monthNameSpan = $(".month_name", monthNav);
		$(".prev", monthNav).click(this.bindToObj(function() { this.moveMonthBy(-1); }));
		$(".next", monthNav).click(this.bindToObj(function() { this.moveMonthBy(1); }));

	this.monthNameSpan.dblclick(this.bindToObj(function(){
		this.monthNameSpan.empty().append(this.getMonthSelect());
		$('select', this.monthNameSpan).change(this.bindToObj(function(){
			this.moveMonthBy(parseInt($('select :selected', this.monthNameSpan).val()) - this.currentMonth.getMonth());
		}));
	}));

		var yearNav = $('<p class="year_nav">' +
			' <span class="year_name" id="year_name"></span> ' +
			'</p>');

		this.yearNameSpan = $(".year_name", yearNav);
		$(".prev", yearNav).click(this.bindToObj(function() { this.moveMonthBy(-12); }));
		$(".next", yearNav).click(this.bindToObj(function() { this.moveMonthBy(12); }));

		this.yearNameSpan.dblclick(this.bindToObj(function(){

			if($('.year_name input', this.rootLayers).length==0){
			var initialDate = this.yearNameSpan.html();

			var yearNameInput = $('<input type="text" class="text year_input" value="'+initialDate+'" />');
			this.yearNameSpan.empty().append(yearNameInput);

			$(".year_input", yearNav).keyup(this.bindToObj(function(){
				if($('input',this.yearNameSpan).val().length == 4 && $('input',this.yearNameSpan).val() != initialDate && parseInt($('input',this.yearNameSpan).val()) == $('input',this.yearNameSpan).val()){
					this.moveMonthBy(parseInt(parseInt(parseInt($('input',this.yearNameSpan).val()) - initialDate)*12));
				}else if($('input',this.yearNameSpan).val().length>4)
					$('input',this.yearNameSpan).val($('input',this.yearNameSpan).val().substr(0, 4));
			}));

			$('input',this.yearNameSpan).focus();
			$('input',this.yearNameSpan).select();
			}

		}));

	var error_msg = $('<div class="error_msg"></div>');

		var nav = $('<div class="nav"></div>').append(error_msg, monthNav, yearNav);

		var tableShell = "<table><thead><tr>";

	if(this.show_week == 1) tableShell +='<th class="week_label">'+(this.week_label)+'</th>';

		$(this.adjustDays(this.short_day_names)).each(function() {
			tableShell += "<th>" + this + "</th>";
		});

		tableShell += "</tr></thead><tbody></tbody></table>";

		var style = (this.input.context.type=="hidden")?' style="display:block; position:static; margin:0 auto"':'';

		this.dateSelector = this.rootLayers = $('<div class="date_selector" '+style+'></div>').append(nav, tableShell).insertAfter(this.input);

		if ($.browser.msie && $.browser.version < 7) {

			this.ieframe = $('<iframe class="date_selector_ieframe" frameborder="0" src="#"></iframe>').insertBefore(this.dateSelector);
			this.rootLayers = this.rootLayers.add(this.ieframe);

			$(".button", nav).mouseover(function() { $(this).addClass("hover"); });
			$(".button", nav).mouseout(function() { $(this).removeClass("hover"); });
		};

		this.tbody = $("tbody", this.dateSelector);

		this.input.change(this.bindToObj(function() { this.selectDate(); }));
		this.selectDate();

	},

	selectMonth: function(date) {
		var newMonth = new Date(date.getFullYear(), date.getMonth(), date.getDate());
		if(this.isNewDateAllowed(newMonth)){
		if (!this.currentMonth || !(this.currentMonth.getFullYear() == newMonth.getFullYear() &&
									this.currentMonth.getMonth() == newMonth.getMonth())) {

			this.currentMonth = newMonth;

			var rangeStart = this.rangeStart(date), rangeEnd = this.rangeEnd(date);
			var numDays = this.daysBetween(rangeStart, rangeEnd);
			var dayCells = "";

			for (var i = 0; i <= numDays; i++) {
			var currentDay = new Date(rangeStart.getFullYear(), rangeStart.getMonth(), rangeStart.getDate() + i, 12, 00);

			if (this.isFirstDayOfWeek(currentDay)){

				var firstDayOfWeek = currentDay;
				var lastDayOfWeek = new Date(currentDay.getFullYear(), currentDay.getMonth(), currentDay.getDate()+6, 12, 00);

				if(this.select_week && this.isNewDateAllowed(firstDayOfWeek))
					dayCells += "<tr date='" + this.dateToString(currentDay) + "' class='selectable_week'>";
				else
					dayCells += "<tr>";

				if(this.show_week==1)
					dayCells += '<td class="week_num">'+this.getWeekNum(currentDay)+'</td>';
			}
			if ((this.select_week == 0 && currentDay.getMonth() == date.getMonth() && this.isNewDateAllowed(currentDay) && !this.isHoliday(currentDay)) || (this.select_week==1 && currentDay.getMonth() == date.getMonth() && this.isNewDateAllowed(firstDayOfWeek))) {
				dayCells += '<td class="selectable_day" date="' + this.dateToString(currentDay) + '">' + currentDay.getDate() + '</td>';
			} else {
				dayCells += '<td class="unselected_month" date="' + this.dateToString(currentDay) + '">' + currentDay.getDate() + '</td>';
			};

			if (this.isLastDayOfWeek(currentDay)) dayCells += "</tr>";
			};
			this.tbody.empty().append(dayCells);

			this.monthNameSpan.empty().append(this.monthName(date));
			this.yearNameSpan.empty().append(this.currentMonth.getFullYear());

			if(this.select_week == 0){
				$(".selectable_day", this.tbody).click(this.bindToObj(function(event) {
				this.changeInput($(event.target).attr("date"));
				}));
			}else{
				$(".selectable_week", this.tbody).click(this.bindToObj(function(event) {
				this.changeInput($(event.target.parentNode).attr("date"));
				}));
			}

			$("td[date=" + this.dateToString(new Date()) + "]", this.tbody).addClass("today");
			if(this.select_week == 1){
				$("tr", this.tbody).mouseover(function() { $(this).addClass("hover"); });
				$("tr", this.tbody).mouseout(function() { $(this).removeClass("hover"); });
			}else{
				$("td.selectable_day", this.tbody).mouseover(function() { $(this).addClass("hover"); });
				$("td.selectable_day", this.tbody).mouseout(function() { $(this).removeClass("hover"); });
			}
		};

		$('.selected', this.tbody).removeClass("selected");
		$('td[date=' + this.selectedDateString + '], tr[date=' + this.selectedDateString + ']', this.tbody).addClass("selected");
	}else
		this.show_error(this.error_out_of_range);
	},

	selectDate: function(date) {
		if (typeof(date) == "undefined") {
			date = this.stringToDate(this.input.val());
		};
		if (!date) date = new Date();

	if(this.select_week == 1 && !this.isFirstDayOfWeek(date))
		date = new Date(date.getFullYear(), date.getMonth(), (date.getDate() - date.getDay() + this.start_of_week), 12, 00);

	if(this.isNewDateAllowed(date)){
		this.selectedDate = date;
		this.selectedDateString = this.dateToString(this.selectedDate);
		this.selectMonth(this.selectedDate);
	}else if((this.date_min) && this.daysBetween(this.date_min, date)<0){
			this.selectedDate = this.date_min;
			this.selectMonth(this.date_min);
			this.input.val(" ");
	}else{
			this.selectMonth(this.date_max);
			this.input.val(" ");
	}
	},

	isNewDateAllowed: function(date){
	return ((!this.date_min) || this.daysBetween(this.date_min, date)>=0) && ((!this.date_max) || this.daysBetween(date, this.date_max)>=0);
	},

	isHoliday: function(date){
	return ((this.indexFor(this.selectable_days, date.getDay())===false || this.indexFor(this.non_selectable, this.dateToString(date))!==false) || this.indexFor(this.rec_non_selectable, this.dateToShortString(date))!==false);
	},

	changeInput: function(dateString) {
	this.input.val(dateString).change();
		this.input.addClass("focus");
		if(this.input.context.type!="hidden")
			 this.hide();
	},

	show: function() {
	$('.error_msg', this.rootLayers).css('display', 'none');
		this.rootLayers.slideDown();
		$([window, document.body]).click(this.hideIfClickOutside);
		this.input.unbind("focus", this.show);
		$(document.body).keydown(this.keydownHandler);
		this.setPosition();
	},

	hide: function() {
	if(this.input.context.type!="hidden"){
		this.rootLayers.slideUp();
		$([window, document.body]).unbind("click", this.hideIfClickOutside);
		this.input.focus(this.show);
		$(document.body).unbind("keydown", this.keydownHandler);
	}
	},

	hideIfClickOutside: function(event) {
		if (event.target != this.input[0] && !this.insideSelector(event)) {
			this.hide();
		};
	},

	insideSelector: function(event) {
		var offset = this.dateSelector.position();
		offset.right = offset.left + this.dateSelector.outerWidth();
		offset.bottom = offset.top + this.dateSelector.outerHeight();

		return event.pageY < offset.bottom &&
					 event.pageY > offset.top &&
					 event.pageX < offset.right &&
					 event.pageX > offset.left;
	},

	keydownHandler: function(event) {
		switch (event.keyCode)
		{
			case 9:
			case 27:
				this.hide();
				return;
			break;
			case 13:
		if(this.isNewDateAllowed(this.stringToDate(this.selectedDateString)) && !this.isHoliday(this.stringToDate(this.selectedDateString)))
					this.changeInput(this.selectedDateString);
			break;
			case 33:
				this.moveDateMonthBy(event.ctrlKey ? -12 : -1);
			break;
			case 34:
				this.moveDateMonthBy(event.ctrlKey ? 12 : 1);
			break;
			case 38:
				this.moveDateBy(-7);
			break;
			case 40:
				this.moveDateBy(7);
			break;
//			case 37:
//				if(this.select_week == 0) this.moveDateBy(-1);
//			break;
//			case 39:
//				if(this.select_week == 0) this.moveDateBy(1);
//			break;
			default:
				return;
		}
		event.preventDefault();
	},

	stringToDate: function(string) {
		var matches;

		if (matches = string.match(this.reg)) {
			if(matches[3]==0 && matches[2]==0 && matches[1]==0)
			return null;
			else
				return eval(this.date_decode);
		} else {
			return null;
		};
	},

	dateToString: function(date) {
		return eval(this.date_encode);
	},

	dateToShortString: function(date){
		return eval(this.date_encode_s);
	},

	setPosition: function() {
		var offset = this.input.offset();
		this.rootLayers.css({
			top: offset.top + this.input.outerHeight(),
			left: offset.left
		});

		if (this.ieframe) {
			this.ieframe.css({
				width: this.dateSelector.outerWidth(),
				height: this.dateSelector.outerHeight()
			});
		};
	},

	moveDateBy: function(amount) {
		var newDate = new Date(this.selectedDate.getFullYear(), this.selectedDate.getMonth(), this.selectedDate.getDate() + amount);
		this.selectDate(newDate);
	},

	moveDateMonthBy: function(amount) {
		var newDate = new Date(this.selectedDate.getFullYear(), this.selectedDate.getMonth() + amount, this.selectedDate.getDate());
		if (newDate.getMonth() == this.selectedDate.getMonth() + amount + 1) {
			newDate.setDate(0);
		};
		this.selectDate(newDate);
	},

	moveMonthBy: function(amount) {
	if(amount<0)
		var newMonth = new Date(this.currentMonth.getFullYear(), this.currentMonth.getMonth() + amount+1, -1);
		else
		var newMonth = new Date(this.currentMonth.getFullYear(), this.currentMonth.getMonth() + amount, 1);
		this.selectMonth(newMonth);
	},

	monthName: function(date) {
		return this.month_names[date.getMonth()];
	},

	getMonthSelect:function(){
		var month_select = '<select>';
	for(var i = 0; i<this.month_names.length; i++){
		if(i==this.currentMonth.getMonth())
			month_select += '<option value="'+(i)+'" selected="selected">'+this.month_names[i]+'</option>';
		else
			month_select += '<option value="'+(i)+'">'+this.month_names[i]+'</option>';
	}
	month_select += '</select>';

	return month_select;
	},

	bindToObj: function(fn) {
		var self = this;
		return function() { return fn.apply(self, arguments) };
	},

	bindMethodsToObj: function() {
		for (var i = 0; i < arguments.length; i++) {
			this[arguments[i]] = this.bindToObj(this[arguments[i]]);
		};
	},

	indexFor: function(array, value) {
		for (var i = 0; i < array.length; i++) {
			if (value == array[i]) return i;
		};
	return false;
	},

	monthNum: function(month_name) {
		return this.indexFor(this.month_names, month_name);
	},

	shortMonthNum: function(month_name) {
		return this.indexFor(this.short_month_names, month_name);
	},

	shortDayNum: function(day_name) {
		return this.indexFor(this.short_day_names, day_name);
	},

	daysBetween: function(start, end) {
		start = Date.UTC(start.getFullYear(), start.getMonth(), start.getDate());
		end = Date.UTC(end.getFullYear(), end.getMonth(), end.getDate());
		return (end - start) / 86400000;
	},

	changeDayTo: function(dayOfWeek, date, direction) {
		var difference = direction * (Math.abs(date.getDay() - dayOfWeek - (direction * 7)) % 7);
		return new Date(date.getFullYear(), date.getMonth(), date.getDate() + difference);
	},

	rangeStart: function(date) {
		return this.changeDayTo(this.start_of_week, new Date(date.getFullYear(), date.getMonth()), -1);
	},

	rangeEnd: function(date) {
		return this.changeDayTo((this.start_of_week - 1) % 7, new Date(date.getFullYear(), date.getMonth() + 1, 0), 1);
	},

	isFirstDayOfWeek: function(date) {
		return date.getDay() == this.start_of_week;
	},

	getWeekNum:function(date){
	date_week= new Date(date.getFullYear(), date.getMonth(), date.getDate()+6);
	var firstDayOfYear = new Date(date_week.getFullYear(), 0, 1, 12, 00);
	var n = parseInt(this.daysBetween(firstDayOfYear, date_week)) + 1;
	return Math.floor((date_week.getDay() + n + 5)/7) - Math.floor(date_week.getDay() / 5);
	},

	isLastDayOfWeek: function(date) {
		return date.getDay() == (this.start_of_week - 1) % 7;
	},

	show_error: function(error){
	$('.error_msg', this.rootLayers).html(error);
	$('.error_msg', this.rootLayers).slideDown(400, function(){
		setTimeout("$('.error_msg', this.rootLayers).slideUp(200);", 2000);
	});
	},

	adjustDays: function(days) {
		var newDays = [];
		for (var i = 0; i < days.length; i++) {
			newDays[i] = days[(i + this.start_of_week) % 7];
		};
		return newDays;
	},

	strpad: function(num){
	if(parseInt(num)<10)	return "0"+parseInt(num);
	else	return parseInt(num);
	}

};

$.fn.jdPicker = function(opts) {
	return this.each(function() { new jdPicker(this, opts); });
};
$.jdPicker = { initialize: function(opts) {
	$("input.jdpicker").jdPicker(opts);
} };

return jdPicker;
})(jQuery);

$($.jdPicker.initialize);

    
	$(function() {
		var availableTags = [
		"Abbekås",
		"Abborrberget",
		"Åby",
		"Åbyggeby",
		"Åbytorp",
		"Agunnaryd",
		"Åhus",
		"Åkarp",
		"Åkers styckebruk",
		"Åkersberga",
		"Älandsbro",
		"Alberga",
		"Ålberga",
		"Alby",
		"Ale kommun",
		"Åled",
		"Ålem",
		"Alfta",
		"Älgarås",
		"Älghult",
		"Algutsrum",
		"Alingsås",
		"Alingsås kommun",
		"Allerum",
		"Almby",
		"Älmhult",
		"Älmhults kommun",
		"Älmsta",
		"Almunge",
		"Almvik",
		"Alsike",
		"Alstad",
		"Alster",
		"Alsterbro",
		"Alstermo",
		"Älta",
		"Alunda",
		"Älvängen",
		"Älvdalen",
		"Älvdalens kommun",
		"Alvesta",
		"Alvesta kommun",
		"Alvhem",
		"Alvik",
		"Älvkarleby",
		"Älvkarleby kommun",
		"Älvnäs",
		"Älvsborg",
		"Älvsbyn",
		"Älvsbyns kommun",
		"Älvsered",
		"Åmål",
		"Åmåls kommun",
		"Ambjörby",
		"Ambjörnarp",
		"Åmmeberg",
		"Ammenäs",
		"Åmot",
		"Åmotfors",
		"Åmsele",
		"Åmynnet",
		"Ånäset",
		"Andalen",
		"Anderslöv",
		"Anderstorp",
		"Aneby",
		"Aneby kommun",
		"Äng",
		"Ånge",
		"Änge",
		"Ånge kommun",
		"Ängelholm",
		"Ängelholms kommun",
		"Angelstad",
		"Angered",
		"Ängsvik",
		"Ankarsrum",
		"Ankarsvik",
		"Anneberg",
		"Annelöv",
		"Annelund",
		"Antnäs",
		"Aplared",
		"Äppelbo",
		"Arboga",
		"Arboga kommun",
		"Arbrå",
		"Ardala",
		"Åre",
		"Åre kommun",
		"Arentorp",
		"Arild",
		"Årjäng",
		"Årjängs kommun",
		"Arjeplog",
		"Arjeplogs kommun",
		"Arkelstorp",
		"Ärla",
		"Arlöv",
		"Arnäsvall",
		"Arnö",
		"Aröd och Timmervik",
		"Arontorp",
		"Årstad",
		"Årsunda",
		"Arvidsjaur",
		"Arvidsjaurs kommun",
		"Arvika",
		"Arvika kommun",
		"Åryd",
		"Ås",
		"Åsa",
		"Åsarne",
		"Åsarp",
		"Åsbro",
		"Åsby",
		"Åseda",
		"Åsele",
		"Åsele kommun",
		"Åselstad",
		"Åsen",
		"Åsenhöga",
		"Åsensbruk",
		"Åshammar",
		"Askeby",
		"Askersby",
		"Askersund",
		"Askersunds kommun",
		"Äsköping",
		"Åsljunga",
		"Asmundtorp",
		"Aspås",
		"Äspered",
		"Asperö",
		"Äsperöd",
		"Åstol",
		"Åstorp",
		"Åstorps kommun",
		"Återvall",
		"Åtorp",
		"Ätran",
		"Åtvidaberg",
		"Åtvidabergs kommun",
		"Avesta",
		"Avesta kommun",
		"Åvik",
		"Axvall",
		"Backa",
		"Backaryd",
		"Bäckaskog",
		"Backberg",
		"Backe",
		"Bäckebo",
		"Bäckefors",
		"Backen",
		"Bäckhammar",
		"Baggetorp",
		"Bälgviken",
		"Bälinge",
		"Ballingslöv",
		"Balsby",
		"Bålsta",
		"Bammarboda",
		"Bankekind",
		"Bankeryd",
		"Bara",
		"Bärby",
		"Barkarö",
		"Barnarp",
		"Barsebäck",
		"Barsebäckshamn",
		"Bårslöv",
		"Baskemölla",
		"Bäsna",
		"Båstad",
		"Båstads kommun",
		"Bastuträsk",
		"Båtskärsnäs",
		"Beddingestrand",
		"Benareby",
		"Bengtsfors",
		"Bengtsfors kommun",
		"Bengtsheden",
		"Bensbyn",
		"Berg",
		"Berga",
		"Bergagård",
		"Bergby",
		"Bergeforsen",
		"Berghem",
		"Bergkvara",
		"Bergnäset",
		"Bergs kommun",
		"Bergsäng",
		"Bergsbyn",
		"Bergshammar",
		"Bergshamra",
		"Bergsjö",
		"Bergsviken",
		"Bergvik",
		"Bestorp",
		"Bettna",
		"Bie",
		"Billdal",
		"Billeberga",
		"Billesholm",
		"Billinge",
		"Billingsfors",
		"Billsta",
		"Bjärnum",
		"Bjärred",
		"Bjärsjölagård",
		"Bjästa",
		"Björbo",
		"Björboholm",
		"Björke",
		"Björketorp",
		"Björkhamre",
		"Björklinge",
		"Björkö",
		"Björköby",
		"Björkvik",
		"Björkviken",
		"Björlanda",
		"Björna",
		"Björneborg",
		"Björneröd och Kroken",
		"Björnlunda",
		"Björnö",
		"Björnömalmen och Klacknäset",
		"Björsäter",
		"Bjurholm",
		"Bjurholms kommun",
		"Bjursås",
		"Bjuv",
		"Bjuvs kommun",
		"Blåsmark",
		"Bleket",
		"Blentarp",
		"Blidsberg",
		"Blikstorp",
		"Blombacka",
		"Blomstermåla",
		"Blötberget",
		"Bockara",
		"Boda",
		"Boda glasbruk",
		"Bodafors",
		"Boden",
		"Bodens kommun",
		"Bodträskfors",
		"Boholmarna",
		"Böle",
		"Boliden",
		"Bollebygd",
		"Bollebygds kommun",
		"Bollnäs",
		"Bollnäs kommun",
		"Bollstabruk",
		"Bönan",
		"Bonäs",
		"Boo",
		"Bor",
		"Borås",
		"Borås kommun",
		"Borensberg",
		"Borggård",
		"Borghamn",
		"Borgholm",
		"Borgholms kommun",
		"Borgs villastad",
		"Borgstena",
		"Borlänge",
		"Borlänge kommun",
		"Borrby",
		"Bosnäs",
		"Botkyrka kommun",
		"Botsmark",
		"Bottnaryd",
		"Bovallstrand",
		"Boxholm",
		"Boxholms kommun",
		"Braås",
		"Bräcke",
		"Bräcke kommun",
		"Bräkne-Hoby",
		"Brålanda",
		"Brändön",
		"Bränna",
		"Brännö",
		"Brantevik",
		"Brastad",
		"Brattås",
		"Bredared",
		"Bredaryd",
		"Bredbyn",
		"Bredviken",
		"Brevik",
		"Brevikshalvön",
		"Bro",
		"Broaryd",
		"Broby",
		"Brokind",
		"Bromölla",
		"Bromölla kommun",
		"Brömsebro",
		"Bromsten",
		"Brösarp",
		"Brunflo",
		"Brunn",
		"Brunna",
		"Brunnsberg",
		"Bruzaholm",
		"Bua",
		"Buerås",
		"Bullmark",
		"Bunkeflostrand",
		"Bureå",
		"Burgsvik",
		"Burlövs egnahem",
		"Burlövs kommun",
		"Burseryd",
		"Burträsk",
		"Buskhyttan",
		"Butbro",
		"Bygdeå",
		"Bygdsiljum",
		"Byske",
		"Charlottenberg",
		"Dalarö",
		"Dalby",
		"Dals Långed",
		"Dals Rostock",
		"Dals-Eds kommun",
		"Dalsjöfors",
		"Dalstorp",
		"Dalum",
		"Danderyds kommun",
		"Danholn",
		"Dannemora",
		"Dannike",
		"Degeberga",
		"Degerfors",
		"Degerfors kommun",
		"Degerhamn",
		"Deje",
		"Delary",
		"Delsbo",
		"Dingersjö",
		"Dingle",
		"Dingtuna",
		"Diö",
		"Diseröd",
		"Djulö kvarn",
		"Djupvik",
		"Djura",
		"Djurås",
		"Djurmo",
		"Djurö",
		"Djursholm",
		"Docksta",
		"Domnarvet",
		"Domsten",
		"Donsö",
		"Dorotea",
		"Dorotea kommun",
		"Dösjebro",
		"Drängsmark",
		"Drottningholm",
		"Drottningskär",
		"Dunö",
		"Duvbo",
		"Duved",
		"Dvärsätt",
		"Dyvelsten",
		"Ed",
		"Eda glasbruk",
		"Eda kommun",
		"Edane",
		"Edebäck",
		"Edsbro",
		"Edsbruk",
		"Edsbyn",
		"Edshultshall",
		"Edsvalla",
		"Eggby",
		"Ekängen",
		"Ekeby",
		"Ekeby-Almby",
		"Ekedalen",
		"Ekenässjön",
		"Ekerö",
		"Ekerö kommun",
		"Ekerö sommarstad",
		"Eket",
		"Ekshärad",
		"Eksjö",
		"Eksjö kommun",
		"Eldsberga",
		"Ellös",
		"Emmaboda",
		"Emmaboda kommun",
		"Emmaljunga",
		"Emsfors",
		"Emtunga",
		"Enånger",
		"Enebybergs villastad",
		"Eneryda",
		"Enhagen-Ekbacken",
		"Enköping",
		"Enköpings kommun",
		"Ensjön",
		"Enstaberga",
		"Enviken",
		"Eriksmåla",
		"Eringsboda",
		"Ersmark",
		"Ersnäs",
		"Eskilsby och Snugga",
		"Eskilstuna",
		"Eskilstuna kommun",
		"Eslöv",
		"Eslövs kommun",
		"Essunga kommun",
		"Essvik",
		"Everöd",
		"Evertsberg",
		"Fågelfors",
		"Fågelmara",
		"Fågelsta",
		"Fågelvikshöjden",
		"Fagerås",
		"Fagerhult",
		"Fagersanna",
		"Fagersta",
		"Fagersta kommun",
		"Fåglavik",
		"Fåker",
		"Falerum",
		"Falkenberg",
		"Falkenbergs kommun",
		"Falköping",
		"Falköpings förstäder",
		"Falköpings kommun",
		"Falla",
		"Falu kommun",
		"Falun",
		"Fanbyn",
		"Fårbo",
		"Färgelanda",
		"Färgelanda kommun",
		"Färila",
		"Färjestaden",
		"Färlöv",
		"Färnäs",
		"Fårösund",
		"Fellingsbro",
		"Fengersfors",
		"Figeholm",
		"Filipstad",
		"Filipstads kommun",
		"Filsbäck",
		"Finja",
		"Finkarby",
		"Finnerödja",
		"Finspång",
		"Finspångs kommun",
		"Fiskebäckskil",
		"Fisksätra",
		"Fjälkinge",
		"Fjällbacka",
		"Fjärås kyrkby",
		"Fjärdhundra",
		"Fjugesta",
		"Flädie",
		"Flatholmen",
		"Flen",
		"Flens kommun",
		"Flerohopp",
		"Flisby",
		"Fliseryd",
		"Floby",
		"Floda",
		"Flurkmark",
		"Flygsfors",
		"Flyinge",
		"Flysta",
		"Föllinge",
		"Fornåsa",
		"Fors",
		"Forsbacka",
		"Forsby",
		"Forserum",
		"Forshaga",
		"Forshaga kommun",
		"Forsheda",
		"Förslöv",
		"Forssjö",
		"Forsvik",
		"Fosie",
		"Fotö",
		"Främmestad",
		"Frändefors",
		"Frånö",
		"Fränsta",
		"Fredrika",
		"Fredriksberg",
		"Fredriksdal",
		"Fridafors",
		"Fridlevstad",
		"Friggesund",
		"Frillesås",
		"Frinnaryd",
		"Fristad",
		"Fritsla",
		"Frödinge",
		"Frösakull",
		"Frövi",
		"Frufällan",
		"Fullersta",
		"Funäsdalen",
		"Furuby",
		"Furudal",
		"Furulund",
		"Furusjö",
		"Furuvik",
		"Fyllinge",
		"Gäddede",
		"Gagnef",
		"Gagnefs kommun",
		"Gällivare",
		"Gällivare kommun",
		"Gällö",
		"Gällstad",
		"Gamleby",
		"Gammelgården",
		"Gammelstaden",
		"Gånghester",
		"Gängletorp",
		"Gångviken",
		"Gantofta",
		"Gårda",
		"Gårdby",
		"Gärds Köpinge",
		"Gårdskär",
		"Gårdstånga",
		"Garpenberg",
		"Garphyttan",
		"Gärsnäs",
		"Gävle",
		"Gävle kommun",
		"Gåvsta",
		"Geijersholm",
		"Gemla",
		"Genarp",
		"Genevad",
		"Gessie villastad",
		"Gesunda",
		"Getinge",
		"Gideå",
		"Gimåt",
		"Gimmersta",
		"Gimo",
		"Gislaved",
		"Gislaveds kommun",
		"Gislövs läge och Simremarken",
		"Gistad",
		"Gladö kvarn",
		"Glanshammar",
		"Glava",
		"Glemmingebro",
		"Glimåkra",
		"Glommen",
		"Glommersträsk",
		"Glumslöv",
		"Gnarp",
		"Gnesta",
		"Gnesta kommun",
		"Gnosjö",
		"Gnosjö kommun",
		"Godegård",
		"Gonäs",
		"Göta",
		"Göteborg",
		"Göteborgs kommun",
		"Götene",
		"Götene kommun",
		"Gotlands kommun",
		"Götlunda",
		"Gottne",
		"Gråbo",
		"Gräfsnäs",
		"Grangärde",
		"Grängesberg",
		"Gränna",
		"Granö",
		"Granön",
		"Gränum",
		"Grästorp",
		"Grästorps kommun",
		"Gravarne och Bäckevik",
		"Grebbestad",
		"Grebo",
		"Grevie",
		"Grillby",
		"Grimsås",
		"Grimslöv",
		"Grimstorp",
		"Gripenberg",
		"Grisslehamn",
		"Grödby",
		"Grums",
		"Grums kommun",
		"Grundsund",
		"Grycksbo",
		"Grytgöl",
		"Grythyttan",
		"Gualöv",
		"Gubbo",
		"Gudhem",
		"Gullbrandstorp",
		"Gullbranna",
		"Gulleråsen",
		"Gullholmen",
		"Gullringen",
		"Gullspång",
		"Gullspångs kommun",
		"Gundal och Högås",
		"Gunnarskog",
		"Gunnarstorp",
		"Gunnebo",
		"Gunsta",
		"Gusselby",
		"Gustavsberg",
		"Gusum",
		"Gyllenfors",
		"Gyttorp",
		"Habo",
		"Habo kommun",
		"Håbo kommun",
		"Håbo-Tibble kyrkby",
		"Hackås",
		"Haga",
		"Håga",
		"Hagby",
		"Hagbyhöjden",
		"Hagen",
		"Hagfors",
		"Hagfors kommun",
		"Hagge",
		"Häggeby och Vreta",
		"Häggenås",
		"Hagryd-Dala",
		"Hagsta",
		"Hakkas",
		"Håksberg",
		"Häljarp",
		"Halla Heberg",
		"Hallabro",
		"Hällabrottet",
		"Hällaryd",
		"Hällberga",
		"Hällbybrunn",
		"Hällefors",
		"Hällefors kommun",
		"Hälleforsnäs",
		"Hällekis",
		"Hallen",
		"Hallerna",
		"Hällesåker",
		"Hällestad",
		"Hällevadsholm",
		"Hällevik",
		"Hälleviksstrand",
		"Hällingsjö",
		"Hällnäs",
		"Hallsberg",
		"Hallsbergs kommun",
		"Hållsta",
		"Hallstahammar",
		"Hallstahammars kommun",
		"Hallstavik",
		"Halltorp",
		"Halmstad",
		"Halmstads kommun",
		"Hålsjö",
		"Hälsö",
		"Halvarsgårdarna",
		"Hamburgsund",
		"Hammar",
		"Hammarby",
		"Hammarö kommun",
		"Hammarslund",
		"Hammarstrand",
		"Hammenhög",
		"Hammerdal",
		"Hampetorp",
		"Hamrångefjärden",
		"Hanaskog",
		"Hånger",
		"Haninge kommun",
		"Haparanda",
		"Haparanda kommun",
		"Härad",
		"Harads",
		"Häradsbygden",
		"Harbo",
		"Hargshamn",
		"Härjedalens kommun",
		"Harlösa",
		"Harmånger",
		"Härnösand",
		"Härnösands kommun",
		"Harplinge",
		"Härryda",
		"Härryda kommun",
		"Härslöv",
		"Hassela",
		"Hässelby Villastad",
		"Hasselfors",
		"Hasselösund",
		"Hasslarp",
		"Hässleholm",
		"Hässleholms kommun",
		"Hasslö",
		"Hasslöv",
		"Hästhagen",
		"Hästholmen",
		"Hästveda",
		"Havdhem",
		"Haverdal",
		"Havstensund",
		"Heberg",
		"Heby",
		"Heby kommun",
		"Hedared",
		"Hede",
		"Hedekas",
		"Hedemora",
		"Hedemora kommun",
		"Hedenäset",
		"Hedeskoga",
		"Hedesunda",
		"Helsingborg",
		"Helsingborgs kommun",
		"Helsingborgs landsförsamling",
		"Hemavan/Bierke",
		"Hemmesta",
		"Hemmingsmark",
		"Hemse",
		"Henån",
		"Herräng",
		"Herrestad",
		"Herrljunga",
		"Herrljunga kommun",
		"Herstadberg",
		"Hestra",
		"Hillared",
		"Hillerstorp",
		"Himle",
		"Hindås",
		"Hishult",
		"Hissjön",
		"Hittarp",
		"Hjälm",
		"Hjälmared",
		"Hjältevad",
		"Hjärnarp",
		"Hjärsås",
		"Hjärtum",
		"Hjärup",
		"Hjo",
		"Hjo kommun",
		"Hjorted",
		"Hjortkvarn",
		"Hjortsberga",
		"Hjuvik",
		"Hofors",
		"Hofors kommun",
		"Hofterup",
		"Höganäs",
		"Höganäs bruk",
		"Höganäs fiskeläge",
		"Höganäs kommun",
		"Högboda",
		"Högsäter",
		"Högsby",
		"Högsby kommun",
		"Högsjö",
		"Hogstad",
		"Hogstorp",
		"Hohultslätt",
		"Höja",
		"Hok",
		"Hökåsen",
		"Hökerum",
		"Hököpinge",
		"Höllviken",
		"Holm",
		"Holmeja",
		"Holmsjö",
		"Holmsund",
		"Hölö",
		"Holsbybrunn",
		"Holsljunga",
		"Hönö",
		"Höör",
		"Höörs kommun",
		"Hörby",
		"Hörby kommun",
		"Horda",
		"Horn",
		"Horndal",
		"Hörnefors",
		"Hörningsnäs villastad",
		"Hornsberg",
		"Horred",
		"Hortlax",
		"Hörvik",
		"Hoting",
		"Hova",
		"Hovenäset",
		"Hovid",
		"Höviksnäs",
		"Hovmantorp",
		"Hovsta",
		"Huaröd",
		"Huddinge",
		"Huddinge kommun",
		"Hudiksvall",
		"Hudiksvalls kommun",
		"Hult",
		"Hultafors",
		"Hultsfred",
		"Hultsfreds kommun",
		"Hulu",
		"Hummelsta",
		"Hunnebostrand",
		"Hurva",
		"Husby",
		"Husum",
		"Hybo",
		"Hyllinge",
		"Hylte kommun",
		"Hyltebruk",
		"Hyssna",
		"Idala",
		"Idkerberget",
		"Idre",
		"Igelfors",
		"Igelsta",
		"Igelstorp",
		"Iggesund",
		"Ilsbo",
		"Immeln",
		"Indal",
		"Ingared",
		"Ingaröstrand",
		"Ingatorp",
		"Ingelstad",
		"Ingelsträde",
		"Innertavle",
		"Insjön",
		"Irsta",
		"Jäderfors",
		"Jädraås",
		"Jämjö",
		"Jämshög",
		"Jämtön",
		"Järbo",
		"Järfälla kommun",
		"Järlåsa",
		"Järna",
		"Järnforsen",
		"Järpås",
		"Järpen",
		"Järvsö",
		"Jättendal",
		"Jävre",
		"Johannedal",
		"Johannishus",
		"Johansfors",
		"Jokkmokk",
		"Jokkmokks kommun",
		"Jönåker",
		"Jönköping",
		"Jönköpings kommun",
		"Jonsered",
		"Jonslund",
		"Jonstorp",
		"Jordbro",
		"Jörlanda",
		"Jörn",
		"Jössefors",
		"Jukkasjärvi",
		"Jung",
		"Juniskär",
		"Junosuando",
		"Junsele",
		"Juoksengi",
		"Jursla",
		"Kåge",
		"Kågeröd",
		"Kåhög",
		"Kälarne",
		"Kalix",
		"Kalix kommun",
		"Kallax",
		"Källby",
		"Kållekärr",
		"Kållered",
		"Kallinge",
		"Källö-Knippla",
		"Källö-Knipplan",
		"Kalmar",
		"Kalmar kommun",
		"Kalvsund",
		"Kangos",
		"Kånna",
		"Karby",
		"Kärda",
		"Kareby",
		"Karesuando",
		"Käringön",
		"Karlholmsbruk",
		"Karlsborg",
		"Karlsborgs kommun",
		"Karlshamn",
		"Karlshamns kommun",
		"Karlskoga",
		"Karlskoga kommun",
		"Karlskrona",
		"Karlskrona kommun",
		"Karlstad",
		"Karlstads kommun",
		"Karlsvik",
		"Kärna",
		"Kårsta",
		"Kärsta och Bredsdal",
		"Karungi",
		"Karups sommarby",
		"Kastlösa",
		"Katrineholm",
		"Katrineholms kommun",
		"Kattarp",
		"Kättilsmåla",
		"Kättilstorp",
		"Kävlinge",
		"Kävlinge kommun",
		"Kaxholmen",
		"Kebal",
		"Kil",
		"Kilafors",
		"Killeberg",
		"Kils kommun",
		"Kilsmo",
		"Kimstad",
		"Kinda kommun",
		"Kinna",
		"Kinnared",
		"Kinnarp",
		"Kinnarumma",
		"Kiruna",
		"Kiruna kommun",
		"Kisa",
		"Kivik",
		"Kjulaås",
		"Klädesholmen",
		"Klågerup",
		"Klagstorp",
		"Kläppa",
		"Klässbol",
		"Klevshult",
		"Klingsta och Allsta",
		"Klintehamn",
		"Klippan",
		"Klippans bruk",
		"Klippans kommun",
		"Klockestrand",
		"Klockrike",
		"Klöverträsk",
		"Klövsjö",
		"Knäred",
		"Knislinge",
		"Knivsta",
		"Knivsta kommun",
		"Knutby",
		"Kode",
		"Kolbäck",
		"Kolmården",
		"Kolsva",
		"Konga",
		"Köping",
		"Köpinge (Ramlösa)",
		"Köpingebro",
		"Köpings kommun",
		"Köpingsvik",
		"Köpmanholmen",
		"Kopparberg",
		"Kopparmora",
		"Koppom",
		"Korpilombolo",
		"Korsberga",
		"Korsträsk",
		"Koskullskulle",
		"Kosta",
		"Kovland",
		"Krägga",
		"Kramfors",
		"Kramfors kommun",
		"Krika",
		"Kristdala",
		"Kristianopel",
		"Kristianstad",
		"Kristianstads kommun",
		"Kristineberg",
		"Kristinehamn",
		"Kristinehamns kommun",
		"Kristvallabrunn",
		"Krokek",
		"Krokom",
		"Krokoms kommun",
		"Krokslätt",
		"Krylbo",
		"Kullö",
		"Kulltorp",
		"Kumla",
		"Kumla kommun",
		"Kumla kyrkby",
		"Kummelnäs",
		"Kungälv",
		"Kungälvs kommun",
		"Kungsängen",
		"Kungsäter",
		"Kungsbacka",
		"Kungsbacka kommun",
		"Kungsberga",
		"Kungsgården",
		"Kungshamn",
		"Kungshult",
		"Kungsör",
		"Kungsörs kommun",
		"Kusmark",
		"Kuttainen",
		"Kvänum",
		"Kvärlöv",
		"Kvibille",
		"Kvicksund",
		"Kvidinge",
		"Kvillsfors",
		"Kvisljungeby",
		"Kvissleby",
		"Kyrkesund",
		"Kyrkheddinge",
		"Kyrkhult",
		"Kyrksten",
		"Läby",
		"Läckeby",
		"Lagan",
		"Laholm",
		"Laholms kommun",
		"Lammhult",
		"Landeryd",
		"Landfjärden",
		"Landsbro",
		"Landskrona",
		"Landskrona kommun",
		"Landvetter",
		"Långås",
		"Långasjö",
		"Långedrag",
		"Länghem",
		"Långö",
		"Långsele",
		"Långshyttan",
		"Långvik",
		"Långviksmon",
		"Lanna",
		"Länna",
		"Lärbro",
		"Larv",
		"Låssby",
		"Latorpsbruk",
		"Laxå",
		"Laxå kommun",
		"Laxvik",
		"Lekebergs kommun",
		"Lekeryd",
		"Leksand",
		"Leksands kommun",
		"Leksandsnoret",
		"Lenhovda",
		"Lerdala",
		"Lerkil",
		"Lerum",
		"Lerums kommun",
		"Lesjöfors",
		"Lessebo",
		"Lessebo kommun",
		"Liatorp",
		"Liden",
		"Lidhult",
		"Lidingö",
		"Lidingö kommun",
		"Lidköping",
		"Lidköpings kommun",
		"Liljeholmen",
		"Lilla Alby",
		"Lilla Edet",
		"Lilla Edets kommun",
		"Lilla Harrie",
		"Lilla Tjärby",
		"Lillhaga",
		"Lillhärdal",
		"Lillkyrka",
		"Lillpite",
		"Lima",
		"Limedsforsen",
		"Limhamn",
		"Limmared",
		"Linderöd",
		"Lindesberg",
		"Lindesbergs kommun",
		"Lindholmen",
		"Lindö",
		"Lindome",
		"Lindsdal",
		"Lingbo",
		"Linghed",
		"Linghem",
		"Linköping",
		"Linköpings kommun",
		"Linneryd",
		"Listerby",
		"Lit",
		"Ljung",
		"Ljunga",
		"Ljungaverk",
		"Ljungby",
		"Ljungby kommun",
		"Ljungbyhed",
		"Ljungbyholm",
		"Ljunghusen",
		"Ljungsarp",
		"Ljungsbro",
		"Ljungskile",
		"Ljungstorp och Jägersbo",
		"Ljusdal",
		"Ljusdals kommun",
		"Ljusfallshammar",
		"Ljusnarsbergs kommun",
		"Ljusne",
		"Löberöd",
		"Löddeköpinge",
		"Löderup",
		"Lödöse",
		"Loftahammar",
		"Löftaskog",
		"Lögdeå",
		"Lomma",
		"Lomma kommun",
		"Lönsboda",
		"Lörby",
		"Los",
		"Lotorp",
		"Lottefors",
		"Löttorp",
		"Lövånger",
		"Lövestad",
		"Lövstalöt",
		"Löwenströmska lasarettet",
		"Lucksta",
		"Ludvigsborg",
		"Ludvika",
		"Ludvika kommun",
		"Lugnås",
		"Lugnet och Skälsmara",
		"Luleå",
		"Luleå kommun",
		"Lund",
		"Lundby",
		"Lunde",
		"Lunden",
		"Lunds kommun",
		"Lundsbrunn",
		"Lungvik",
		"Lunnarp",
		"Lycksele",
		"Lycksele kommun",
		"Lycksele marknadsplats",
		"Lyrestad",
		"Lysekil",
		"Lysekils kommun",
		"Lysvik",
		"Madängsholm",
		"Mala",
		"Malå",
		"Malå kommun",
		"Malåträsk",
		"Malen",
		"Målerås",
		"Målilla",
		"Malmbäck",
		"Malmberget",
		"Malmköping",
		"Malmö",
		"Malmö kommun",
		"Malmön",
		"Malmslätt",
		"Målsryd",
		"Malung",
		"Malung-Sälens kommun",
		"Malungsfors",
		"Månkarbo",
		"Mantorp",
		"Marbäck",
		"Margretetorp",
		"Mariannelund",
		"Marieberg",
		"Marieby",
		"Mariedal",
		"Mariefred",
		"Mariehäll",
		"Marieholm",
		"Marielund",
		"Mariestad",
		"Mariestads kommun",
		"Markaryd",
		"Markaryds kommun",
		"Marks kommun",
		"Marma",
		"Marmaskogen",
		"Marmaverken",
		"Marmorbyn",
		"Marnäs",
		"Märsta",
		"Marstrand",
		"Matfors",
		"Måttsund",
		"Medåker",
		"Medle",
		"Mehedeby",
		"Mellansel",
		"Mellbystrand",
		"Mellerud",
		"Melleruds kommun",
		"Mellösa",
		"Merlänna",
		"Mjällby",
		"Mjällom",
		"Mjöbäck",
		"Mjöhult",
		"Mjölby",
		"Mjölby kommun",
		"Mjönäs",
		"Mockfjärd",
		"Mogata",
		"Mohed",
		"Moheda",
		"Moholm",
		"Möklinta",
		"Moliden",
		"Molkom",
		"Mölle",
		"Mollösund",
		"Mölltorp",
		"Mölnbo",
		"Mölndal",
		"Mölndals kommun",
		"Mölnlycke",
		"Mönsterås",
		"Mönsterås kommun",
		"Mora",
		"Mora kommun",
		"Mörarp",
		"Morastrand",
		"Mörbylånga",
		"Mörbylånga kommun",
		"Morgongåva",
		"Morjärv",
		"Mörlunda",
		"Mörrum",
		"Mörsil",
		"Mörtnäs",
		"Morup",
		"Mosås",
		"Moskosel",
		"Motala",
		"Motala kommun",
		"Mullhyttan",
		"Mullsjö",
		"Mullsjö kommun",
		"Munga",
		"Munka-Ljungby",
		"Munkedal",
		"Munkedals kommun",
		"Munkfors",
		"Munkfors kommun",
		"Munktorp",
		"Muskö",
		"Myckle",
		"Myggenäs",
		"Myresjö",
		"Myrviken",
		"Mysingsö",
		"Mysterna",
		"Nacka kommun",
		"Naglarby och Enbacka",
		"Nälden",
		"När",
		"Nås",
		"Näs bruk",
		"Näsåker",
		"Nässjö",
		"Nässjö kommun",
		"Näsum",
		"Näsviken",
		"Nättraby",
		"Nävekvarn",
		"Nävragöl",
		"Nedansjö",
		"Nedre Gärdsjö",
		"Nikkala",
		"Nissafors",
		"Nitta",
		"Njurundabommen",
		"Njutånger",
		"Nöbbele",
		"Nödinge-Nol",
		"Nogersund",
		"Nolvik",
		"Nora",
		"Nora kommun",
		"Norberg",
		"Norbergs kommun",
		"Nordanö",
		"Nordanstigs kommun",
		"Nordingrå",
		"Nordkroken",
		"Nordmaling",
		"Nordmalings kommun",
		"Nordmark",
		"Nore",
		"Norje",
		"Norr Amsberg",
		"Norr-Hede",
		"Norra Åsum",
		"Norra Bro",
		"Norra Lagnö",
		"Norra Rörum",
		"Norrböle",
		"Norrfjärden",
		"Norrhult-Klavreström",
		"Norrköping",
		"Norrköpings kommun",
		"Norrköpings norra förstad",
		"Norrlandet",
		"Norrö",
		"Norrskedika",
		"Norrsundet",
		"Norrtälje",
		"Norrtälje kommun",
		"Norrviken",
		"Norsesund",
		"Norsholm",
		"Norsjö",
		"Norsjö kommun",
		"Nossebro",
		"Nusnäs",
		"Nya hagalund",
		"Nya Huvudsta",
		"Nya Kopparberg",
		"Nya Långenäs",
		"Nyborg",
		"Nybro",
		"Nybro kommun",
		"Nybrostrand",
		"Nye",
		"Nyfors",
		"Nygård",
		"Nyhammar",
		"Nyhem",
		"Nykil",
		"Nyköping",
		"Nyköpings kommun",
		"Nykroppa",
		"Nykvarn",
		"Nykvarns kommun",
		"Nykyrka",
		"Nyland",
		"Nymölla",
		"Nynäshamn",
		"Nynäshamns kommun",
		"Obbola",
		"Öbonäs",
		"och Sundsvalls stad",
		"Ockelbo",
		"Ockelbo kommun",
		"Öckerö",
		"Öckerö kommun",
		"Ödåkra",
		"Ödeborg",
		"Odensbacken",
		"Odensberg",
		"Odensjö",
		"Odenslund",
		"Ödeshög",
		"Ödeshögs kommun",
		"Ödsmål",
		"Öggestorp",
		"Öjersjö",
		"Oleby",
		"Ölmanäs",
		"Ölmbrotorp",
		"Ölme",
		"Ölmstad",
		"Olofstorp",
		"Olofström",
		"Olofströms kommun",
		"Olsfors",
		"Olshammar",
		"Olstorp",
		"Önnestad",
		"Onsala",
		"Onslunda",
		"Ope",
		"Optand",
		"Örby",
		"Örbyhus",
		"Örebro",
		"Örebro kommun",
		"Öregrund",
		"Örkelljunga",
		"Örkelljunga kommun",
		"Ormanäs och Stanstorp",
		"Ornäs",
		"Örnsköldsvik",
		"Örnsköldsviks kommun",
		"Orrefors",
		"Orrhammar",
		"Orrviken",
		"Orsa",
		"Orsa kommun",
		"Örserum",
		"Örsjö",
		"Örslösa",
		"Örsundsbro",
		"Örtagården",
		"Orusts kommun",
		"Örviken",
		"Osby",
		"Osby kommun",
		"Osbyholm",
		"Oskar-Fredriksborg",
		"Oskarshamn",
		"Oskarshamns kommun",
		"Oskarström",
		"Ösmo",
		"Östadkulle",
		"Östanå",
		"Östansjö",
		"Östavall",
		"Österåkers kommun",
		"Österbybruk",
		"Österbymo",
		"Österfärnebo",
		"Österforse",
		"Östersidan",
		"Österslöv",
		"Österstad",
		"Östersund",
		"Östersunds kommun",
		"Östervåla",
		"Östhammar",
		"Östhammars kommun",
		"Östhamra",
		"Östmark",
		"Östnor",
		"Östra Bispgården",
		"Östra Frölunda",
		"Östra Göinge kommun",
		"Östra Grevie",
		"Östra Husby",
		"Östra Karup",
		"Östra Ljungby",
		"Östra Ryd",
		"Östra Sönnarslöv",
		"Östra Tommarp",
		"Ostvik",
		"Otterbäcken",
		"Ovanåker",
		"Ovanåkers kommun",
		"Överhörnäs",
		"Överkalix",
		"Överkalix kommun",
		"Överlida",
		"Övertorneå",
		"Övertorneå kommun",
		"Överum",
		"Ovesholm",
		"Övre Soppero",
		"Öxabäck",
		"Oxbacken",
		"Oxelösund",
		"Oxelösunds kommun",
		"Öxeryd",
		"Oxie",
		"Påarp",
		"Pajala",
		"Pajala kommun",
		"Påläng",
		"Pålsboda",
		"Parksidan",
		"Partille",
		"Partille kommun",
		"Påryd",
		"Påskallavik",
		"Pataholm",
		"Pauliström",
		"Persberg",
		"Persbo",
		"Pershagen",
		"Persön",
		"Perstorp",
		"Perstorps kommun",
		"Pilgrimstad",
		"Piperskärr",
		"Piteå",
		"Piteå kommun",
		"Porjus",
		"Pukavik",
		"Råå",
		"Rabbalshede",
		"Råby",
		"Råda",
		"Ragunda kommun",
		"Raksta",
		"Rälla",
		"Ramlösa",
		"Ramnäs",
		"Ramsberg",
		"Ramsele",
		"Ramstalund",
		"Ramvik",
		"Rånäs",
		"Råneå",
		"Rångedala",
		"Rängs sand",
		"Rånnaväg",
		"Ränneslöv",
		"Ransta",
		"Rappestad",
		"Råsunda",
		"Rättvik",
		"Rättviks kommun",
		"Raus plantering",
		"Rävemåla",
		"Rävlanda",
		"Reftele",
		"Rejmyre",
		"Rengsjö",
		"Repbäcken",
		"Resarö",
		"Revingeby",
		"Riala",
		"Riddarhyttan",
		"Rimbo",
		"Rimforsa",
		"Ringarum",
		"Ringsegård",
		"Rinkaby",
		"Rinkabyholm",
		"Risögrund",
		"Rixö",
		"Röbäck",
		"Robertsfors",
		"Robertsfors kommun",
		"Rockhammar",
		"Rockneby",
		"Röda holme",
		"Rödbo",
		"Rödeby",
		"Röfors",
		"Röke",
		"Roknäs",
		"Rolfs",
		"Rolfstorp",
		"Roma",
		"Romakloster",
		"Rönnäng",
		"Ronneby",
		"Ronneby kommun",
		"Ronnebyhamn",
		"Rönneshytta",
		"Rönninge",
		"Rörö",
		"Rörvik",
		"Rosenfors",
		"Rosenlund",
		"Rosersberg",
		"Rossön",
		"Röstånga",
		"Rosvik",
		"Rot",
		"Roteberg",
		"Rottne",
		"Rottneros",
		"Ruda",
		"Rundvik",
		"Runemo",
		"Runhällen",
		"Runtuna",
		"Rutvik",
		"Rya",
		"Ryd",
		"Rydaholm",
		"Rydal",
		"Rydbo",
		"Rydboholm",
		"Rydebäck",
		"Rydöbruk",
		"Rydsgård",
		"Rydsnäs",
		"Ryssby",
		"Säffle",
		"Säffle kommun",
		"Sågmyra",
		"Sala",
		"Sala kommun",
		"Salbohed",
		"Saleby",
		"Salems kommun",
		"Sälen",
		"Sälgsjön",
		"Saltsjöbaden",
		"Saltvik",
		"Sandared",
		"Sandarne",
		"Sandhem",
		"Sandhult",
		"Sandskogen",
		"Sandslån",
		"Sandviken",
		"Sandvikens kommun",
		"Sangis",
		"Sankt Lars",
		"Sankt Olof",
		"Sannahed",
		"Sannäs",
		"Särna",
		"Särö",
		"Säter",
		"Säters kommun",
		"Sätila",
		"Sätofta",
		"Sätra brunn",
		"Sävar",
		"Sävast",
		"Säve",
		"Sävedalen",
		"Sävja",
		"Sävsjö",
		"Sävsjö kommun",
		"Saxdalen",
		"Saxtorpsskogen",
		"sedermera omdöpt till",
		"Segeltorp",
		"Segersta",
		"Segmon",
		"Selja",
		"Sennan",
		"Seskarö",
		"Sexdrega",
		"Sibbhult",
		"Sibble",
		"Sibo",
		"Sidensjö",
		"Sifferbo",
		"Sigtuna",
		"Sigtuna kommun",
		"Sikfors",
		"Siljansnäs",
		"Silverdalen",
		"Simlångsdalen",
		"Simonstorp",
		"Simris",
		"Simrishamn",
		"Simrishamns kommun",
		"Sjöberg",
		"Sjöbo",
		"Sjöbo kommun",
		"Sjöbo sommarby och Svansjö sommarby",
		"Sjödiken",
		"Sjögestad",
		"Sjömarken",
		"Sjörröd",
		"Sjösa",
		"Sjötofta",
		"Sjötorp",
		"Sjövik",
		"Sjulsmark",
		"Sjunnen",
		"Sjuntorp",
		"Skagersvik",
		"Skälderviken",
		"Skällinge",
		"Skånes-Fagerhult",
		"Skänninge",
		"Skanör med Falsterbo",
		"Skåpafors",
		"Skara",
		"Skara kommun",
		"Skärblacka",
		"Skåre",
		"Skärgårdsstad",
		"Skärhamn",
		"Skärplinge",
		"Skärstad",
		"Skattkärr",
		"Skattungbyn",
		"Skavkulla och Skillingenäs",
		"Skebobruk",
		"Skebokvarn",
		"Skeda udde",
		"Skedala",
		"Skede",
		"Skee",
		"Skegrie",
		"Skellefteå",
		"Skellefteå kommun",
		"Skelleftehamn",
		"Skelleftestrand",
		"Skene",
		"Skepparkroken",
		"Skepplanda",
		"Skeppsdalsström",
		"Skeppshult",
		"Skillingaryd",
		"Skillinge",
		"Skinnskatteberg",
		"Skinnskattebergs kommun",
		"Skivarp",
		"Skoby",
		"Skog",
		"Skoghall",
		"Skogsby",
		"Skogstorp",
		"Sköldinge",
		"Sköllersta",
		"Skölsta",
		"Skönsmon",
		"Skottorp",
		"Skottsund",
		"Skövde",
		"Skövde kommun",
		"Skrea",
		"Skruv",
		"Skultorp",
		"Skultuna",
		"Skummeslövsstrand",
		"Skurup",
		"Skurups kommun",
		"Skutskär",
		"Skyttorp",
		"Slaka",
		"Slätten",
		"Slite",
		"Slöinge",
		"Slottsbron",
		"Slottsskogen",
		"Smålandsstenar",
		"Smedby",
		"Smedjebacken",
		"Smedjebackens kommun",
		"Smedstorp",
		"Smögen",
		"Smygehamn",
		"Snättringe",
		"Snöveltorp",
		"Söderåkra",
		"Söderala",
		"Söderbärke",
		"Söderby-Karl",
		"Söderfors",
		"Söderhamn",
		"Söderhamns kommun",
		"Söderköping",
		"Söderköpings kommun",
		"Söderskogen",
		"Södersvik",
		"Södertälje",
		"Södertälje kommun",
		"Södra Bergsbyn och Stackgrönnan",
		"Södra Klagshamn",
		"Södra Näs",
		"Södra Sandby",
		"Södra Sunderbyn",
		"Södra Vi",
		"Södra Vrams fälad",
		"Sofielund",
		"Solberga",
		"Solhem",
		"Sollebrunn",
		"Sollefteå",
		"Sollefteå kommun",
		"Sollentuna kommun",
		"Sollerön",
		"Solna kommun",
		"Solsidan",
		"Solvarbo",
		"Sölvesborg",
		"Sölvesborgs kommun",
		"Sommen",
		"Sonstorp",
		"Söråker",
		"Sörfors",
		"Sörforsa",
		"Sörmjöle",
		"Sorsele",
		"Sorsele kommun",
		"Sörstafors",
		"Sorunda",
		"Sörvik",
		"Sösdala",
		"Sotenäs kommun",
		"Sövde",
		"Sövestad",
		"Spångsholm",
		"Sparreholm",
		"Spillersboda",
		"Spjutsbygd",
		"Staffanstorp",
		"Staffanstorps kommun",
		"Staffanstorps kommuner",
		"Stallarholmen",
		"Ställdalen",
		"Stånga",
		"Stångby",
		"Starrkärr och Näs",
		"Stava",
		"Stavreviken",
		"Stavsjö",
		"Stavsnäs",
		"Stehag",
		"Stenhamra",
		"Steninge",
		"Stensele",
		"Stensjön",
		"Stenstorp",
		"Stensund och Krymla",
		"Stenungsön",
		"Stenungsund",
		"Stenungsunds kommun",
		"Sticklinge udde",
		"Stidsvig",
		"Stigen",
		"Stigtomta",
		"Stjärnhov",
		"Stoby",
		"Stocka",
		"Stockamöllan",
		"Stockaryd",
		"Stöcke",
		"Stocken",
		"Stockholm",
		"Stockholms kommun",
		"Stöcksjö",
		"Stocksunds villastad",
		"Stockvik",
		"Stöde",
		"Stöllet",
		"Stöpen",
		"Storå",
		"Stora Bugärde",
		"Stora Dyrön",
		"Stora Herrestad",
		"Stora Höga",
		"Stora Levene",
		"Stora Mellby",
		"Stora Mellösa",
		"Stora Vika",
		"Storebro",
		"Storfors",
		"Storfors kommun",
		"Storuman",
		"Storumans kommun",
		"Storvik",
		"Storvreta",
		"Strålsnäs",
		"Strandnorum",
		"Strängnäs",
		"Strängnäs kommun",
		"Strångsjö",
		"Stråssa",
		"Striberg",
		"Strömma",
		"Strömsbruk",
		"Strömsfors",
		"Strömsholm",
		"Strömsnäs bruk",
		"Strömsnäsbruk",
		"Strömstad",
		"Strömstads kommun",
		"Strömsund",
		"Strömsunds kommun",
		"Strövelstorp",
		"Stugun",
		"Sturefors",
		"Sturkö",
		"Stuvsta",
		"Styrsö",
		"Sulvik",
		"Sund",
		"Sundborn",
		"Sundby",
		"Sundbybergs kommun",
		"Sundbyholm",
		"Sundhultsbrunn",
		"Sundsbruk",
		"Sundsvall",
		"Sundsvalls kommun",
		"Sunnanå",
		"Sunnansjö",
		"Sunne",
		"Sunne kommun",
		"Sunnemo",
		"Sunningen",
		"Surahammar",
		"Surahammars kommun",
		"Surte",
		"Svalöv",
		"Svalövs kommun",
		"Svalsta",
		"Svanberga",
		"Svanesund",
		"Svängsta",
		"Svanskog",
		"Svanstein",
		"Svanvik",
		"Svappavaara",
		"Svärdsjö",
		"Svartå",
		"Svartbyn",
		"Svarte",
		"Svartehallen",
		"Svärtinge",
		"Svartöstaden",
		"Svartvik",
		"Svedala",
		"Svedala kommun",
		"Sveg",
		"Svegsmon",
		"Svenljunga",
		"Svenljunga kommun",
		"Svensbyn",
		"Svenshögen",
		"Svenstavik",
		"Svenstorp",
		"Svinninge",
		"Sya",
		"Sylta",
		"Sysslebäck",
		"Taberg",
		"Täby",
		"Täby kommun",
		"Täfteå",
		"Tågarp",
		"Tahult",
		"Täljö",
		"Tallåsen",
		"Tällberg",
		"Tallvik",
		"Tandsbyn",
		"Tånga och Rögle",
		"Tångaberg",
		"Tången",
		"Tanums kommun",
		"Tanumshede",
		"Tärnaby",
		"Tärnsjö",
		"Tävelsås",
		"Tavelsjö",
		"Teckomatorp",
		"Teg",
		"Tenhult",
		"Tibro",
		"Tibro kommun",
		"Tidaholm",
		"Tidaholms kommun",
		"Tidan",
		"Tidö-Lindö",
		"Tierp",
		"Tierps kommun",
		"Tillberga",
		"Timmele",
		"Timmernabben",
		"Timmersdala",
		"Timrå",
		"Timrå kommun",
		"Timsfors",
		"Tingsryd",
		"Tingsryds kommun",
		"Tingstäde",
		"Tjällmo",
		"Tjärnheden",
		"Tjautjas/Cavccas",
		"Tjörnarp",
		"Tjörnekalv",
		"Tjörns kommun",
		"Tjuvkil",
		"Tobo",
		"Töcksfors",
		"Tofta",
		"Toftbyn",
		"Tollarp",
		"Tollered",
		"Töllsjö",
		"Tomelilla",
		"Tomelilla kommun",
		"Tomtebo",
		"Torarp",
		"Torbjörntorp",
		"Töre",
		"Töreboda",
		"Töreboda kommun",
		"Torekov",
		"Torestorp",
		"Törestorp",
		"Torhamn",
		"Tormestorp",
		"Torna Hällestad",
		"Torpsbruk",
		"Torpshammar",
		"Torreby",
		"Torsåker",
		"Torsång",
		"Torsås",
		"Torsås kommun",
		"Torsby",
		"Torsby kommun",
		"Torsebro",
		"Torshälla",
		"Torshälla huvud",
		"Torslanda",
		"Tortuna",
		"Torup",
		"Tösse",
		"Tosseryd",
		"Totebo",
		"Totra",
		"Trädet",
		"Tranås",
		"Tranås kommun",
		"Tranås kvarn",
		"Tranemo",
		"Tranemo kommun",
		"Trånghalla",
		"Trångsviken",
		"Tranholmen",
		"Transtrand",
		"Traryd",
		"Träslövsläge",
		"Tråvad",
		"Trekanten",
		"Trelleborg",
		"Trelleborgs kommun",
		"Trödje",
		"Trollhättan",
		"Trollhättans kommun",
		"Trönninge",
		"Trosa",
		"Trosa kommun",
		"Trulsegården",
		"Tulebo",
		"Tumba",
		"Tumbo",
		"Tumlehed",
		"Tun",
		"Tuna",
		"Tunadal",
		"Tunnerstad",
		"Tureholm",
		"Tvååker",
		"Tvärålund",
		"Tvärskog",
		"Tving",
		"Tygelsjö",
		"Tylösand",
		"Tyresö kommun",
		"Tyringe",
		"Tystberga",
		"Ucklum",
		"Uddebo",
		"Uddeholm",
		"Uddevalla",
		"Uddevalla kommun",
		"Uddheden",
		"Ulebergshamn",
		"Ullånger",
		"Ullared",
		"Ullatti",
		"Ullervad",
		"Ulricehamn",
		"Ulricehamns kommun",
		"Ulvåker",
		"Ulvkälla",
		"Umeå",
		"Umeå kommun",
		"Unbyn",
		"Undenäs",
		"Undersåker",
		"Unnaryd",
		"uppgick i Limhamns köping",
		"Upphärad",
		"Upplanda",
		"Upplands Väsby",
		"Upplands Väsby kommun",
		"Upplands-Bro kommun",
		"Uppsala",
		"Uppsala kommun",
		"Uppvidinge kommun",
		"Urshult",
		"Ursviken",
		"Utansjö",
		"Utby",
		"Utvälinge",
		"Väckelsång",
		"Vad",
		"Väderstad",
		"Vadstena",
		"Vadstena kommun",
		"Väggarp",
		"Vaggeryd",
		"Vaggeryds kommun",
		"Vagnhärad",
		"Väjern",
		"Väländan",
		"Vålberg",
		"Valbo",
		"Valdemarsvik",
		"Valdemarsviks kommun",
		"Valje",
		"Valjeviken",
		"Valla",
		"Vallåkra",
		"Vallargärdet",
		"Vallberga",
		"Vallda",
		"Vallentuna",
		"Vallentuna kommun",
		"Vallsta",
		"Vallvik",
		"Valskog",
		"Våmhus",
		"Väne-Åsaka",
		"Vänersborg",
		"Vänersborgs kommun",
		"Vånga",
		"Vänge",
		"Vankiva",
		"Vännäs",
		"Vännäs kommun",
		"Vännäsberget",
		"Vännäsby",
		"Vannsätter",
		"Vansbro",
		"Vansbro kommun",
		"Vaplan",
		"Vara",
		"Vara kommun",
		"Varberg",
		"Varbergs kommun",
		"Vårdsätra",
		"Varekil",
		"Vårgårda",
		"Vårgårda kommun",
		"Vargön",
		"Väring",
		"Värmdö kommun",
		"Värmdö-Evlinge",
		"Värmlandsbro",
		"Värnamo",
		"Värnamo kommun",
		"Varnhem",
		"Väröbacka",
		"Värsås",
		"Vårsta",
		"Vartofta",
		"Väse",
		"Väskinde",
		"Vassmolösa",
		"Västanfors",
		"Västanvik",
		"Västerås",
		"Västerås kommun",
		"Västerberg",
		"Västerby",
		"Västerfärnebo",
		"Västerhaninge",
		"Västerhejde",
		"Västerhus",
		"Västerljung",
		"Västerlösa",
		"Västermyckeläng",
		"Västervik",
		"Västerviks kommun",
		"Västibyn",
		"Västra Ämtervik",
		"Västra Bispgården",
		"Västra Bodarna",
		"Västra Borsökna",
		"Västra Hagen",
		"Västra Husby",
		"Västra Ingelstad",
		"Västra Karup",
		"Västra Klagstorp",
		"Västra Sallerup",
		"Västra Torup",
		"Vattholma",
		"Vattjom",
		"Vattnäs",
		"Vattubrinken",
		"Vaxholm",
		"Vaxholms kommun",
		"Växjö",
		"Växjö kommun",
		"Växjö Östregård",
		"Våxtorp",
		"Veberöd",
		"Veddige",
		"Vedevåg",
		"Vedum",
		"Vegby",
		"Veinge",
		"Vejbystrand",
		"Velanda",
		"Vellinge",
		"Vellinge kommun",
		"Vemdalen",
		"Vena",
		"Venjan",
		"Vessigebro",
		"Vetlanda",
		"Vetlanda kommun",
		"Vi",
		"Vibble",
		"Viby",
		"Vickleby",
		"Vidja",
		"Vidöåsen",
		"Vidsel",
		"Vik",
		"Vika",
		"Vikarbyn",
		"Viken",
		"Vikingstad",
		"Vikmanshyttan",
		"Viksäter",
		"Viksjöfors",
		"Vilan",
		"Vilhelmina",
		"Vilhelmina kommun",
		"Villshärad",
		"Vilshult",
		"Vimmerby",
		"Vimmerby kommun",
		"Vinäs",
		"Vinberg",
		"Vinbergs kyrkby",
		"Vindeln",
		"Vindelns kommun",
		"Vingåker",
		"Vingåkers kommun",
		"Vinninga",
		"Vinnö",
		"Vinslöv",
		"Vintrie",
		"Vintrosa",
		"Virsbo",
		"Virserum",
		"Visby",
		"Viskafors",
		"Vislanda",
		"Vissefjärda",
		"Vistträsk",
		"Vitaby",
		"Vitemölla",
		"Vittangi",
		"Vittaryd",
		"Vittinge",
		"Vittjärv",
		"Vittsjö",
		"Vittskövle",
		"Vivsta-Näs",
		"Vollsjö",
		"Vrångö",
		"Vrena",
		"Vretstorp",
		"Vrigstad",
		"Vuollerim",
		"Ydre kommun",
		"Yngsjö",
		"Ysane",
		"Ysby",
		"Ystad",
		"Ystads kommun",
		"Ytterån",
		"Ytterhogdal",
		"Yttermalung",
		"Ytternäs och Vreta",
		"Zinkgruvan"
		];
		$( ".from, .to" ).autocomplete({
			delay: 0,
			minLength: 3,
			source: availableTags
		});
	});  	
  	


