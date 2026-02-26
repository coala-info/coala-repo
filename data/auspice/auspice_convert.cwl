cwlVersion: v1.2
class: CommandLineTool
baseCommand: auspice convert
label: auspice_convert
doc: "Convert auspice dataset JSON file(s) to the most up-to-date schema (currently
  v2). Note that in auspice v2.x, \"auspice view\" will convert v1 JSONs to v2 for
  you (using the same logic as this command).\n\nTool homepage: https://docs.nextstrain.org/projects/auspice/"
inputs:
  - id: minify_json
    type:
      - 'null'
      - boolean
    doc: export JSONs without indentation or line returns
    inputBinding:
      position: 101
      prefix: --minify-json
  - id: v1_meta_tree
    type:
      - 'null'
      - File
    doc: v1 dataset JSONs
    inputBinding:
      position: 101
      prefix: --v1 META TREE
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File to write output to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/auspice:2.66.0--h503566f_2
