cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - bioquant
label: philosopher_bioquant
doc: "Protein report based on protein functional groups\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: id
    type:
      - 'null'
      - string
    doc: "UniProt proteome ID"
    inputBinding:
      position: 100
      prefix: --id
  - id: level
    type:
      - 'null'
      - float
    doc: "cluster identity level"
    inputBinding:
      position: 100
      prefix: --level
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (the .meta folder written by an earlier step); it is staged writable as .meta in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: workspace_out
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (.meta folder) after this step; pass it to the next step"
    outputBinding:
      glob: .meta
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .meta
        entry: $(inputs.workspace)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
    dockerOutputDirectory: /work
stdout: philosopher_bioquant.out
