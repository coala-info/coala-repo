cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtbseq
label: mtbseq
doc: "MTBseq is a pipeline for whole genome sequencing data analysis of Mycobacterium
  tuberculosis complex isolates. (Note: The provided help text contains only system
  error messages and no usage information.)\n\nTool homepage: https://github.com/ngs-fzb/MTBseq_source"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtbseq:1.1.0--hdfd78af_1
stdout: mtbseq.out
