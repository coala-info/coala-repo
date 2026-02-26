cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppx
label: ppx
doc: "Use this command line utility to download files from the PRIDE and MassIVE proteomics
  repositories. The paths to the downloaded files are written to stdout.\n\nTool homepage:
  https://github.com/wfondrie/ppx"
inputs:
  - id: identifier
    type: string
    doc: The ProteomeXchange, PRIDE, or MassIVE identifier for the project.
    inputBinding:
      position: 1
  - id: files
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more files to download. If none are provided, all files 
      associated with the project are downloaded. Unix-style glob wildcards can 
      be used, but they will need to be enclosed in quotation marks so as not to
      match files in your current working directory.
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Should ppx download files that are already present in the local data 
      directory?
    inputBinding:
      position: 103
      prefix: --force
  - id: local_directory
    type:
      - 'null'
      - Directory
    doc: The local directory where data will be downloaded. The default is 
      ~/.ppx/<identifier>. This can also be changed globally by setting the 
      PPX_DATA_DIR environment variable to your desired location.
    default: ~/.ppx/<identifier>
    inputBinding:
      position: 103
      prefix: --local
  - id: timeout
    type:
      - 'null'
      - int
    doc: The maximum amount of time to wait for a server response.
    inputBinding:
      position: 103
      prefix: --timeout
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppx:1.5.0--pyhdfd78af_0
stdout: ppx.out
