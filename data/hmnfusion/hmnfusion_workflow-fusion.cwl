cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnfusion
  - workflow-fusion
label: hmnfusion_workflow-fusion
doc: "HmnFusion workflow for fusion detection\n\nTool homepage: https://github.com/guillaume-gricourt/HmnFusion"
inputs:
  - id: input_forward_fastq
    type:
      - 'null'
      - File
    doc: Fastq file forward
    inputBinding:
      position: 101
      prefix: --input-forward-fastq
  - id: input_genefuse_bed
    type:
      - 'null'
      - File
    doc: Genefuse bed file
    inputBinding:
      position: 101
      prefix: --input-genefuse-bed
  - id: input_hmnfusion_bed
    type:
      - 'null'
      - File
    doc: HmnFusion bed file
    inputBinding:
      position: 101
      prefix: --input-hmnfusion-bed
  - id: input_lumpy_bed
    type:
      - 'null'
      - File
    doc: Lumpy bed file
    inputBinding:
      position: 101
      prefix: --input-lumpy-bed
  - id: input_reference_fasta
    type: File
    doc: Reference fasta file (hg19)
    inputBinding:
      position: 101
      prefix: --input-reference-fasta
  - id: input_reverse_fastq
    type:
      - 'null'
      - File
    doc: Fastq file reverse
    inputBinding:
      position: 101
      prefix: --input-reverse-fastq
  - id: input_sample_bam
    type: File
    doc: Bam file
    inputBinding:
      position: 101
      prefix: --input-sample-bam
  - id: name
    type: string
    doc: Name of sample
    inputBinding:
      position: 101
      prefix: --name
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads used
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_hmnfusion_vcf
    type: File
    doc: Vcf file output
    outputBinding:
      glob: $(inputs.output_hmnfusion_vcf)
  - id: output_genefuse_html
    type: File
    doc: Genefuse html file output
    outputBinding:
      glob: $(inputs.output_genefuse_html)
  - id: output_lumpy_vcf
    type: File
    doc: Lumpy vcf file output
    outputBinding:
      glob: $(inputs.output_lumpy_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
