cwlVersion: v1.2
class: CommandLineTool
baseCommand: jronn
label: jronn
doc: "JRONN is a Java implementation of RONN. JRONN is based on RONN and uses the
  same model data, therefore gives the same predictions. Main motivation behind JRONN
  development was providing an implementation of RONN more suitable to use by the
  automated analysis pipelines and web services.\n\nTool homepage: https://biojava.org/"
inputs:
  - id: disorder_value
    type:
      - 'null'
      - float
    doc: the value of disorder
    inputBinding:
      position: 101
      prefix: -d=
      separate: false
  - id: input_file
    type: File
    doc: Input file can contain one or more FASTA formatted sequences.
    inputBinding:
      position: 101
      prefix: -i=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format, V for vertical, where the letters of the sequence and 
      corresponding disorder values are output in two column layout. H for 
      horizontal, where the disorder values are provided under the letters of 
      the sequence. Letters and values separated by tabulation in this case.
    inputBinding:
      position: 101
      prefix: -f=
      separate: false
  - id: statistics_file
    type:
      - 'null'
      - string
    doc: the file name to write execution statistics to.
    inputBinding:
      position: 101
      prefix: -s=
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of threads to use. Defaults to the number of cores available
      on the computer. n=1 mean sequential processing. Valid values are 1 < n < 
      (2 x num_of_cores)
    inputBinding:
      position: 101
      prefix: -n=
      separate: false
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: full path to the output file, if not specified standard out is used
    inputBinding:
      position: 102
      prefix: -o=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Predictions written to standard output when no output file is given
  - id: output_file
    type:
      - 'null'
      - File
    doc: Predictions written to the output file
    outputBinding:
      glob: '$(inputs.output_file_path === null ? [] : inputs.output_file_path)'
  - id: statistics_output
    type:
      - 'null'
      - File
    doc: Execution statistics
    outputBinding:
      glob: '$(inputs.statistics_file === null ? [] : inputs.statistics_file)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jronn:7.1.0--hdfd78af_1
stdout: jronn.out
