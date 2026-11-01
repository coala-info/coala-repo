cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- FifoBuffer
label: gatk_FifoBuffer
doc: |-
  Acts as a large memory buffer between processes that are connected with unix pipes for the case that one or more processes produces or consumes their input or output in bursts. By inserting a large memory buffer between such processes each process can run at full speed and the bursts can be smoothed out by the memory buffer. Example java -jar SamToFastq.jar \ F=my.fastq \ INTERLEAVE=true | java -jar FifoBuffer | bwa mem -t 8 \dev\stdin output.bam

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: buffer_size
  type:
  - 'null'
  - int
  doc: 'The size of the memory buffer in bytes. Default value: 536870912.'
  inputBinding:
    prefix: --BUFFER_SIZE
- id: create_index
  type:
  - 'null'
  - boolean
  doc: 'Whether to create an index when writing VCF or coordinate sorted BAM output.
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --CREATE_INDEX
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: debug_frequency
  type:
  - 'null'
  - int
  doc: 'How frequently, in seconds, to report debugging statistics. Set to zero for
    never. Default value: 0.'
  inputBinding:
    prefix: --DEBUG_FREQUENCY
- id: io_size
  type:
  - 'null'
  - int
  doc: 'The size, in bytes, to read/write atomically to the input and output streams.
    Default value: 65536.'
  inputBinding:
    prefix: --IO_SIZE
- id: name
  type:
  - 'null'
  - string
  doc: Name to use for Fifo in debugging statements.
  inputBinding:
    prefix: --NAME
- id: reference_sequence
  type:
  - 'null'
  - File
  doc: Reference sequence file.
  inputBinding:
    prefix: --REFERENCE_SEQUENCE
- id: input_stream
  type: File
  doc: File streamed into the standard input of the tool (the buffer copies it to
    standard output)
outputs:
- id: output_stream
  type: stdout
  doc: Data that passed through the buffer
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
stdin: $(inputs.input_stream.path)
stdout: fifo_buffer_out.dat
