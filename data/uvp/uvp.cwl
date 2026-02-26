cwlVersion: v1.2
class: CommandLineTool
baseCommand: uvp
label: uvp
doc: "Call SNPs and InDels\n\nTool homepage: https://github.com/CPTR-ReSeqTB/UVP"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Run all SNP / InDel calling programs.
    inputBinding:
      position: 101
      prefix: --all
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Run snpEff functional annotation.
    inputBinding:
      position: 101
      prefix: --annotate
  - id: bwa
    type:
      - 'null'
      - boolean
    doc: Align Illumina reads using bwa. (Default)
    inputBinding:
      position: 101
      prefix: --bwa
  - id: config
    type:
      - 'null'
      - File
    doc: Config file
    inputBinding:
      position: 101
      prefix: --config
  - id: fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 101
      prefix: --fastq
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Second paired-end FASTQ file.
    inputBinding:
      position: 101
      prefix: --fastq2
  - id: gatk
    type:
      - 'null'
      - boolean
    doc: Run GATK SNP / InDel calling. (Default)
    inputBinding:
      position: 101
      prefix: --gatk
  - id: keepfiles
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files.
    inputBinding:
      position: 101
      prefix: --keepfiles
  - id: krakendb
    type:
      - 'null'
      - string
    doc: Path to kraken database
    inputBinding:
      position: 101
      prefix: --krakendb
  - id: name
    type: string
    doc: Sample name to be used as a prefix.
    inputBinding:
      position: 101
      prefix: --name
  - id: reference
    type: File
    doc: Reference genome in FASTA format.
    inputBinding:
      position: 101
      prefix: --reference
  - id: samtools
    type:
      - 'null'
      - boolean
    doc: Run SamTools SNP / InDel calling.
    inputBinding:
      position: 101
      prefix: --samtools
  - id: threads
    type:
      - 'null'
      - int
    doc: Num CPU threads for parallel execution
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Produce status updates of the run.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uvp:2.7.0--py_0
