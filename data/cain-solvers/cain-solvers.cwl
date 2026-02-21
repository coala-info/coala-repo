cwlVersion: v1.2
class: CommandLineTool
baseCommand: cain-solvers
label: cain-solvers
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help text, usage instructions, or argument definitions for
  the tool 'cain-solvers'.\n\nTool homepage: https://github.com/brachbach/cains-jawbone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cain-solvers:v1.10dfsg-3-deb_cv1
stdout: cain-solvers.out
