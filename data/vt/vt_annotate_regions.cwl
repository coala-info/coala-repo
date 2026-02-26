cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt annotate_regions
label: vt_annotate_regions
doc: "annotates regions in a VCF file\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: intervals
    type:
      - 'null'
      - string
    doc: intervals
    inputBinding:
      position: 102
      prefix: -i
  - id: intervals_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals
    inputBinding:
      position: 102
      prefix: -I
  - id: left_window_size
    type:
      - 'null'
      - string
    doc: left window size for overlap
    inputBinding:
      position: 102
      prefix: -l
  - id: regions_bed_file
    type: File
    doc: regions BED file
    inputBinding:
      position: 102
      prefix: -b
  - id: regions_description
    type: string
    doc: regions tag description
    inputBinding:
      position: 102
      prefix: -d
  - id: regions_tag
    type: string
    doc: regions tag
    inputBinding:
      position: 102
      prefix: -t
  - id: right_window_size
    type:
      - 'null'
      - string
    doc: right window size for overlap
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: output VCF file
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
