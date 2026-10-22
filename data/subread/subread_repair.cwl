cwlVersion: v1.2
class: CommandLineTool
baseCommand: repair
label: subread_repair
doc: "Find reads that are from the same pair and place them next to each other in the output; a dummy read is added for each singleton read. The output is compatible with featureCounts.\n\nTool homepage: http://subread.sourceforge.net/"
inputs:
  - id: input_file
    type: File
    doc: Name of input file. BAM format by default.
    inputBinding:
      position: 1
      prefix: -i
  - id: output_file
    type: string
    doc: Name of output file (BAM format).
    inputBinding:
      position: 1
      prefix: -o
  - id: sam_input
    type:
      - 'null'
      - boolean
    doc: The input file is in SAM format.
    inputBinding:
      position: 1
      prefix: -S
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the output BAM file.
    inputBinding:
      position: 1
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads. 8 by default.
    inputBinding:
      position: 1
      prefix: -T
  - id: no_dummy_reads
    type:
      - 'null'
      - boolean
    doc: Do not add dummy reads for singleton reads.
    inputBinding:
      position: 1
      prefix: -d
  - id: no_sequences
    type:
      - 'null'
      - boolean
    doc: Do not include sequences and quality scores of reads in the output file.
    inputBinding:
      position: 1
      prefix: -t
outputs:
  - id: repaired
    type: File
    doc: Repaired BAM
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
