cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tksm
  - model-truncation
label: tksm_model-truncation
doc: "KDE computation module of truncation of transcriptomic long-reads using their cDNA mapping\n\nTool homepage: https://github.com/vpc-ccg/tksm"
inputs:
  - id: input
    type: File
    doc: "PAF file of the mapping of the long-reads to the reference transcriptome."
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "Path prefix for the output JSON model (e.g. sample.json)."
    inputBinding:
      position: 1
      prefix: --output
  - id: bandwidth
    type:
      - 'null'
      - float
    doc: "Bandwidth value for the KDE. If set to -1, script will use cross validation to compute it. (default: 100.0)"
    inputBinding:
      position: 1
      prefix: --bandwidth
  - id: grid_start
    type:
      - 'null'
      - int
    doc: "Read/transcript length start of the KDE grid. (default: 0)"
    inputBinding:
      position: 1
      prefix: --grid-start
  - id: grid_end
    type:
      - 'null'
      - int
    doc: "Read/transcript length end of the KDE grid. (default: 10000)"
    inputBinding:
      position: 1
      prefix: --grid-end
  - id: grid_step
    type:
      - 'null'
      - int
    doc: "Read/transcript length step of the KDE grid. (default: 100)"
    inputBinding:
      position: 1
      prefix: --grid-step
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to run KDE and GridSearchCV. (default: 1)"
    inputBinding:
      position: 1
      prefix: --threads
  - id: model_lengths
    type:
      - 'null'
      - boolean
    doc: "Model read lengths instead of truncation lengths (default: False)"
    inputBinding:
      position: 1
      prefix: --model-lengths
  - id: end_ratio
    type:
      - 'null'
      - float
    doc: "Ratio of truncation from the end of the molecule. If set to -1, TKSM will build a distribution of the end ratios from the PAF file. If set between 0 and 1, TKSM will use this value as the end ratio for all molecules. (default: -1)"
    inputBinding:
      position: 1
      prefix: --end-ratio
outputs:
  - id: model
    type: File
    doc: "Truncation KDE model (JSON)"
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
stdout: tksm_model-truncation.out
