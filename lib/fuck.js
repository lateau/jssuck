// Generated by LispyScript v1.0.0
(function() {
    var jsfuck = require('jsfuck'),
        fuckcode = jsfuck.JSFuck.encode;
    var encode = function(data,ugly) {
        return (ugly ?
            (function() {
                var uglify = require('uglify-js'),
                    uglified = uglify.minify(data,{fromString: true});
                return fuckcode(uglified.code,false);
            })() :
            fuckcode(data,false));
    };
    module.exports = encode;
})();
