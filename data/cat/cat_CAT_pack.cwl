cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CAT
  - pack
label: cat_CAT_pack
doc: "The provided text does not contain help information or argument definitions
  for cat_CAT_pack; it is an error log from a container runtime (Apptainer/Singularity)
  indicating a 'no space left on device' failure during an image build.\n\nTool homepage:
  https://github.com/dutilh/CAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: ubuntu:latest
stdout: cat_CAT_pack.out
