cwlVersion: v1.2
class: CommandLineTool
baseCommand: bior_annotate
label: bior_annotate
doc: "Annotates variants in a given input file (vcf)\n\nTool homepage: https://github.com/michaelmeiners/biorAnnotateLite"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: The config file containing the columns to be shown in the result.
    inputBinding:
      position: 101
      prefix: --configfile
  - id: log
    type:
      - 'null'
      - boolean
    doc: Use this option to generate the log file. By default, the log file is 
      not generated.
    inputBinding:
      position: 101
      prefix: --log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bior_annotate:v2.1.1_cv3
stdout: bior_annotate.out
