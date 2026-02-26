# plannotate CWL Generation Report

## plannotate_batch

### Tool Description
Annotates engineered DNA sequences, primarily plasmids. Accepts a FASTA or GenBank file and outputs a GenBank file with annotations, as well as an optional interactive plasmid map as an HTLM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/plannotate:1.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/barricklab/pLannotate
- **Package**: https://anaconda.org/channels/bioconda/packages/plannotate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plannotate/overview
- **Total Downloads**: 109.5K
- **Last updated**: 2025-06-12
- **GitHub**: https://github.com/barricklab/pLannotate
- **Stars**: N/A
### Original Help Text
```text
Usage: plannotate batch [OPTIONS]

  Annotates engineered DNA sequences, primarily plasmids. Accepts a FASTA or
  GenBank file and outputs a GenBank file with annotations, as well as an
  optional interactive plasmid map as an HTLM file.

Options:
  -i, --input TEXT      location of a FASTA or GBK file  [required]
  -o, --output TEXT     location of output folder. DEFAULT: current dir
  -f, --file_name TEXT  name of output file (do not add extension). DEFAULT:
                        input file name
  -s, --suffix TEXT     suffix appended to output files. Use '' for no suffix.
                        DEFAULT: '_pLann'
  -y, --yaml_file TEXT  path to YAML file for custom databases. DEFAULT:
                        builtin
  -l, --linear          enables linear DNA annotation
  -h, --html            creates an html plasmid map in specified path
  -hf, --htmlfull       creates an html plasmid map in specified path, with
                        bokeh baked in
  -c, --csv             creates a cvs file in specified path
  -d, --detailed        uses modified algorithm for a more-detailed search
                        with more false positives
  -x, --no_gbk          supresses GenBank output file
  --help                Show this message and exit.
```


## plannotate_setupdb

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/plannotate:1.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/barricklab/pLannotate
- **Package**: https://anaconda.org/channels/bioconda/packages/plannotate/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Databases already downloaded.

