cwlVersion: v1.2
class: CommandLineTool
baseCommand: sigprofilermatrixgenerator
label: sigprofilermatrixgenerator_SigProfilerMatrixGenerator
doc: "SigProfilerMatrixGenerator\n\nTool homepage: https://github.com/AlexandrovLab/SigProfilerMatrixGenerator.git"
inputs:
  - id: command
    type: string
    doc: 'Command to execute: install, matrix_generator, sv_matrix_generator, or cnv_matrix_generator'
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/sigprofilermatrixgenerator:1.3.3--pyhdfd78af_1
stdout: sigprofilermatrixgenerator_SigProfilerMatrixGenerator.out
