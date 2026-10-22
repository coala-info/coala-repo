cwlVersion: v1.2
class: CommandLineTool
baseCommand: reformat_output
label: seer_reformat_output
doc: "Reformats output for easier reading as tsv. Prints to stdout\n\nTool homepage: https://github.com/johnlees/seer"
inputs:
  - id: kmers
    type: File
    doc: "Filtered significant kmers, as output by seer + filter_seer"
    inputBinding:
      position: 1
      prefix: --kmers
  - id: pheno
    type: File
    doc: "Phenotype file used by seer"
    inputBinding:
      position: 1
      prefix: --pheno
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer_reformat_output.out
