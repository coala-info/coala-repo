cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - proteinprophet
label: philosopher_proteinprophet
doc: "Runs ProteinProphet on Philosopher results.\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: iprophet
    type:
      - 'null'
      - boolean
    doc: input is from iProphet
    inputBinding:
      position: 101
      prefix: --iprophet
  - id: maxppmdiff
    type:
      - 'null'
      - int
    doc: maximum peptide mass difference in ppm
    inputBinding:
      position: 101
      prefix: --maxppmdiff
  - id: minprob
    type:
      - 'null'
      - float
    doc: probability threshold
    inputBinding:
      position: 101
      prefix: --minprob
  - id: nonsp
    type:
      - 'null'
      - boolean
    doc: do not use NSP model
    inputBinding:
      position: 101
      prefix: --nonsp
  - id: output
    type:
      - 'null'
      - string
    doc: Output name
    inputBinding:
      position: 101
      prefix: --output
  - id: subgroups
    type:
      - 'null'
      - boolean
    doc: do not use NOGROUPS
    inputBinding:
      position: 101
      prefix: --subgroups
  - id: unmapped
    type:
      - 'null'
      - boolean
    doc: report results for UNMAPPED proteins
    inputBinding:
      position: 101
      prefix: --unmapped
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_proteinprophet.out
