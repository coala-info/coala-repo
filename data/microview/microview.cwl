cwlVersion: v1.2
class: CommandLineTool
baseCommand: microview
label: microview
doc: "MicroView, a reporting tool for taxonomic classification\nMicroView agreggates
  reports from taxonomic classification tools, such as\nKaiju and Kraken.\n\nTool
  homepage: https://github.com/jvfe/microview"
inputs:
  - id: csv_file
    type:
      - 'null'
      - File
    doc: 2-column CSV table (sample,group) with taxonomy classification results 
      paths
    inputBinding:
      position: 101
      prefix: --csv-file
  - id: taxonomy_results
    type:
      - 'null'
      - Directory
    doc: Path to taxonomy classification results
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: sample_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Classification result files named in the CSV table; they are staged in the working directory so the relative paths in the table resolve.
  - id: output_file_path
    type: string
    doc: PATH  Report file name                                      │
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Report file name
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.sample_files ? inputs.sample_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microview:0.11.0--py312h031d066_0
