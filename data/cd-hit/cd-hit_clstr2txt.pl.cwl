cwlVersion: v1.2
class: CommandLineTool
baseCommand: cd-hit_clstr2txt.pl
label: cd-hit_clstr2txt.pl
doc: "The provided text does not contain help information for the tool, but rather
  a system error log indicating a failure to build a container image due to lack of
  disk space. No arguments could be extracted from the provided text.\n\nTool homepage:
  https://github.com/weizhongli/cdhit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
stdout: cd-hit_clstr2txt.pl.out
