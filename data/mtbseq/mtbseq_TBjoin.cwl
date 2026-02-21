cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtbseq_TBjoin
label: mtbseq_TBjoin
doc: "The provided text does not contain help information for the tool, but rather
  an error message regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/ngs-fzb/MTBseq_source"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtbseq:1.1.0--hdfd78af_1
stdout: mtbseq_TBjoin.out
