cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haproh
  - hapCon
label: haproh_hapCon
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to pull or build the container image due to lack of disk space.\n\nTool
  homepage: https://github.com/hringbauer/hapROH"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haproh:0.64--py310h1fe012e_4
stdout: haproh_hapCon.out
