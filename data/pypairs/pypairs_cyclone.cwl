cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyclone
label: pypairs_cyclone
doc: "Cyclone is a tool for inferring cell cycle phase from single-cell RNA sequencing
  data.\n\nTool homepage: https://github.com/rfechtner/pypairs"
inputs:
  - id: input_file
    type: File
    doc: Input file containing single-cell RNA sequencing data (e.g., AnnData, 
      Loom, or CSV format).
    inputBinding:
      position: 1
  - id: genes
    type:
      - 'null'
      - File
    doc: File containing a list of genes to use for cell cycle inference (e.g., 
      a text file with one gene per line).
    inputBinding:
      position: 102
      prefix: --genes
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: Number of parallel jobs to run.
    inputBinding:
      position: 102
      prefix: --n-jobs
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to save the inferred cell cycle phases (e.g., AnnData, 
      Loom, or CSV format).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypairs:3.2.3--py_0
