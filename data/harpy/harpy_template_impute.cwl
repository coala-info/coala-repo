cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - template
  - impute
label: harpy_template_impute
doc: "Create a template STITCH imputation parameter file for harpy impute; the template is written to standard output.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs: []
outputs:
  - id: template_file
    type: File
    doc: The template written to standard output
    outputBinding:
      glob: impute_params.tsv
stdout: impute_params.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
