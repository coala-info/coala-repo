cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff2aplot
label: gff2aplot
doc: A tool for visualizing genomic features and alignments from GFF-formatted files.
inputs:
  - id: gff_files
    type:
      type: array
      items: File
    doc: Input GFF file(s) to be processed.
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to a custom configuration file.
    inputBinding:
      position: 102
      prefix: --config
  - id: page_layout
    type:
      - 'null'
      - string
    doc: Define the page layout (e.g., portrait, landscape).
    inputBinding:
      position: 102
      prefix: --layout
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run in quiet mode, suppressing non-error messages.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: show_report
    type:
      - 'null'
      - boolean
    doc: Generate a report of the features processed.
    inputBinding:
      position: 102
      prefix: --report
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output for debugging.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify the output file name (usually PostScript).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gff2aplot:v2.0-11-deb_cv1
