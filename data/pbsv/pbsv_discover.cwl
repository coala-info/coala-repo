cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pbsv
  - discover
label: pbsv_discover
doc: "Find structural variant (SV) signatures in read alignments (BAM to SVSIG).\n
  \nTool homepage: https://github.com/PacificBiosciences/pbsv"
inputs:
  - id: input_bam
    type: File
    doc: Coordinate-sorted aligned reads in which to identify SV signatures.
    inputBinding:
      position: 1
  - id: downsample_max_alignments
    type:
      - 'null'
      - int
    doc: Consider up to N alignments in a window; 0 means disabled.
    inputBinding:
      position: 102
      prefix: --downsample-max-alignments
  - id: downsample_window_length
    type:
      - 'null'
      - string
    doc: Window in which to limit coverage, in basepairs.
    inputBinding:
      position: 102
      prefix: --downsample-window-length
  - id: hifi
    type:
      - 'null'
      - boolean
    doc: 'Use options optimized for HiFi reads: -y 97'
    inputBinding:
      position: 102
      prefix: --ccs
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    inputBinding:
      position: 102
      prefix: --log-level
  - id: max_skip_split
    type:
      - 'null'
      - string
    doc: Ignore alignment pairs separated by > N bp of a read or reference.
    inputBinding:
      position: 102
      prefix: --max-skip-split
  - id: min_gap_comp_id_perc
    type:
      - 'null'
      - float
    doc: Ignore alignments with gap-compressed sequence identity < N%.
    inputBinding:
      position: 102
      prefix: --min-gap-comp-id-perc
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Ignore alignments with mapping quality < N.
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: min_ref_span
    type:
      - 'null'
      - string
    doc: Ignore alignments with reference length < N bp.
    inputBinding:
      position: 102
      prefix: --min-ref-span
  - id: min_svsig_length
    type:
      - 'null'
      - string
    doc: Ignore SV signatures with length < N bp.
    inputBinding:
      position: 102
      prefix: --min-svsig-length
  - id: region
    type:
      - 'null'
      - string
    doc: 'Limit discovery to this reference region: CHR|CHR:START-END.'
    inputBinding:
      position: 102
      prefix: --region
  - id: sample
    type:
      - 'null'
      - string
    doc: Override sample name tag from BAM read group.
    inputBinding:
      position: 102
      prefix: --sample
  - id: tandem_repeats
    type:
      - 'null'
      - string
    doc: Tandem repeat intervals for indel clustering.
    inputBinding:
      position: 102
      prefix: --tandem-repeats
outputs:
  - id: output_svsig
    type: File
    doc: Structural variant signatures output.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbsv:2.11.0--h9ee0642_0
