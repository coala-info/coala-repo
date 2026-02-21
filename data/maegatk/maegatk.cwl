cwlVersion: v1.2
class: CommandLineTool
baseCommand: maegatk
label: maegatk
doc: "Mitochondrial Alignment and Error-corrected Genotyping from ATAC-seq. (Note:
  The provided text is a container runtime error log and does not contain usage instructions
  or argument definitions).\n\nTool homepage: https://github.com/caleblareau/maegatk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maegatk:0.2.0--pyhdfd78af_2
stdout: maegatk.out
