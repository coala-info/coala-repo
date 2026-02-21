cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_toolkit
label: fastx_toolkit
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the image due to insufficient disk space.
  It does not contain CLI help text or argument definitions.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx_toolkit.out
