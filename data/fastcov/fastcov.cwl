cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastcov
label: fastcov
doc: "Plot the coverage based on some bam files.\n\nTool homepage: https://github.com/RaverJay/fastcov"
inputs:
  - id: bamfile
    type:
      type: array
      items: File
    doc: Alignment files to include in the coverage plot.
    inputBinding:
      position: 1
  - id: csv_no_header
    type:
      - 'null'
      - boolean
    doc: Suppress column names in csv output.
    inputBinding:
      position: 102
      prefix: --csv_no_header
  - id: logscale
    type:
      - 'null'
      - boolean
    doc: Use logarithmic scale on y-axis.
    inputBinding:
      position: 102
      prefix: --logscale
  - id: position
    type:
      - 'null'
      - string
    doc: "Specify a genomic position to plot exclusively. Format: <ref_name>[:<start>-<stop>]
      Coordinates are 1-based and inclusive. Start and/or stop are optional with fallbacks
      1 and <length_of_ref> respectively (i.e. 'chr1', 'chr1:-200', 'chr1:100-' and
      'chr1:100-200 are legal)"
    inputBinding:
      position: 102
      prefix: --position
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Specify plot output filename. File extension defines the format (default:
      fastcov_output.pdf)'
    outputBinding:
      glob: $(inputs.output_file)
  - id: csv_out
    type:
      - 'null'
      - File
    doc: Specify csv data output filename. Use '-' to write to stdout. Will 
      disable plot output by default, specify --output_file to re-enable plot 
      output.
    outputBinding:
      glob: $(inputs.csv_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastcov:0.1.3--hdfd78af_0
