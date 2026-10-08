cwlVersion: v1.2
class: CommandLineTool
baseCommand: makerep
label: consel_makerep
doc: "Generate multiscale bootstrap replicates of the test statistics (<output_base>.rep) from an mt file (or phylogeny package output) for the hypotheses in an ass file; consel -R computes the p-values from it.\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: input_file
    type: File
    doc: "input mt file (or phylogeny package output with a format option)"
    inputBinding:
      position: 2
  - id: output_base
    type:
      - 'null'
      - string
    doc: "base name of the output rep file, without extension"
    default: "makerep_out"
    inputBinding:
      position: 3
  - id: seed
    type:
      - 'null'
      - long
    doc: "random seed (default 0: taken from the system clock)"
    inputBinding:
      position: 1
      prefix: -s
  - id: pa_file
    type:
      - 'null'
      - File
    doc: "pa file giving the scales and the numbers of replicates"
    inputBinding:
      position: 1
      prefix: -p
  - id: ass_file
    type:
      - 'null'
      - File
    doc: "association file (hypotheses) from treeass or catass"
    inputBinding:
      position: 1
      prefix: -a
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
outputs:
  - id: rep
    type: File
    doc: "replicates of the test statistics (rep file)"
    outputBinding:
      glob: $(inputs.output_base).rep
  - id: log
    type: stdout
    doc: program output and log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
stdout: consel_makerep.log
