cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnftools
  - dwgsim2rnf
label: rnftools_dwgsim2rnf
doc: "Convert a DwgSim FASTQ file (dwgsim_prefix.bfast.fastq) to RNF-FASTQ.\n\nTool
  homepage: http://karel-brinda.github.io/rnftools"
inputs:
  - id: dwgsim_prefix
    type: string
    doc: Prefix for DwgSim.
    inputBinding:
      position: 101
      prefix: --dwgsim-prefix
  - id: estimate_unknown
    type:
      - 'null'
      - boolean
    doc: Estimate unknown values.
    inputBinding:
      position: 101
      prefix: --estimate-unknown
  - id: faidx
    type:
      - 'null'
      - File
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
    inputBinding:
      position: 101
      prefix: --genome-id
outputs:
  - id: rnf_fastq
    type:
      - 'null'
      - File
    doc: Output FASTQ file (- for standard output).
    outputBinding:
      glob: $(inputs.rnf_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
