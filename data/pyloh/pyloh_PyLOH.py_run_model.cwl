cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PyLOH.py
  - run_model
label: pyloh_PyLOH.py_run_model
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
  - id: preprocessed_files
    type:
      type: array
      items: File
    doc: Preprocessed files created by the preprocess step (counts, segments and
      BAF heat map), staged in the working directory next to the base name.
outputs:
  - id: purity
    type: File
    doc: Estimated tumor purity and model summary
    outputBinding:
      glob: $(inputs.filename_base).PyLOH.purity
  - id: segments_extended
    type: File
    doc: Segments with the inferred copy numbers and genotypes
    outputBinding:
      glob: $(inputs.filename_base).PyLOH.segments.extended
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.preprocessed_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyloh:1.4.3--py27_0
stdout: pyloh_PyLOH.py_run_model.out