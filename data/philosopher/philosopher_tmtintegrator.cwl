cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - tmtintegrator
label: philosopher_tmtintegrator
doc: "Integrates TMT quantification results from Philosopher.\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: memory
    type:
      - 'null'
      - int
    doc: ""
    inputBinding:
      position: 100
      prefix: --memory
  - id: param
    type:
      - 'null'
      - File
    doc: ""
    inputBinding:
      position: 100
      prefix: --param
  - id: path
    type:
      - 'null'
      - string
    doc: ""
    inputBinding:
      position: 100
      prefix: --path
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (the .meta folder written by an earlier step); it is staged writable as .meta in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: integrated_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: "TMT-Integrator result tables"
    outputBinding:
      glob:
        - '*.tsv'
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
stdout: philosopher_tmtintegrator.out
