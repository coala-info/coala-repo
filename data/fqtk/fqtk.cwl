cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtk
label: fqtk
doc: "A toolkit for FASTQ file manipulation. (Note: The provided text contains system
  error messages regarding container execution and does not include the tool's help
  documentation or argument definitions.)\n\nTool homepage: https://github.com/fulcrumgenomics/fqtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtk:0.3.1--ha6fb395_3
stdout: fqtk.out
