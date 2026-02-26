cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - /usr/local/bin/transit
  - export
label: transit_export
doc: "Export data from Transit1. Please use one of the known methods (or see documentation
  to add a new one).\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: method
    type: string
    doc: 'The export method to use. Known methods: combined_wig, igv, mean_counts.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
stdout: transit_export.out
