cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanopolish index
label: nanopolish_index
doc: "Build an index mapping from basecalled reads to the signals measured by the
  sequencer\n\nTool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: reads_fastq
    type: File
    doc: fastq file containing basecalled reads
    inputBinding:
      position: 1
  - id: raw_ont_signal_directory
    type:
      - 'null'
      - type: array
        items: Directory
    doc: path to the directory containing the raw ONT signal files. This option 
      can be given multiple times.
    inputBinding:
      position: 102
      prefix: --directory
  - id: sequencing_summary
    type:
      - 'null'
      - File
    doc: the sequencing summary file from albacore, providing this option will 
      make indexing much faster
    inputBinding:
      position: 102
      prefix: --sequencing-summary
  - id: slow5_file
    type:
      - 'null'
      - File
    doc: slow5 file
    inputBinding:
      position: 102
      prefix: --slow5
  - id: summary_fofn
    type:
      - 'null'
      - File
    doc: file containing the paths to the sequencing summary files (one per 
      line)
    inputBinding:
      position: 102
      prefix: --summary-fofn
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
stdout: nanopolish_index.out
