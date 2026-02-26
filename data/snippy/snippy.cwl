cwlVersion: v1.2
class: CommandLineTool
baseCommand: snippy
label: snippy
doc: "Rapid haploid variant calling and core genome alignment\n\nTool homepage: https://github.com/tseemann/snippy"
inputs:
  - id: basequal
    type:
      - 'null'
      - int
    doc: Minimum VCF variant quality
    default: 13
    inputBinding:
      position: 101
      prefix: --basequal
  - id: contigs
    type:
      - 'null'
      - File
    doc: Don't use reads, use these contigs (FASTA)
    inputBinding:
      position: 101
      prefix: --ctgs
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    default: 8
    inputBinding:
      position: 101
      prefix: --cpus
  - id: mincov
    type:
      - 'null'
      - int
    doc: Minimum coverage to call a site
    default: 10
    inputBinding:
      position: 101
      prefix: --mincov
  - id: minfrac
    type:
      - 'null'
      - float
    doc: Minimum proportion for variant evidence
    default: 0.1
    inputBinding:
      position: 101
      prefix: --minfrac
  - id: peil
    type:
      - 'null'
      - File
    doc: Interleaved paired-end reads (FASTQ)
    inputBinding:
      position: 101
      prefix: --peil
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No screen output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: r1
    type:
      - 'null'
      - File
    doc: Forward reads (FASTQ)
    inputBinding:
      position: 101
      prefix: --R1
  - id: r2
    type:
      - 'null'
      - File
    doc: Reverse reads (FASTQ)
    inputBinding:
      position: 101
      prefix: --R2
  - id: ram
    type:
      - 'null'
      - int
    doc: RAM to use in GB
    default: 8
    inputBinding:
      position: 101
      prefix: --ram
  - id: reference
    type: File
    doc: Reference genome in FASTA or Genbank format
    inputBinding:
      position: 101
      prefix: --ref
  - id: se
    type:
      - 'null'
      - File
    doc: Single-end reads (FASTQ)
    inputBinding:
      position: 101
      prefix: --se
outputs:
  - id: outdir
    type: Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snippy:4.6.0--hdfd78af_6
