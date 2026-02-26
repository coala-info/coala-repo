cwlVersion: v1.2
class: CommandLineTool
baseCommand: notramp
label: notramp
doc: "NoTrAmp is a Tool for read-depth normalization and trimming of reads in\namplicon-tiling
  approaches. It trims amplicons to their appropriate length\nremoving barcodes, adpaters
  and primers (if desired) in a single clipping step\nand can be used to cap coverage
  of all amplicons at a chosen value.\n\nTool homepage: https://github.com/simakro/NoTrAmp.git"
inputs:
  - id: all
    type: boolean
    doc: "Perform read depth normalization by coverage-\ncapping/downsampling first,
      then clip the normalized\nreads. (mut.excl. with -c, -t)"
    inputBinding:
      position: 101
      prefix: --all
  - id: cov
    type: boolean
    doc: "Perform only read-depth normalization/downsampling.\n(mut.excl. with -a,
      -t)"
    inputBinding:
      position: 101
      prefix: --cov
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Set this flag to request output in fastq format. By\ndefault output is in
      fasta format. Has no effect if\ninput file is fasta."
    inputBinding:
      position: 101
      prefix: --fastq
  - id: figures
    type:
      - 'null'
      - type: array
        items: boolean
    doc: "Set to generate figures of input and output\nread_counts. Available for
      --all and --cov modes. You\ncan optionally provide a value to draw a red helper\n\
      line in the output read plot, showing a threshold, e.g.\nmin. required reads.
      [default=False;\ndefault_threshold=20]"
    inputBinding:
      position: 101
      prefix: --figures
  - id: incl_prim
    type:
      - 'null'
      - boolean
    doc: "Set this flag if you want to include the primer\nsequences in the trimmed
      reads. By default primers are\nremoved together with all overhanging sequences
      like\nbarcodes and adapters."
    inputBinding:
      position: 101
      prefix: --incl_prim
  - id: max_cov
    type:
      - 'null'
      - int
    doc: "Provide threshold for maximum read-depth per amplicon\nas integer value.
      [default=200]"
    default: 200
    inputBinding:
      position: 101
      prefix: --max_cov
  - id: name_scheme
    type:
      - 'null'
      - File
    doc: "Provide path to json-file containing a naming scheme\nwhich is consistently
      used for all\nprimers.[default=artic_nCoV_scheme_v5.3.2]"
    default: artic_nCoV_scheme_v5.3.2
    inputBinding:
      position: 101
      prefix: --name_scheme
  - id: primers
    type: File
    doc: "Path to primer bed-file (primer-names must adhere to a\nconsistent naming
      scheme see readme)"
    inputBinding:
      position: 101
      prefix: --primers
  - id: reads
    type: File
    doc: Path to sequencing reads fasta
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: File
    doc: "Path to reference (genome) fasta file. Must contain\nonly one target sequence.
      Multiple target sequences\nare not currently supported."
    inputBinding:
      position: 101
      prefix: --reference
  - id: selftest
    type:
      - 'null'
      - boolean
    doc: "Run a selftest of NoTrAmp using included test-data.\nOverrides all other
      arguments and parameters. Useful\nfor checking how NoTrAmp runs in your environment."
    inputBinding:
      position: 101
      prefix: --selftest
  - id: seq_tec
    type:
      - 'null'
      - string
    doc: "Specify long-read sequencing technology (ont/pb).\n[default=ont]"
    default: ont
    inputBinding:
      position: 101
      prefix: --seq_tec
  - id: set_margins
    type:
      - 'null'
      - int
    doc: "Set length of tolerance margins for sorting of\nmappings to amplicons. [default=5]"
    default: 5
    inputBinding:
      position: 101
      prefix: --set_margins
  - id: set_max_len
    type:
      - 'null'
      - string
    doc: "Set a maximum allowed length for alignments of reads\nto amplicon. If this
      is not set the max_len will be\n1.2*longest_amp_len. The default setting normally\n\
      doesn't need to be changed."
    inputBinding:
      position: 101
      prefix: --set_max_len
  - id: set_min_len
    type:
      - 'null'
      - string
    doc: "Set a minimum required length for alignments of reads\nto amplicons. If
      this is not set the min_len will be\n0.8*shortest_amp_len. When using reads
      that are\nshorter than amplicon sizes use this argument to\nadjust. For long
      reads this option is usually not\nrequired."
    inputBinding:
      position: 101
      prefix: --set_min_len
  - id: split
    type:
      - 'null'
      - boolean
    doc: "Set this flag to request output of capped, untrimmed\nreads split to amplicon
      specific files (can be a lot)."
    inputBinding:
      position: 101
      prefix: --split
  - id: trim
    type: boolean
    doc: "Perform only trimming to amplicon length (excluding\nprimers by default;
      to include primers set --incl_prim\nflag). (mut.excl. with -a, -c)"
    inputBinding:
      position: 101
      prefix: --trim
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: "Optionally specify a directory for saving of outfiles.\nIf this argument
      is not given, out-files will be saved\nin the directory where the input reads
      are located.\n[default=False]"
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/notramp:1.1.9--pyh7e72e81_0
