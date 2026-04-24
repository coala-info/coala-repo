cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transanno
  - chain-to-bed-vcf
label: transanno_chain-to-bed-vcf
doc: "Create BED and VCF file from chain file\n\nTool homepage: https://github.com/informationsea/transanno"
inputs:
  - id: chain
    type: File
    doc: Input Chain file
    inputBinding:
      position: 1
  - id: new
    type: File
    doc: New assembly FASTA (.fai file is required)
    inputBinding:
      position: 102
      prefix: --new
  - id: original
    type: File
    doc: Original assembly FASTA (.fai file is required)
    inputBinding:
      position: 102
      prefix: --original
  - id: svlen
    type:
      - 'null'
      - int
    doc: Do not write nucleotides if a length of reference or alternative sequence
      is longer than svlen
    inputBinding:
      position: 102
      prefix: --svlen
outputs:
  - id: output_original_bed
    type: File
    doc: Output original assembly BED file (Not sorted)
    outputBinding:
      glob: $(inputs.output_original_bed)
  - id: output_new_bed
    type: File
    doc: Output new assembly BED file (Not sorted)
    outputBinding:
      glob: $(inputs.output_new_bed)
  - id: output_original_vcf
    type: File
    doc: Output original assembly VCF file (Not sorted)
    outputBinding:
      glob: $(inputs.output_original_vcf)
  - id: output_new_vcf
    type: File
    doc: Output new assembly VCF file (Not sorted)
    outputBinding:
      glob: $(inputs.output_new_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
