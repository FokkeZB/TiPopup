
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
win.open();

var TiPopup = require('com.popup');
Ti.API.info("module is => " + TiPopup);

var popup = TiPopup.createPopupMenu();

var block = Ti.UI.createView({
	width: 100,
	height: 100,
	backgroundColor: 'black'
});

win.add(block);
win.add(popup);

popup.create({
	items: ['One', 'Two', 'Three']
});

popup.addEventListener('click', function(e) {
	Ti.API.log('index: ' + e.index);
});

win.addEventListener('longpress', function() {
	popup.show({
		view: block
	});
});