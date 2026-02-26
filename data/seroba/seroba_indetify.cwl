cwlVersion: v1.2
class: CommandLineTool
baseCommand: seroba
label: seroba_indetify
doc: "Seroba command-line tool\n\nTool homepage: https://github.com/sanger-pathogens/seroba"
inputs:
  - id: command
    type: string
    doc: 'The seroba command to execute. Available commands: getPneumocat, createDBs,
      runSerotyping, summary, version'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
stdout: seroba_indetify.out
