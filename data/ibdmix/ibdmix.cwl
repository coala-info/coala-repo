cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdmix
label: ibdmix
doc: "ibdmix is a tool for admixture analysis of diploid populations.\n\nTool homepage:
  https://github.com/PrincetonUniversity/IBDmix"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input genotype files (e.g., VCF, PLINK)
    inputBinding:
      position: 1
  - id: reference_panels
    type:
      type: array
      items: File
    doc: Reference panel files (e.g., VCF, PLINK)
    inputBinding:
      position: 2
  - id: max_missing
    type:
      - 'null'
      - float
    doc: Maximum missing genotype rate per individual
    inputBinding:
      position: 103
      prefix: --max-missing
  - id: min_maf
    type:
      - 'null'
      - float
    doc: Minimum minor allele frequency for variants
    inputBinding:
      position: 103
      prefix: --min-maf
  - id: num_ancestry_components
    type:
      - 'null'
      - int
    doc: Number of ancestry components (K)
    inputBinding:
      position: 103
      prefix: --k
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: output_prefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 103
      prefix: --output-prefix
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility
    inputBinding:
      position: 103
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdmix:1.0.1--h4ac6f70_2
stdout: ibdmix.out
