cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - prob
label: microhapulator_mhpl8r_prob
doc: "Compute a profile random match probability (RMP) or an RMP-based likelihood ratio (LR) test\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: erate
    type: ['null', float]
    doc: "rate of genotyping error; by default 0.01"
    inputBinding:
      position: 1
      prefix: --erate
  - id: out
    type: string
    doc: "write output to FILE; by default, output is written to the terminal (standard output)"
    default: "prob.json"
    inputBinding:
      position: 1
      prefix: --out
  - id: freq
    type: File
    doc: "population haplotype frequencies in tabular (TSV) format"
    inputBinding:
      position: 2
  - id: profile1
    type: File
    doc: "typing result or simulated genotype in JSON format"
    inputBinding:
      position: 3
  - id: profile2
    type: ['null', File]
    doc: "typing result or simulated genotype in JSON format; optional"
    inputBinding:
      position: 4
outputs:
  - id: output_file
    type: File
    doc: "Random match probability or likelihood ratio in JSON format"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
