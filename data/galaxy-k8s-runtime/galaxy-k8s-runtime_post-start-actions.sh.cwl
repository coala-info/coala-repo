cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-k8s-runtime_post-start-actions.sh
label: galaxy-k8s-runtime_post-start-actions.sh
doc: "A script intended for post-start actions within a Galaxy Kubernetes runtime
  environment. Note: The provided text appears to be an execution error log rather
  than standard help documentation.\n\nTool homepage: https://github.com/phnmnl/container-galaxy-k8s-runtime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/galaxy-k8s-runtime:phenomenal-v17.09-pheno-lr_cv1.6.175
stdout: galaxy-k8s-runtime_post-start-actions.sh.out
