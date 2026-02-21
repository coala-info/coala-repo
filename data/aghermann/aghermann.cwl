cwlVersion: v1.2
class: CommandLineTool
baseCommand: aghermann
label: aghermann
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or argument definitions for the tool 'aghermann'.\n
  \nTool homepage: https://github.com/BackupTheBerlios/aghermann"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/aghermann:v1.1.2-2-deb_cv1
stdout: aghermann.out
