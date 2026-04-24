cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyloh_PyLOH.py
  - run_model
label: pyloh_PyLOH.py run_model
doc: "Run the PyLOH model training.\n\nTool homepage: https://github.com/uci-cbcl/PyLOH"
inputs:
  - id: filename_base
    type: string
    doc: Base name of preprocessed files created.
    inputBinding:
      position: 1
  - id: allelenumber_max
    type:
      - 'null'
      - int
    doc: Maximum copy number of each allele allows to take.
    inputBinding:
      position: 102
      prefix: --allelenumber_max
  - id: max_iters
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for training.
    inputBinding:
      position: 102
      prefix: --max_iters
  - id: priors
    type:
      - 'null'
      - File
    doc: File of the prior distribution. If not provided, use uniform prior.
    inputBinding:
      position: 102
      prefix: --priors
  - id: stop_value
    type:
      - 'null'
      - float
    doc: Stop value of the EM algorithm for training. If the change of 
      log-likelihood is lower than this value, stop training.
    inputBinding:
      position: 102
      prefix: --stop_value
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyloh:1.4.3--py27_0
stdout: pyloh_PyLOH.py run_model.out
