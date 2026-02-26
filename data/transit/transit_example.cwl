cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit_example
label: transit_example
doc: "Generates an example configuration for Transit1.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type:
      type: array
      items: File
    doc: Comma-separated .wig files
    inputBinding:
      position: 1
  - id: annotation_prot_table
    type: File
    doc: Annotation .prot_table file
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
