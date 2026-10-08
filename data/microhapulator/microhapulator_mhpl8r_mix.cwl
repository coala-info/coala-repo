cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - mix
label: microhapulator_mhpl8r_mix
doc: "Combine simulated profiles into a mock DNA mixture\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: out
    type: string
    doc: "write output to FILE; by default, output is written to the terminal (standard output)"
    default: "mix.json"
    inputBinding:
      position: 1
      prefix: --out
  - id: profiles
    type:
      type: array
      items: File
    doc: "simulated genotype profiles in JSON format"
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: "Mixture profile in JSON format"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
