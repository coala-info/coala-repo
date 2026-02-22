cwlVersion: v1.2
class: CommandLineTool
baseCommand: assembly_finder
label: assembly_finder
doc: "The provided text appears to be a system log or error message from a container
  build process rather than CLI help text. As a result, no command-line arguments,
  flags, or usage patterns could be extracted.\n\nTool homepage: https://github.com/metagenlab/assembly_finder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblycomparator2:2.7.1--hdfd78af_2
stdout: assembly_finder.out
