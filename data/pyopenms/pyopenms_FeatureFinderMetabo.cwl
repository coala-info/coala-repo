cwlVersion: v1.2
class: CommandLineTool
baseCommand: FeatureFinderMetabo
label: pyopenms_FeatureFinderMetabo
doc: "The provided text contains container engine logs and a fatal error message rather
  than the help documentation for the tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/OpenMS/OpenMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyopenms:3.4.1--py310h7ad0250_2
stdout: pyopenms_FeatureFinderMetabo.out
