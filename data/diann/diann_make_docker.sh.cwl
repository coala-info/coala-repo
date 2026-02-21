cwlVersion: v1.2
class: CommandLineTool
baseCommand: diann_make_docker.sh
label: diann_make_docker.sh
doc: "A script to create or manage Docker/Singularity containers for DIA-NN. Note:
  The provided text appears to be an error log rather than a help menu, so no specific
  arguments could be extracted.\n\nTool homepage: https://github.com/vdemichev/DiaNN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/diann:v1.8.1_cv1
stdout: diann_make_docker.sh.out
