cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-k8s-runtime
label: galaxy-k8s-runtime
doc: "Galaxy Kubernetes runtime tool (Note: The provided text appears to be an error
  log rather than help documentation, so no arguments could be extracted).\n\nTool
  homepage: https://github.com/phnmnl/container-galaxy-k8s-runtime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/galaxy-k8s-runtime:phenomenal-v17.09-pheno-lr_cv1.6.175
stdout: galaxy-k8s-runtime.out
