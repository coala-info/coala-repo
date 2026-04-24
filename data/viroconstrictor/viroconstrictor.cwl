cwlVersion: v1.2
class: CommandLineTool
baseCommand: ViroConstrictor
label: viroconstrictor
doc: "a pipeline for analysing Viral targeted\n(amplicon) sequencing data in order
  to generate a biologically valid consensus\nsequence.\n\nTool homepage: https://rivm-bioinformatics.github.io/ViroConstrictor/"
inputs:
  - id: amplicon_type
    type: string
    doc: "Define the amplicon-type, either being\n'end-to-end', 'end-to-mid', or\n\
      'fragmented'. See the docs for more\ninfo"
    inputBinding:
      position: 101
      prefix: --amplicon-type
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Adds extra information to the log file
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable_presets
    type:
      - 'null'
      - boolean
    doc: "Disable the use of presets, this will\ncause all analysis settings to be
      set\nto default values"
    inputBinding:
      position: 101
      prefix: --disable-presets
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: "Run the workflow without actually\ndoing anything"
    inputBinding:
      position: 101
      prefix: --dryrun
  - id: features
    type:
      - 'null'
      - File
    doc: "GFF file containing the Open Reading\nFrame (ORF) information of the\nreference.
      Supplying NONE will let\nViroConstrictor use prodigal to\ndetermine coding regions"
    inputBinding:
      position: 101
      prefix: --features
  - id: fragment_lookaround_size
    type:
      - 'null'
      - int
    doc: "Size of the fragment lookaround region\n(in bp) for the AmpliGone tool."
    inputBinding:
      position: 101
      prefix: --fragment-lookaround-size
  - id: input_dir
    type: Directory
    doc: "The input directory with raw\nfastq(.gz) files"
    inputBinding:
      position: 101
      prefix: --input
  - id: match_ref
    type:
      - 'null'
      - boolean
    doc: "Match your data to the best reference\navailable in the given reference
      fasta\nfile."
    inputBinding:
      position: 101
      prefix: --match-ref
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: "Minimum coverage for the consensus\nsequence."
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: output_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: platform
    type: string
    doc: "Define the sequencing platform that\nwas used to generate the dataset,\n\
      either being 'nanopore', 'illumina' or\n'iontorrent', see the docs for more\n\
      info"
    inputBinding:
      position: 101
      prefix: --platform
  - id: preset
    type:
      - 'null'
      - string
    doc: "Define the specific target for the\npipeline, if the target matches a\n\
      certain preset then pre-defined\nanalysis settings will be used, see\nthe docs
      for more info"
    inputBinding:
      position: 101
      prefix: --preset
  - id: primer_mismatch_rate
    type:
      - 'null'
      - int
    doc: "Maximum number of mismatches allowed\nin the primer sequences during primer\n\
      coordinate search. Use 0 for exact\nprimer matches Default is 3."
    inputBinding:
      position: 101
      prefix: --primer-mismatch-rate
  - id: primers
    type:
      - 'null'
      - File
    doc: "Used primer sequences in FASTA or BED\nformat. If no primers should be\n\
      removed, supply the value NONE to this\nflag."
    inputBinding:
      position: 101
      prefix: --primers
  - id: reference
    type:
      - 'null'
      - File
    doc: "Input Reference sequence genome in\nFASTA format"
    inputBinding:
      position: 101
      prefix: --reference
  - id: samplesheet
    type:
      - 'null'
      - File
    doc: Sample sheet information file
    inputBinding:
      position: 101
      prefix: --samplesheet
  - id: scheduler
    type:
      - 'null'
      - string
    doc: "The scheduler to use for the workflow,\neither 'auto', 'none', or any in
      the\nfollowing list: ['LOCAL', 'SLURM',\n'LSF', 'DRYRUN', 'AUTO']. Default is\n\
      'auto', which will try to determine\nthe scheduler automatically."
    inputBinding:
      position: 101
      prefix: --scheduler
  - id: segmented
    type:
      - 'null'
      - boolean
    doc: "Use this flag in combination with\nmatch-ref to indicate that the match-\n\
      ref process should take segmented\nreference information into account.\nPlease
      note that specific formatting\nis required for the reference fasta\nfile, see
      the docs for more info."
    inputBinding:
      position: 101
      prefix: --segmented
  - id: skip_updates
    type:
      - 'null'
      - boolean
    doc: Skip the update check
    inputBinding:
      position: 101
      prefix: --skip-updates
  - id: target
    type:
      - 'null'
      - string
    doc: "Define the specific target for the\npipeline, if the target matches a\n\
      certain preset then pre-defined\nanalysis settings will be used, see\nthe docs
      for more info"
    inputBinding:
      position: 101
      prefix: --target
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of local threads that are\navailable to use. Default is the\nnumber
      of available threads in your\nsystem (20)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: unidirectional
    type:
      - 'null'
      - boolean
    doc: "Use this flag to indicate that the\n(illumina) sequencing data is\nunidirectional
      (i.e. only R1 reads are\navailable). This will cause the\npipeline to not consider
      R2 reads for\nthe analysis. Can only be combined\nwith the illumina platform."
    inputBinding:
      position: 101
      prefix: --unidirectional
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Adds extra information to the log file
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viroconstrictor:1.6.4--pyhdfd78af_0
stdout: viroconstrictor.out
