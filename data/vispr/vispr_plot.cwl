cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vispr
  - plot
label: vispr_plot
doc: "Plot visualizations in VEGA JSON format.\n\nTool homepage: https://bitbucket.org/liulab/vispr"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.config)
      - $(inputs.referenced_files)
inputs:
  - id: config
    type: File
    doc: YAML config file pointing to MAGeCK results.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: referenced_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the config file (staged next to the config file so the
      relative paths resolve).
  - id: prefix
    type: string
    doc: Prefix of all resulting plots. This can be a path to a subdirectory.
    inputBinding:
      position: 2
outputs:
  - id: prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix
    outputBinding:
      glob: $(inputs.prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
