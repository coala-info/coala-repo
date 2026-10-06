cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, estshift]
requirements:
  - class: InlineJavascriptRequirement
label: bart_estshift
doc: "Estimate shift in spectral data\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: flags
    type: string
    doc: Flags for the estimation
    inputBinding:
      position: 10
  - id: arg1
    type: File
    doc: First argument
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: arg2
    type: File
    doc: Second argument
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 12
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_estshift.out
