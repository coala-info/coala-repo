cwlVersion: v1.2
class: CommandLineTool
baseCommand: SmartMapPrep
label: smartmap_SmartMapPrep
doc: "SmartMapPrep prepares input files for SmartMap.\n\nTool homepage: http://shah-rohan.github.io/SmartMap"
inputs:
  - id: bowtie2_index
    type: File
    doc: Path to basename of Bowtie2 index for alignment
    inputBinding:
      position: 101
      prefix: -x
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: Maximum number of alignments reported
    default: 51
    inputBinding:
      position: 101
      prefix: -k
  - id: max_insert_length
    type:
      - 'null'
      - int
    doc: Maximum insert length
    default: 250
    inputBinding:
      position: 101
      prefix: -L
  - id: min_insert_length
    type:
      - 'null'
      - int
    doc: Minimum insert length
    default: 100
    inputBinding:
      position: 101
      prefix: -I
  - id: output_prefix
    type: string
    doc: Output prefix prepended to the output files
    inputBinding:
      position: 101
      prefix: -o
  - id: read1_fastq
    type: File
    doc: Fastq file for read mate 1 (can be gzipped)
    inputBinding:
      position: 101
      prefix: '-1'
  - id: read2_fastq
    type: File
    doc: Fastq file for read mate 2 (can be gzipped)
    inputBinding:
      position: 101
      prefix: '-2'
  - id: read_name_suffix_to_remove
    type:
      - 'null'
      - string
    doc: String to be removed from read names
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to be used for multithreaded alignment
    default: 1
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartmap:1.0.0--h077b44d_4
stdout: smartmap_SmartMapPrep.out
