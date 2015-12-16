require("coffee-script/register");

var synchronizer = require("../synchronizer.coffee");

synchronizer.synchronize(process.env.WOOW_USER_ID);
