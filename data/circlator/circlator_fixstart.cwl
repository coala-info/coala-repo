cwlVersion: v1.2
class: CommandLineTool
baseCommand: circlator_fixstart
label: circlator_fixstart
doc: "Change start point of each sequence in assembly\n\nTool homepage: https://github.com/sanger-pathogens/circlator"
inputs:
  - id: assembly_fasta
    type: File
    doc: Name of input FASTA file
    inputBinding:
      position: 1
  - id: outprefix
    type: string
    doc: Prefix of output files
    inputBinding:
      position: 2
  - id: genes_fa
    type:
      - 'null'
      - File
    doc: FASTA file of genes to search for to use as start point. If this option
      is not used, a built-in set of dnaA genes is used
    inputBinding:
      position: 103
      prefix: --genes_fa
  - id: ignore
    type:
      - 'null'
      - File
    doc: Absolute path to file of IDs of contigs to not change
    inputBinding:
      position: 103
      prefix: --ignore
  - id: min_id
    type:
      - 'null'
      - float
    doc: Minimum percent identity of promer match between contigs and gene(s) to
      use as start point
    default: 70
    inputBinding:
      position: 103
      prefix: --min_id
  - id: mincluster
    type:
      - 'null'
      - int
    doc: The -c|mincluster option of promer. If this option is used, it 
      overrides promer's default value
    inputBinding:
      position: 103
      prefix: --mincluster
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circlator:v1.5.5-3-deb_cv1
stdout: circlator_fixstart.out
