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
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microview:0.11.0--py312h031d066_0
