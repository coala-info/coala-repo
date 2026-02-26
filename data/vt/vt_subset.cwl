cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt_subset
label: vt_subset
doc: "Subsets a VCF file to a set of variants that are polymorphic on a selected set
  of individuals.\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: in_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: filter_expression
    type:
      - 'null'
      - string
    doc: filter expression
    default: ''
    inputBinding:
      position: 102
      prefix: -f
  - id: intervals
    type:
      - 'null'
      - string
    doc: Intervals
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
  - id: samples_file
    type: File
    doc: file containing list of samples
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output VCF/VCF.GZ/BCF file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
