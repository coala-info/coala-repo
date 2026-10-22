cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SigProfilerMatrixGenerator
  - sv_matrix_generator
label: sigprofilermatrixgenerator_sv_matrix_generator
doc: "Generate a structural variant (SV) matrix from input data.\n\nTool homepage:
  https://github.com/AlexandrovLab/SigProfilerMatrixGenerator"
inputs:
  - id: input_dir
    type: Directory
    doc: The directory containing the input files.
    inputBinding:
      position: 1
  - id: project
    type: string
    doc: The name of the project.
    inputBinding:
      position: 2
  - id: output_dir
    type: string
    doc: The directory where the output matrix will be stored.
    inputBinding:
      position: 3
outputs:
  - id: output_directory
    type: Directory
    doc: Directory with the SV matrix
    outputBinding:
      glob: $(inputs.output_dir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sigprofilermatrixgenerator:1.3.3--pyhdfd78af_1
stdout: sigprofilermatrixgenerator_sv_matrix_generator.out
