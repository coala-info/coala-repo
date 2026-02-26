cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar JRONN_JAR_NAME
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
    default: 0.5
    inputBinding:
      position: 101
      prefix: -d
  - id: input_file
    type: File
    doc: Input file can contain one or more FASTA formatted sequences.
    inputBinding:
      position: 101
      prefix: -i
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format, V for vertical, where the letters of the sequence and 
      corresponding disorder values are output in two column layout. H for 
      horizontal, where the disorder values are provided under the letters of 
      the sequence. Letters and values separated by tabulation in this case.
    default: V
    inputBinding:
      position: 101
      prefix: -f
  - id: statistics_file
    type:
      - 'null'
      - File
    doc: the file name to write execution statistics to.
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of threads to use. Defaults to the number of cores available
      on the computer. n=1 mean sequential processing. Valid values are 1 < n < 
      (2 x num_of_cores)
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: full path to the output file, if not specified standard out is used
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jronn:7.1.0--hdfd78af_1
