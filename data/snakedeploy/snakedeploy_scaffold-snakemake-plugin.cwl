cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakedeploy scaffold-snakemake-plugin
label: snakedeploy_scaffold-snakemake-plugin
doc: "Scaffold a snakemake plugin by adding recommended dependencies and code snippets.\n\
  \nTool homepage: https://github.com/snakemake/snakedeploy"
inputs:
  - id: plugin_type
    type: string
    doc: Type of the plugin to scaffold.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
stdout: snakedeploy_scaffold-snakemake-plugin.out
