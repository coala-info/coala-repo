cwlVersion: v1.2
class: CommandLineTool
baseCommand: unifire_run_unifire_docker.sh
label: unifire_run_unifire_docker.sh
doc: "A script to run the UniFire (Universal Functional Annotation Pipeline) tool
  using a Docker or Singularity container.\n\nTool homepage: https://github.com/cmatKhan/unifire/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifire:1.0.1--hdfd78af_0
stdout: unifire_run_unifire_docker.sh.out
