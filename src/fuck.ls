;;;; src/fuck.ls
;;; Provides 2ways fuck up js.

((function ()
  (var jsfuck (require 'jsfuck')
       fuckcode jsfuck.JSFuck.encode)

  ;; TODO: uglify
  (var encode
   (function (data ugly)
    (fuckcode data false)
   ))

  
  ;; Exports
  (set module.exports encode)
))