cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiparagraph.py
label: paragraph_multiparagraph.py
doc: 'Run paragraph on a BAM file for a set of events given as JSON files (breakpoints of deletions, insertions, swaps) and merge the results.\n\nTool homepage: https://github.com/Illumina/paragraph'
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: 'Input event JSON file(s)'
    inputBinding:
      position: 1
  - id: bam
    type: File
    doc: 'BAM file name'
    secondaryFiles:
      - .bai
    inputBinding:
      position: 101
      prefix: --bam
  - id: output_path
    type: string
    doc: 'Output file name'
    inputBinding:
      position: 101
      prefix: --output
  - id: reference
    type: File
    doc: 'Reference FASTA'
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: --reference-sequence
  - id: extended_output
    type:
      - 'null'
      - boolean
    doc: 'Run paragraph with -E 1'
    inputBinding:
      position: 101
      prefix: --extended-output
  - id: max_events
    type:
      - 'null'
      - int
    doc: 'Only do the first n events.'
    inputBinding:
      position: 101
      prefix: --max-events
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Minimum event length.'
    inputBinding:
      position: 101
      prefix: --min-length
  - id: event_threads
    type:
      - 'null'
      - int
    doc: 'Number of events to process in parallel.'
    inputBinding:
      position: 101
      prefix: --event-threads
  - id: paragraph_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads for parallel read processing.'
    inputBinding:
      position: 101
      prefix: --paragraph-threads
  - id: keep_scratch
    type:
      - 'null'
      - boolean
    doc: 'Do not delete temp files.'
    inputBinding:
      position: 101
      prefix: --keep-scratch
  - id: scratch_dir
    type:
      - 'null'
      - string
    doc: 'Directory for temp files'
    inputBinding:
      position: 101
      prefix: --scratch-dir
  - id: paragraph
    type:
      - 'null'
      - string
    doc: 'Path to the paragraph executable'
    inputBinding:
      position: 101
      prefix: --paragraph
  - id: logfile_path
    type:
      - 'null'
      - string
    doc: 'Write logging information into file rather than to stderr'
    inputBinding:
      position: 101
      prefix: --logfile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Raise logging level from warning to info.'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Set logging level to output errors only.'
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output
    type: File
    doc: 'Output file name'
    outputBinding:
      glob: $(inputs.output_path)
  - id: logfile
    type:
      - 'null'
      - File
    doc: 'Log file'
    outputBinding:
      glob: $(inputs.logfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paragraph:2.3--h8908b6f_0
