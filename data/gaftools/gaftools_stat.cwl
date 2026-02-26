cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaftools_stat
label: gaftools_stat
doc: "Calculate statistics of the given GAF file.\n\nTool homepage: https://github.com/marschall-lab/gaftools"
inputs:
  - id: gaf_file
    type: File
    doc: GAF file (can be bgzip-compressed)
    inputBinding:
      position: 1
  - id: cigar
    type:
      - 'null'
      - boolean
    doc: Outputs cigar related statistics (requires more time)
    inputBinding:
      position: 102
      prefix: --cigar
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file. If omitted, use standard output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
