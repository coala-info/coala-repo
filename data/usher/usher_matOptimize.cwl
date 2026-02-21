cwlVersion: v1.2
class: CommandLineTool
baseCommand: matOptimize
label: usher_matOptimize
doc: "The provided text does not contain help information for the tool. It is a log
  of a failed container build/execution attempt.\n\nTool homepage: https://github.com/yatisht/usher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usher:0.6.6--h719ac0c_1
stdout: usher_matOptimize.out
