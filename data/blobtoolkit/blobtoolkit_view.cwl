cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtools
  - view
label: blobtoolkit_view
doc: "Generate plots using BlobToolKit Viewer.\n\nTool homepage: https://github.com/blobtoolkit/blobtoolkit"
inputs:
  - id: blobdir
    type: Directory
    doc: BlobDir dataset directory.
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --format
    doc: 'Image format (svg|png). [Default: png]'
    inputBinding:
      position: 1
  - id: host
    type: ['null', string]
    doc: 'Hostname. [Default: http://localhost]'
    inputBinding:
      position: 1
      prefix: --host
  - id: interactive
    type: ['null', boolean]
    doc: 'Start interactive session (opens dataset in Firefox/Chromium). [Default: False]'
    inputBinding:
      position: 1
      prefix: --interactive
  - id: out
    type: string
    default: blobtoolkit_view_out
    doc: 'Directory for outfiles. [Default: .]'
    inputBinding:
      position: 1
      prefix: --out
  - id: param
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --param
    doc: Query string parameter (key=value).
    inputBinding:
      position: 1
  - id: ports
    type: ['null', string]
    doc: 'Port range for viewer and API. [Default: 8000-8099]'
    inputBinding:
      position: 1
      prefix: --ports
  - id: prefix
    type: ['null', string]
    doc: 'URL prefix. [Default: view]'
    inputBinding:
      position: 1
      prefix: --prefix
  - id: preview
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --preview
    doc: Field name.
    inputBinding:
      position: 1
  - id: driver
    type: ['null', string]
    doc: 'Webdriver to use (chromium or firefox). [Default: firefox]'
    inputBinding:
      position: 1
      prefix: --driver
  - id: driver_log
    type: ['null', string]
    doc: 'Path to driver logfile for debugging. [Default: /dev/null]'
    inputBinding:
      position: 1
      prefix: --driver-log
  - id: local
    type: ['null', boolean]
    doc: 'Start viewer for local session. [Default: False]'
    inputBinding:
      position: 1
      prefix: --local
  - id: remote
    type: ['null', boolean]
    doc: 'Start viewer for remote session. [Default: False]'
    inputBinding:
      position: 1
      prefix: --remote
  - id: plot
    type: ['null', boolean]
    doc: 'Use blobtk plot to generate plots. [Default: False]'
    inputBinding:
      position: 1
      prefix: --plot
  - id: timeout
    type: ['null', int]
    doc: 'Time to wait for page load in seconds. Default (0) is no timeout. [Default: 0]'
    inputBinding:
      position: 1
      prefix: --timeout
  - id: view
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --view
    doc: 'Plot type (blob|cumulative|snail). [Default: blob]'
    inputBinding:
      position: 1
outputs:
  - id: out_dir
    type: Directory
    doc: Directory holding the plot images
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: '${ return {"class": "Directory", "basename": inputs.out, "listing": []}; }'
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
