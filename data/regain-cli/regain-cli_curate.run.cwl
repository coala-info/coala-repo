cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regain-cli
  - curate
label: regain-cli_curate.run
doc: "The provided text contains error logs from a container runtime (Apptainer/Singularity)
  and does not include the help documentation or usage instructions for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/ERBringHorvath/regain_CLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regain-cli:1.7.1--pyhdfd78af_0
stdout: regain-cli_curate.run.out
