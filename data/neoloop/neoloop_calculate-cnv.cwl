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
    type: File
    doc: Cool file (.cool, or an .mcool together with hic_group).
    inputBinding:
      position: 101
      prefix: --hic
      valueFrom: "$(self.path)$(inputs.hic_group ? inputs.hic_group : '')"
  - id: hic_group
    type:
      - 'null'
      - string
    doc: Group inside an .mcool file appended to the cool URI, for example ::resolutions/25000.
  - id: log_file
    type:
      - 'null'
      - string
    doc: Logging file name.
    inputBinding:
      position: 101
      prefix: --logFile
  - id: output_path
    type: string
    doc: Output file path (bedGraph).
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output file path.
    outputBinding:
      glob: $(inputs.output_path)
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file.
    outputBinding:
      glob: |-
        ${ return inputs.log_file ? inputs.log_file : 'cnv-calculation.log'; }
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
