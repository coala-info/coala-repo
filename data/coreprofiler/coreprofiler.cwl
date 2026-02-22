cwlVersion: v1.2
class: CommandLineTool
baseCommand: coreprofiler
label: coreprofiler
doc: "The provided text appears to be a system error log (Singularity/Apptainer build
  failure) rather than CLI help text. No arguments or usage information could be extracted
  from the input.\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
stdout: coreprofiler.out
