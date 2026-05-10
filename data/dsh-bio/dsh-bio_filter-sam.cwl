cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-filter-sam
label: dsh-bio_filter-sam
doc: "Filter SAM/BAM files based on various criteria.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_sam_path
    type:
      - 'null'
      - File
    doc: input SAM path, default stdin
    inputBinding:
      position: 101
      prefix: --input-sam-path
  - id: mapq
    type:
      - 'null'
      - int
    doc: filter by mapq
    inputBinding:
      position: 101
      prefix: --mapq
  - id: range
    type:
      - 'null'
      - string
    doc: filter by range, specify as chrom:start-end in 0-based coordindates
    inputBinding:
      position: 101
      prefix: --range
  - id: script
    type:
      - 'null'
      - string
    doc: filter by script, eval against r
    inputBinding:
      position: 101
      prefix: --script
  - id: output_sam_file_path
    type: string
    doc: Output or path parameter `output_sam_file_path`
    inputBinding:
      position: 102
      prefix: --output-sam-file
outputs:
  - id: output_sam_file
    type:
      - 'null'
      - File
    doc: output SAM file, default stdout
    outputBinding:
      glob: $(inputs.output_sam_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
