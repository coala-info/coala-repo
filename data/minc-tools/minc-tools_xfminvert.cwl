cwlVersion: v1.2
class: CommandLineTool
baseCommand: xfminvert
label: minc-tools_xfminvert
doc: "Invert a MINC transformation file. (Note: The provided help text contained only
  system error messages regarding container execution and did not list specific arguments.)\n
  \nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_xfminvert.out
