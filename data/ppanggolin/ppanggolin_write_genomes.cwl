cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin write_genomes
label: ppanggolin_write_genomes
doc: "Write genomes from a pangenome analysis.\n\nTool homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: add_metadata
    type:
      - 'null'
      - boolean
    doc: Include metadata information in the output files if any have been added
      to pangenome elements (see ppanggolin metadata command).
    inputBinding:
      position: 101
      prefix: --add_metadata
  - id: anno
    type:
      - 'null'
      - File
    doc: A tab-separated file listing the genome names, and the gff/gbff 
      filepath of its annotations (the files can be compressed with gzip). One 
      line per genome. If this is provided, those annotations will be used.
    inputBinding:
      position: 101
      prefix: --anno
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the files in .gz
    inputBinding:
      position: 101
      prefix: --compress
  - id: config
    type:
      - 'null'
      - File
    doc: Specify command arguments through a YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of available cpus
    inputBinding:
      position: 101
      prefix: --cpu
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: fasta
    type:
      - 'null'
      - File
    doc: A tab-separated file listing the genome names, and the fasta filepath 
      of its genomic sequence(s) (the fastas can be compressed with gzip). One 
      line per genome.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the genomes for which to generate output. You can provide a 
      list of genome names either directly in the command line separated by 
      commas, or by referencing a file containing the list of genome names, with
      one name per line.
    inputBinding:
      position: 101
      prefix: --genomes
  - id: gff
    type:
      - 'null'
      - boolean
    doc: Generate a gff file for each genome containing pangenome annotations.
    inputBinding:
      position: 101
      prefix: --gff
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: metadata_sep
    type:
      - 'null'
      - string
    doc: The separator used to join multiple metadata values for elements with 
      multiple metadata values from the same source. This character should not 
      appear in metadata values.
    inputBinding:
      position: 101
      prefix: --metadata_sep
  - id: metadata_sources
    type:
      - 'null'
      - type: array
        items: string
    doc: Which source of metadata should be written. By default all metadata 
      sources are included.
    inputBinding:
      position: 101
      prefix: --metadata_sources
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: proksee
    type:
      - 'null'
      - boolean
    doc: Generate JSON map files for PROKSEE for each genome containing 
      pangenome annotations to be used in proksee.
    inputBinding:
      position: 101
      prefix: --proksee
  - id: table
    type:
      - 'null'
      - boolean
    doc: Generate a tsv file for each genome with pangenome annotations.
    inputBinding:
      position: 101
      prefix: --table
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: Output directory where the file(s) will be written
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
