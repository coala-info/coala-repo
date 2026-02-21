cwlVersion: v1.2
class: CommandLineTool
baseCommand: pywfa
label: pywfa
doc: "Python wrapper for the Wavefront Alignment (WFA) algorithm. (Note: The provided
  text appears to be a container engine error log rather than CLI help text; no arguments
  could be extracted from the input.)\n\nTool homepage: https://github.com/kcleal/pywfa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pywfa:0.5.1--py39hbcbf7aa_4
stdout: pywfa.out
