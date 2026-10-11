cwlVersion: v1.2
class: CommandLineTool
baseCommand: neotad-caller
label: neoloop_neotad-caller
doc: "Identify neo-TADs.\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: assembly
    type: File
    doc: The assembled SV list outputed by assemble-complexSVs.
    inputBinding:
      position: 101
      prefix: --assembly
  - id: balance_type
    type:
      - 'null'
      - string
    doc: Normalization method.
    inputBinding:
      position: 101
      prefix: --balance-type
  - id: hic
    type: File
    doc: Cool file (use hic_group for an .mcool file).
    inputBinding:
      position: 101
      prefix: --hic
      valueFrom: "$(self.path)$(inputs.hic_group ? inputs.hic_group : '')"
  - id: hic_group
    type:
      - 'null'
      - string
    doc: Group inside an .mcool file appended to the cool URI, for example ::resolutions/25000.
  - id: logfile
    type:
      - 'null'
      - string
    doc: Logging file name.
    inputBinding:
      position: 101
      prefix: --logFile
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 101
      prefix: --nproc
  - id: output_path
    type: string
    doc: Output file path.
    inputBinding:
      position: 101
      prefix: --output
  - id: protocol
    type:
      - 'null'
      - string
    doc: Experimental protocol of your Hi-C.
    inputBinding:
      position: 101
      prefix: --protocol
  - id: region_size
    type:
      - 'null'
      - int
    doc: The extended genomic span of SV break points.(bp)
    inputBinding:
      position: 101
      prefix: --region-size
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for calculating DI.
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: output
    type: File
    doc: Output file with the neo-TAD domains.
    outputBinding:
      glob: $(inputs.output_path)
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file.
    outputBinding:
      glob: |-
        ${ return inputs.logfile ? inputs.logfile : 'neotad.log'; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
