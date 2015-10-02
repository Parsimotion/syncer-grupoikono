require("coffee-script/register");

var synchronizer = require("../synchronizer.coffee");

synchronizer.synchronize(process.env.NETSHOES_USER_ID);
