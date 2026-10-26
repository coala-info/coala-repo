cwlVersion: v1.2
class: CommandLineTool
baseCommand: umi_mark_duplicates
label: umitools_mark_duplicates
doc: "A pair of FASTQ files are first reformatted using reformat_umi_fastq.py and
  then is aligned to get the bam file. This script can parse the umi barcode in the
  name of each read to mark duplicates. This script is also known as umitools mark.\n\
  \nTool homepage: https://github.com/weng-lab/umitools"
inputs:
  - id: count
    type:
      - 'null'
      - boolean
    doc: Count the number of raw reads for each locus (determined by pairs)
    inputBinding:
      position: 101
      prefix: --count
  - id: debug
    type:
      - 'null'
      - boolean
    doc: turn on debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_bam_file
    type: File
    doc: the input bam file
    inputBinding:
      position: 101
      prefix: --file
  - id: processes
    type:
      - 'null'
      - int
    doc: number of processes
    inputBinding:
      position: 101
      prefix: --processes
outputs:
  - id: marked_bam
    type: File
    doc: BAM file with duplicates marked (written beside the input as <input
      without .bam>.deumi.sorted.bam)
    secondaryFiles:
      - .bai
    outputBinding:
      glob: '*.deumi.sorted.bam'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_bam_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umitools:0.3.4--py36_0
