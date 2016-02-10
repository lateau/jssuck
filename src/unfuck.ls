;;;; src/unfuck.ls
;;; JsFuck decoder.

((function ()
  ;; TODO: move these codes into other lispyscript.
  (var jsfuck (require 'jsfuck')
       encode jsfuck.JSFuck.encode)

  ;; TODO: Retrieve more patterns.
  (var FUCKED
   ;; Elements that should fucked by jsfuck.
   ['false', 'true', 'undefined', 'NaN', 'Infinity',
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
    ' ', '!', "\"", '#', '$', '%', '&', '\\', '(', ')', '*', '+', ',', '-', '.', '/', ':', ';', '<', '=',
    '>', '?', '@', '[', '\\', ']', '^', '_', '`', '{', '|', '}', '~'])

  (var MAPPING
   ;; Storage for real patterns.
   [])
  
  (var initPatterns
   (function ()
    (each FUCKED
     (function (source index list)
      (var encoded (encode source false)
           escaped (encoded.replace /(\(|\)|\[|\]|\!|\+)/g '\\$1')
           pattern (+ escaped '\\+?'))
      (MAPPING.push [source, pattern])))
    (MAPPING.sort (function (a b) (- b[1].length a[1].length)))))

  ;; Decode jsfucked input string to normal js.
  ;; Static pattern definition is not necessary here, just simply run jsfuck
  ;; itself to find the patterns exactly same as jsfuck it does.
  ;;
  ;; This could be slower than solid pattern matching.
  (var decode
   (function (fucked pretty)
    ;; TODO: delete spaces before replacing
    (var output fucked)
    (each MAPPING
     (function (m)
      (var pattern (new RegExp m[1] 'g'))
      (set output (output.replace pattern m[0]))))
    output))

  (initPatterns)

  ;; Exports
  (set module.exports decode)
))