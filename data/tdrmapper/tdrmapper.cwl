cwlVersion: v1.2
class: CommandLineTool
baseCommand: tdrmapper
label: tdrmapper
doc: "A tool for mapping and quantifying tRNA-derived small RNAs (tsRNAs/tRFs) from
  RNA-seq data.\n\nTool homepage: https://github.com/sararselitsky/tDRmapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tdrmapper:1.1--pl526_3
stdout: tdrmapper.out
