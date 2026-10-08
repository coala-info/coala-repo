cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - sim
label: microhapulator_mhpl8r_sim
doc: "Simulate a diploid genotype from the specified microhaplotype frequencies\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: seed
    type: ['null', int]
    doc: "seed for random number generator"
    inputBinding:
      position: 1
      prefix: --seed
  - id: out
    type: string
    doc: "write simulated profile data in JSON format to FILE"
    default: "sim.json"
    inputBinding:
      position: 1
      prefix: --out
  - id: haplo_seq
    type: ['null', string]
    doc: "write simulated haplotype sequences in FASTA format to FILE"
    inputBinding:
      position: 1
      prefix: --haplo-seq
  - id: sequences
    type: ['null', File]
    doc: "microhaplotype sequences in FASTA format; required if `--haplo-seq` enabled, ignored if not"
    inputBinding:
      position: 1
      prefix: --sequences
  - id: markers
    type: ['null', File]
    doc: "microhaplotype marker definitions in tabular (tab separated) format; required if `--haplo-seq` enabled, ignored if not"
    inputBinding:
      position: 1
      prefix: --markers
  - id: freq
    type: File
    doc: "population microhaplotype frequencies in tabular (tab separated) format"
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: "Simulated profile in JSON format"
    outputBinding:
      glob: $(inputs.out)
  - id: haplo_seq_file
    type: ['null', File]
    doc: "Simulated haplotype sequences in FASTA format (written with --haplo-seq)"
    outputBinding:
      glob: $(inputs.haplo_seq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
