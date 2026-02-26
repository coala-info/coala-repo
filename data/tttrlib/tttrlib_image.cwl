cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tttrlib
  - image
label: tttrlib_image
doc: "Image processing (exporting, FLIM, ...)\n\nTool homepage: https://github.com/fluorescence-tools/tttrlib"
inputs:
  - id: command
    type: string
    doc: The subcommand to run (e.g., export)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tttrlib:0.25.1--py312hd82e9f0_1
stdout: tttrlib_image.out
