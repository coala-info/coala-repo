cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - freequant
label: philosopher_freequant
doc: "Label-free Quantification\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: dir
    type:
      - 'null'
      - Directory
    doc: "folder path containing the raw files"
    inputBinding:
      position: 100
      prefix: --dir
  - id: faims
    type:
      - 'null'
      - boolean
    doc: "Use FAIMS information for the quantification"
    inputBinding:
      position: 100
      prefix: --faims
  - id: ptw
    type:
      - 'null'
      - float
    doc: "specify the time windows for the peak (minute)"
    inputBinding:
      position: 100
      prefix: --ptw
  - id: raw
    type:
      - 'null'
      - boolean
    doc: "read raw files instead of converted XML"
    inputBinding:
      position: 100
      prefix: --raw
  - id: tol
    type:
      - 'null'
      - float
    doc: "m/z tolerance in ppm"
    inputBinding:
      position: 100
      prefix: --tol
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
stdout: philosopher_freequant.out
