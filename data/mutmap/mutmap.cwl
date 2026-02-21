cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutmap
label: mutmap
doc: "MutMap is a method for identifying genes responsible for mutant phenotypes.
  (Note: The provided text is a system error message regarding container execution
  and does not contain usage instructions or argument definitions.)\n\nTool homepage:
  https://github.com/YuSugihara/MutMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutmap:2.3.9--pyhdfd78af_0
stdout: mutmap.out
