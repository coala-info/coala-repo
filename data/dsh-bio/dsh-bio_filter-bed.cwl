cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-filter-bed
label: dsh-bio_filter-bed
doc: "Filter BED files based on various criteria.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_bed_path
    type:
      - 'null'
      - File
    doc: input BED path, default stdin
    inputBinding:
      position: 101
      prefix: --input-bed-path
  - id: range
    type:
      - 'null'
      - string
    doc: filter by range, specify as chrom:start-end in 0-based coordindates
    inputBinding:
      position: 101
      prefix: --range
  - id: score
    type:
      - 'null'
      - int
    doc: filter by score
    inputBinding:
      position: 101
      prefix: --score
  - id: script
    type:
      - 'null'
      - string
    doc: filter by script, eval against r
    inputBinding:
      position: 101
      prefix: --script
  - id: output_bed_file_path
    type: string
    doc: Output or path parameter `output_bed_file_path`
    inputBinding:
      position: 102
      prefix: --output-bed-file
outputs:
  - id: output_bed_file
    type:
      - 'null'
      - File
    doc: output BED file, default stdout
    outputBinding:
      glob: $(inputs.output_bed_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
