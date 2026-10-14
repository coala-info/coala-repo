cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyling
  - download
label: phyling_download
doc: "Help to download/update BUSCO v5 markerset to a local folder.\n\nTool homepage:
  https://github.com/stajichlab/Phyling"
inputs:
  - id: hmm_markerset
    type: string
    doc: Name of the HMM markerset
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode for debug
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: markerset_dir
    type:
      - 'null'
      - Directory
    doc: Downloaded markersets (the ~/.phyling folder; HOME is the working directory)
    outputBinding:
      glob: .phyling
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyling:2.3.1--pyhdfd78af_0
stdout: phyling_download.out
