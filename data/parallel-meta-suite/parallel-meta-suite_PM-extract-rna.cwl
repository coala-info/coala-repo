cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PM-extract-rna
label: parallel-meta-suite_PM-extract-rna
doc: "Extract rRNA fragments from shotgun sequences\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs:
  - id: domain
    type:
      - 'null'
      - string
    doc: "Domain, B (Bacteria, 16S rRNA) or E (Eukaryote, 18S rRNA), default is B"
    inputBinding:
      position: 1
      prefix: "-D"
  - id: input_sequence_m
    type:
      - 'null'
      - File
    doc: "Input single sequence file (Shotgun)"
    inputBinding:
      position: 1
      prefix: "-m"
  - id: input_sequence
    type:
      - 'null'
      - File
    doc: "Input single sequence file (Shotgun), same as -m"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output Path, default is \"Extract_RNA\""
    default: Extract_RNA
    inputBinding:
      position: 1
      prefix: "-o"
  - id: rrna_length_threshold
    type:
      - 'null'
      - int
    doc: "rRNA length threshold of rRNA extraction. default is 0"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads, default is auto"
    inputBinding:
      position: 1
      prefix: "-t"
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: "Extracted rRNA fragments"
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
stdout: parallel-meta-suite_PM-extract-rna.out
