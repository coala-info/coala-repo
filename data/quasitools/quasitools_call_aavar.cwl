cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quasitools
  - call
  - aavar
label: quasitools_call_aavar
doc: "Identify amino acid mutations from a BAM file.\n\nTool homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: bam_file
    type: File
    doc: "BAM alignment file"
    secondaryFiles:
      - pattern: ^.bai
        required: false
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
  - id: reference_file
    type: File
    doc: "Reference sequence in FASTA format"
    inputBinding:
      position: 2
  - id: bed4_file
    type: File
    doc: "BED file with at least 4 columns giving gene locations"
    inputBinding:
      position: 3
  - id: variants_file
    type:
      - 'null'
      - File
    doc: "Variants file in VCF format"
    inputBinding:
      position: 4
  - id: mutation_db_file
    type:
      - 'null'
      - File
    doc: "Mutation database file"
    inputBinding:
      position: 5
  - id: min_freq
    type:
      - 'null'
      - float
    doc: "The minimum required frequency."
    inputBinding:
      position: 100
      prefix: --min_freq
  - id: error_rate
    type:
      - 'null'
      - float
    doc: "Estimated sequencing error rate."
    inputBinding:
      position: 100
      prefix: --error_rate
  - id: output_filename_path
    type:
      - 'null'
      - string
    doc: "Output file."
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
