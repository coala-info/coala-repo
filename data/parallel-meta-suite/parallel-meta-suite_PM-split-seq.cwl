cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PM-split-seq
label: parallel-meta-suite_PM-split-seq
doc: "Split sequences by sample\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs:
  - id: input_sequence
    type: File
    doc: "Input sequence file in FASTA or FASTQ format [Required]"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: barcode_file
    type:
      - 'null'
      - File
    doc: "Input barcode file [Conflicts with -g and -q]"
    inputBinding:
      position: 1
      prefix: "-b"
  - id: group_file
    type:
      - 'null'
      - File
    doc: "Input group file [Conflicts with -b and -q]"
    inputBinding:
      position: 1
      prefix: "-g"
  - id: qiime_format
    type:
      - 'null'
      - string
    doc: "T or F, if the input in QIIME format [Conflicts with -g and -b]"
    inputBinding:
      position: 1
      prefix: "-q"
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Result output path, default is \"Out\""
    default: Out
    inputBinding:
      position: 1
      prefix: "-o"
outputs:
  - id: output_directory
    type: Directory
    doc: "One sequence file per sample and the analysis report"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Standard output (screen messages)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
stdout: parallel-meta-suite_PM-split-seq.out
