cwlVersion: v1.2
class: CommandLineTool
baseCommand: scikit-bio
label: scikit-bio
doc: "The provided text contains system error messages related to a container environment
  (Singularity/Docker) and does not contain CLI help text or usage information for
  scikit-bio.\n\nTool homepage: https://github.com/scikit-bio/scikit-bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scikit-bio:0.4.2--np112py27_0
stdout: scikit-bio.out
