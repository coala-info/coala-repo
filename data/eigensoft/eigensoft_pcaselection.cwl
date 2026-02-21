cwlVersion: v1.2
class: CommandLineTool
baseCommand: pcaselection
label: eigensoft_pcaselection
doc: "A tool from the EIGENSOFT package, likely used for PCA selection, though the
  provided text contains only system error messages and no usage information.\n\n
  Tool homepage: https://github.com/DReichLab/EIG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eigensoft:8.0.0--h75d7a4a_6
stdout: eigensoft_pcaselection.out
