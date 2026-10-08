cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - contrib
label: microhapulator_mhpl8r_contrib
doc: "Estimate the minimum number of DNA contributors to a suspected mixture\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: out
    type: string
    doc: "write output to FILE; by default, output is written to the terminal (standard output)"
    default: "contrib.json"
    inputBinding:
      position: 1
      prefix: --out
  - id: result
    type: File
    doc: "typing result in JSON format"
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: "Contributor estimate in JSON format"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
