cwlVersion: v1.2
class: CommandLineTool
baseCommand: clips
label: clips
doc: "The provided text is a container build error log (Apptainer/Singularity) and
  does not contain the help documentation or usage instructions for the 'clips' tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/openai/CLIP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clips:v1.0.7.348clips-4-deb-py2_cv1
stdout: clips.out
