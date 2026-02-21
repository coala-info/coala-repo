cwlVersion: v1.2
class: CommandLineTool
baseCommand: melting_play_clean_up.py
label: melting_play_clean_up.py
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image building (no space
  left on device).\n\nTool homepage: https://github.com/google-deepmind/meltingpot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/melting:v5.2.0-1-deb_cv1
stdout: melting_play_clean_up.py.out
