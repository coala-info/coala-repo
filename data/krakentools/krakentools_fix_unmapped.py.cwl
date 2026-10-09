cwlVersion: v1.2
class: CommandLineTool
baseCommand: fix_unmapped.py
label: krakentools_fix_unmapped.py
doc: "Map accession IDs to taxonomy IDs using NCBI accession2taxid files.\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs:
  - id: input_file
    type: File
    doc: "Input file containing accession IDs to map; only the first column is mapped"
    inputBinding:
      position: 1
      prefix: -i
  - id: accession2taxid
    type:
      type: array
      items: File
    doc: "Accession2taxid reference mappings to search (NCBI format: accession in column 1, taxid in column 3)"
    inputBinding:
      position: 1
      prefix: --accession2taxid
  - id: output_file_path
    type: string
    doc: "Output file with 2 tab-delimited columns for accessions and taxids"
    inputBinding:
      position: 102
      prefix: -o
  - id: remaining_file_path
    type:
      - 'null'
      - string
    doc: "Name of text file containing non-found accessions from input file"
    inputBinding:
      position: 103
      prefix: -r
outputs:
  - id: output_file
    type: File
    doc: "Accession to taxid table"
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: remaining_file
    type:
      - 'null'
      - File
    doc: "Accessions that were not found"
    outputBinding:
      glob: $(inputs.remaining_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
