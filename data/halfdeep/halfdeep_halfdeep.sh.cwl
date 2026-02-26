cwlVersion: v1.2
class: CommandLineTool
baseCommand: halfdeep
label: halfdeep_halfdeep.sh
doc: "Assumes we have <ref>.lengths and <input.fofn> in the same dir\n\nTool homepage:
  https://github.com/richard-burhans/HalfDeep"
inputs:
  - id: ref
    type: string
    doc: Reference file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
stdout: halfdeep_halfdeep.sh.out
