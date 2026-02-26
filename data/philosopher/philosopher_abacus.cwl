cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - abacus
label: philosopher_abacus
doc: "Generates abacus reports.\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: full
    type:
      - 'null'
      - boolean
    doc: generates combined tables with extra information
    inputBinding:
      position: 101
      prefix: --full
  - id: labels
    type:
      - 'null'
      - boolean
    doc: indicates whether the data sets includes TMT labels or not
    inputBinding:
      position: 101
      prefix: --labels
  - id: pep_prob
    type:
      - 'null'
      - float
    doc: minimum peptide probability
    default: 0.5
    inputBinding:
      position: 101
      prefix: --pepProb
  - id: peptide
    type:
      - 'null'
      - boolean
    doc: global level peptide report
    inputBinding:
      position: 101
      prefix: --peptide
  - id: picked
    type:
      - 'null'
      - boolean
    doc: apply the picked FDR algorithm before the protein scoring
    inputBinding:
      position: 101
      prefix: --picked
  - id: plex
    type:
      - 'null'
      - string
    doc: number of channels
    default: '10'
    inputBinding:
      position: 101
      prefix: --plex
  - id: protein
    type:
      - 'null'
      - boolean
    doc: global level protein report
    inputBinding:
      position: 101
      prefix: --protein
  - id: prt_prob
    type:
      - 'null'
      - float
    doc: minimum protein probability
    default: 0.9
    inputBinding:
      position: 101
      prefix: --prtProb
  - id: razor
    type:
      - 'null'
      - boolean
    doc: use razor peptides for protein FDR scoring
    inputBinding:
      position: 101
      prefix: --razor
  - id: reprint
    type:
      - 'null'
      - boolean
    doc: create abacus reports using the Reprint format
    inputBinding:
      position: 101
      prefix: --reprint
  - id: tag
    type:
      - 'null'
      - string
    doc: decoy tag
    default: rev_
    inputBinding:
      position: 101
      prefix: --tag
  - id: uniqueonly
    type:
      - 'null'
      - boolean
    doc: report TMT quantification based on only unique peptides
    inputBinding:
      position: 101
      prefix: --uniqueonly
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_abacus.out
