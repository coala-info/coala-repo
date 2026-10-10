cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mumemto, merge]
label: mumemto_merge
doc: "Merge MUMs files.\n\nTool homepage: https://github.com/vikshiv/mumemto"
inputs:
  - id: mum_files
    type:
      type: array
      items: File
    doc: MUMs files to merge (staged in the working directory next to their .lengths files)
    inputBinding:
      position: 1
      valueFrom: "$(self.map(function(f) { return f.basename; }))"
  - id: merged_mums
    type:
      - 'null'
      - File
    doc: Path to the MUMs-of-MUMs file (only for string merging)
    inputBinding:
      position: 100
      prefix: --merged_mums
  - id: output
    type: string
    doc: Path to the output merged MUMs file
    inputBinding:
      position: 100
      prefix: --output
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output
    inputBinding:
      position: 100
      prefix: --verbose
  - id: sibling_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files that belong to the MUMs files and must sit next to them, such as the .lengths files"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: merged
    type:
      type: array
      items: File
    doc: Merged MUMs file and its lengths file
    outputBinding:
      glob: "$(inputs.output.replace(/\\.(mums|bumbl)$/, ''))*"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.mum_files.concat(inputs.sibling_files || []))
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
stdout: mumemto_merge.out
