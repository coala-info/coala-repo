cwlVersion: v1.2
class: CommandLineTool
baseCommand: hopla_hopla.R
label: hopla_hopla.R
doc: "Haplotype-based detection of chromosomal aberrations (Note: The provided text
  is an error log and does not contain help information or argument definitions).\n
  \nTool homepage: https://github.com/leraman/Hopla"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hopla:1.2.1--hdfd78af_1
stdout: hopla_hopla.R.out
