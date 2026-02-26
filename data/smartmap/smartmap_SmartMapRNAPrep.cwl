cwlVersion: v1.2
class: CommandLineTool
baseCommand: SmartMapPrep
label: smartmap_SmartMapRNAPrep
doc: "SmartMapRNAPrep [options] -x [Bowtie2 index] -o [output prefix] -1 [R1 fastq]
  -2 [R2 fastq]\n\nTool homepage: http://shah-rohan.github.io/SmartMap"
inputs:
  - id: bowtie2_index
    type: string
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
  - id: output_prefix
    type: string
    doc: Output prefix prepended to the output files
    inputBinding:
      position: 101
      prefix: -o
  - id: r1_fastq
    type: File
    doc: Fastq file for read mate 1 (can be gzipped)
    inputBinding:
      position: 101
      prefix: '-1'
  - id: r2_fastq
    type: File
    doc: Fastq file for read mate 2 (can be gzipped)
    inputBinding:
      position: 101
      prefix: '-2'
  - id: remove_from_read_names
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
stdout: smartmap_SmartMapRNAPrep.out
