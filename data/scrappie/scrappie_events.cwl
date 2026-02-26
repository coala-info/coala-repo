cwlVersion: v1.2
class: CommandLineTool
baseCommand: events
label: scrappie_events
doc: "Scrappie basecaller -- basecall via events\n\nTool homepage: https://github.com/nanoporetech/scrappie"
inputs:
  - id: fast5_files
    type:
      type: array
      items: File
    doc: Input FAST5 files
    inputBinding:
      position: 1
  - id: dwell_correction
    type:
      - 'null'
      - boolean
    doc: Perform dwell correction of homopolymer lengths
    inputBinding:
      position: 102
      prefix: --dwell
  - id: hdf5_chunk_size
    type:
      - 'null'
      - string
    doc: Chunk size for HDF5 output
    inputBinding:
      position: 102
      prefix: --hdf5-chunk
  - id: hdf5_compression_level
    type:
      - 'null'
      - int
    doc: 'Gzip compression level for HDF5 output (0:off, 1: quickest, 9: best)'
    inputBinding:
      position: 102
      prefix: --hdf5-compression
  - id: local_penalty
    type:
      - 'null'
      - float
    doc: Penalty for local basecalling
    inputBinding:
      position: 102
      prefix: --local
  - id: max_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads to call (0 is unlimited)
    default: 0
    inputBinding:
      position: 102
      prefix: --limit
  - id: min_probability
    type:
      - 'null'
      - float
    doc: Minimum bound on probability of match
    inputBinding:
      position: 102
      prefix: --min_prob
  - id: no_dwell_correction
    type:
      - 'null'
      - boolean
    doc: Perform dwell correction of homopolymer lengths
    inputBinding:
      position: 102
      prefix: --no-dwell
  - id: no_slipping
    type:
      - 'null'
      - boolean
    doc: Use slipping
    inputBinding:
      position: 102
      prefix: --no-slip
  - id: no_uuid
    type:
      - 'null'
      - boolean
    doc: Output UUID
    inputBinding:
      position: 102
      prefix: --no-uuid
  - id: output_format
    type:
      - 'null'
      - string
    doc: Format to output reads (FASTA or SAM)
    inputBinding:
      position: 102
      prefix: --format
  - id: output_uuid
    type:
      - 'null'
      - boolean
    doc: Output UUID
    inputBinding:
      position: 102
      prefix: --uuid
  - id: print_licence
    type:
      - 'null'
      - boolean
    doc: Print licensing information
    inputBinding:
      position: 102
      prefix: --licence
  - id: print_license
    type:
      - 'null'
      - boolean
    doc: Print licensing information
    inputBinding:
      position: 102
      prefix: --license
  - id: read_prefix
    type:
      - 'null'
      - string
    doc: Prefix to append to name of each read
    inputBinding:
      position: 102
      prefix: --prefix
  - id: segmentation
    type:
      - 'null'
      - string
    doc: Chunk size and percentile for variance based segmentation
    inputBinding:
      position: 102
      prefix: --segmentation
  - id: skip_penalty
    type:
      - 'null'
      - float
    doc: Penalty for skipping a base
    inputBinding:
      position: 102
      prefix: --skip
  - id: stay_penalty
    type:
      - 'null'
      - float
    doc: Penalty for staying
    inputBinding:
      position: 102
      prefix: --stay
  - id: temperature1
    type:
      - 'null'
      - float
    doc: Temperature for softmax weights
    inputBinding:
      position: 102
      prefix: --temperature1
  - id: temperature2
    type:
      - 'null'
      - float
    doc: Temperature for softmax bias
    inputBinding:
      position: 102
      prefix: --temperature2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of reads to call in parallel
    inputBinding:
      position: 102
      prefix: --threads
  - id: trim_events
    type:
      - 'null'
      - string
    doc: Number of events to trim, as start:end
    inputBinding:
      position: 102
      prefix: --trim
  - id: use_slipping
    type:
      - 'null'
      - boolean
    doc: Use slipping
    inputBinding:
      position: 102
      prefix: --slip
outputs:
  - id: dump_file
    type:
      - 'null'
      - File
    doc: Dump annotated events to HDF5 file
    outputBinding:
      glob: $(inputs.dump_file)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write to file rather than stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
