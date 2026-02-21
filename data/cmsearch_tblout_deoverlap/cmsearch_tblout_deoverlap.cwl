cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmsearch_tblout_deoverlap
label: cmsearch_tblout_deoverlap
doc: "A tool to remove overlapping hits from Infernal cmsearch tabular output (tblout)
  files.\n\nTool homepage: https://github.com/nawrockie/cmsearch_tblout_deoverlap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmsearch_tblout_deoverlap:0.09--pl5321hdfd78af_0
stdout: cmsearch_tblout_deoverlap.out
