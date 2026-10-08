cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - CGI
label: transit_cgi
doc: "CRISPRi chemical genetic analysis (CRISPRi-DR). Sub-commands: extract_counts, create_combined_counts, extract_abund, run_model, visualize; give the sub-command and its arguments in order.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: sub_command
    type: string
    doc: "Sub-command: extract_counts, create_combined_counts, extract_abund, run_model or visualize"
    inputBinding:
      position: 1
  - id: sub_command_args
    type: string[]?
    doc: "Arguments of the sub-command, in the order of its usage"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
stdout: transit_cgi.out
