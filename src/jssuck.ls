;;;; src/suck.ls
;;; Exports user functions of jssuck.

((function ()
  (var fs (require 'fs')
       decode (require './unfuck.js')
       encode (require './fuck.js'))

  (var jssuck
   {encode: encode,
    decode: decode})

  ;; TODO: pretty print
  ;; TODO: save
  (var print
   (function (data pretty save)
    (console.log data)
    (console.log '\n')
   )
  )

  (var autorun
   (function (argv)
    (when (< argv.length 3)
     (var message (+ "Usage: jssuck [OPTION]... [FILE]...\n\n"
                   "JSSuck takes multiple files and both directions at once.\n"
                   "Just put the files what you do encode or decode.\n\n"
                   "Encoding:\n"
                   "  -1: Process jsfuck [DEFAULT]\n"
                   "  -2: Process uglified jsfuck.\n"
                   "Decoding:\n"
                   "  -p: Enable pretty print. This option is unactivated in default.\n"
                   "Output:\n"
                   "-s: Store the result in each files. Default is stdout."))
     (console.error message)
     (process.exit -2))
     
    ;; Parse options
    (var options {pretty: false, lv1: true, lv2: false, save: false, files: []})
    (argv.shift) (argv.shift)
    (each argv
     (function (arg index list)
      (cond (= '-2' arg) (set options['lv2'] true)
            (= '-p' arg) (set options['pretty'] true)
            (= '-s' arg) (set options['save'] true)
            true (do
                  (var stat (fs.statSync arg))
                  (when (stat.isFile)
                   (options['files'].push arg))))))

    (each options['files']
     (function (file index list)
      (var data (fs.readFileSync(file, 'utf8')))
      (if (= 0 (data.search /[^()\[\]+!]/))
       (print
        (encode data (= options['lv1'] options['lv2']))
        false options['save'])
       (print
        (decode data options['pretty'])
        options['pretty'] options['save']))))
    )
  )

  (set jssuck['autorun'] autorun)
  (set module.exports jssuck)
))