cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqmt
label: consel_seqmt
doc: "Convert site-wise log-likelihoods from a phylogeny package (Molphy, PAML, PAUP*, TREE-PUZZLE, PhyML) to a CONSEL mt file (<output_base>.mt).\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: input_file
    type: File
    doc: "input file of site-wise log-likelihoods (mt file by default, or the format chosen by a format option)"
    inputBinding:
      position: 2
  - id: output_base
    type:
      - 'null'
      - string
    doc: "base name of the output file (<output_base>.mt), without extension"
    default: "seqmt_out"
    inputBinding:
      position: 3
  - id: molphy
    type:
      - 'null'
      - boolean
    doc: "input is a Molphy lls file"
    inputBinding:
      position: 1
      prefix: --molphy
  - id: paml
    type:
      - 'null'
      - boolean
    doc: "input is a PAML lnf file"
    inputBinding:
      position: 1
      prefix: --paml
  - id: paup
    type:
      - 'null'
      - boolean
    doc: "input is a PAUP* site-likelihood text file"
    inputBinding:
      position: 1
      prefix: --paup
  - id: puzzle
    type:
      - 'null'
      - boolean
    doc: "input is a TREE-PUZZLE sitelh file"
    inputBinding:
      position: 1
      prefix: --puzzle
  - id: phyml
    type:
      - 'null'
      - boolean
    doc: "input is a PhyML site-likelihood file"
    inputBinding:
      position: 1
      prefix: --phyml
  - id: debug_mode
    type:
      - 'null'
      - int
    doc: "debug mode level"
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: mt
    type: File
    doc: "matrix of site-wise log-likelihoods (mt file)"
    outputBinding:
      glob: $(inputs.output_base).mt
  - id: log
    type: stdout
    doc: program output and log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
stdout: consel_seqmt.log
