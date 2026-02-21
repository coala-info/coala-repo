cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hera
  - build
label: hera_hera_build
doc: "Hera is a tool for rapid and accurate RNA-seq analysis. The build command is
  used to create the necessary index files for alignment.\n\nTool homepage: https://github.com/bioturing/hera"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hera:1.1--h8121788_3
stdout: hera_hera_build.out
