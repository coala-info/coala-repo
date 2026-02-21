cwlVersion: v1.2
class: CommandLineTool
baseCommand: irida-sistr-results
label: irida-sistr-results
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding container image conversion
  and disk space. No arguments could be extracted.\n\nTool homepage: http://github.com/phac-nml/irida-sistr-results"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irida-sistr-results:0.6.0--py36_0
stdout: irida-sistr-results.out
