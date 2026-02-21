cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poppunk
  - mst
label: poppunk_poppunk_mst
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) while attempting
  to fetch the poppunk image.\n\nTool homepage: https://github.com/johnlees/PopPUNK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
stdout: poppunk_poppunk_mst.out
