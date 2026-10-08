cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- squire
- Seek
label: squire_seek
doc: 'Extract the repeat sequences for given genomic coordinates from a genome fasta file.


  Tool homepage: https://github.com/wyang17/SQuIRE'
inputs:
- id: infile
  type: File
  doc: Repeat genomic coordinates, can be TE_ID, bedfile, or gff (required)
  inputBinding:
    position: 1
    prefix: --infile
- id: outfile
  type: string
  doc: Repeat sequences output file (FASTA), can use "-" for stdout (required)
  inputBinding:
    position: 1
    prefix: --outfile
  default: repeats.fa
- id: genome
  type:
  - File
  - Directory
  doc: Genome build's fasta chromosomes - .fa file or .chromFa folder (required)
  inputBinding:
    position: 1
    prefix: --genome
- id: verbosity
  type:
  - 'null'
  - boolean
  doc: Want messages and runtime printed to stderr (optional; default=False)
  inputBinding:
    position: 1
    prefix: --verbosity
outputs:
- id: outfile_result
  type: File
  doc: Repeat sequences output file (FASTA), can use "-" for stdout (required)
  outputBinding:
    glob: $(inputs.outfile)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.genome)
    writable: true
