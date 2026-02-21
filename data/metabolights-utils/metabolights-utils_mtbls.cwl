cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metabolights-utils
  - mtbls
label: metabolights-utils_mtbls
doc: "MetaboLights utility tool. (Note: The provided text contains container runtime
  error messages and does not include help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/EBI-Metabolights/metabolights-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
stdout: metabolights-utils_mtbls.out
