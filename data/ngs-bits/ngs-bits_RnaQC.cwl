cwlVersion: v1.2
class: CommandLineTool
baseCommand: RnaQC
label: ngs-bits_RnaQC
doc: "Calculates QC metrics for RNA samples.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: bam
    type: File
    doc: "Input BAM/CRAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 1
      prefix: -bam
  - id: expression
    type:
      - 'null'
      - File
    doc: "TSV file containing RNA expression."
    inputBinding:
      position: 2
      prefix: -expression
  - id: housekeeping_genes
    type:
      - 'null'
      - File
    doc: "BED file containing the exon region of housekeeping genes."
    inputBinding:
      position: 3
      prefix: -housekeeping_genes
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Set minimal mapping quality (default:1)"
    inputBinding:
      position: 4
      prefix: -min_mapq
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output qcML file. If unset, writes to STDOUT."
    inputBinding:
      position: 5
      prefix: -out
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 6
      prefix: -ref
  - id: roi
    type:
      - 'null'
      - File
    doc: "BED file containing the target region of the analysis."
    inputBinding:
      position: 7
      prefix: -roi
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 8
      prefix: --settings
  - id: splicing
    type:
      - 'null'
      - File
    doc: "TSV file containing spliced reads by gene."
    inputBinding:
      position: 9
      prefix: -splicing
  - id: txt
    type:
      - 'null'
      - boolean
    doc: "Writes TXT format instead of qcML."
    inputBinding:
      position: 10
      prefix: -txt
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output qcML file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
