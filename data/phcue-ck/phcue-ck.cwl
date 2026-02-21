cwlVersion: v1.2
class: CommandLineTool
baseCommand: phcue-ck
label: phcue-ck
doc: "Phage Contig Usage Estimator (Note: The provided text is a container build log
  and does not contain help information or argument definitions).\n\nTool homepage:
  https://lgi-onehealth.github.io/phcue-ck/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phcue-ck:0.2.0--h1f4ba0c_0
stdout: phcue-ck.out
