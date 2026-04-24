cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bygul
  - simulate-proportions
label: bygul_simulate-proportions
doc: "Simulate proportions for genomes, primers, and reference.\n\nTool homepage:
  https://github.com/andersen-lab/Bygul"
inputs:
  - id: genomes
    type: File
    doc: Input genomes
    inputBinding:
      position: 1
  - id: primers
    type: File
    doc: Input primers
    inputBinding:
      position: 2
  - id: reference
    type: File
    doc: Input reference
    inputBinding:
      position: 3
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Base error rate (e.g., 0.02) for simulation using both wgsim and mason
    inputBinding:
      position: 104
      prefix: --error_rate
  - id: haplotype
    type:
      - 'null'
      - boolean
    doc: use this to simulate reads for a haploid organism for wgsim
    inputBinding:
      position: 104
      prefix: --haplotype
  - id: indel_extend_probability
    type:
      - 'null'
      - float
    doc: Probability an indel is extended (e.g., 0.3)for simulation for wgsim
    inputBinding:
      position: 104
      prefix: --indel_extend_probability
  - id: indel_fraction
    type:
      - 'null'
      - float
    doc: Fraction of indels (e.g., 0.15) for simulation,this will be both 
      insertion and deletion probablity for mason
    inputBinding:
      position: 104
      prefix: --indel_fraction
  - id: maxmismatch
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches allowed in primer region
    inputBinding:
      position: 104
      prefix: --maxmismatch
  - id: mean_quality_begin
    type:
      - 'null'
      - float
    doc: Mean sequence quality in beginning of the read for mason simulator only
    inputBinding:
      position: 104
      prefix: --mean_quality_begin
  - id: mean_quality_end
    type:
      - 'null'
      - float
    doc: Mean sequence quality in end of the read for mason simulator only
    inputBinding:
      position: 104
      prefix: --mean_quality_end
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Mutation rate (e.g., 0.001) for simulation for wgsim
    inputBinding:
      position: 104
      prefix: --mutation_rate
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 104
      prefix: --outdir
  - id: outerdistance
    type:
      - 'null'
      - int
    doc: Outer distance for simulation using wgsim
    inputBinding:
      position: 104
      prefix: --outerdistance
  - id: proportions
    type:
      - 'null'
      - string
    doc: Read proportions for each sample, e.g.(0.8,0.2) must sum to 1.0. If not
      provided, the program will randomly assign proportions
    inputBinding:
      position: 104
      prefix: --proportions
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length for simulation
    inputBinding:
      position: 104
      prefix: --read_length
  - id: readcnt
    type:
      - 'null'
      - int
    doc: Number of reads per amplicon
    inputBinding:
      position: 104
      prefix: --readcnt
  - id: redo
    type:
      - 'null'
      - boolean
    doc: Overwrite the output directory if it already exists.
    inputBinding:
      position: 104
      prefix: --redo
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for simulation
    inputBinding:
      position: 104
      prefix: --seed
  - id: simulator
    type:
      - 'null'
      - string
    doc: Select the simulator to use (wgsim or mason)
    inputBinding:
      position: 104
      prefix: --simulator
  - id: standard_deviation
    type:
      - 'null'
      - int
    doc: Standard deviation of insert size for wgsim
    inputBinding:
      position: 104
      prefix: --standard_deviation
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bygul:1.0.7--pyhdfd78af_0
stdout: bygul_simulate-proportions.out
