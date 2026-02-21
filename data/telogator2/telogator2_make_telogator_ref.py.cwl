cwlVersion: v1.2
class: CommandLineTool
baseCommand: telogator2_make_telogator_ref.py
label: telogator2_make_telogator_ref.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a container engine error log. No arguments could be extracted.\n\nTool homepage:
  https://github.com/zstephens/telogator2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telogator2:2.2.3--pyhdfd78af_0
stdout: telogator2_make_telogator_ref.py.out
