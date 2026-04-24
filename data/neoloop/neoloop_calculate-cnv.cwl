cwlVersion: v1.2
class: CommandLineTool
baseCommand: calculate-cnv
label: neoloop_calculate-cnv
doc: "Calculate the copy number variation profile from Hi-C map using a generalized
  additive model with the Poisson link function\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: cachefolder
    type:
      - 'null'
      - Directory
    doc: Cache folder. We suggest keep this setting the same between different 
      runs.
    inputBinding:
      position: 101
      prefix: --cachefolder
  - id: enzyme
    type:
      - 'null'
      - string
    doc: The restriction enzyme name used in the Hi-C experiment. If the genome 
      was cutted using a sequence-independent/uniform-cutting enzyme, please 
      consider setting this parameter to "uniform".
    inputBinding:
      position: 101
      prefix: --enzyme
  - id: genome
    type:
      - 'null'
      - string
    doc: Reference genome name.
    inputBinding:
      position: 101
      prefix: --genome
  - id: hic_map
    type:
      - 'null'
      - string
    doc: Cool URI.
    inputBinding:
      position: 101
      prefix: --hic
  - id: log_file
    type:
      - 'null'
      - File
    doc: Logging file name.
    inputBinding:
      position: 101
      prefix: --logFile
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
