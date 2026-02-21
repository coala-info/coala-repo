cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks_summary_ollama
label: stacks_summary_ollama
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process using
  Singularity/Apptainer.\n\nTool homepage: https://github.com/Jayrajsinh-Gohil/ResearchGPT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_summary_ollama.out
