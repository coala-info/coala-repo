cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - diff
label: microhapulator_mhpl8r_diff
doc: "Compare two profiles and determine the markers at which their genotypes differ\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: out
    type: string
    doc: "write output to FILE; by default, output is written to the terminal (standard output)"
    default: "diff.txt"
    inputBinding:
      position: 1
      prefix: --out
  - id: profile1
    type: File
    doc: "typing result or simulated profile in JSON format"
    inputBinding:
      position: 2
  - id: profile2
    type: File
    doc: "typing result or simulated profile in JSON format"
    inputBinding:
      position: 3
outputs:
  - id: output_file
    type: File
    doc: "Markers at which the two genotypes differ"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
