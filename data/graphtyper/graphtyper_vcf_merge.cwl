cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
label: graphtyper_vcf_merge
doc: "GraphTyper\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: vcfs
    type:
      type: array
      items: File
    doc: VCFs to merge
    inputBinding:
      position: 1
  - id: encoding
    type:
      - 'null'
      - string
    doc: 'Select output encoding. Available are: vcf, popvcf'
    inputBinding:
      position: 102
      prefix: --encoding
  - id: file_list
    type:
      - 'null'
      - File
    doc: File containing VCFs to merge
    inputBinding:
      position: 102
      prefix: --file_list
  - id: log
    type:
      - 'null'
      - string
    doc: Set path to log file
    inputBinding:
      position: 102
      prefix: --log
  - id: sv
    type:
      - 'null'
      - boolean
    doc: Set if the input VCFs were generated from genotype_sv
    inputBinding:
      position: 102
      prefix: --sv
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set to output verbose logging
    inputBinding:
      position: 102
      prefix: --verbose
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: Set to output very verbose logging
    inputBinding:
      position: 102
      prefix: --vverbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output VCF file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
