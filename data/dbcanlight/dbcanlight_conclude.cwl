cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dbcanlight
  - conclude
label: dbcanlight_conclude
doc: "Conclude the results made by each module. The predictions made by each module
  must be in the same folder with their original file names. The output \"overview.tsv\"
  is written to the same folder.\n\nTool homepage: https://github.com/chtsai0105/dbcanLight/tree/main"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.output)
        writable: true
inputs:
  - id: output
    type: Directory
    doc: Folder that contains dbcanlight search results (cazymes.tsv, 
      substrates.tsv, diamond.tsv)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode for debug
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: overview
    type: File
    doc: Overview table of all search results
    outputBinding:
      glob: $(inputs.output.basename)/overview.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcanlight:1.1.1--pyhdfd78af_0
