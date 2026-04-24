cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnftools wgsim2rnf
label: rnftools_wgsim2rnf
doc: "Convert WgSim FASTQ files to RNF-FASTQ.\n\nTool homepage: http://karel-brinda.github.io/rnftools"
inputs:
  - id: allow_unmapped
    type:
      - 'null'
      - boolean
    doc: Allow unmapped reads.
    inputBinding:
      position: 101
      prefix: --allow-unmapped
  - id: faidx
    type: File
    doc: FAI index of the reference FASTA file (- for standard input). It can be
      created using 'samtools faidx'.
    inputBinding:
      position: 101
      prefix: --faidx
  - id: genome_id
    type:
      - 'null'
      - int
    doc: 'Genome ID in RNF (default: 1).'
    inputBinding:
      position: 101
      prefix: --genome-id
  - id: wgsim_fastq_1
    type: File
    doc: First WgSim FASTQ file (- for standard input)
    inputBinding:
      position: 101
      prefix: --wgsim-fastq-1
  - id: wgsim_fastq_2
    type:
      - 'null'
      - File
    doc: 'Second WgSim FASTQ file (in case of paired-end reads, default: none).'
    inputBinding:
      position: 101
      prefix: --wgsim-fastq-2
outputs:
  - id: rnf_fastq
    type: File
    doc: Output FASTQ file (- for standard output).
    outputBinding:
      glob: $(inputs.rnf_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
