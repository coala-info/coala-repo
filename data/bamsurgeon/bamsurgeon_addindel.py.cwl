cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamsurgeon_addindel.py
label: bamsurgeon_addindel.py
doc: "The provided text does not contain help information for bamsurgeon_addindel.py;
  it contains system error messages regarding a failed container build (no space left
  on device).\n\nTool homepage: https://github.com/adamewing/bamsurgeon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamsurgeon:1.4.1--pyhdfd78af_0
stdout: bamsurgeon_addindel.py.out
