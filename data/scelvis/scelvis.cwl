cwlVersion: v1.2
class: CommandLineTool
baseCommand: scelvis
label: scelvis
doc: "A tool for interactive visualization of single-cell RNA-seq data.\n\nTool homepage:
  https://github.com/bihealth/scelvis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scelvis:0.8.9--pyhdfd78af_0
stdout: scelvis.out
