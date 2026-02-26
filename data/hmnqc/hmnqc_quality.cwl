cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnqc
  - quality
label: hmnqc_quality
doc: "Quality analysis of fastq, bam, and vcf files\n\nTool homepage: https://github.com/guillaume-gricourt/HmnQc"
inputs:
  - id: input_fastq_forward_raw
    type:
      - 'null'
      - File
    doc: Fastq forward before trimming
    inputBinding:
      position: 101
      prefix: --input-fastq-forward-raw
  - id: input_fastq_forward_trim
    type:
      - 'null'
      - File
    doc: Fastq forward after trimming
    inputBinding:
      position: 101
      prefix: --input-fastq-forward-trim
  - id: input_fastq_reverse_raw
    type:
      - 'null'
      - File
    doc: Fastq reverse before trimming
    inputBinding:
      position: 101
      prefix: --input-fastq-reverse-raw
  - id: input_fastq_reverse_trim
    type:
      - 'null'
      - File
    doc: Fastq reverse after trimming
    inputBinding:
      position: 101
      prefix: --input-fastq-reverse-trim
  - id: input_sample_bam
    type:
      - 'null'
      - File
    doc: Bam file to analyse
    inputBinding:
      position: 101
      prefix: --input-sample-bam
  - id: input_sample_bed
    type:
      - 'null'
      - File
    doc: Bed file to compute coverage
    inputBinding:
      position: 101
      prefix: --input-sample-bed
  - id: input_sample_name
    type: string
    doc: Name of sample
    inputBinding:
      position: 101
      prefix: --input-sample-name
  - id: input_sample_vcf
    type:
      - 'null'
      - File
    doc: Vcf file to analyse
    inputBinding:
      position: 101
      prefix: --input-sample-vcf
  - id: parameter_coverage_cut_off
    type:
      - 'null'
      - int
    doc: Cut off coverage to compute
    inputBinding:
      position: 101
      prefix: --parameter-coverage-cut-off
  - id: parameter_threads
    type:
      - 'null'
      - int
    doc: Threads
    inputBinding:
      position: 101
      prefix: --parameter-threads
outputs:
  - id: output_hmnqc_json
    type: File
    doc: Output json file
    outputBinding:
      glob: $(inputs.output_hmnqc_json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnqc:0.5.1--pyhdfd78af_0
