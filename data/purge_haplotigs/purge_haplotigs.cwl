cwlVersion: v1.2
class: CommandLineTool
baseCommand: purge_haplotigs
label: purge_haplotigs
doc: "The provided text does not contain help information or a description of the
  tool; it contains container build logs and a fatal error message.\n\nTool homepage:
  https://bitbucket.org/mroachawri/purge_haplotigs/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/purge-dups-runner:2019.12.20--pyhdfd78af_0
stdout: purge_haplotigs.out
