cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - locityper
  - preproc
label: locityper_preproc
doc: "Preprocess WGS dataset.\n\nTool homepage: https://github.com/tprodanov/locityper"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Save debug CSV files.
    inputBinding:
      position: 101
      prefix: --debug
  - id: describe
    type:
      - 'null'
      - boolean
    doc: Simply describe already preprocessed data.
    inputBinding:
      position: 101
      prefix: --describe
  - id: input_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: "Reads in BAM/CRAM format, mutually exclusive with -i/--input.\n        \
      \                      Unless --no-index, mapped, sorted & indexed BAM/CRAM
      file is expected.\n                              If provided, second file should
      contain path to the alignment index."
    inputBinding:
      position: 101
      prefix: --alignment
  - id: input_fq
    type:
      - 'null'
      - type: array
        items: File
    doc: "Reads 1 and 2 in FASTA or FASTQ format, optionally gzip compressed.\n  \
      \                            Reads 1 are required, reads 2 are optional."
    inputBinding:
      position: 101
      prefix: --input
  - id: input_list
    type:
      - 'null'
      - File
    doc: File with input filenames (see documentation).
    inputBinding:
      position: 101
      prefix: --in-list
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Interleaved paired-end reads in single input file.
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: jf_counts
    type: File
    doc: Jellyfish k-mer counts (see documentation).
    inputBinding:
      position: 101
      prefix: --jf-counts
  - id: like_dir
    type:
      - 'null'
      - Directory
    doc: "This dataset is similar to already preprocessed dataset.\n             \
      \                 Use with care. Only utilizes difference in the number of reads."
    inputBinding:
      position: 101
      prefix: --like
  - id: no_index
    type:
      - 'null'
      - boolean
    doc: "Use input full BAM/CRAM file (-a) without index.\n                     \
      \         Single-end and paired-end interleaved (-^) data is allowed."
    inputBinding:
      position: 101
      prefix: --no-index
  - id: reference
    type: File
    doc: Reference FASTA file. Must be indexed with FAIDX.
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: --reference
  - id: rerun_mode
    type:
      - 'null'
      - string
    doc: "Rerun mode [none]. Rerun everything (all); do not rerun\n              \
      \                read mapping (part); do not rerun (none)."
    inputBinding:
      position: 101
      prefix: --rerun
  - id: tech
    type:
      - 'null'
      - string
    doc: "Sequencing technology [illumina]:\n                              sr  | illumina
      : short-read sequencing,\n                                hifi         : PacBio
      HiFi,\n                              pb  | pacbio   : PacBio CLR,\n        \
      \                      ont | nanopore : Oxford Nanopore."
    inputBinding:
      position: 101
      prefix: --tech
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: bg_region
    type:
      - 'null'
      - string
    doc: Preprocess WGS data based on this background region, preferably >3 Mb and without many duplications. Default regions are defined for CHM13, GRCh38 and GRCh37.
    inputBinding:
      position: 101
      prefix: --bg-region
  - id: skip_recruit
    type:
      - 'null'
      - boolean
    doc: Skip read recruitment before read mapping.
    inputBinding:
      position: 101
      prefix: --skip-recruit
  - id: recr_threads
    type:
      - 'null'
      - float
    doc: Number of threads used for read recruitment [0.4]. Fraction of the total number of threads, if under 1.
    inputBinding:
      position: 101
      prefix: --recr-threads
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Ignore reads with mapping quality less than INT [30].
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: max_clipping
    type:
      - 'null'
      - float
    doc: Ignore reads with soft/hard clipping > NUM * read length [0.02].
    inputBinding:
      position: 101
      prefix: --max-clipping
  - id: pval_thresh
    type:
      - 'null'
      - type: array
        items: float
    doc: Two p-value thresholds for filtering recruited reads - on insert size [0.001] and on edit distance [0.01].
    inputBinding:
      position: 101
      prefix: --pval-thresh
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Specie ploidy [2].
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: window
    type:
      - 'null'
      - int
    doc: Count read depth in windows of this size [auto]. Default - half of the mean read length.
    inputBinding:
      position: 101
      prefix: --window
  - id: boundary
    type:
      - 'null'
      - int
    doc: Skip INT bp near the edge of the background region [1k].
    inputBinding:
      position: 101
      prefix: --boundary
  - id: kmer_perc
    type:
      - 'null'
      - float
    doc: Ignore windows where less than NUM% k-mers are unique [90].
    inputBinding:
      position: 101
      prefix: --kmer-perc
  - id: frac_windows
    type:
      - 'null'
      - float
    doc: This fraction of all windows is used in LOESS during read depth estimation [0.5].
    inputBinding:
      position: 101
      prefix: --frac-windows
  - id: filesize
    type:
      - 'null'
      - boolean
    doc: Estimate read depth by comparing file sizes with similar dataset (--like). Use with extreme care.
    inputBinding:
      position: 101
      prefix: --filesize
  - id: subsample
    type:
      - 'null'
      - float
    doc: Subsample input reads by this fraction [1].
    inputBinding:
      position: 101
      prefix: --subsample
  - id: seed
    type:
      - 'null'
      - int
    doc: Subsampling seed (optional).
    inputBinding:
      position: 101
      prefix: --seed
  - id: head
    type:
      - 'null'
      - int
    doc: Instead of the full preprocessing, map first INT reads to the reference and extract insert sizes and error profiles from them.
    inputBinding:
      position: 101
      prefix: --head
  - id: output_dir_path
    type: string
    doc: DIR    Output directory.
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
