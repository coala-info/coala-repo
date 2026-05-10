cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt paste
label: vt_paste
doc: "Pastes VCF files like the unix paste functions. This is used after the per sample
  genotyping step in vt.\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: input_vcfs
    type:
      type: array
      items: File
    doc: Input VCF files
    inputBinding:
      position: 1
  - id: input_list_file
    type:
      - 'null'
      - File
    doc: file containing list of input VCF files
    inputBinding:
      position: 102
      prefix: -L
  - id: print_options
    type:
      - 'null'
      - boolean
    doc: print options and summary
    inputBinding:
      position: 102
      prefix: -p
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
