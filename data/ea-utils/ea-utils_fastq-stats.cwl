cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-stats
label: ea-utils_fastq-stats
doc: "Produces lots of easily digested statistics for the files listed\n\nTool homepage:
  https://expressionanalysis.github.io/ea-utils/"
inputs:
  - id: fastq_file
    type: File
    doc: Input fastq file
    inputBinding:
      position: 1
  - id: cyclemax
    type:
      - 'null'
      - int
    doc: max cycles for which following quality stats are produced
    default: 35
    inputBinding:
      position: 102
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: prints out debug statements
    inputBinding:
      position: 102
      prefix: -d
  - id: no_duplicate_read_statistics
    type:
      - 'null'
      - boolean
    doc: don't do duplicate read statistics
    inputBinding:
      position: 102
      prefix: -D
  - id: num_top_duplicate_reads
    type:
      - 'null'
      - int
    doc: number of top duplicate reads to display
    inputBinding:
      position: 102
      prefix: -s
  - id: window
    type:
      - 'null'
      - int
    doc: max window size for generating duplicate read statistics
    default: 2000000
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: output_fastx_file
    type:
      - 'null'
      - File
    doc: output fastx statistics (requires an output filename)
    outputBinding:
      glob: $(inputs.output_fastx_file)
  - id: output_base_breakdown_file
    type:
      - 'null'
      - File
    doc: output base breakdown by per phred quality at every cycle. It sets 
      cylemax to longest read length
    outputBinding:
      glob: $(inputs.output_base_breakdown_file)
  - id: output_length_counts_file
    type:
      - 'null'
      - File
    doc: Output length counts
    outputBinding:
      glob: $(inputs.output_length_counts_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
