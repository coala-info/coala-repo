cwlVersion: v1.2
class: CommandLineTool
baseCommand: plast-example
label: plast-example
doc: "The provided text is an error log from a container build process and does not
  contain help information or usage instructions for the tool 'plast-example'.\n\n
  Tool homepage: https://github.com/NotRealEngineering/WARP3D-Mises-plasticity-with-isotropic-hardening-Example-1"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plast-example:v2.3.1dfsg-4-deb_cv1
stdout: plast-example.out
