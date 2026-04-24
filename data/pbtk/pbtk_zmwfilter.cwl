cwlVersion: v1.2
class: CommandLineTool
baseCommand: zmwfilter
label: pbtk_zmwfilter
doc: "Filter ZMWs from BAM data\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: input
    type: File
    doc: Input BAM, FASTX, or DataSet XML
    inputBinding:
      position: 1
  - id: downsample
    type:
      - 'null'
      - float
    doc: Fraction of random ZMWs to include in the output BAM file. Downsampling is
      not supported on FASTX files.
    inputBinding:
      position: 102
      prefix: --downsample
  - id: downsample_count
    type:
      - 'null'
      - int
    doc: Number of random ZMWs to include in the output BAM file. Downsampling is
      not supported on FASTX files.
    inputBinding:
      position: 102
      prefix: --downsample-count
  - id: downsample_seed
    type:
      - 'null'
      - int
    doc: Seed for the downsampling random-number generator. Set this value for reproducible
      output. Downsampling is not supported on FASTX files.
    inputBinding:
      position: 102
      prefix: --downsample-seed
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude ZMWs from the output file. This can be either a comma-separated list
      of IDs or a filename containing one ID per line.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: include
    type:
      - 'null'
      - string
    doc: Include ZMWs in the output file. This can be either a comma-separated list
      of IDs or a filename containing one ID per line.
    inputBinding:
      position: 102
      prefix: --include
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
  - id: names
    type:
      - 'null'
      - File
    doc: Include only these read names in the output file. This should be a file containing
      one name per line. No other filtering is applied, and FASTX input is not supported.
    inputBinding:
      position: 102
      prefix: --names
  - id: num_passes
    type:
      - 'null'
      - int
    doc: Include only ZMWs that have >= N subreads.
    inputBinding:
      position: 102
      prefix: --num-passes
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: show_all
    type:
      - 'null'
      - boolean
    doc: Print all unique ZMW hole numbers to stdout, one per line. No filtering is
      applied.
    inputBinding:
      position: 102
      prefix: --show-all
outputs:
  - id: output
    type: File
    doc: Output BAM or FASTX (same as input format)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
