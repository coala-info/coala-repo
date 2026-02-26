cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnftools mason2rnf
label: rnftools_mason2rnf
doc: "Convert a Mason SAM file to RNF-FASTQ.\n\nTool homepage: http://karel-brinda.github.io/rnftools"
inputs:
  - id: allow_unmapped
    type:
      - 'null'
      - boolean
    doc: Allow unmapped reads.
    inputBinding:
      position: 101
      prefix: --allow-unmapped
  - id: faidx_file
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
    default: 1
    inputBinding:
      position: 101
      prefix: --genome-id
  - id: sam_file
    type: File
    doc: Input SAM/BAM with true (expected) alignments of the reads (- for 
      standard input).
    inputBinding:
      position: 101
      prefix: --sam
  - id: simulator_name
    type:
      - 'null'
      - string
    doc: Name of the simulator (for RNF).
    inputBinding:
      position: 101
      prefix: --simulator-name
outputs:
  - id: rnf_fastq_file
    type: File
    doc: Output FASTQ file (- for standard output).
    outputBinding:
      glob: $(inputs.rnf_fastq_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
