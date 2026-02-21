cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_simple_stats.py
label: biocode_fastq_simple_stats.py
doc: "Provides simple quantitative statistics for a given FASTQ file\n\nTool homepage:
  http://github.com/jorvis/biocode"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Path to one or more input files, separated by spaces
    inputBinding:
      position: 1
  - id: individual
    type:
      - 'null'
      - boolean
    doc: Report stats on each file individually
    inputBinding:
      position: 102
      prefix: --individual
  - id: progress_interval
    type:
      - 'null'
      - int
    doc: Pass an integer to show progress ever N entries on STDERR
    inputBinding:
      position: 102
      prefix: --progress_interval
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Optional path to an output file to be created, else prints on STDOUT
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocode:0.12.1--pyhdfd78af_0
