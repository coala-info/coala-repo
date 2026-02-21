cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmapper
label: taxmapper
doc: "A tool for taxonomic mapping. (Note: The provided text appears to be a container
  build log rather than help text; therefore, no arguments could be extracted.)\n\n
  Tool homepage: https://bitbucket.org/dbeisser/taxmapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmapper:1.0.2--py36_0
stdout: taxmapper.out
