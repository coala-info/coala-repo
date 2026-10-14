cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - peptideprophet
label: philosopher_peptideprophet
doc: "Peptide assignment validation\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: accmass
    type:
      - 'null'
      - boolean
    doc: "use accurate mass model binning"
    inputBinding:
      position: 100
      prefix: --accmass
  - id: clevel
    type:
      - 'null'
      - int
    doc: "set Conservative Level in neg_stdev from the neg_mean, low numbers are less conservative, high numbers are more conservative"
    inputBinding:
      position: 100
      prefix: --clevel
  - id: combine
    type:
      - 'null'
      - boolean
    doc: "combine the results from PeptideProphet into a single result file"
    inputBinding:
      position: 100
      prefix: --combine
  - id: database
    type:
      - 'null'
      - File
    doc: "path to the database"
    inputBinding:
      position: 100
      prefix: --database
  - id: decoy
    type:
      - 'null'
      - string
    doc: "semi-supervised mode, protein name prefix to identify decoy entries (default \"rev_\")"
    inputBinding:
      position: 100
      prefix: --decoy
  - id: decoyprobs
    type:
      - 'null'
      - boolean
    doc: "compute possible non-zero probabilities for decoy entries on the last iteration"
    inputBinding:
      position: 100
      prefix: --decoyprobs
  - id: enzyme
    type:
      - 'null'
      - string
    doc: "enzyme used in sample"
    inputBinding:
      position: 100
      prefix: --enzyme
  - id: expectscore
    type:
      - 'null'
      - boolean
    doc: "use expectation value as the only contributor to the f-value for modeling"
    inputBinding:
      position: 100
      prefix: --expectscore
  - id: glyc
    type:
      - 'null'
      - boolean
    doc: "enable peptide glyco motif model"
    inputBinding:
      position: 100
      prefix: --glyc
  - id: ignorechg
    type:
      - 'null'
      - string
    doc: "use comma to separate the charge states to exclude from modeling"
    inputBinding:
      position: 100
      prefix: --ignorechg
  - id: masswidth
    type:
      - 'null'
      - float
    doc: "model mass width (default 5)"
    inputBinding:
      position: 100
      prefix: --masswidth
  - id: minpeplen
    type:
      - 'null'
      - int
    doc: "minimum peptide length not rejected (default 7)"
    inputBinding:
      position: 100
      prefix: --minpeplen
  - id: minprob
    type:
      - 'null'
      - float
    doc: "report results with minimum probability (default 0.05)"
    inputBinding:
      position: 100
      prefix: --minprob
  - id: nomass
    type:
      - 'null'
      - boolean
    doc: "disable mass model"
    inputBinding:
      position: 100
      prefix: --nomass
  - id: nonmc
    type:
      - 'null'
      - boolean
    doc: "disable NMC missed cleavage model"
    inputBinding:
      position: 100
      prefix: --nonmc
  - id: nonparam
    type:
      - 'null'
      - boolean
    doc: "use semi-parametric modeling, must be used in conjunction with --decoy option"
    inputBinding:
      position: 100
      prefix: --nonparam
  - id: nontt
    type:
      - 'null'
      - boolean
    doc: "disable NTT enzymatic termini model"
    inputBinding:
      position: 100
      prefix: --nontt
  - id: output
    type:
      - 'null'
      - string
    doc: "output name prefix (default \"interact\")"
    inputBinding:
      position: 100
      prefix: --output
  - id: phospho
    type:
      - 'null'
      - boolean
    doc: "enable peptide phospho motif model"
    inputBinding:
      position: 100
      prefix: --phospho
  - id: ppm
    type:
      - 'null'
      - boolean
    doc: "use ppm mass error instead of Daltons for mass modeling"
    inputBinding:
      position: 100
      prefix: --ppm
  - id: pepxml
    type:
      type: array
      items: File
    doc: "pepXML files from the database search"
    inputBinding:
      position: 200
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (the .meta folder written by an earlier step); it is staged writable as .meta in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: interact_pepxml
    type:
      - 'null'
      - type: array
        items: File
    doc: "PeptideProphet results (interact*.pep.xml)"
    outputBinding:
      glob: '*.pep.xml'
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
stdout: philosopher_peptideprophet.out
