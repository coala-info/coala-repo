cwlVersion: v1.2
class: CommandLineTool
baseCommand: mincaverage
label: minc-tools_mincaverage
doc: "The provided text does not contain help information as it is an error log reporting
  a system failure (no space left on device) during a container image build.\n\nTool
  homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_mincaverage.out
