cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnfusion
  - mmej-deletion
label: hmnfusion_mmej-deletion
doc: "Analyze MMEJ-mediated deletions using VCF files and a reference genome\n\nTool
  homepage: https://github.com/guillaume-gricourt/HmnFusion"
inputs:
  - id: input_reference_fasta
    type: File
    doc: Genome of reference
    inputBinding:
      position: 101
      prefix: --input-reference-fasta
  - id: input_sample_vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: Vcf file
    inputBinding:
      position: 101
      prefix: --input-sample-vcf
outputs:
  - id: output_hmnfusion_xlsx
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_hmnfusion_xlsx)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
