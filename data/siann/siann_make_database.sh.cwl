cwlVersion: v1.2
class: CommandLineTool
baseCommand: siann_make_database.sh
label: siann_make_database.sh
doc: "The provided text does not contain help information or usage instructions for
  siann_make_database.sh. It contains system log messages related to a container build
  failure.\n\nTool homepage: https://github.com/signaturescience/siann/wiki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/siann:1.3--hdfd78af_0
stdout: siann_make_database.sh.out
