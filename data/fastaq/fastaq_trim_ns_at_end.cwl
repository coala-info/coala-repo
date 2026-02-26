cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq
label: fastaq_trim_ns_at_end
doc: "A collection of commands for manipulating DNA/RNA sequences.\n\nTool homepage:
  https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: command
    type: string
    doc: The command to execute. Available commands are listed below.
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified command.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
stdout: fastaq_trim_ns_at_end.out