Run 'plannotate streamlit' or 'plannotate batch {arguments}' to launch pLannotate.
To get a list of available arguments for command line use, run 'plannotate batch --help'.
Please also consider citing: https://doi.org/10.1093/nar/gkab374 :)
```


## plannotate_streamlit

### Tool Description
Launches pLannotate as an interactive web app.

### Metadata
- **Docker Image**: quay.io/biocontainers/plannotate:1.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/barricklab/pLannotate
- **Package**: https://anaconda.org/channels/bioconda/packages/plannotate/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: plannotate streamlit [OPTIONS]

  Launches pLannotate as an interactive web app.

Options:
  --global.disableWatchdogWarning BOOLEAN
                                  By default, Streamlit checks if the Python
                                  watchdog module is available and, if not,
                                  prints a warning asking for you to install
                                  it. The watchdog module is not required, but
                                  highly recommended. It improves Streamlit's
                                  ability to detect changes to files in your
                                  filesystem.
                                  
                                  If you'd like to turn off this warning, set
                                  this to True.  [env var:
                                  STREAMLIT_GLOBAL_DISABLE_WATCHDOG_WARNING]
  --global.showWarningOnDirectExecution BOOLEAN
                                  If True, will show a warning when you run a
                                  Streamlit-enabled script via "python
                                  my_script.py".  [env var: STREAMLIT_GLOBAL_S
                                  HOW_WARNING_ON_DIRECT_EXECUTION]
  --global.developmentMode BOOLEAN
                                  Are we in development mode.
                                  
                                  This option defaults to True if and only if
                                  Streamlit wasn't installed normally.  [env
                                  var: STREAMLIT_GLOBAL_DEVELOPMENT_MODE]
  --global.logLevel TEXT          Level of logging: 'error', 'warning',
                                  'info', or 'debug'.
                                  
                                     Default: 'info'     global.logLevel has
                                     been replaced with logger.level -
                                     2020-11-30  [env var:
                                     STREAMLIT_GLOBAL_LOG_LEVEL]
  --global.unitTest BOOLEAN       Are we in a unit test?
                                  
                                  This option defaults to False.  [env var:
                                  STREAMLIT_GLOBAL_UNIT_TEST]
  --global.suppressDeprecationWarnings BOOLEAN
                                  Hide deprecation warnings in the streamlit
                                  app.  [env var: STREAMLIT_GLOBAL_SUPPRESS_DE
                                  PRECATION_WARNINGS]
  --global.minCachedMessageSize FLOAT
                                  Only cache ForwardMsgs that are greater than
                                  or equal to this minimum.  [env var:
                                  STREAMLIT_GLOBAL_MIN_CACHED_MESSAGE_SIZE]
  --global.maxCachedMessageAge INTEGER
                                  Expire cached ForwardMsgs whose age is
                                  greater than this value. A message's age is
                                  defined by how many times its script has
                                  finished running since the message has been
                                  accessed.  [env var:
                                  STREAMLIT_GLOBAL_MAX_CACHED_MESSAGE_AGE]
  --global.dataFrameSerialization TEXT
                                  DataFrame serialization.
                                  
                                  Acceptable values: - 'legacy': Serialize
                                  DataFrames using Streamlit's custom format.
                                  Slow   but battle-tested. - 'arrow':
                                  Serialize DataFrames using Apache Arrow.
                                  Much faster and versatile.  [env var:
                                  STREAMLIT_GLOBAL_DATA_FRAME_SERIALIZATION]
  --logger.level TEXT             Level of logging: 'error', 'warning',
                                  'info', or 'debug'.
                                  
                                  Default: 'info'  [env var:
                                  STREAMLIT_LOGGER_LEVEL]
  --logger.messageFormat TEXT     String format for logging messages. If
                                  logger.datetimeFormat is set, logger
                                  messages will default to
                                  `%(asctime)s.%(msecs)03d %(message)s`. See
                                  [Python's documentation](https://docs.python
                                  .org/2.6/library/logging.html#formatter-
                                  objects) for available attributes.
                                  
                                  Default: "%(asctime)s %(message)s"  [env
                                  var: STREAMLIT_LOGGER_MESSAGE_FORMAT]
  --client.caching BOOLEAN        Whether to enable st.cache.  [env var:
                                  STREAMLIT_CLIENT_CACHING]
  --client.displayEnabled BOOLEAN
                                  If false, makes your Streamlit script not
                                  draw to a Streamlit app.  [env var:
                                  STREAMLIT_CLIENT_DISPLAY_ENABLED]
  --client.showErrorDetails BOOLEAN
                                  Controls whether uncaught app exceptions are
                                  displayed in the browser. By default, this
                                  is set to True and Streamlit displays app
                                  exceptions and associated tracebacks in the
                                  browser.
                                  
                                  If set to False, an exception will result in
                                  a generic message being shown in the
                                  browser, and exceptions and tracebacks will
                                  be printed to the console only.  [env var:
                                  STREAMLIT_CLIENT_SHOW_ERROR_DETAILS]
  --runner.magicEnabled BOOLEAN   Allows you to type a variable or string by
                                  itself in a single line of Python code to
                                  write it to the app.  [env var:
                                  STREAMLIT_RUNNER_MAGIC_ENABLED]
  --runner.installTracer BOOLEAN  Install a Python tracer to allow you to stop
                                  or pause your script at any point and
                                  introspect it. As a side-effect, this slows
                                  down your script's execution.  [env var:
                                  STREAMLIT_RUNNER_INSTALL_TRACER]
  --runner.fixMatplotlib BOOLEAN  Sets the MPLBACKEND environment variable to
                                  Agg inside Streamlit to prevent Python
                                  crashing.  [env var:
                                  STREAMLIT_RUNNER_FIX_MATPLOTLIB]
  --runner.postScriptGC BOOLEAN   Run the Python Garbage Collector after each
                                  script execution. This can help avoid excess
                                  memory use in Streamlit apps, but could
                                  introduce delay in rerunning the app script
                                  for high-memory-use applications.  [env var:
                                  STREAMLIT_RUNNER_POST_SCRIPT_GC]
  --server.folderWatchBlacklist TEXT
                                  List of folders that should not be watched
                                  for changes. This impacts both "Run on Save"
                                  and @st.cache.
                                  
                                  Relative paths will be taken as relative to
                                  the current working directory.
                                  
                                  Example: ['/home/user1/env',
                                  'relative/path/to/folder']  [env var:
                                  STREAMLIT_SERVER_FOLDER_WATCH_BLACKLIST]
  --server.fileWatcherType TEXT   Change the type of file watcher used by
                                  Streamlit, or turn it off completely.
                                  
                                  Allowed values: * "auto"     : Streamlit
                                  will attempt to use the watchdog module, and
                                  falls back to polling if watchdog is not
                                  available. * "watchdog" : Force Streamlit to
                                  use the watchdog module. * "poll"     :
                                  Force Streamlit to always use polling. *
                                  "none"     : Streamlit will not watch files.
                                  [env var:
                                  STREAMLIT_SERVER_FILE_WATCHER_TYPE]
  --server.cookieSecret TEXT      Symmetric key used to produce signed
                                  cookies. If deploying on multiple replicas,
                                  this should be set to the same value across
                                  all replicas to ensure they all share the
                                  same secret.
                                  
                                  Default: randomly generated secret key.
                                  [env var: STREAMLIT_SERVER_COOKIE_SECRET]
  --server.headless BOOLEAN       If false, will attempt to open a browser
                                  window on start.
                                  
                                  Default: false unless (1) we are on a Linux
                                  box where DISPLAY is unset, or (2) we are
                                  running in the Streamlit Atom plugin.  [env
                                  var: STREAMLIT_SERVER_HEADLESS]
  --server.runOnSave BOOLEAN      Automatically rerun script when the file is
                                  modified on disk.
                                  
                                  Default: false  [env var:
                                  STREAMLIT_SERVER_RUN_ON_SAVE]
  --server.allowRunOnSave BOOLEAN
                                  Allows users to automatically rerun when app
                                  is updated.
                                  
                                  Default: true  [env var:
                                  STREAMLIT_SERVER_ALLOW_RUN_ON_SAVE]
  --server.address TEXT           The address where the server will listen for
                                  client and browser connections. Use this if
                                  you want to bind the server to a specific
                                  address. If set, the server will only be
                                  accessible from this address, and not from
                                  any aliases (like localhost).
                                  
                                  Default: (unset)  [env var:
                                  STREAMLIT_SERVER_ADDRESS]
  --server.port INTEGER           The port where the server will listen for
                                  browser connections.
                                  
                                  Default: 8501  [env var:
                                  STREAMLIT_SERVER_PORT]
  --server.scriptHealthCheckEnabled BOOLEAN
                                  Flag for enabling the script health check
                                  endpoint. It used for checking if a script
                                  loads successfully. On success, the endpoint
                                  will return a 200 HTTP status code. On
                                  failure, the endpoint will return a 503 HTTP
                                  status code.
                                  
                                  Note: This is an experimental Streamlit
                                  internal API. The API is subject to change
                                  anytime so this should be used at your own
                                  risk  [env var: STREAMLIT_SERVER_SCRIPT_HEAL
                                  TH_CHECK_ENABLED]
  --server.baseUrlPath TEXT       The base path for the URL where Streamlit
                                  should be served from.  [env var:
                                  STREAMLIT_SERVER_BASE_URL_PATH]
  --server.enableCORS BOOLEAN     Enables support for Cross-Origin Request
                                  Sharing (CORS) protection, for added
                                  security.
                                  
                                  Due to conflicts between CORS and XSRF, if
                                  `server.enableXsrfProtection` is on and
                                  `server.enableCORS` is off at the same time,
                                  we will prioritize
                                  `server.enableXsrfProtection`.
                                  
                                  Default: true  [env var:
                                  STREAMLIT_SERVER_ENABLE_CORS]
  --server.enableXsrfProtection BOOLEAN
                                  Enables support for Cross-Site Request
                                  Forgery (XSRF) protection, for added
                                  security.
                                  
                                  Due to conflicts between CORS and XSRF, if
                                  `server.enableXsrfProtection` is on and
                                  `server.enableCORS` is off at the same time,
                                  we will prioritize
                                  `server.enableXsrfProtection`.
                                  
                                  Default: true  [env var:
                                  STREAMLIT_SERVER_ENABLE_XSRF_PROTECTION]
  --server.maxUploadSize INTEGER  Max size, in megabytes, for files uploaded
                                  with the file_uploader.
                                  
                                  Default: 200  [env var:
                                  STREAMLIT_SERVER_MAX_UPLOAD_SIZE]
  --server.maxMessageSize INTEGER
                                  Max size, in megabytes, of messages that can
                                  be sent via the WebSocket connection.
                                  
                                  Default: 200  [env var:
                                  STREAMLIT_SERVER_MAX_MESSAGE_SIZE]
  --server.enableWebsocketCompression BOOLEAN
                                  Enables support for websocket compression.
                                  
                                  Default: false  [env var: STREAMLIT_SERVER_E
                                  NABLE_WEBSOCKET_COMPRESSION]
  --browser.serverAddress TEXT    Internet address where users should point
                                  their browsers in order to connect to the
                                  app. Can be IP address or DNS name and path.
                                  
                                  This is used to: - Set the correct URL for
                                  CORS and XSRF protection purposes. - Show
                                  the URL on the terminal - Open the browser
                                  
                                  Default: 'localhost'  [env var:
                                  STREAMLIT_BROWSER_SERVER_ADDRESS]
  --browser.gatherUsageStats BOOLEAN
                                  Whether to send usage statistics to
                                  Streamlit.
                                  
                                  Default: true  [env var:
                                  STREAMLIT_BROWSER_GATHER_USAGE_STATS]
  --browser.serverPort INTEGER    Port where users should point their browsers
                                  in order to connect to the app.
                                  
                                  This is used to: - Set the correct URL for
                                  CORS and XSRF protection purposes. - Show
                                  the URL on the terminal - Open the browser
                                  
                                  Default: whatever value is set in
                                  server.port.  [env var:
                                  STREAMLIT_BROWSER_SERVER_PORT]
  --ui.hideTopBar BOOLEAN         Flag to hide most of the UI elements found
                                  at the top of a Streamlit app.
                                  
                                  NOTE: This does *not* hide the hamburger
                                  menu in the top-right of an app.  [env var:
                                  STREAMLIT_UI_HIDE_TOP_BAR]
  --mapbox.token TEXT             Configure Streamlit to use a custom Mapbox
                                  token for elements like st.pydeck_chart and
                                  st.map. To get a token for yourself, create
                                  an account at https://mapbox.com. It's free
                                  (for moderate usage levels)!  [env var:
                                  STREAMLIT_MAPBOX_TOKEN]
  --deprecation.showfileUploaderEncoding BOOLEAN
                                  Set to false to disable the deprecation
                                  warning for the file uploader encoding.
                                  [env var: STREAMLIT_DEPRECATION_SHOWFILE_UPL
                                  OADER_ENCODING]
  --deprecation.showImageFormat BOOLEAN
                                  Set to false to disable the deprecation
                                  warning for the image format parameter. The
                                  format parameter for st.image has been
                                  removed. - 2021-03-24  [env var:
                                  STREAMLIT_DEPRECATION_SHOW_IMAGE_FORMAT]
  --deprecation.showPyplotGlobalUse BOOLEAN
                                  Set to false to disable the deprecation
                                  warning for using the global pyplot
                                  instance.  [env var: STREAMLIT_DEPRECATION_S
                                  HOW_PYPLOT_GLOBAL_USE]
  --theme.base TEXT               The preset Streamlit theme that your custom
                                  theme inherits from. One of "light" or
                                  "dark".  [env var: STREAMLIT_THEME_BASE]
  --theme.primaryColor TEXT       Primary accent color for interactive
                                  elements.  [env var:
                                  STREAMLIT_THEME_PRIMARY_COLOR]
  --theme.backgroundColor TEXT    Background color for the main content area.
                                  [env var: STREAMLIT_THEME_BACKGROUND_COLOR]
  --theme.secondaryBackgroundColor TEXT
                                  Background color used for the sidebar and
                                  most interactive widgets.  [env var:
                                  STREAMLIT_THEME_SECONDARY_BACKGROUND_COLOR]
  --theme.textColor TEXT          Color used for almost all text.  [env var:
                                  STREAMLIT_THEME_TEXT_COLOR]
  --theme.font TEXT               Font family for all text in the app, except
                                  code blocks. One of "sans serif", "serif",
                                  or "monospace".  [env var:
                                  STREAMLIT_THEME_FONT]
  --yaml_file PATH                path to YAML file.
  --help                          Show this message and exit.
```


