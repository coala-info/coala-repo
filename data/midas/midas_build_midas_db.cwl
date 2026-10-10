cwlVersion: v1.2
class: CommandLineTool
baseCommand: build_midas_db.py
label: midas_build_midas_db
doc: "Build a custom MIDAS reference database from a directory of genomes.\n\nTool homepage: https://github.com/snayfach/MIDAS"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (1).
    inputBinding:
      position: 101
      prefix: --threads
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output files with gzip (False).
    inputBinding:
      position: 101
      prefix: --compress
  - id: max_species
    type:
      - 'null'
      - int
    doc: Maximum number of species to process from input (use all). Useful for quick tests.
    inputBinding:
      position: 101
      prefix: --max_species
  - id: max_genomes
    type:
      - 'null'
      - int
    doc: Maximum number of genomes to process per species (use all). Useful for quick tests.
    inputBinding:
      position: 101
      prefix: --max_genomes
  - id: indir
    type: Directory
    doc: Path to directory of input genomes. Each subdirectory is named by a genome_id and holds genome_id.fna,
      genome_id.ffn and genome_id.faa.
    inputBinding:
      position: 1
  - id: mapfile
    type: File
    doc: Tab-delimited mapping file with header and fields genome_id, species_id, rep_genome (0 or 1).
    inputBinding:
      position: 2
  - id: outdir
    type: string
    doc: Directory to store the MIDAS database.
    inputBinding:
      position: 3
outputs:
  - id: out_dir
    type: Directory
    doc: MIDAS database directory.
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
