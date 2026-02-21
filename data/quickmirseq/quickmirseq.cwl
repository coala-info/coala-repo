cwlVersion: v1.2
class: CommandLineTool
baseCommand: quickmirseq
label: quickmirseq
doc: "QuickMIRSeq is a tool for the analysis of microRNA-seq data. (Note: The provided
  text is a container build error log and does not contain help documentation; arguments
  could not be extracted from this source.)\n\nTool homepage: https://sourceforge.net/projects/quickmirseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quickmirseq:1.0.0--hdfd78af_3
stdout: quickmirseq.out
