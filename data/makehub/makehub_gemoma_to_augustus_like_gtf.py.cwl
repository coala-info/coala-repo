cwlVersion: v1.2
class: CommandLineTool
baseCommand: makehub_gemoma_to_augustus_like_gtf.py
label: makehub_gemoma_to_augustus_like_gtf.py
doc: "A script to convert GeMoMa output to an Augustus-like GTF format. Note: The
  provided help text contains only system error messages and no usage information.\n
  \nTool homepage: https://github.com/Gaius-Augustus/MakeHub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/makehub:1.0.8--hdfd78af_1
stdout: makehub_gemoma_to_augustus_like_gtf.py.out
