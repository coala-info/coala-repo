cwlVersion: v1.2
class: CommandLineTool
baseCommand: process_yeast_bam
label: callingcardstools_process_yeast_bam
doc: "Processes yeast BAM files.\n\nTool homepage: https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: bampath
    type: File
    doc: path to the input bam file
    inputBinding:
      position: 101
      prefix: --bampath
  - id: barcode_details
    type: File
    doc: Path to the barcode details json file
    inputBinding:
      position: 101
      prefix: --barcode_details
  - id: genome
    type: File
    doc: Path to a genome .fasta file. Note that an index .fai file must exist 
      in the same path
    inputBinding:
      position: 101
      prefix: --genome
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 101
      prefix: --log_level
  - id: mapq_threshold
    type:
      - 'null'
      - int
    doc: Mapping quality threshold
    inputBinding:
      position: 101
      prefix: --mapq_threshold
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: path to the output directory
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: verbose_qc
    type:
      - 'null'
      - boolean
    doc: save complete alignment summary
    inputBinding:
      position: 101
      prefix: --verbose_qc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
stdout: callingcardstools_process_yeast_bam.out
