cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pod5
  - convert
  - fast5
label: pod5_convert_fast5
doc: "Convert fast5 file(s) into a pod5 file(s)\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Input path for fast5 file
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: Output path for the pod5 file(s). This can be an existing directory (creating
      'output.pod5' within it) or a new named file path. A directory must be given
      when using --one-to-one.
    inputBinding:
      position: 102
      prefix: --output
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search for input files recursively matching `*.pod5`
    inputBinding:
      position: 102
      prefix: --recursive
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Set the number of threads to use (default: 4)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Immediately quit if an exception is encountered during conversion instead
      of continuing with remaining inputs after issuing a warning
    inputBinding:
      position: 102
      prefix: --strict
  - id: one_to_one
    type:
      - 'null'
      - string
    doc: Output files are written 1:1 to inputs. 1:1 output files are written to the
      output directory in a new directory structure relative to the directory path provided
      to this argument. This directory path must be a relative parent of all inputs.
    inputBinding:
      position: 102
      prefix: --one-to-one
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite destination files
    inputBinding:
      position: 102
      prefix: --force-overwrite
  - id: signal_chunk_size
    type:
      - 'null'
      - int
    doc: 'Chunk size to use for signal data set (default: 102400)'
    inputBinding:
      position: 102
      prefix: --signal-chunk-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Converted pod5 file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
stdout: pod5_convert_fast5.out
