cwlVersion: v1.2
class: CommandLineTool
baseCommand: updio
label: updio
doc: "A tool for UniProt ID mapping and data retrieval, allowing users to convert
  identifiers and download associated data columns from UniProt.\n\nTool homepage:
  https://github.com/rhpvorderman/updio"
inputs:
  - id: ids
    type:
      type: array
      items: string
    doc: UniProt IDs or identifiers to map/retrieve.
    inputBinding:
      position: 1
  - id: columns
    type:
      - 'null'
      - string
    doc: Comma-separated list of UniProt data columns to retrieve (e.g., 'id,entry
      name,reviewed').
    inputBinding:
      position: 102
      prefix: --columns
  - id: from_db
    type:
      - 'null'
      - string
    doc: The database type of the input identifiers (e.g., ACC+ID, P_ENTREZGENEID).
    inputBinding:
      position: 102
      prefix: --from
  - id: to_db
    type:
      - 'null'
      - string
    doc: The target database type for mapping (e.g., ACC, P_ENTREZGENEID).
    inputBinding:
      position: 102
      prefix: --to
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file where results will be saved.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/updio:1.1.0--hdfd78af_0
