cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - unite
label: microhapulator_mhpl8r_unite
doc: "Simulate the creation of a new profile from a mother and father\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: out
    type: string
    doc: "write output to FILE; by default, output is written to the terminal (standard output)"
    default: "unite.json"
    inputBinding:
      position: 1
      prefix: --out
  - id: seed
    type: ['null', int]
    doc: "seed for random number generator"
    inputBinding:
      position: 1
      prefix: --seed
  - id: mom
    type: File
    doc: "simulated or inferred genotype in JSON format"
    inputBinding:
      position: 2
  - id: dad
    type: File
    doc: "simulated or inferred genotype in JSON format"
    inputBinding:
      position: 3
outputs:
  - id: output_file
    type: File
    doc: "Child profile in JSON format"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
