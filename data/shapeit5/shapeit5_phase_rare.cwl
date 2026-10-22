cwlVersion: v1.2
class: CommandLineTool
baseCommand: [SHAPEIT5_phase_rare]
label: shapeit5_phase_rare
doc: "Phase rare variants onto a haplotype scaffold (SHAPEIT5 phase_rare).\n\nTool homepage: https://odelaneau.github.io/shapeit5/"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Genotypes to be phased
    inputBinding:
      position: 101
      prefix: --input
  - id: input_region
    type: string
    doc: Region to be considered in --input
    inputBinding:
      position: 101
      prefix: --input-region
  - id: scaffold
    type: File
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Scaffold of haplotypes
    inputBinding:
      position: 101
      prefix: --scaffold
  - id: scaffold_region
    type: string
    doc: Region to be considered in --scaffold
    inputBinding:
      position: 101
      prefix: --scaffold-region
  - id: map
    type: ['null', File]
    doc: Genetic map
    inputBinding:
      position: 101
      prefix: --map
  - id: pedigree
    type: ['null', File]
    doc: Pedigree file (kid father mother)
    inputBinding:
      position: 101
      prefix: --pedigree
  - id: haploids
    type: ['null', File]
    doc: List of haploid samples (e.g. chrX for males). One sample ID per line.
    inputBinding:
      position: 101
      prefix: --haploids
  - id: seed
    type: ['null', int]
    doc: Seed of the random number generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: thread
    type: ['null', int]
    doc: Number of thread used
    inputBinding:
      position: 101
      prefix: --thread
  - id: progress
    type: ['null', boolean]
    doc: Verbose progress percentages on screen for longer tasks
    inputBinding:
      position: 101
      prefix: --progress
  - id: pbwt_modulo
    type: ['null', float]
    doc: Storage frequency of PBWT indexes in cM
    inputBinding:
      position: 101
      prefix: --pbwt-modulo
  - id: pbwt_depth_common
    type: ['null', int]
    doc: Depth of PBWT indexes at common sites to condition on
    inputBinding:
      position: 101
      prefix: --pbwt-depth-common
  - id: pbwt_depth_rare
    type: ['null', int]
    doc: Depth of PBWT indexes at rare hets to condition on
    inputBinding:
      position: 101
      prefix: --pbwt-depth-rare
  - id: pbwt_mac
    type: ['null', int]
    doc: Minimal Minor Allele Count at which PBWT is evaluated
    inputBinding:
      position: 101
      prefix: --pbwt-mac
  - id: pbwt_mdr
    type: ['null', float]
    doc: Maximal Missing Data Rate at which PBWT is evaluated
    inputBinding:
      position: 101
      prefix: --pbwt-mdr
  - id: effective_size
    type: ['null', int]
    doc: Effective size of the population
    inputBinding:
      position: 101
      prefix: --effective-size
  - id: score_singletons
    type: ['null', boolean]
    doc: Score singleton phasing between 0.5 and 1.0 (experimental)
    inputBinding:
      position: 101
      prefix: --score-singletons
  - id: output_path
    type: string
    doc: Phased haplotypes (at common AND rare variants)
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Phased haplotypes (at common AND rare variants)
    outputBinding:
      glob: $(inputs.output_path)
    secondaryFiles:
      - pattern: .csi
        required: false
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
