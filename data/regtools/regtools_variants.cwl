cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regtools
  - variants
label: regtools_variants
doc: "Annotate variants with splicing information.\n\nTool homepage: https://github.com/griffithlab/regtools/"
inputs:
  - id: command
    type: string
    doc: The subcommand to run (e.g., annotate)
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
    dockerPull: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
stdout: regtools_variants.out
