cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxstrec]
label: phyx_pxstrec
doc: |-
  This will conduct state reconstruction analyses.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: data_file
    type: File
    doc: "input data file"
    inputBinding:
      prefix: -d
  - id: datawide
    type: ['null', boolean]
    doc: "data is in wide format so (001 instead of 2)"
    inputBinding:
      prefix: -w
  - id: dataz
    type: ['null', boolean]
    doc: "data is in probability format (0,1,0,0)"
    inputBinding:
      prefix: -z
  - id: tree_file
    type: File
    doc: "input tree file"
    inputBinding:
      prefix: -t
  - id: conf_file
    type: File
    doc: "configuration file"
    inputBinding:
      prefix: -c
  - id: outanc
    type: ['null', string]
    doc: "output file for ancestral calc"
    inputBinding:
      prefix: -o
  - id: outstnum
    type: ['null', string]
    doc: "output file for stochastic mapping number"
    inputBinding:
      prefix: -n
  - id: outstnumany
    type: ['null', string]
    doc: "output file for stochastic mapping number any"
    inputBinding:
      prefix: -a
  - id: outsttim
    type: ['null', string]
    doc: "output file for stochastic mapping duration"
    inputBinding:
      prefix: -m
  - id: periods
    type: ['null', string]
    doc: "comma separated times"
    inputBinding:
      prefix: -p
  - id: log_file_path
    type: ['null', string]
    doc: "log file, STOUT otherwise"
    inputBinding:
      prefix: -l
outputs:
  - id: anc_file
    type: ['null', File]
    doc: "ancestral state calculation"
    outputBinding:
      glob: $(inputs.outanc)
  - id: stnum_file
    type: ['null', File]
    doc: "stochastic mapping number of changes"
    outputBinding:
      glob: $(inputs.outstnum)
  - id: stnumany_file
    type: ['null', File]
    doc: "stochastic mapping number (any)"
    outputBinding:
      glob: $(inputs.outstnumany)
  - id: sttim_file
    type: ['null', File]
    doc: "stochastic mapping duration"
    outputBinding:
      glob: $(inputs.outsttim)
  - id: log_file
    type: ['null', File]
    doc: "log file"
    outputBinding:
      glob: $(inputs.log_file_path)
  - id: stdout_text
    type: stdout
    doc: "standard output (data and likelihood messages)"
stdout: pxstrec.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
