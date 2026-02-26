cwlVersion: v1.2
class: CommandLineTool
baseCommand: gwyddion
label: gwyddion
doc: "An SPM data visualization and analysis tool, written with Gtk+.\n\nTool homepage:
  https://github.com/christian-sahlmann/gwyddion"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Files to process
    inputBinding:
      position: 1
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check FILES, print problems and terminate.
    inputBinding:
      position: 102
      prefix: --check
  - id: class
    type:
      - 'null'
      - string
    doc: Set program class as used by the window manager.
    inputBinding:
      position: 102
      prefix: --class
  - id: debug_objects
    type:
      - 'null'
      - boolean
    doc: Catch leaking objects (devel only).
    inputBinding:
      position: 102
      prefix: --debug-objects
  - id: disable_gl
    type:
      - 'null'
      - boolean
    doc: Disable OpenGL, including any availability checks.
    inputBinding:
      position: 102
      prefix: --disable-gl
  - id: disable_modules
    type:
      - 'null'
      - type: array
        items: string
    doc: Prevent registration of given modules.
    inputBinding:
      position: 102
      prefix: --disable-modules
  - id: display
    type:
      - 'null'
      - string
    doc: Set X display to use.
    inputBinding:
      position: 102
      prefix: --display
  - id: gtk_module
    type:
      - 'null'
      - type: array
        items: string
    doc: Load an additional Gtk module MODULE.
    inputBinding:
      position: 102
      prefix: --gtk-module
  - id: log_to_console
    type:
      - 'null'
      - boolean
    doc: Print messages to console
    inputBinding:
      position: 102
      prefix: --log-to-console
  - id: log_to_file
    type:
      - 'null'
      - boolean
    doc: Write messages to file set in GWYDDION_LOGFILE.
    inputBinding:
      position: 102
      prefix: --log-to-file
  - id: name
    type:
      - 'null'
      - string
    doc: Set program name as used by the window manager.
    inputBinding:
      position: 102
      prefix: --name
  - id: no_log_to_console
    type:
      - 'null'
      - boolean
    doc: Do not print messages to console.
    inputBinding:
      position: 102
      prefix: --no-log-to-console
  - id: no_log_to_file
    type:
      - 'null'
      - boolean
    doc: Do not write messages to any file.
    inputBinding:
      position: 102
      prefix: --no-log-to-file
  - id: no_splash
    type:
      - 'null'
      - boolean
    doc: Don't show splash screen.
    inputBinding:
      position: 102
      prefix: --no-splash
  - id: remote_existing
    type:
      - 'null'
      - boolean
    doc: Load FILES to a running instance or fail.
    inputBinding:
      position: 102
      prefix: --remote-existing
  - id: remote_new
    type:
      - 'null'
      - boolean
    doc: Load FILES to a running instance or run a new one.
    inputBinding:
      position: 102
      prefix: --remote-new
  - id: remote_query
    type:
      - 'null'
      - boolean
    doc: Check if a Gwyddion instance is already running.
    inputBinding:
      position: 102
      prefix: --remote-query
  - id: screen
    type:
      - 'null'
      - string
    doc: Set X screen to use.
    inputBinding:
      position: 102
      prefix: --screen
  - id: startup_time
    type:
      - 'null'
      - boolean
    doc: Measure time of startup tasks.
    inputBinding:
      position: 102
      prefix: --startup-time
  - id: sync
    type:
      - 'null'
      - boolean
    doc: Make X calls synchronous.
    inputBinding:
      position: 102
      prefix: --sync
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gwyddion:v2.52-1-deb_cv1
stdout: gwyddion.out
