cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - contain
label: microhapulator_mhpl8r_contain
doc: "Perform a simple containment test\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: out
    type: string
    doc: "write output to FILE; by default, output is written to the terminal (standard output)"
    default: "contain.json"
    inputBinding:
      position: 1
      prefix: --out
  - id: profile1
    type: File
    doc: "simulated or inferred genotype profile in JSON format"
    inputBinding:
      position: 2
  - id: profile2
    type: File
    doc: "simulated or inferred genotype profile in JSON format"
    inputBinding:
      position: 3
outputs:
  - id: output_file
    type: File
    doc: "Containment result in JSON format"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
