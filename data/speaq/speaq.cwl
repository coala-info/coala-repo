cwlVersion: v1.2
class: CommandLineTool
baseCommand: speaq
label: speaq
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the 'speaq' tool.\n
  \nTool homepage: https://github.com/mlvlab/SpeaQ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/speaq:phenomenal-v2.3.1_cv1.0.1.13
stdout: speaq.out
