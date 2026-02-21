cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs-disambiguate
label: ngs-disambiguate
doc: "The provided text is a system error log from a container runtime (Singularity/Apptainer)
  and does not contain the help text or usage information for the tool. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/AstraZeneca-NGS/disambiguate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-disambiguate:2018.05.03--h2bd4fab_12
stdout: ngs-disambiguate.out
