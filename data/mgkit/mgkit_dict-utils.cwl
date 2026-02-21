cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mgkit
  - dict-utils
label: mgkit_dict-utils
doc: "The provided text does not contain help information for mgkit_dict-utils; it
  contains a fatal error message from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space.\n\nTool homepage:
  https://github.com/frubino/mgkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
stdout: mgkit_dict-utils.out
