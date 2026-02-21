cwlVersion: v1.2
class: CommandLineTool
baseCommand: dextractor_UnityLive2DExtractor.exe
label: dextractor_UnityLive2DExtractor.exe
doc: "A tool for extracting Unity Live2D assets. (Note: The provided text contains
  system error messages regarding container image building and does not include the
  tool's help documentation; therefore, no arguments could be extracted.)\n\nTool
  homepage: https://github.com/Perfare/UnityLive2DExtractor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dextractor:1.0p2--hb2ce006_9
stdout: dextractor_UnityLive2DExtractor.exe.out
