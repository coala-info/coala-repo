cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - BAMscale
  - scale
label: bamscale_scale
doc: "Convert BAM files to BigWigs; scale one or multiple files to genome size or\
  \ to each other.\n\nTool homepage: https://github.com/ncbi/BAMscale"
inputs:
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
  - id: fragsize
    type:
      - 'null'
      - int
    doc: Fragment size to be used to extend single-end library reads
    inputBinding:
      position: 1
      prefix: --fragsize
  - id: normtype
    type:
      - 'null'
      - string
    doc: 'Type of normalization, reads or base (default: base)'
    inputBinding:
      position: 1
      prefix: --normtype
  - id: scale
    type:
      - 'null'
      - string
    doc: 'Method to scale samples together, no, smallest, genome or custom (default:
      genome)'
    inputBinding:
      position: 1
      prefix: --scale
  - id: factor
    type:
      - 'null'
      - string
    doc: Scaling factor(s) when --scale custom is selected; comma delimited for several
      BAM files
    inputBinding:
      position: 1
      prefix: --factor
  - id: operation
    type:
      - 'null'
      - string
    doc: 'Operation to perform when scaling samples (scaled, unscaled, log2, ratio,
      subtract, rfd, endseq, endseqr, reptime, rna, strandrna, strandrnaR). Default:
      scaled'
    inputBinding:
      position: 1
      prefix: --operation
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: Output strand-specific normalized tracks. One BAM file can be specified only
    inputBinding:
      position: 1
      prefix: -S
  - id: binsize
    type:
      - 'null'
      - int
    doc: 'Size of bins for output bigWig/bedgraph generation (default: 20)'
    inputBinding:
      position: 1
      prefix: --binsize
  - id: seqcov
    type:
      - 'null'
      - int
    doc: Compute sequencing coverage from BAM file (0 use reads in index, 1 count
      reads while parsing BAMs; default 1)
    inputBinding:
      position: 1
      prefix: --seqcov
  - id: blacklist
    type:
      - 'null'
      - File
    doc: Input file with list of chromosomes to blacklist during scaling analysis
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
  - id: smoothen
    type:
      - 'null'
      - int
    doc: 'Smoothen signal by calculating mean of N bins flanking both sides of each
      bin (default: 0)'
    inputBinding:
      position: 1
      prefix: --smoothen
  - id: tracksmooth
    type:
      - 'null'
      - int
    doc: Which tracks should be smoothened (0 scaled and transformed, 1 only scaled,
      2 only transformed; default 1)
    inputBinding:
      position: 1
      prefix: --tracksmooth
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
    doc: Output directory with the coverage tracks
    outputBinding:
      glob: $(inputs.outdir)
  - id: bigwigs
    type: File[]
    doc: Coverage tracks in BigWig format (un-scaled, scaled, transformed)
    outputBinding:
      glob: $(inputs.outdir)/*.bw
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamscale:0.0.9--hf9495ce_0
