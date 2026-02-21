cwlVersion: v1.2
class: CommandLineTool
baseCommand: isorefiner_run_stringtie
label: isorefiner_run_stringtie
doc: "A tool for running StringTie within the IsoRefiner pipeline. (Note: The provided
  help text contains system error messages regarding container execution and does
  not list specific command-line arguments.)\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
stdout: isorefiner_run_stringtie.out
