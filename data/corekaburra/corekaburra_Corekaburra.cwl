cwlVersion: v1.2
class: CommandLineTool
baseCommand: Corekaburra
label: corekaburra_Corekaburra
doc: "An extension to pan-genome analyses that summarise genomic regions between core
  genes and segments of neighbouring core genes using gene synteny from a set of input
  genomes and a pan-genome folder.\n\nTool homepage: https://github.com/milnus/Corekaburra"
inputs:
  - id: input_gffs
    type:
      type: array
      items: File
    doc: Path to gff files used for pan-genome
    inputBinding:
      position: 1
  - id: input_pangenome
    type: Directory
    doc: Path to the folder produced by Panaroo or Roary
    inputBinding:
      position: 2
  - id: complete_genomes
    type:
      - 'null'
      - File
    doc: text file containing names of genomes that are to be handled as 
      complete genomes
    inputBinding:
      position: 103
      prefix: --complete_genomes
  - id: core_cutoff
    type:
      - 'null'
      - float
    doc: Percentage of isolates in which a core gene must be present
    default: 1.0
    inputBinding:
      position: 103
      prefix: --core_cutoff
  - id: cpu
    type:
      - 'null'
      - int
    doc: Give max number of CPUs
    default: 1
    inputBinding:
      position: 103
      prefix: --cpu
  - id: log
    type:
      - 'null'
      - boolean
    doc: Record program progress in for debugging purpose
    inputBinding:
      position: 103
      prefix: --log
  - id: low_cutoff
    type:
      - 'null'
      - float
    doc: Percentage of isolates where genes found in less than these are seen as
      low-frequency genes
    default: 0.05
    inputBinding:
      position: 103
      prefix: --low_cutoff
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files, if any is desired
    inputBinding:
      position: 103
      prefix: --prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only print warnings
    inputBinding:
      position: 103
      prefix: --quiet
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Path to where output files will be placed
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/corekaburra:0.0.5--pyhdfd78af_0
