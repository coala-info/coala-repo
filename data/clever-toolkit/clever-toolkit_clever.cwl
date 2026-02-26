cwlVersion: v1.2
class: CommandLineTool
baseCommand: clever
label: clever-toolkit_clever
doc: "This tool runs the whole workflow necessary to use CLEVER.\n\nTool homepage:
  https://bitbucket.org/tobiasmarschall/clever-toolkit"
inputs:
  - id: bam_file
    type: File
    doc: "Input BAM file. All alignments for the same read (pair) must be in\n   \
      \                subsequent lines. It is highly recommended to allows multiple\
      \ \n                   alignments per read to avoid spurious predictions."
    inputBinding:
      position: 1
  - id: ref_fasta
    type: File
    doc: "The reference genome in (gzipped) FASTA format. This is needed to\n    \
      \               recompute alignment scores (AS tags). If your BAM file does
      have AS tags\n                   such that 10^(AS/-10.0) can be interpreted
      as the probability of this\n                   alignment being correct, use
      option -a to omit this step."
    inputBinding:
      position: 2
  - id: result_directory
    type: Directory
    doc: "Directory to be created to store results in. If it already exists, abort\n\
      \                   unless option -f is given."
    inputBinding:
      position: 3
  - id: add_clever_params
    type:
      - 'null'
      - string
    doc: "Additional parameters to be passed to the CLEVER core\n                \
      \        algorithm. Call \"clever-core\" without parameters for a\n        \
      \                list of options."
    inputBinding:
      position: 104
      prefix: -C
  - id: add_post_params
    type:
      - 'null'
      - string
    doc: "Additional parameters for postprocessing results. Call\n               \
      \         \"postprocess-predictions\" without parameters for a\n           \
      \             list of options."
    inputBinding:
      position: 104
      prefix: -P
  - id: chromosome
    type:
      - 'null'
      - string
    doc: 'Only process given chromosome (default: all).'
    default: all
    inputBinding:
      position: 104
      prefix: --chromosome
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Delete old result and working directory first (if\n                    \
      \    present)."
    inputBinding:
      position: 104
      prefix: -f
  - id: keep_work_dir
    type:
      - 'null'
      - boolean
    doc: "Keep working directory (default: delete directory when\n               \
      \         finished)."
    inputBinding:
      position: 104
      prefix: -k
  - id: no_compute_as_tags
    type:
      - 'null'
      - boolean
    doc: "Do not (re-)compute AS tags. If given, the argument\n                  \
      \      <ref.fasta(.gz)> is ignored."
    inputBinding:
      position: 104
      prefix: -a
  - id: plot_segment_size
    type:
      - 'null'
      - boolean
    doc: "Create a plot of internal segment size distribution\n                  \
      \      (=fragment size - 2x read length). Also displays the\n              \
      \          estimated normal distribution (requires NumPy and\n             \
      \           matplotlib)."
    inputBinding:
      position: 104
      prefix: -I
  - id: read_groups
    type:
      - 'null'
      - boolean
    doc: Take read groups into account (multi sample mode).
    inputBinding:
      position: 104
      prefix: -r
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: "Input BAM file is sorted by position. Note that this\n                 \
      \       requires alternative alignments to be given as XA tags\n           \
      \             (like produced by BWA, stampy, etc.)."
    inputBinding:
      position: 104
      prefix: --sorted
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default=1).
    default: 1
    inputBinding:
      position: 104
      prefix: -T
  - id: use_mapq
    type:
      - 'null'
      - boolean
    doc: Use MAPQ value instead re-computing posteriors.
    inputBinding:
      position: 104
      prefix: --use_mapq
  - id: use_xa
    type:
      - 'null'
      - boolean
    doc: "Interprete XA tags in input BAM file. This option\n                    \
      \    SHOULD be given for mappers writing XA tags like BWA\n                \
      \        and stampy."
    inputBinding:
      position: 104
      prefix: --use_xa
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: 'Working directory (default: <result-directory>/work).'
    inputBinding:
      position: 104
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clever-toolkit:2.4--h077b44d_14
stdout: clever-toolkit_clever.out
