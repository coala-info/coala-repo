cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virstrain
  - build
label: virstrain_virstrain_build
doc: "The provided text does not contain help information for the tool; it appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/liaoherui/VirStrain"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virstrain:1.17--pyhdfd78af_1
stdout: virstrain_virstrain_build.out
