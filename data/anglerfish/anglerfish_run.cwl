cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anglerfish
  - run
label: anglerfish_run
doc: "Run anglerfish. This is the main command for anglerfish\n\nTool homepage: https://github.com/remiolsen/anglerfish"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: force_rc
    type:
      - 'null'
      - string
    doc: Force reverse complementing the I5 and/or I7 indices. If set to anything
      other than 'original' this will disregard lenient mode.
    default: original
    inputBinding:
      position: 101
      prefix: --force_rc
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Will try reverse complementing the I5 and/or I7 indices and choose the best
      match.
    inputBinding:
      position: 101
      prefix: --lenient
  - id: lenient_factor
    type:
      - 'null'
      - float
    doc: If lenient is set, this is the minimum factor of additional matches required
      to reverse complement the index
    default: 4.0
    inputBinding:
      position: 101
      prefix: --lenient_factor
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Manually set maximum allowed edit distance for index matching,by default
      this is set to 0, 1 or 2 based on the minimum detectedindex distance in the
      samplesheet.
    default: 2
    inputBinding:
      position: 101
      prefix: --max-distance
  - id: max_unknowns
    type:
      - 'null'
      - int
    doc: Maximum number of unknown indices to show in the output. default is length
      of samplesheet + 10
    default: 0
    inputBinding:
      position: 101
      prefix: --max-unknowns
  - id: ont_barcodes
    type:
      - 'null'
      - boolean
    doc: Will assume the samplesheet refers to a single ONT run prepped with a barcoding
      kit. And will treat each barcode separately
    inputBinding:
      position: 101
      prefix: --ont_barcodes
  - id: run_name
    type:
      - 'null'
      - string
    doc: Run name
    default: anglerfish
    inputBinding:
      position: 101
      prefix: --run_name
  - id: samplesheet
    type: File
    doc: CSV formatted list of samples and barcodes
    inputBinding:
      position: 101
      prefix: --samplesheet
  - id: skip_demux
    type:
      - 'null'
      - boolean
    doc: Only do BC counting and not demuxing
    inputBinding:
      position: 101
      prefix: --skip_demux
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_fastq
    type:
      - 'null'
      - Directory
    doc: Analysis output folder
    outputBinding:
      glob: $(inputs.out_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anglerfish:0.7.0--pyhdfd78af_0
