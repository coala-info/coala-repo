cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslMrnaCover
label: ucsc-pslmrnacover
doc: "Calculate mRNA coverage from PSLs. Note: The provided input text contained a
  system error (no space left on device) rather than the help text; the following
  arguments are based on the standard UCSC pslMrnaCover utility.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_in
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
  - id: ignore_size
    type:
      - 'null'
      - boolean
    doc: Ignore mRNA size in PSL
    inputBinding:
      position: 102
      prefix: -ignoreSize
  - id: min_cover
    type:
      - 'null'
      - float
    doc: Minimum coverage to keep (0.0 to 1.0)
    inputBinding:
      position: 102
      prefix: -minCover
outputs:
  - id: out_psl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslmrnacover:482--h0b57e2e_0
