cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clm
  - info
label: mcl_clm info
doc: "The provided text contains a fatal error message from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the mcl container image due to insufficient
  disk space. No help text or argument definitions were found in the input.\n\nTool
  homepage: https://micans.org/mcl/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcl:22.282--pl5321h7b50bb2_4
stdout: mcl_clm info.out
