cwlVersion: v1.2
class: CommandLineTool
baseCommand: NanoFilt
label: nanofilt
doc: "Perform quality and length filtering and trimming of long read sequencing data.\n\
  \nTool homepage: https://github.com/wdecoster/nanofilt"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input, uncompressed fastq file
    inputBinding:
      position: 200
  - id: logfile
    type:
      - 'null'
      - string
    doc: Specify the path and filename for the log file.
    inputBinding:
      position: 101
      prefix: --logfile
  - id: maxlength
    type:
      - 'null'
      - int
    doc: Filter on a maximum read length
    inputBinding:
      position: 101
      prefix: --maxlength
  - id: min_gc
    type:
      - 'null'
      - float
    doc: Sequences must have GC content >= to this. Float between 0.0 and 1.0.
      Ignored if using summary file.
    inputBinding:
      position: 101
      prefix: --minGC
  - id: max_gc
    type:
      - 'null'
      - float
    doc: Sequences must have GC content <= to this. Float between 0.0 and 1.0.
      Ignored if using summary file.
    inputBinding:
      position: 101
      prefix: --maxGC
  - id: headcrop
    type:
      - 'null'
      - int
    doc: Trim n nucleotides from the start of a read.
    inputBinding:
      position: 101
      prefix: --headcrop
  - id: length
    type:
      - 'null'
      - int
    doc: Filter on a minimum read length.
    inputBinding:
      position: 101
      prefix: --length
  - id: quality
    type:
      - 'null'
      - int
    doc: Filter on a minimum average read quality.
    inputBinding:
      position: 101
      prefix: --quality
  - id: readtype
    type:
      - 'null'
      - string
    doc: Which read type to extract information about from summary. Options are 
      1D, 2D, 1D2
    inputBinding:
      position: 101
      prefix: --readtype
  - id: summary
    type:
      - 'null'
      - File
    doc: Use a summary file from albacore or guppy for filtering.
    inputBinding:
      position: 101
      prefix: --summary
  - id: tailcrop
    type:
      - 'null'
      - int
    doc: Trim n nucleotides from the end of a read.
    inputBinding:
      position: 101
      prefix: --tailcrop
outputs:
  - id: stdout
    type: stdout
    doc: Filtered fastq on standard output
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.logfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanofilt:2.8.0--py_0
stdout: nanofilt.out
