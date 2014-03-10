
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
win.open();

var TiPopup = require('com.popup');
Ti.API.info("module is => " + TiPopup);

// TODO: Change createView to createPopup
var popup = TiPopup.createView({
	width: 200,
	height: 200,
	backgroundColor: 'blue' // used for testing UIView location
});
win.add(popup);

popup.create({
	items: ['One', 'Two', 'Three']
});

popup.addEventListener('click', function() {
	popup.show();
	/* // you can tap the area outside the square to hide it, otherwise it hides when you click again with the timeout function
	setTimeout(function() {
		popup.hide();
	}, 2000); 
	*/
});