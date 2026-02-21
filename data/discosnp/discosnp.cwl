cwlVersion: v1.2
class: CommandLineTool
baseCommand: discosnp
label: discosnp
doc: "DiscoSnp is a tool for discovering SNPs and indels from raw NGS reads. (Note:
  The provided text was a container runtime error message and did not contain help
  documentation; therefore, no arguments could be extracted.)\n\nTool homepage: https://gatb.inria.fr/software/discosnp/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/discosnp:2.6.2--h5ca1c30_6
stdout: discosnp.out
