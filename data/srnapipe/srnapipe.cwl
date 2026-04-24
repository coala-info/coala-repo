cwlVersion: v1.2
class: CommandLineTool
baseCommand: srnapipe
label: srnapipe
doc: "sRNAPipe version 1.2.1\n\nTool homepage: https://github.com/GReD-Clermont/sRNAPipe-cli"
inputs:
  - id: TE
    type: File
    doc: Fasta file containing the transposable elements
    inputBinding:
      position: 101
      prefix: --TE
  - id: build_TE
    type:
      - 'null'
      - boolean
    doc: Build index for the transposable elements if not provided
    inputBinding:
      position: 101
      prefix: --build_TE
  - id: build_index
    type:
      - 'null'
      - boolean
    doc: Build index for the reference genome if not provided
    inputBinding:
      position: 101
      prefix: --build_index
  - id: build_miRNAs
    type:
      - 'null'
      - boolean
    doc: Build index for the miRNAs if not provided
    inputBinding:
      position: 101
      prefix: --build_miRNAs
  - id: build_rRNAs
    type:
      - 'null'
      - boolean
    doc: Build index for the rRNAs if not provided
    inputBinding:
      position: 101
      prefix: --build_rRNAs
  - id: build_snRNAs
    type:
      - 'null'
      - boolean
    doc: Build index for the snRNAs if not provided
    inputBinding:
      position: 101
      prefix: --build_snRNAs
  - id: build_tRNAs
    type:
      - 'null'
      - boolean
    doc: Build index for the tRNAs if not provided
    inputBinding:
      position: 101
      prefix: --buid_tRNAs
  - id: build_transcripts
    type:
      - 'null'
      - boolean
    doc: Build index for the transcripts if not provided
    inputBinding:
      position: 101
      prefix: --build_transcripts
  - id: fastq
    type:
      type: array
      items: File
    doc: Fastq file to process
    inputBinding:
      position: 101
      prefix: --fastq
  - id: fastq_n
    type:
      type: array
      items: string
    doc: Name of the content to process
    inputBinding:
      position: 101
      prefix: --fastq_n
  - id: max_TE_mismatches
    type:
      - 'null'
      - int
    doc: Maximal TE mismatches
    inputBinding:
      position: 101
      prefix: --misTE
  - id: max_genome_mismatches
    type:
      - 'null'
      - int
    doc: Maximal genome mismatches
    inputBinding:
      position: 101
      prefix: --mis
  - id: max_read_size
    type:
      - 'null'
      - int
    doc: Maximum read size
    inputBinding:
      position: 101
      prefix: --max
  - id: miRNAs
    type: File
    doc: Fasta file containing the miRNAs
    inputBinding:
      position: 101
      prefix: --miRNAs
  - id: min_read_size
    type:
      - 'null'
      - int
    doc: Minimum read size
    inputBinding:
      position: 101
      prefix: --min
  - id: piRNA_max_range
    type:
      - 'null'
      - int
    doc: Higher bound of piRNA range
    inputBinding:
      position: 101
      prefix: --pi_max
  - id: piRNA_min_range
    type:
      - 'null'
      - int
    doc: Lower bound of piRNA range
    inputBinding:
      position: 101
      prefix: --pi_min
  - id: ping_pong_partners
    type:
      - 'null'
      - boolean
    doc: Ping-pong partners
    inputBinding:
      position: 101
      prefix: --PPPon
  - id: rRNAs
    type: File
    doc: Fasta file containing the rRNAs
    inputBinding:
      position: 101
      prefix: --rRNAs
  - id: ref
    type: File
    doc: Fasta file containing the reference genome
    inputBinding:
      position: 101
      prefix: --ref
  - id: results_dir
    type: Directory
    doc: Folder where results will be stored
    inputBinding:
      position: 101
      prefix: --dir
  - id: siRNA_max_range
    type:
      - 'null'
      - int
    doc: Higher bound of siRNA range
    inputBinding:
      position: 101
      prefix: --si_max
  - id: siRNA_min_range
    type:
      - 'null'
      - int
    doc: Lower bound of siRNA range
    inputBinding:
      position: 101
      prefix: --si_min
  - id: snRNAs
    type: File
    doc: Fasta file containing the snRNAs
    inputBinding:
      position: 101
      prefix: --snRNAs
  - id: tRNAs
    type: File
    doc: Fasta file containing the tRNAs
    inputBinding:
      position: 101
      prefix: --tRNAs
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used
    inputBinding:
      position: 101
      prefix: --threads
  - id: transcripts
    type: File
    doc: Fasta file containing the transcripts
    inputBinding:
      position: 101
      prefix: --transcripts
outputs:
  - id: html_results
    type: File
    doc: Main HTML file where results will be displayed
    outputBinding:
      glob: $(inputs.html_results)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srnapipe:1.2.1--pl5321r44hdfd78af_0
