cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmetashot_kMetaShot_test.py
label: kmetashot_kMetaShot_test.py
doc: "The provided text contains system logs and error messages related to a container
  environment failure (no space left on device) rather than help documentation for
  the tool. No arguments or usage information could be extracted.\n\nTool homepage:
  https://github.com/gdefazio/kMetaShot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmetashot:2.0--pyh7e72e81_1
stdout: kmetashot_kMetaShot_test.py.out
