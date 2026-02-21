cwlVersion: v1.2
class: CommandLineTool
baseCommand: FamSeqCuda
label: famseq_FamSeqCuda
doc: "FamSeq: A tool for variant calling in family sequencing data. (Note: The provided
  help text contains only system error messages regarding container image building
  and disk space; no specific command-line arguments could be extracted from the input.)\n
  \nTool homepage: http://bioinformatics.mdanderson.org/main/FamSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famseq:1.0.3--h7d875b9_3
stdout: famseq_FamSeqCuda.out
