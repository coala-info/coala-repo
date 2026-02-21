cwlVersion: v1.2
class: CommandLineTool
baseCommand: eagle
label: eagle2
doc: "Eagle2 is a software tool for high-accuracy genetic haplotype phasing. (Note:
  The provided help text contains only system error messages and no CLI usage information;
  arguments could not be extracted.)\n\nTool homepage: https://github.com/poruloh/Eagle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eagle2:2.4.1--h6a68c12_0
stdout: eagle2.out
