path = require "path"

startsWith = (string, substring) ->
  string.lastIndexOf(substring, 0) is 0

exports.config =
  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  modules:
    definition: false
    wrapper: false

  conventions:
    ignored: (filePath) ->
      ignoreRE = /^vendor\/(?!scripts|styles|assets)/
      ignoreRE.test(filePath) or startsWith path.basename(filePath), '_'

  coffeelint:
    pattern: /^app\/.*\.coffee$/
    # options doc : http: //www.coffeelint.org/#options
    options:
      max_line_length: level: "ignore"
      no_backticks: level: "ignore"
      indentation:
        value: 2
        level: "ignore"

  paths:
    public: 'public'

  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^(bower_components|vendor)/
        'test/scenarios.js': /^test(\/|\\)e2e/
      order:
        before: [
          'vendor/scripts/bootstrap/bootstrap-tooltip.js'
        ]

    stylesheets:
      joinTo:
        'css/app.css': /^(app|vendor)/
    templates:
      joinTo: 'js/templates.js'

  plugins:
    jade:
      pretty: yes # Adds pretty-indentation whitespaces to output (false by default)

  # Enable or disable minifying of result js / css files.
  # minify: true
