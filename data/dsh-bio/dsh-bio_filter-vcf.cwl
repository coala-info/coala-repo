cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-filter-vcf
label: dsh-bio_filter-vcf
doc: "Filter VCF file based on various criteria.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: filter_passed
    type:
      - 'null'
      - boolean
    doc: filter to records that have passed all filters
    inputBinding:
      position: 101
      prefix: --filter
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
    doc: filter by id, specify as id1,id2,id3
    inputBinding:
      position: 101
      prefix: --id
  - id: input_vcf_path
    type:
      - 'null'
      - File
    doc: input VCF path, default stdin
    inputBinding:
      position: 101
      prefix: --input-vcf-path
  - id: qual
    type:
      - 'null'
      - float
    doc: filter by quality score
    inputBinding:
      position: 101
      prefix: --qual
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
outputs:
  - id: output_vcf_file
    type:
      - 'null'
      - File
    doc: output VCF file, default stdout
    outputBinding:
      glob: $(inputs.output_vcf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
