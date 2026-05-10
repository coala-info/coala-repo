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
    doc: Do not write nucleotides if a length of reference or alternative 
      sequence is longer than svlen
    inputBinding:
      position: 102
      prefix: --svlen
  - id: output_new_bed_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_new_bed_path`
    inputBinding:
      position: 103
      prefix: --output-new-bed
  - id: output_new_vcf_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_new_vcf_path`
    inputBinding:
      position: 104
      prefix: --output-new-vcf
  - id: output_original_bed_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_original_bed_path`
    inputBinding:
      position: 105
      prefix: --output-original-bed
  - id: output_original_vcf_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_original_vcf_path`
    inputBinding:
      position: 106
      prefix: --output-original-vcf
outputs:
  - id: output_original_bed
    type: File
    doc: Output original assembly BED file (Not sorted)
    outputBinding:
      glob: $(inputs.output_original_bed_path)
  - id: output_new_bed
    type: File
    doc: Output new assembly BED file (Not sorted)
    outputBinding:
      glob: $(inputs.output_new_bed_path)
  - id: output_original_vcf
    type: File
    doc: Output original assembly VCF file (Not sorted)
    outputBinding:
      glob: $(inputs.output_original_vcf_path)
  - id: output_new_vcf
    type: File
    doc: Output new assembly VCF file (Not sorted)
    outputBinding:
      glob: $(inputs.output_new_vcf_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
