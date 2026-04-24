cwlVersion: v1.2
class: CommandLineTool
baseCommand: runBrowser
label: hicbrowser_runBrowser
doc: "Activate HiCBrowser using a given configuration file.\n\nTool homepage: https://github.com/maxplanck-ie/HiCBrowser"
inputs:
  - id: config
    type: File
    doc: Configuration file with genomic tracks.
    inputBinding:
      position: 101
      prefix: --config
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Set to run the server in debug mode which will print useful 
      information.
    inputBinding:
      position: 101
      prefix: --debug
  - id: html_folder
    type:
      - 'null'
      - Directory
    doc: File where the template index.html file is located. The default isfine 
      unless the contents wants to be personalized. The full path has to be 
      given.
    inputBinding:
      position: 101
      prefix: --htmlFolder
  - id: num_processors
    type:
      - 'null'
      - int
    doc: Number of processors to use.
    inputBinding:
      position: 101
      prefix: --numProcessors
  - id: port
    type:
      - 'null'
      - int
    doc: Local browser port to use.
    inputBinding:
      position: 101
      prefix: --port
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicbrowser:1.0--py27_1
stdout: hicbrowser_runBrowser.out
