cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-k8s-runtime_container-simple-checks.sh
label: galaxy-k8s-runtime_container-simple-checks.sh
doc: "A script to perform simple container checks within a Galaxy Kubernetes runtime
  environment. Note: The provided text appears to be a runtime error log rather than
  a help message, so no specific arguments could be extracted.\n\nTool homepage: https://github.com/phnmnl/container-galaxy-k8s-runtime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/galaxy-k8s-runtime:phenomenal-v17.09-pheno-lr_cv1.6.175
stdout: galaxy-k8s-runtime_container-simple-checks.sh.out
