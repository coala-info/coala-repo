cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clinvar-this
  - data
  - xml-to-jsonl
label: clinvar-this_data_xml_to_jsonl
doc: "Convert XML to JSONL\n\nTool homepage: https://github.com/bihealth/clinvar-this"
inputs:
  - id: input_file
    type: File
    doc: ClinVar XML file (plain or .gz)
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Output JSONL file (gzipped when the name ends in .gz)
    inputBinding:
      position: 2
  - id: fasta_ref_hg19
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: Normalize hg19 coordinates with FASTA
    inputBinding:
      position: 101
      prefix: --fasta-ref-hg19
  - id: fasta_ref_hg38
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: Normalize hg38 coordinates with FASTA
    inputBinding:
      position: 101
      prefix: --fasta-ref-hg38
  - id: max_records
    type:
      - 'null'
      - int
    doc: Maximum number of records to convert
    inputBinding:
      position: 101
      prefix: --max-records
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: Whether to show progress bar.
    inputBinding:
      position: 101
      prefix: --show-progress
  - id: no_show_progress
    type:
      - 'null'
      - boolean
    doc: Do not show a progress bar.
    inputBinding:
      position: 101
      prefix: --no-show-progress
outputs:
  - id: output
    type: File
    doc: Output JSONL file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
