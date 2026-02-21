cwlVersion: v1.2
class: CommandLineTool
baseCommand: obiuniq
label: obitools_obiuniq
doc: "A tool from the OBITools suite used to dereplicate sequences (group identical
  sequences and merge their attributes).\n\nTool homepage: http://metabarcoding.org/obitools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools:1.2.13--py27h516909a_0
stdout: obitools_obiuniq.out
