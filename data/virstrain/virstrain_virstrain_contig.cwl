cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virstrain
  - contig
label: virstrain_virstrain_contig
doc: "Viral strain identification from contig data. (Note: The provided text contains
  container runtime logs and error messages rather than the tool's help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/liaoherui/VirStrain"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virstrain:1.17--pyhdfd78af_1
stdout: virstrain_virstrain_contig.out
