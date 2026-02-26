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
