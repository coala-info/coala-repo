cwlVersion: v1.2
class: CommandLineTool
baseCommand: minccalc
label: minc-tools_minccalc
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to initialize a container (no space
  left on device) while attempting to run the tool.\n\nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_minccalc.out
