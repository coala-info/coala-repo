cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ltrsift
label: ltrsift_run_ltrsift
doc: "LTRsift is a tool for the identification and annotation of LTR retrotransposons.
  (Note: The provided help text contains only system error messages regarding container
  execution and does not list specific command-line arguments.)\n\nTool homepage:
  https://github.com/satta/ltrsift"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ltrsift:v1.0.2-8-deb_cv1
stdout: ltrsift_run_ltrsift.out
