cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isorefiner
  - run_rnabloom
label: isorefiner_run_rnabloom
doc: "IsoRefiner tool (Note: The provided text is a system error log regarding container
  execution and does not contain CLI help information or argument definitions).\n\n
  Tool homepage: https://github.com/rkajitani/IsoRefiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
stdout: isorefiner_run_rnabloom.out
