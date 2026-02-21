cwlVersion: v1.2
class: CommandLineTool
baseCommand: slamdunk_multiqc
label: slamdunk_multiqc
doc: "The provided text does not contain help information as it is a log of a failed
  container execution. No arguments could be parsed.\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
stdout: slamdunk_multiqc.out
