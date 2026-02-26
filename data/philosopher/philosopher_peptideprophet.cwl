cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - peptideprophet
label: philosopher_peptideprophet
doc: "peptideprophet\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: accmass
    type:
      - 'null'
      - boolean
    doc: use accurate mass model binning
    inputBinding:
      position: 101
      prefix: --accmass
  - id: clevel
    type:
      - 'null'
      - int
    doc: set Conservative Level in neg_stdev from the neg_mean, low numbers are 
      less conservative, high numbers are more conservative
    inputBinding:
      position: 101
      prefix: --clevel
  - id: combine
    type:
      - 'null'
      - boolean
    doc: combine the results from PeptideProphet into a single result file
    inputBinding:
      position: 101
      prefix: --combine
  - id: database
    type:
      - 'null'
      - string
    doc: path to the database
    inputBinding:
      position: 101
      prefix: --database
  - id: decoy
    type:
      - 'null'
      - string
    doc: semi-supervised mode, protein name prefix to identify decoy entries 
      (default "rev_")
    default: rev_
    inputBinding:
      position: 101
      prefix: --decoy
  - id: decoyprobs
    type:
      - 'null'
      - boolean
    doc: compute possible non-zero probabilities for decoy entries on the last 
      iteration
    inputBinding:
      position: 101
      prefix: --decoyprobs
  - id: enzyme
    type:
      - 'null'
      - string
    doc: enzyme used in sample
    inputBinding:
      position: 101
      prefix: --enzyme
  - id: expectscore
    type:
      - 'null'
      - boolean
    doc: use expectation value as the only contributor to the f-value for 
      modeling
    inputBinding:
      position: 101
      prefix: --expectscore
  - id: glyc
    type:
      - 'null'
      - boolean
    doc: enable peptide glyco motif model
    inputBinding:
      position: 101
      prefix: --glyc
  - id: ignorechg
    type:
      - 'null'
      - string
    doc: use comma to separate the charge states to exclude from modeling
    inputBinding:
      position: 101
      prefix: --ignorechg
  - id: masswidth
    type:
      - 'null'
      - float
    doc: model mass width (default 5)
    default: 5.0
    inputBinding:
      position: 101
      prefix: --masswidth
  - id: minpeplen
    type:
      - 'null'
      - int
    doc: minimum peptide length not rejected (default 7)
    default: 7
    inputBinding:
      position: 101
      prefix: --minpeplen
  - id: minprob
    type:
      - 'null'
      - float
    doc: report results with minimum probability (default 0.05)
    default: 0.05
    inputBinding:
      position: 101
      prefix: --minprob
  - id: nomass
    type:
      - 'null'
      - boolean
    doc: disable mass model
    inputBinding:
      position: 101
      prefix: --nomass
  - id: nonmc
    type:
      - 'null'
      - boolean
    doc: disable NMC missed cleavage model
    inputBinding:
      position: 101
      prefix: --nonmc
  - id: nonparam
    type:
      - 'null'
      - boolean
    doc: use semi-parametric modeling, must be used in conjunction with --decoy 
      option
    inputBinding:
      position: 101
      prefix: --nonparam
  - id: nontt
    type:
      - 'null'
      - boolean
    doc: disable NTT enzymatic termini model
    inputBinding:
      position: 101
      prefix: --nontt
  - id: output
    type:
      - 'null'
      - string
    doc: output name prefix (default "interact")
    default: interact
    inputBinding:
      position: 101
      prefix: --output
  - id: phospho
    type:
      - 'null'
      - boolean
    doc: enable peptide phospho motif model
    inputBinding:
      position: 101
      prefix: --phospho
  - id: ppm
    type:
      - 'null'
      - boolean
    doc: use ppm mass error instead of Daltons for mass modeling
    inputBinding:
      position: 101
      prefix: --ppm
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_peptideprophet.out