## plannotate_yaml

### Tool Description
Annotates sequences with information from various databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/plannotate:1.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/barricklab/pLannotate
- **Package**: https://anaconda.org/channels/bioconda/packages/plannotate/overview
- **Validation**: PASS

### Original Help Text
```text
Rfam:
  details:
    compressed: false
    default_type: ncRNA
    location: None
  location: Default
  method: infernal
  parameters:
  - --cpu 1
  priority: 3
  version: release 14.5
fpbase:
  details:
    compressed: false
    default_type: CDS
    location: Default
  location: Default
  method: diamond
  parameters:
  - -k 0
  - --min-orf 1
  - --matrix BLOSUM90
  - --gapopen 10
  - --gapextend 1
  - --algo ctg
  - --id 75
  - --max-hsps 10
  - --culling-overlap 200
  - --seed-cut .001
  - --comp-based-stats 0
  - --threads 1
  priority: 1
  version: downloaded 2020-09-02
snapgene:
  details:
    compressed: false
    default_type: None
    location: Default
  location: Default
  method: blastn
  parameters:
  - -perc_identity 95
  - -max_target_seqs 20000
  - -culling_limit 25
  - -word_size 12
  - -num_threads 1
  priority: 1
  version: Downloaded 2021-07-23
swissprot:
  details:
    compressed: true
    default_type: CDS
    location: Default
  location: Default
  method: diamond
  parameters:
  - -k 0
  - --min-orf 1
  - --matrix BLOSUM90
  - --gapopen 10
  - --gapextend 1
  - --algo ctg
  - --id 50
  - --max-hsps 10
  - --culling-overlap 200
  - --seed-cut .001
  - --comp-based-stats 0
  - --threads 1
  priority: 2
  version: Release 2021_03
```

