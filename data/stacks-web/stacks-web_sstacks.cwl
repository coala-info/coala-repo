cwlVersion: v1.2
class: CommandLineTool
baseCommand: sstacks
label: stacks-web_sstacks
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool.\n\nTool
  homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stacks-web:v2.2dfsg-1-deb_cv1
stdout: stacks-web_sstacks.out
