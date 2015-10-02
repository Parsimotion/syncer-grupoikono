require("coffee-script/register");

var synchronizer = require("../synchronizer.coffee");

synchronizer.synchronize(process.env.MOTOMEL_USER_ID);
