cwlVersion: v1.2
class: CommandLineTool
baseCommand: RepeatMasker
label: repeatmasker-recon_RepeatMasker
doc: "RepeatMasker is a program that screens DNA sequences for interspersed repeats
  and low complexity DNA sequences. (Note: The provided help text contains only container
  runtime error messages and no usage information.)\n\nTool homepage: https://www.repeatmasker.org/RepeatMasker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
stdout: repeatmasker-recon_RepeatMasker.out
