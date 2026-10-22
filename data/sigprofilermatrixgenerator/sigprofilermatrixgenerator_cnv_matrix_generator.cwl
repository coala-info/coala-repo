cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SigProfilerMatrixGenerator
  - cnv_matrix_generator
label: sigprofilermatrixgenerator_cnv_matrix_generator
doc: "Generate a Copy Number Variation (CNV) matrix.\n\nTool homepage: https://github.com/AlexandrovLab/SigProfilerMatrixGenerator"
inputs:
  - id: file_type
    type: string
    doc: "The type of the input file based on the CNV calling tool used: ASCAT,
      ASCAT_NGS, SEQUENZA, ABSOLUTE, BATTENBERG, FACETS, PURPLE or TCGA."
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: The multi-sample segmentation file.
    inputBinding:
      position: 2
  - id: project
    type: string
    doc: The name of the project.
    inputBinding:
      position: 3
  - id: output_path
    type: string
    doc: The path where the output CNV matrix will be stored.
    inputBinding:
      position: 4
outputs:
  - id: output_directory
    type: Directory
    doc: Directory with the CNV matrix
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sigprofilermatrixgenerator:1.3.3--pyhdfd78af_1
stdout: sigprofilermatrixgenerator_cnv_matrix_generator.out
