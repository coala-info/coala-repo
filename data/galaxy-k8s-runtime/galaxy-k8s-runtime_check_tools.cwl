cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-k8s-runtime_check_tools
label: galaxy-k8s-runtime_check_tools
doc: "A tool for checking tools within a Galaxy Kubernetes runtime environment. (Note:
  The provided text contains runtime log information and error messages rather than
  standard help documentation; no arguments were identified in the text.)\n\nTool
  homepage: https://github.com/phnmnl/container-galaxy-k8s-runtime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/galaxy-k8s-runtime:phenomenal-v17.09-pheno-lr_cv1.6.175
stdout: galaxy-k8s-runtime_check_tools.out
