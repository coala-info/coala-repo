cwlVersion: v1.2
class: CommandLineTool
baseCommand: irida-linker_ngsArchiveLinker.pl
label: irida-linker_ngsArchiveLinker.pl
doc: "IRIDA NGS Archive Linker. (Note: The provided text contains only system error
  messages regarding container execution and does not include the tool's help or usage
  information.)\n\nTool homepage: https://github.com/phac-nml/irida-linker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irida-linker:1.1.1--hdfd78af_2
stdout: irida-linker_ngsArchiveLinker.pl.out
