
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
win.open();

var TiPopup = require('com.popup');
Ti.API.info("module is => " + TiPopup);

// TODO: Change createView to createPopup
var popup = TiPopup.createView({
	//width: 200,
	//height: 200,
	backgroundColor: 'grey' // used for testing UIView location
});

var block = Ti.UI.createView({
	width: 100,
	height: 100,
	backgroundColor: 'black'
});
win.add(popup);
win.add(block);

popup.create({
	items: ['One', 'Two', 'Three']
});

popup.addEventListener('click', function(e) {
	Ti.API.log('index: ' + e.index);
});

block.addEventListener('click', function(e) {
	Ti.API.log('Red block clicked');
	Ti.API.log(JSON.stringify(e));
	popup.show({
		view: block
	});
	/* // you can tap the area outside the square to hide it, otherwise it hides when you click again with the timeout function
	setTimeout(function() {
		popup.hide();
	}, 2000); 
	*/
});
