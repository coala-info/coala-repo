cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snakesv
  - snakejob
label: snakesv_snakejob
doc: "A tool for structural variant calling (Note: The provided text appears to be
  a container build log rather than CLI help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/RajLabMSSM/snakeSV/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakesv:0.8--py311hdfd78af_1
stdout: snakesv_snakejob.out
