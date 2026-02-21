cwlVersion: v1.2
class: CommandLineTool
baseCommand: gogstools
label: gogstools
doc: "A tool for processing GOGS (Global Ocean Gene Synthesis) data or related genomic/oceanographic
  datasets.\n\nTool homepage: https://github.com/genouest/ogs-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gogstools:0.1.2--py310hdfd78af_0
stdout: gogstools.out
