cwlVersion: v1.2
class: CommandLineTool
baseCommand: dampa targets
label: dampa_targets
doc: "Generates target sequences based on a dampa design JSON file.\n\nTool homepage:
  https://github.com/MultipathogenGenomics/dampa"
inputs:
  - id: inputjson
    type: File
    doc: path to dampa design json arguments file
    inputBinding:
      position: 101
      prefix: --inputjson
  - id: keeplogs
    type:
      - 'null'
      - boolean
    doc: keep logs containing output from pangraph and probetools
    inputBinding:
      position: 101
      prefix: --keeplogs
  - id: nthresh
    type:
      - 'null'
      - float
    doc: proportion of Ns allowed in any given graph node to be included in 
      targets
    inputBinding:
      position: 101
      prefix: --nthresh
  - id: outputfolder
    type:
      - 'null'
      - Directory
    doc: path to output folder
    inputBinding:
      position: 101
      prefix: --outputfolder
  - id: outputprefix
    type:
      - 'null'
      - string
    doc: prefix for all output files and folders
    inputBinding:
      position: 101
      prefix: --outputprefix
  - id: probelen
    type:
      - 'null'
      - int
    doc: length of output probes
    inputBinding:
      position: 101
      prefix: --probelen
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dampa:0.2.0--pyhdfd78af_0
stdout: dampa_targets.out
