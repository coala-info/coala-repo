cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tritimap
  - init
label: tritimap_init
doc: "Generate snakemake configuration file and other needed file. The command will
  generate three configuration files(config.yaml, sample.csv and region.csv) in the
  running directory.\n\nTool homepage: https://github.com/fei0810/Triti-Map"
inputs:
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Triti-Map running directory.
    inputBinding:
      position: 101
      prefix: --working-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tritimap:0.9.7--pyh5e36f6f_0
stdout: tritimap_init.out
