cwlVersion: v1.2
class: CommandLineTool
baseCommand: panorama
label: panorama_panorama
doc: "Panorama tool for various bioinformatics tasks.\n\nTool homepage: https://github.com/labgem/panorama"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to execute. Available choices: info, annotation, systems,
      align, cluster, compare_context, compare_systems, compare_spots, write, write_systems,
      pansystems, utils'
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
stdout: panorama_panorama.out
