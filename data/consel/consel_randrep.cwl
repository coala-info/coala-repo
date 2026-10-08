cwlVersion: v1.2
class: CommandLineTool
baseCommand: randrep
label: consel_randrep
doc: "Random generation of rep files (or rmt files with -m) for simulations, from a vt file giving the noncentralities and degrees of freedom (or the mean vector with -m).\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: vt_file
    type: File
    doc: "vt file with the parameters of the distributions"
    inputBinding:
      position: 2
  - id: output_base
    type:
      - 'null'
      - string
    doc: "base name of the output files, without extension (with -r the file number is appended)"
    default: "randrep_out"
    inputBinding:
      position: 3
  - id: seed
    type:
      - 'null'
      - long
    doc: "random seed"
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
  - id: repeats
    type:
      - 'null'
      - int
    doc: "number of repetitions (output files)"
    inputBinding:
      position: 1
      prefix: -r
  - id: fluctuation
    type:
      - 'null'
      - double
    doc: "fluctuation scale lambda of the observed vector"
    inputBinding:
      position: 1
      prefix: -f
  - id: rmt_mode
    type:
      - 'null'
      - boolean
    doc: "generate rmt files instead of rep files"
    inputBinding:
      position: 1
      prefix: -m
  - id: nonpara
    type:
      - 'null'
      - boolean
    doc: "nonparametric generation"
    inputBinding:
      position: 1
      prefix: --nonpara
  - id: model
    type:
      - 'null'
      - int
    doc: "model of the replicates (0: chi, 1: exponential)"
    inputBinding:
      position: 1
      prefix: --model
  - id: debug_mode
    type:
      - 'null'
      - int
    doc: "debug mode level"
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: rep_files
    type: File[]
    doc: "generated rep files"
    outputBinding:
      glob: $(inputs.output_base)*.rep
  - id: rmt_files
    type: File[]
    doc: "generated rmt files (with -m)"
    outputBinding:
      glob: $(inputs.output_base)*.rmt
  - id: log
    type: stdout
    doc: program output and log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
stdout: consel_randrep.log
