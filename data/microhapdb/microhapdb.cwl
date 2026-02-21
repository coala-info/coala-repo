cwlVersion: v1.2
class: CommandLineTool
baseCommand: microhapdb
label: microhapdb
doc: "A tool for microhaplotype data (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/bioforensics/MicroHapDB/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
stdout: microhapdb.out
