cwlVersion: v1.2
class: CommandLineTool
baseCommand: ecotag
label: obitools_ecotag
doc: "\nTool homepage: http://metabarcoding.org/obitools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools:1.2.13--py27h516909a_0
stdout: obitools_ecotag.out
