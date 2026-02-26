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
    inputBinding:
      position: 101
      prefix: --reference
  - id: rerun_mode
    type:
      - 'null'
      - string
    doc: "Rerun mode [none]. Rerun everything (all); do not rerun\n              \
      \                read mapping (part); do not rerun (none)."
    default: none
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
    default: illumina
    inputBinding:
      position: 101
      prefix: --tech
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
