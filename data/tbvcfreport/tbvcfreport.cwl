cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbvcfreport
label: tbvcfreport
doc: "A tool for generating reports from TB (Tuberculosis) VCF files. (Note: The provided
  text is a container execution error log and does not contain help documentation
  or argument definitions.)\n\nTool homepage: http://github.com/COMBAT-TB/tbvcfreport"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbvcfreport:1.0.1--pyhdfd78af_0
stdout: tbvcfreport.out
