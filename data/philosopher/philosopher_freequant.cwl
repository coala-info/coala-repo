cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - freequant
label: philosopher_freequant
doc: "Quantify peaks using free energy calculations.\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: dir
    type:
      - 'null'
      - Directory
    doc: folder path containing the raw files
    inputBinding:
      position: 101
      prefix: --dir
  - id: faims
    type:
      - 'null'
      - boolean
    doc: Use FAIMS information for the quantification
    inputBinding:
      position: 101
      prefix: --faims
  - id: ptw
    type:
      - 'null'
      - float
    doc: specify the time windows for the peak (minute)
    inputBinding:
      position: 101
      prefix: --ptw
  - id: raw
    type:
      - 'null'
      - boolean
    doc: read raw files instead of converted XML
    inputBinding:
      position: 101
      prefix: --raw
  - id: tol
    type:
      - 'null'
      - float
    doc: m/z tolerance in ppm
    inputBinding:
      position: 101
      prefix: --tol
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_freequant.out
