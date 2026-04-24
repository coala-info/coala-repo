cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slivar
  - ddc
label: slivar_ddc
doc: "Calculate DDC scores for variants.\n\nTool homepage: https://github.com/brentp/slivar"
inputs:
  - id: vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: ped
    type: File
    doc: Input PED file
    inputBinding:
      position: 2
  - id: chrom
    type:
      - 'null'
      - string
    doc: limit to this chromosome only. use '-3' for all chromosomes (in the 
      case of exome data)
    inputBinding:
      position: 103
      prefix: --chrom
  - id: fmt_fields
    type:
      - 'null'
      - string
    doc: comma-delimited list of sample fields
    inputBinding:
      position: 103
      prefix: --fmt-fields
  - id: info_fields
    type:
      - 'null'
      - string
    doc: comma-delimited list of info fields
    inputBinding:
      position: 103
      prefix: --info-fields
outputs:
  - id: html
    type:
      - 'null'
      - File
    doc: path to output file
    outputBinding:
      glob: $(inputs.html)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
