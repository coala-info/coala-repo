cwlVersion: v1.2
class: CommandLineTool
baseCommand: DRAM-setup.py
label: dram_DRAM-setup.py
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build a Singularity/Apptainer container due to insufficient
  disk space.\n\nTool homepage: https://github.com/shafferm/DRAM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dram:1.5.0--pyhdfd78af_0
stdout: dram_DRAM-setup.py.out
