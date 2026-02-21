cwlVersion: v1.2
class: CommandLineTool
baseCommand: ltrsift
label: ltrsift_ltrsift_static
doc: "LTRsift is a tool for the identification and annotation of LTR retrotransposons.
  (Note: The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: https://github.com/satta/ltrsift"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ltrsift:v1.0.2-8-deb_cv1
stdout: ltrsift_ltrsift_static.out
