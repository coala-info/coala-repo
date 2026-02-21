cwlVersion: v1.2
class: CommandLineTool
baseCommand: epik_epik.py
label: epik_epik.py
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build a Singularity/Apptainer container due to insufficient
  disk space.\n\nTool homepage: https://github.com/phylo42/epik"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epik:0.2.0--h077b44d_2
stdout: epik_epik.py.out
