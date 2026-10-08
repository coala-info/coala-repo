cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - dist
label: microhapulator_mhpl8r_dist
doc: "Compute a simple Hamming distance between two profiles\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: out
    type: string
    doc: "write output to FILE; by default, output is written to the terminal (standard output)"
    default: "dist.json"
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
    doc: "Hamming distance in JSON format"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
