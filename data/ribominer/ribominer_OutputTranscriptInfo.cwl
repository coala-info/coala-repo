cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribominer_OutputTranscriptInfo
label: ribominer_OutputTranscriptInfo
doc: "A tool from the RiboMiner suite to output transcript information. (Note: The
  provided text contains container build errors rather than the tool's help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/xryanglab/RiboMiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribominer:0.2.3.2--pyh5e36f6f_0
stdout: ribominer_OutputTranscriptInfo.out
