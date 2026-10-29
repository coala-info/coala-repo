cwlVersion: v1.2
class: CommandLineTool
baseCommand: zmwfilter
label: zmwfilter
doc: "Filter ZMWs (Zero-Mode Waveguides) from PacBio BAM, FASTX or DataSet XML data.\n\nTool homepage: https://github.com/PacificBiosciences/zmwfilter"
inputs:
  - id: input
    type: File
    doc: Input BAM, FASTX, or DataSet XML (a BAM needs its .pbi index beside it)
    secondaryFiles:
      - pattern: .pbi
        required: false
    inputBinding:
      position: 100
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output BAM or FASTX (same as input format); not given with --show-all
    inputBinding:
      position: 101
  - id: include
    type:
      - 'null'
      - string
    doc: Include ZMWs in the output file. This can be either a comma-separated list of IDs or a filename containing one ID per line.
    inputBinding:
      position: 1
      prefix: --include
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude ZMWs from the output file. This can be either a comma-separated list of IDs or a filename containing one ID per line.
    inputBinding:
      position: 1
      prefix: --exclude
  - id: include_file
    type:
      - 'null'
      - File
    doc: File containing one ZMW ID per line to include (use instead of the include string)
    inputBinding:
      position: 1
      prefix: --include
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: File containing one ZMW ID per line to exclude (use instead of the exclude string)
    inputBinding:
      position: 1
      prefix: --exclude
  - id: downsample
    type:
      - 'null'
      - float
    doc: Fraction of random ZMWs to include in the output BAM file. Not supported on FASTX files.
    inputBinding:
      position: 1
      prefix: --downsample
  - id: downsample_count
    type:
      - 'null'
      - int
    doc: Number of random ZMWs to include in the output BAM file. Not supported on FASTX files.
    inputBinding:
      position: 1
      prefix: --downsample-count
  - id: downsample_seed
    type:
      - 'null'
      - int
    doc: Seed for the downsampling random-number generator. Set this value for reproducible output.
    inputBinding:
      position: 1
      prefix: --downsample-seed
  - id: show_all
    type:
      - 'null'
      - boolean
    doc: Print all unique ZMW hole numbers to stdout, one per line. No filtering is applied.
    inputBinding:
      position: 1
      prefix: --show-all
  - id: num_passes
    type:
      - 'null'
      - int
    doc: Include only ZMWs that have >= N subreads.
    inputBinding:
      position: 1
      prefix: --num-passes
  - id: names
    type:
      - 'null'
      - File
    doc: Include only these read names in the output file. A file containing one name per line. No other filtering is applied, and FASTX input is not supported.
    inputBinding:
      position: 1
      prefix: --names
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 1
      prefix: --num-threads
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    inputBinding:
      position: 1
      prefix: --log-level
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filtered BAM or FASTX file
    outputBinding:
      glob: |-
        ${ return inputs.output_path ? inputs.output_path : []; }
  - id: stdout
    type: stdout
    doc: Standard output (ZMW hole numbers with --show-all)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zmwfilter:1.0.0--h9ee0642_2
stdout: zmwfilter.out
