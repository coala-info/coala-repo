cwlVersion: v1.2
class: CommandLineTool
baseCommand: [simulate-cnv]
label: neoloop_simulate-cnv
doc: "Generate a Hi-C matrix given a normal Hi-C cool file and a genomic CNV profile
  in bedGraph format.\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: normal_cool
    type: File
    doc: Cool file of a normal cell (use normal_group for an .mcool file).
    inputBinding:
      position: 101
      prefix: --normal-cool
      valueFrom: "$(self.path)$(inputs.normal_group ? inputs.normal_group : '')"
  - id: normal_group
    type:
      - 'null'
      - string
    doc: Group inside an .mcool file appended to the normal cool URI, for example ::resolutions/25000.
  - id: cancer_cool
    type: File
    doc: Cool file of a cancer cell (use cancer_group for an .mcool file).
    inputBinding:
      position: 101
      prefix: --cancer-cool
      valueFrom: "$(self.path)$(inputs.cancer_group ? inputs.cancer_group : '')"
  - id: cancer_group
    type:
      - 'null'
      - string
    doc: Group inside an .mcool file appended to the cancer cool URI, for example ::resolutions/25000.
  - id: cnv_file
    type: File
    doc: Copy number profile from the same cancer cell (bedGraph).
    inputBinding:
      position: 101
      prefix: --cnv-file
  - id: output_dir
    type: string
    doc: Output folder name.
    inputBinding:
      position: 101
      prefix: --output
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Chromosomes to exclude (default chrY chrM).
    inputBinding:
      position: 101
      prefix: --exclude
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Ploidy of the cancer genome (default 3).
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of worker processes (default 1).
    inputBinding:
      position: 101
      prefix: --nproc
  - id: log_file
    type:
      - 'null'
      - string
    doc: Logging file name (default cnvsim.log).
    inputBinding:
      position: 101
      prefix: --logFile
outputs:
  - id: simulated
    type: Directory
    doc: Output folder with the simulated Hi-C matrices.
    outputBinding:
      glob: $(inputs.output_dir)
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file.
    outputBinding:
      glob: |-
        ${ return inputs.log_file ? inputs.log_file : 'cnvsim.log'; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
