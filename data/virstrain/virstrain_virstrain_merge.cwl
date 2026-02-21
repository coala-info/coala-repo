cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virstrain
  - merge
label: virstrain_virstrain_merge
doc: "Merge results from VirStrain (Note: The provided help text contains only container
  runtime logs and error messages, no argument definitions were found).\n\nTool homepage:
  https://github.com/liaoherui/VirStrain"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virstrain:1.17--pyhdfd78af_1
stdout: virstrain_virstrain_merge.out
