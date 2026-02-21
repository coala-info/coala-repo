cwlVersion: v1.2
class: CommandLineTool
baseCommand: tdrmapper_TdrMappingScripts.pl
label: tdrmapper_TdrMappingScripts.pl
doc: "The provided text does not contain help information for the tool; it contains
  container engine log messages and a fatal error regarding image fetching.\n\nTool
  homepage: https://github.com/sararselitsky/tDRmapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tdrmapper:1.1--pl526_3
stdout: tdrmapper_TdrMappingScripts.pl.out
