cwlVersion: v1.2
class: CommandLineTool
baseCommand: recalladapters
label: recalladapters
doc: "recalladapters operates on BAM files in one convention (subreads+scraps or hqregions+scraps),
  allows reprocessing adapter calls then outputs the resulting BAM files as subreads
  plus scraps.\n\n\"Scraps\" BAM files are always required to reconstitute the ZMW
  reads internally. Conversely, \"scraps\" BAM files will be output.\n\nZMW reads
  are not allowed as input, due to the missing HQ-region annotations!\n\nInput read
  convention is determined from the READTYPE annotation in the @RG::DS tags of the
  input BAM files.A subreadset *must* be used as input instead of the individual BAM
  files.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: adapter_sequences
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --adapters
  - id: adpqc
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --adpqc
  - id: bam_threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel BAM compression, can only be set when 
      not generating pbindex inline with --inlinePbi
    inputBinding:
      position: 101
      prefix: -b
  - id: disable_adapter_correction
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --disableAdapterCorrection
  - id: disable_adapter_finding
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --disableAdapterFinding
  - id: flank_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --flankLength
  - id: global_aln_flanking
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --globalAlnFlanking
  - id: inline_pbi
    type:
      - 'null'
      - boolean
    doc: Generate pbindex inline with BAM writing
    inputBinding:
      position: 101
      prefix: --inlinePbi
  - id: min_adapter_score
    type:
      - 'null'
      - int
    doc: Minimal score for an adapter
    inputBinding:
      position: 101
      prefix: --minAdapterScore
  - id: min_flanking_score
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --minFlankingScore
  - id: min_hard_accuracy
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --minHardAccuracy
  - id: min_snr
    type:
      - 'null'
      - float
    doc: Minimal SNR across channels.
    inputBinding:
      position: 101
      prefix: --minSnr
  - id: min_soft_accuracy
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --minSoftAccuracy
  - id: min_sub_length
    type:
      - 'null'
      - int
    doc: Minimal subread length.
    inputBinding:
      position: 101
      prefix: --minSubLength
  - id: nprocs
    type:
      - 'null'
      - int
    doc: Number of threads for parallel ZMW processing
    inputBinding:
      position: 101
      prefix: --nProcs
  - id: output_prefix
    type: string
    doc: Prefix of output filenames
    inputBinding:
      position: 101
      prefix: -o
  - id: silent
    type:
      - 'null'
      - boolean
    doc: No progress output.
    inputBinding:
      position: 101
      prefix: --silent
  - id: subreadset
    type: string
    doc: Input subreadset.xml
    inputBinding:
      position: 101
      prefix: --subreadset
  - id: whitelist_zmw_num
    type:
      - 'null'
      - string
    doc: Only process given ZMW NUMBERs
    inputBinding:
      position: 101
      prefix: --whitelistZmwNum
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recalladapters:9.0.0--h9ee0642_1
stdout: recalladapters.out
