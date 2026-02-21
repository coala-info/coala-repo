cwlVersion: v1.2
class: CommandLineTool
baseCommand: SigProfilerMatrixGenerator
label: sigprofilermatrixgenerator
doc: "SigProfilerMatrixGenerator (Note: The provided text contains container engine
  error logs and does not include the tool's help documentation or usage instructions.)\n
  \nTool homepage: https://github.com/AlexandrovLab/SigProfilerMatrixGenerator.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sigprofilermatrixgenerator:1.3.3--pyhdfd78af_1
stdout: sigprofilermatrixgenerator.out
