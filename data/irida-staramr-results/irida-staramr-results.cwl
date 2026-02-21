cwlVersion: v1.2
class: CommandLineTool
baseCommand: irida-staramr-results
label: irida-staramr-results
doc: "The provided text does not contain help information or usage instructions; it
  consists of system log messages and a fatal error regarding a container build failure
  (no space left on device). No arguments could be extracted.\n\nTool homepage: https://github.com/phac-nml/irida-staramr-results"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irida-staramr-results:0.3.1--pyh5e36f6f_0
stdout: irida-staramr-results.out
