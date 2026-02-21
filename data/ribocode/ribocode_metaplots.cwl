cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribocode_metaplots
label: ribocode_metaplots
doc: "A tool for generating metaplots to identify the P-site offset for Ribo-seq data.
  (Note: The provided text contains system error messages rather than the tool's help
  documentation; therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/xryanglab/RiboCode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribocode:1.2.15--pyhdc42f0e_1
stdout: ribocode_metaplots.out
