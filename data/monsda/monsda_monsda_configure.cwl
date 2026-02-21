cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - monsda
  - configure
label: monsda_monsda_configure
doc: "Configure the monsda tool environment. (Note: The provided text contained only
  system error logs and no help documentation; no arguments could be extracted.)\n
  \nTool homepage: https://github.com/jfallmann/MONSDA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monsda:1.2.8--pyhdfd78af_0
stdout: monsda_monsda_configure.out
