cwlVersion: v1.2
class: CommandLineTool
baseCommand: halfdeep_halfdeep.kmers.sh
label: halfdeep_halfdeep.kmers.sh
doc: "A script for k-mer processing as part of the halfdeep toolset. (Note: The provided
  text contains system error logs regarding container execution and does not include
  usage instructions or argument definitions).\n\nTool homepage: https://github.com/richard-burhans/HalfDeep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
stdout: halfdeep_halfdeep.kmers.sh.out
