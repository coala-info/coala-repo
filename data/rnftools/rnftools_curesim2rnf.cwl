cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnftools
  - curesim2rnf
label: rnftools_curesim2rnf
doc: "Convert a CuReSim FASTQ file to RNF-FASTQ.\n\nTool homepage: http://karel-brinda.github.io/rnftools"
inputs:
  - id: curesim_fastq
    type: File
    doc: CuReSim FASTQ file (- for standard input).
    inputBinding:
      position: 101
      prefix: --curesim-fastq
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
    doc: Genome ID in RNF
    default: 1
    inputBinding:
      position: 101
      prefix: --genome-id
outputs:
  - id: rnf_fastq
    type: File
    doc: Output FASTQ file (- for standard output).
    outputBinding:
      glob: $(inputs.rnf_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
