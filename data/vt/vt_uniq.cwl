cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt_uniq
label: vt_uniq
doc: "Drops duplicate variants that appear later in the the VCF file.\n\nTool homepage:
  https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: in_vcf
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
  - id: intervals_list_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals
    inputBinding:
      position: 102
      prefix: -I
  - id: output_vcf_path
    type: string
    doc: Output or path parameter `output_vcf_path`
    inputBinding:
      position: 103
      prefix: --output-vcf
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: output VCF file
    outputBinding:
      glob: $(inputs.output_vcf_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
