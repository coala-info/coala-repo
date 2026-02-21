cwlVersion: v1.2
class: CommandLineTool
baseCommand: melting_play_substrate.py
label: melting_play_substrate.py
doc: "A tool for melting temperature calculations (Note: The provided help text appears
  to be an error log regarding container execution and does not contain usage information).\n
  \nTool homepage: https://github.com/google-deepmind/meltingpot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/melting:v5.2.0-1-deb_cv1
stdout: melting_play_substrate.py.out
