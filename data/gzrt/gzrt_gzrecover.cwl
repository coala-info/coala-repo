cwlVersion: v1.2
class: CommandLineTool
baseCommand: gzrecover
label: gzrt_gzrecover
doc: "The gzip recovery toolkit (gzrt) is designed to recover data from corrupted
  gzip files. The gzrecover tool attempts to extract the uncompressed data from a
  damaged .gz file.\n\nTool homepage: https://www.urbanophile.com/arenn/hacking/gzrt"
inputs:
  - id: input_file
    type: File
    doc: The corrupted gzip file to recover data from. By default the recovered
      data is written to <name>.recovered (the .gz extension is removed).
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Sets the output file name. Cannot be used together with write_stdout.
    inputBinding:
      position: 1
      prefix: -o
  - id: write_stdout
    type:
      - 'null'
      - boolean
    doc: Write output to standard output for pipeline support.
    inputBinding:
      position: 2
      prefix: -p
  - id: split_segments
    type:
      - 'null'
      - boolean
    doc: Splits each recovered segment into its own file, with numeric suffixes
      (.1, .2, etc) (untested).
    inputBinding:
      position: 2
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose logging on.
    inputBinding:
      position: 2
      prefix: -v
outputs:
  - id: recovered_files
    type:
      type: array
      items: File
    doc: Recovered data files (name.recovered, name.recovered.N or the -o name).
    outputBinding:
      glob:
        - '*.recovered*'
        - $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output (recovered data when write_stdout is set).
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gzrt:0.9.1--h577a1d6_0
stdout: gzrt_gzrecover.out
