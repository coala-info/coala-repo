cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - vcfbed
label: jvarkit_vcfbed
doc: "The provided text is an error message indicating a failure to build or run the
  container image (no space left on device) and does not contain help documentation
  or argument definitions.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_vcfbed.out
