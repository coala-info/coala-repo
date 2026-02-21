cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion-bin_cmake
label: relion-bin_cmake
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build or execution attempt.\n
  \nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin:v1.4dfsg-4-deb_cv1
stdout: relion-bin_cmake.out
