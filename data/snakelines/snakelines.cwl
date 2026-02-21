cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakelines
label: snakelines
doc: "A Snakemake-based pipeline tool (Note: The provided text is an error log and
  does not contain usage information or argument definitions).\n\nTool homepage: https://snakelines.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakelines:1.1.8--hdfd78af_0
stdout: snakelines.out
