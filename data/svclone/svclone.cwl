cwlVersion: v1.2
class: CommandLineTool
baseCommand: svclone
label: svclone
doc: "SVclone: A tool for clonal analysis of structural variants\n\nTool homepage:
  https://github.com/mcmero/SVclone"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file containing structural variants.
    inputBinding:
      position: 1
  - id: max_clones
    type:
      - 'null'
      - int
    doc: Maximum number of clones to consider.
    inputBinding:
      position: 102
      prefix: --max-clones
  - id: min_clones
    type:
      - 'null'
      - int
    doc: Minimum number of clones to consider.
    inputBinding:
      position: 102
      prefix: --min-clones
  - id: ploidy
    type:
      - 'null'
      - float
    doc: Ploidy of the sample.
    inputBinding:
      position: 102
      prefix: --ploidy
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility.
    inputBinding:
      position: 102
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to save the output files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
