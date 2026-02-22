cwlVersion: v1.2
class: CommandLineTool
baseCommand: bolt-lmm-example
label: bolt-lmm-example
doc: "The provided text is an error log indicating a failure to pull or build a Singularity/Apptainer
  container due to insufficient disk space, rather than help text for the tool itself.
  No arguments or usage information could be extracted.\n\nTool homepage: https://github.com/sakkayaphab/bolt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bolt-lmm-example:v2.3.2dfsg-3-deb_cv1
stdout: bolt-lmm-example.out
