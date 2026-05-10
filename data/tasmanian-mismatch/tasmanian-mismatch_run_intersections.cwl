cwlVersion: v1.2
class: CommandLineTool
baseCommand: tasmanian-mismatch_run_intersections
label: tasmanian-mismatch_run_intersections
doc: "Run mismatch intersections between BAM and BEDGraph files.\n\nTool homepage:
  https://github.com/nebiolabs/tasmanian-mismatch"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: bed_file_or_bedgraph
    type: File
    doc: Input BED file or BEDGraph file (must contain 3 or more tab-separated 
      columns)
    inputBinding:
      position: 2
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 101
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: Output table file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tasmanian-mismatch:1.0.9--pyhdfd78af_0
