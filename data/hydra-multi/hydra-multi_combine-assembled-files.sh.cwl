cwlVersion: v1.2
class: CommandLineTool
baseCommand: hydra-multi_combine-assembled-files.sh
label: hydra-multi_combine-assembled-files.sh
doc: "A script to combine assembled files. (Note: The provided help text contains
  system error messages regarding container execution and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/arq5x/Hydra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hydra-multi:0.5.4--py27h5ca1c30_4
stdout: hydra-multi_combine-assembled-files.sh.out
