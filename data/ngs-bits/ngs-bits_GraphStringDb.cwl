cwlVersion: v1.2
class: CommandLineTool
baseCommand: GraphStringDb
label: ngs-bits_GraphStringDb
doc: "Creates simple representation of String-DB interaction graph.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: string
    type:
      - File
    doc: "String-DB file with protein interactions (https://stringdb-static.org/download/protein.links.v11.5/9606.protein.links.v11.5.txt.gz)."
    inputBinding:
      position: 1
      prefix: -string
  - id: alias
    type:
      - File
    doc: "Input TSV file with aliases for String protein IDs (https://stringdb-static.org/download/protein.aliases.v11.5/9606.protein.aliases.v11.5.txt.gz)."
    inputBinding:
      position: 2
      prefix: -alias
  - id: output_file_path
    type:
      - string
    doc: "Output TSV file with edges."
    inputBinding:
      position: 3
      prefix: -out
  - id: min_score
    type:
      - 'null'
      - float
    doc: "Minimum confidence score cutoff for String-DB interaction (0-1). Default value: 0.4"
    inputBinding:
      position: 4
      prefix: -min_score
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 100
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "TSV file with graph edges."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
