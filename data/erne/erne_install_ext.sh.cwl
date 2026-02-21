cwlVersion: v1.2
class: CommandLineTool
baseCommand: erne_install_ext.sh
label: erne_install_ext.sh
doc: "A script to install extensions or dependencies for the ERNE (Extended Randomized
  Numerical Estimator) tool suite, often involving the setup of containerized environments.\n
  \nTool homepage: https://github.com/chengyuanba/avatar_ernerf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/erne:2.1.1--boost1.61_0
stdout: erne_install_ext.sh.out
