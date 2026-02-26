cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl EDTA.pl
label: edta_EDTA.pl
doc: "Extensive de-novo TE Annotator that generates a high-quality structure-based
  TE library.\n\nTool homepage: https://github.com/oushujun/EDTA"
inputs:
  - id: anno
    type:
      - 'null'
      - int
    doc: "Perform (1) or not perform (0, default) whole-genome TE annotation\nafter
      TE library construction."
    default: 0
    inputBinding:
      position: 101
      prefix: --anno
  - id: annosine
    type:
      - 'null'
      - Directory
    doc: 'The directory containing AnnoSINE_v2 (default: read from ENV)'
    inputBinding:
      position: 101
      prefix: --annosine
  - id: cds
    type:
      - 'null'
      - File
    doc: "Provide a FASTA file containing the coding sequence (no introns,\nUTRs,
      nor TEs) of this genome or its close relative."
    inputBinding:
      position: 101
      prefix: --cds
  - id: check_dependencies
    type:
      - 'null'
      - boolean
    doc: Check if dependencies are fullfiled and quit
    inputBinding:
      position: 101
      prefix: --check_dependencies
  - id: curatedlib
    type:
      - 'null'
      - File
    doc: "Provided a curated library to keep consistant naming and\nclassification
      for known TEs. TEs in this file will be\ntrusted 100%, so please ONLY provide
      MANUALLY CURATED ones.\nThis option is not mandatory. It's totally OK if no
      file is\nprovided (default)."
    inputBinding:
      position: 101
      prefix: --curatedlib
  - id: debug
    type:
      - 'null'
      - int
    doc: 'Retain intermediate files (default: 0)'
    default: 0
    inputBinding:
      position: 101
      prefix: --debug
  - id: evaluate
    type:
      - 'null'
      - int
    doc: "Evaluate (1) classification consistency of the TE annotation.\n(--anno 1
      required). Default: 1."
    default: 1
    inputBinding:
      position: 101
      prefix: --evaluate
  - id: exclude
    type:
      - 'null'
      - File
    doc: "Exclude regions (bed format) from TE masking in the MAKER.masked\noutput.
      Default: undef. (--anno 1 required)."
    inputBinding:
      position: 101
      prefix: --exclude
  - id: force
    type:
      - 'null'
      - int
    doc: "When no confident TE candidates are found: 0, interrupt and exit\n(default);
      1, use rice TEs to continue."
    default: 0
    inputBinding:
      position: 101
      prefix: --force
  - id: genome
    type: File
    doc: The genome FASTA file.
    inputBinding:
      position: 101
      prefix: --genome
  - id: ltrretriever
    type:
      - 'null'
      - Directory
    doc: 'The directory containing LTR_retriever (default: read from ENV)'
    inputBinding:
      position: 101
      prefix: --ltrretriever
  - id: maxdiv
    type:
      - 'null'
      - int
    doc: "Maximum divergence (0-100%, default: 40) of repeat fragments comparing to\
      \ \nlibrary sequences."
    default: 40
    inputBinding:
      position: 101
      prefix: --maxdiv
  - id: overwrite
    type:
      - 'null'
      - int
    doc: "If previous raw TE results are found, decide to overwrite\n(1, rerun) or
      not (0, default)."
    default: 0
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: repeatmasker
    type:
      - 'null'
      - Directory
    doc: 'The directory containing RepeatMasker (default: read from ENV)'
    inputBinding:
      position: 101
      prefix: --repeatmasker
  - id: repeatmodeler
    type:
      - 'null'
      - Directory
    doc: 'The directory containing RepeatModeler (default: read from ENV)'
    inputBinding:
      position: 101
      prefix: --repeatmodeler
  - id: rmlib
    type:
      - 'null'
      - File
    doc: "Provide the RepeatModeler library containing classified TEs to enhance\n\
      the sensitivity especially for LINEs. If no file is provided (default),\nEDTA
      will generate such file for you."
    inputBinding:
      position: 101
      prefix: --rmlib
  - id: sensitive
    type:
      - 'null'
      - int
    doc: "Use RepeatModeler to identify remaining TEs (1) or not (0,\ndefault). This
      step may help to recover some TEs."
    default: 0
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: species
    type:
      - 'null'
      - string
    doc: Specify the species for identification of TIR candidates.
    default: others
    inputBinding:
      position: 101
      prefix: --species
  - id: step
    type:
      - 'null'
      - string
    doc: "Specify which steps you want to run EDTA.\nall: run the entire pipeline
      (default)\nfilter: start from raw TEs to the end.\nfinal: start from filtered
      TEs to finalizing the run.\nanno: perform whole-genome annotation/analysis after\n\
      \t\t\tTE library construction."
    default: all
    inputBinding:
      position: 101
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of theads to run this script (default: 4)'
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: u
    type:
      - 'null'
      - float
    doc: "Neutral mutation rate to calculate the age of intact LTR elements.\nIntact
      LTR age is found in this file: *EDTA_raw/LTR/*.pass.list.\nDefault: 1.3e-8 (per
      bp per year, from rice)."
    default: '1.3e-8'
    inputBinding:
      position: 101
      prefix: --u
outputs:
  - id: rmout
    type:
      - 'null'
      - File
    doc: "Provide your own homology-based TE annotation instead of using the\nEDTA
      library for masking. File is in RepeatMasker .out format. This\nfile will be
      merged with the structural-based TE annotation. (--anno 1\nrequired). Default:
      use the EDTA library for annotation."
    outputBinding:
      glob: $(inputs.rmout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/edta:2.2.2--hdfd78af_1
