cwlVersion: v1.2
class: CommandLineTool
baseCommand: vpt
label: vpt_Log
doc: "vpt: error: argument : invalid choice: 'Log' (choose from 'run-segmentation',
  'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation',
  'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg',
  'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch',
  'generate-segmentation-metrics')\n\nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: command
    type: string
    doc: The command to execute
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
stdout: vpt_Log.out
