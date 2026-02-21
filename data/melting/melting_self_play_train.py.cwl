cwlVersion: v1.2
class: CommandLineTool
baseCommand: melting_self_play_train.py
label: melting_self_play_train.py
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to container image conversion and disk space issues.\n
  \nTool homepage: https://github.com/google-deepmind/meltingpot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/melting:v5.2.0-1-deb_cv1
stdout: melting_self_play_train.py.out
