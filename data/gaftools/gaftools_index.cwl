cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaftools_index
label: gaftools_index
doc: "Index a GAF file for the view functionality.\n\nTool homepage: https://github.com/marschall-lab/gaftools"
inputs:
  - id: gaf_file
    type: File
    doc: GAF file (can be bgzip-compressed)
    inputBinding:
      position: 1
  - id: rgfa_file
    type: File
    doc: rGFA file (can be bgzip-compressed)
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output GAF View Index (GVI) file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
