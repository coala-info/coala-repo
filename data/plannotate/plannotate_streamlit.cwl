cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plannotate
  - streamlit
label: plannotate_streamlit
doc: "Launches pLannotate as an interactive web app.\n\nTool homepage: https://github.com/barricklab/pLannotate"
inputs:
  - id: browser_gather_usage_stats
    type:
      - 'null'
      - boolean
    doc: Whether to send usage statistics to Streamlit.
    inputBinding:
      position: 101
      prefix: --browser.gatherUsageStats
  - id: browser_server_address
    type:
      - 'null'
      - string
    doc: "Internet address where users should point their browsers in order to connect
      to the app. Can be IP address or DNS name and path.\n                      \
      \            \n                                  This is used to: - Set the
      correct URL for CORS and XSRF protection purposes. - Show the URL on the terminal
      - Open the browser"
    inputBinding:
      position: 101
      prefix: --browser.serverAddress
  - id: browser_server_port
    type:
      - 'null'
      - int
    doc: "Port where users should point their browsers in order to connect to the
      app.\n                                  \n                                 \
      \ This is used to: - Set the correct URL for CORS and XSRF protection purposes.
      - Show the URL on the terminal - Open the browser\n                        \
      \          \n                                  Default: whatever value is set
      in server.port."
    inputBinding:
      position: 101
      prefix: --browser.serverPort
  - id: client_caching
    type:
      - 'null'
      - boolean
    doc: Whether to enable st.cache.
    inputBinding:
      position: 101
      prefix: --client.caching
  - id: client_display_enabled
    type:
      - 'null'
      - boolean
    doc: If false, makes your Streamlit script not draw to a Streamlit app.
    inputBinding:
      position: 101
      prefix: --client.displayEnabled
  - id: client_show_error_details
    type:
      - 'null'
      - boolean
    doc: "Controls whether uncaught app exceptions are displayed in the browser. By
      default, this is set to True and Streamlit displays app exceptions and associated
      tracebacks in the browser.\n                                  \n           \
      \                       If set to False, an exception will result in a generic
      message being shown in the browser, and exceptions and tracebacks will be printed
      to the console only."
    inputBinding:
      position: 101
      prefix: --client.showErrorDetails
  - id: deprecation_show_image_format
    type:
      - 'null'
      - boolean
    doc: Set to false to disable the deprecation warning for the image format 
      parameter. The format parameter for st.image has been removed. - 
      2021-03-24
    inputBinding:
      position: 101
      prefix: --deprecation.showImageFormat
  - id: deprecation_show_pyplot_global_use
    type:
      - 'null'
      - boolean
    doc: Set to false to disable the deprecation warning for using the global 
      pyplot instance.
    inputBinding:
      position: 101
      prefix: --deprecation.showPyplotGlobalUse
  - id: deprecation_showfile_uploader_encoding
    type:
      - 'null'
      - boolean
    doc: Set to false to disable the deprecation warning for the file uploader 
      encoding.
    inputBinding:
      position: 101
      prefix: --deprecation.showfileUploaderEncoding
  - id: global_data_frame_serialization
    type:
      - 'null'
      - string
    doc: "DataFrame serialization.\n                                  \n         \
      \                         Acceptable values: - 'legacy': Serialize DataFrames
      using Streamlit's custom format. Slow   but battle-tested. - 'arrow': Serialize
      DataFrames using Apache Arrow. Much faster and versatile."
    inputBinding:
      position: 101
      prefix: --global.dataFrameSerialization
  - id: global_development_mode
    type:
      - 'null'
      - boolean
    doc: "Are we in development mode.\n                                  \n      \
      \                            This option defaults to True if and only if Streamlit
      wasn't installed normally."
    inputBinding:
      position: 101
      prefix: --global.developmentMode
  - id: global_disable_watchdog_warning
    type:
      - 'null'
      - boolean
    doc: "By default, Streamlit checks if the Python watchdog module is available
      and, if not, prints a warning asking for you to install it. The watchdog module
      is not required, but highly recommended. It improves Streamlit's ability to
      detect changes to files in your filesystem.\n                              \
      \    \n                                  If you'd like to turn off this warning,
      set this to True."
    inputBinding:
      position: 101
      prefix: --global.disableWatchdogWarning
  - id: global_log_level
    type:
      - 'null'
      - string
    doc: "Level of logging: 'error', 'warning', 'info', or 'debug'."
    inputBinding:
      position: 101
      prefix: --global.logLevel
  - id: global_max_cached_message_age
    type:
      - 'null'
      - int
    doc: Expire cached ForwardMsgs whose age is greater than this value. A 
      message's age is defined by how many times its script has finished running
      since the message has been accessed.
    inputBinding:
      position: 101
      prefix: --global.maxCachedMessageAge
  - id: global_min_cached_message_size
    type:
      - 'null'
      - float
    doc: Only cache ForwardMsgs that are greater than or equal to this minimum.
    inputBinding:
      position: 101
      prefix: --global.minCachedMessageSize
  - id: global_show_warning_on_direct_execution
    type:
      - 'null'
      - boolean
    doc: If True, will show a warning when you run a Streamlit-enabled script 
      via "python my_script.py".
    inputBinding:
      position: 101
      prefix: --global.showWarningOnDirectExecution
  - id: global_suppress_deprecation_warnings
    type:
      - 'null'
      - boolean
    doc: Hide deprecation warnings in the streamlit app.
    inputBinding:
      position: 101
      prefix: --global.suppressDeprecationWarnings
  - id: global_unit_test
    type:
      - 'null'
      - boolean
    doc: "Are we in a unit test?\n                                  \n           \
      \                       This option defaults to False."
    inputBinding:
      position: 101
      prefix: --global.unitTest
  - id: logger_level
    type:
      - 'null'
      - string
    doc: "Level of logging: 'error', 'warning', 'info', or 'debug'."
    inputBinding:
      position: 101
      prefix: --logger.level
  - id: logger_message_format
    type:
      - 'null'
      - string
    doc: String format for logging messages. If logger.datetimeFormat is set, 
      logger messages will default to "%(asctime)s.%(msecs)03d %(message)s". See
      [Python's 
      documentation](https://docs.python.org/2.6/library/logging.html#formatter-objects)
      for available attributes.
    inputBinding:
      position: 101
      prefix: --logger.messageFormat
  - id: mapbox_token
    type:
      - 'null'
      - string
    doc: Configure Streamlit to use a custom Mapbox token for elements like 
      st.pydeck_chart and st.map. To get a token for yourself, create an account
      at https://mapbox.com. It's free (for moderate usage levels)!
    inputBinding:
      position: 101
      prefix: --mapbox.token
  - id: runner_fix_matplotlib
    type:
      - 'null'
      - boolean
    doc: Sets the MPLBACKEND environment variable to Agg inside Streamlit to 
      prevent Python crashing.
    inputBinding:
      position: 101
      prefix: --runner.fixMatplotlib
  - id: runner_install_tracer
    type:
      - 'null'
      - boolean
    doc: Install a Python tracer to allow you to stop or pause your script at 
      any point and introspect it. As a side-effect, this slows down your 
      script's execution.
    inputBinding:
      position: 101
      prefix: --runner.installTracer
  - id: runner_magic_enabled
    type:
      - 'null'
      - boolean
    doc: Allows you to type a variable or string by itself in a single line of 
      Python code to write it to the app.
    inputBinding:
      position: 101
      prefix: --runner.magicEnabled
  - id: runner_post_script_gc
    type:
      - 'null'
      - boolean
    doc: Run the Python Garbage Collector after each script execution. This can 
      help avoid excess memory use in Streamlit apps, but could introduce delay 
      in rerunning the app script for high-memory-use applications.
    inputBinding:
      position: 101
      prefix: --runner.postScriptGC
  - id: server_address
    type:
      - 'null'
      - string
    doc: "The address where the server will listen for client and browser connections.
      Use this if you want to bind the server to a specific address. If set, the server
      will only be accessible from this address, and not from any aliases (like localhost).\n\
      \                                  \n                                  Default:
      (unset)"
    inputBinding:
      position: 101
      prefix: --server.address
  - id: server_allow_run_on_save
    type:
      - 'null'
      - boolean
    doc: Allows users to automatically rerun when app is updated.
    inputBinding:
      position: 101
      prefix: --server.allowRunOnSave
  - id: server_base_url_path
    type:
      - 'null'
      - string
    doc: The base path for the URL where Streamlit should be served from.
    inputBinding:
      position: 101
      prefix: --server.baseUrlPath
  - id: server_cookie_secret
    type:
      - 'null'
      - string
    doc: "Symmetric key used to produce signed cookies. If deploying on multiple replicas,
      this should be set to the same value across all replicas to ensure they all
      share the same secret.\n                                  \n               \
      \                   Default: randomly generated secret key."
    inputBinding:
      position: 101
      prefix: --server.cookieSecret
  - id: server_enable_cors
    type:
      - 'null'
      - boolean
    doc: "Enables support for Cross-Origin Request Sharing (CORS) protection, for
      added security.\n                                  \n                      \
      \            Due to conflicts between CORS and XSRF, if `server.enableXsrfProtection`
      is on and `server.enableCORS` is off at the same time, we will prioritize `server.enableXsrfProtection`."
    inputBinding:
      position: 101
      prefix: --server.enableCORS
  - id: server_enable_websocket_compression
    type:
      - 'null'
      - boolean
    doc: Enables support for websocket compression.
    inputBinding:
      position: 101
      prefix: --server.enableWebsocketCompression
  - id: server_enable_xsrf_protection
    type:
      - 'null'
      - boolean
    doc: "Enables support for Cross-Site Request Forgery (XSRF) protection, for added
      security.\n                                  \n                            \
      \      Due to conflicts between CORS and XSRF, if `server.enableXsrfProtection`
      is on and `server.enableCORS` is off at the same time, we will prioritize `server.enableXsrfProtection`."
    inputBinding:
      position: 101
      prefix: --server.enableXsrfProtection
  - id: server_file_watcher_type
    type:
      - 'null'
      - string
    doc: "Change the type of file watcher used by Streamlit, or turn it off completely.\n\
      \                                  \n                                  Allowed
      values: * \"auto\"     : Streamlit will attempt to use the watchdog module,
      and falls back to polling if watchdog is not available. * \"watchdog\" : Force
      Streamlit to use the watchdog module. * \"poll\"     : Force Streamlit to always
      use polling. * \"none\"     : Streamlit will not watch files."
    inputBinding:
      position: 101
      prefix: --server.fileWatcherType
  - id: server_folder_watch_blacklist
    type:
      - 'null'
      - string
    doc: "List of folders that should not be watched for changes. This impacts both
      \"Run on Save\" and @st.cache.\n                                  \n       \
      \                           Relative paths will be taken as relative to the
      current working directory.\n                                  \n           \
      \                       Example: ['/home/user1/env',\n                     \
      \             'relative/path/to/folder']"
    inputBinding:
      position: 101
      prefix: --server.folderWatchBlacklist
  - id: server_headless
    type:
      - 'null'
      - boolean
    doc: "If false, will attempt to open a browser window on start.\n            \
      \                      \n                                  Default: false unless
      (1) we are on a Linux box where DISPLAY is unset, or (2) we are running in the
      Streamlit Atom plugin."
    inputBinding:
      position: 101
      prefix: --server.headless
  - id: server_max_message_size
    type:
      - 'null'
      - int
    doc: Max size, in megabytes, of messages that can be sent via the WebSocket 
      connection.
    inputBinding:
      position: 101
      prefix: --server.maxMessageSize
  - id: server_max_upload_size
    type:
      - 'null'
      - int
    doc: Max size, in megabytes, for files uploaded with the file_uploader.
    inputBinding:
      position: 101
      prefix: --server.maxUploadSize
  - id: server_port
    type:
      - 'null'
      - int
    doc: The port where the server will listen for browser connections.
    inputBinding:
      position: 101
      prefix: --server.port
  - id: server_run_on_save
    type:
      - 'null'
      - boolean
    doc: Automatically rerun script when the file is modified on disk.
    inputBinding:
      position: 101
      prefix: --server.runOnSave
  - id: server_script_health_check_enabled
    type:
      - 'null'
      - boolean
    doc: "Flag for enabling the script health check endpoint. It used for checking
      if a script loads successfully. On success, the endpoint will return a 200 HTTP
      status code. On failure, the endpoint will return a 503 HTTP status code.\n\
      \                                  \n                                  Note:
      This is an experimental Streamlit internal API. The API is subject to change
      anytime so this should be used at your own risk"
    inputBinding:
      position: 101
      prefix: --server.scriptHealthCheckEnabled
  - id: theme_background_color
    type:
      - 'null'
      - string
    doc: Background color for the main content area.
    inputBinding:
      position: 101
      prefix: --theme.backgroundColor
  - id: theme_base
    type:
      - 'null'
      - string
    doc: The preset Streamlit theme that your custom theme inherits from. One of
      "light" or "dark".
    inputBinding:
      position: 101
      prefix: --theme.base
  - id: theme_font
    type:
      - 'null'
      - string
    doc: Font family for all text in the app, except code blocks. One of "sans 
      serif", "serif", or "monospace".
    inputBinding:
      position: 101
      prefix: --theme.font
  - id: theme_primary_color
    type:
      - 'null'
      - string
    doc: Primary accent color for interactive elements.
    inputBinding:
      position: 101
      prefix: --theme.primaryColor
  - id: theme_secondary_background_color
    type:
      - 'null'
      - string
    doc: Background color used for the sidebar and most interactive widgets.
    inputBinding:
      position: 101
      prefix: --theme.secondaryBackgroundColor
  - id: theme_text_color
    type:
      - 'null'
      - string
    doc: Color used for almost all text.
    inputBinding:
      position: 101
      prefix: --theme.textColor
  - id: ui_hide_top_bar
    type:
      - 'null'
      - boolean
    doc: "Flag to hide most of the UI elements found at the top of a Streamlit app.\n\
      \                                  \n                                  NOTE:
      This does *not* hide the hamburger menu in the top-right of an app."
    inputBinding:
      position: 101
      prefix: --ui.hideTopBar
  - id: yaml_file
    type:
      - 'null'
      - File
    doc: path to YAML file.
    inputBinding:
      position: 101
      prefix: --yaml_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plannotate:1.2.4--pyhdfd78af_0
stdout: plannotate_streamlit.out
