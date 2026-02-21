cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - BamStats02
label: jvarkit_BamStats02
doc: "The provided text contains system error messages related to a container runtime
  (Singularity/Apptainer) and does not contain the actual help documentation for the
  tool. Based on the tool name, it is a utility for generating statistics from BAM
  files.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_BamStats02.out
