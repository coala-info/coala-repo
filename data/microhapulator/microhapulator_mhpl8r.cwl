cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhpl8r
label: microhapulator_mhpl8r
doc: "A tool for microhaplotype analysis. (Note: The provided text contains system
  error messages regarding container execution and does not include functional help
  text or argument definitions).\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
stdout: microhapulator_mhpl8r.out
