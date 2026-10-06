cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - BAMscale
  - cov
label: bamscale_cov
doc: "Calculate coverage of BED coordinates in BAM file(s). Outputs are raw read counts,\
  \ FPKM and TPM normalized values.\n\nTool homepage: https://github.com/ncbi/BAMscale"
inputs:
  - id: bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 1
      prefix: --bed
  - id: bam
    type:
      type: array
      items: File
      inputBinding:
        prefix: --bam
    doc: Input BAM file(s), indexed. Given once per file
    inputBinding:
      position: 1
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
  - id: libtype
    type:
      - 'null'
      - string
    doc: 'Sequencing type to be used. Can be: single, paired, and auto (default: autodetect)'
    inputBinding:
      position: 1
      prefix: --libtype
  - id: frag
    type:
      - 'null'
      - boolean
    doc: 'Compute coverage using fragments instead of reads (default: no)'
    inputBinding:
      position: 1
      prefix: --frag
  - id: strand
    type:
      - 'null'
      - boolean
    doc: 'Reads need to have same orientation of peaks (default: unstranded)'
    inputBinding:
      position: 1
      prefix: --strand
  - id: rstrand
    type:
      - 'null'
      - boolean
    doc: 'Reads need to have reverse orientation of peaks (default: unstranded)'
    inputBinding:
      position: 1
      prefix: --rstrand
  - id: seqcov
    type:
      - 'null'
      - int
    doc: Compute sequencing coverage from BAM file quickly using the index (0), or
      count reads by parsing the entire BAM file (1, default)
    inputBinding:
      position: 1
      prefix: --seqcov
  - id: blacklist
    type:
      - 'null'
      - File
    doc: Input file with list of chromosomes to blacklist when computing coverage
      for normalization
    inputBinding:
      position: 1
      prefix: --blacklist
  - id: bedsubtract
    type:
      - 'null'
      - File
    doc: BED file with regions to subtract when computing coverage for normalization
    inputBinding:
      position: 1
      prefix: --bedsubtract
  - id: mapq
    type:
      - 'null'
      - int
    doc: 'Minimum (at least) mapping quality (default: 0)'
    inputBinding:
      position: 1
      prefix: --mapq
  - id: keepdup
    type:
      - 'null'
      - boolean
    doc: 'Keep duplicated reads (default: no)'
    inputBinding:
      position: 1
      prefix: --keepdup
  - id: noproper
    type:
      - 'null'
      - boolean
    doc: 'Do not filter un-proper alignments (default: filter)'
    inputBinding:
      position: 1
      prefix: --noproper
  - id: unmappair
    type:
      - 'null'
      - boolean
    doc: Do not remove reads with unmapped pairs
    inputBinding:
      position: 1
      prefix: --unmappair
  - id: minfrag
    type:
      - 'null'
      - int
    doc: 'Minimum fragment size for read pairs (default: 0)'
    inputBinding:
      position: 1
      prefix: --minfrag
  - id: maxfrag
    type:
      - 'null'
      - int
    doc: 'Maximum fragment size for read pairs (default: 2000)'
    inputBinding:
      position: 1
      prefix: --maxfrag
  - id: fragfilt
    type:
      - 'null'
      - boolean
    doc: 'Filter reads based on fragment size (default: no)'
    inputBinding:
      position: 1
      prefix: --fragfilt
  - id: diffchr
    type:
      - 'null'
      - boolean
    doc: 'Keep reads where read pair aligns to different chromosome (default: no)'
    inputBinding:
      position: 1
      prefix: --diffchr
  - id: outdir
    type: string
    doc: Output directory name
    inputBinding:
      position: 1
      prefix: --outdir
    default: bamscale_out
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Output prefix for file names (default: none)'
    inputBinding:
      position: 1
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: 'No. of threads to use (default: 1)'
    inputBinding:
      position: 1
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the coverage tables
    outputBinding:
      glob: $(inputs.outdir)
  - id: coverage_tables
    type: File[]
    doc: Coverage tables (un-normalized, library-size normalized, FPKM and TPM)
    outputBinding:
      glob: $(inputs.outdir)/*.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamscale:0.0.9--hf9495ce_0
