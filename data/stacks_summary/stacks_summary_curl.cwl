cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks_summary_curl
label: stacks_summary_curl
doc: "Note: The provided text is a container build error log (Apptainer/Singularity)
  and does not contain help documentation or usage instructions for the tool.\n\n
  Tool homepage: https://github.com/Jayrajsinh-Gohil/ResearchGPT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_summary_curl.out
