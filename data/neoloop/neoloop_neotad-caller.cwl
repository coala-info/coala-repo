cwlVersion: v1.2
class: CommandLineTool
baseCommand: neotad-caller
label: neoloop_neotad-caller
doc: "Identify neo-TADs.\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: assembly
    type:
      - 'null'
      - File
    doc: The assembled SV list outputed by assemble-complexSVs.
    default: None
    inputBinding:
      position: 101
      prefix: --assembly
  - id: balance_type
    type:
      - 'null'
      - string
    doc: Normalization method.
    default: CNV
    inputBinding:
      position: 101
      prefix: --balance-type
  - id: hic
    type:
      - 'null'
      - string
    doc: Cooler URI.
    default: None
    inputBinding:
      position: 101
      prefix: --hic
  - id: logfile
    type:
      - 'null'
      - File
    doc: Logging file name.
    default: neotad.log
    inputBinding:
      position: 101
      prefix: --logFile
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    default: 1
    inputBinding:
      position: 101
      prefix: --nproc
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output path.
    default: None
    inputBinding:
      position: 101
      prefix: --output
  - id: protocol
    type:
      - 'null'
      - string
    doc: Experimental protocol of your Hi-C.
    default: insitu
    inputBinding:
      position: 101
      prefix: --protocol
  - id: region_size
    type:
      - 'null'
      - int
    doc: The extended genomic span of SV break points.(bp)
    default: 3000000
    inputBinding:
      position: 101
      prefix: --region-size
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for calculating DI.
    default: 2000000
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
stdout: neoloop_neotad-caller.out
