cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdbtk identify
label: gtdbtk_identify
doc: "Identify GTDB-Tk classifications for genomes.\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: batchfile
    type: File
    doc: path to file describing genomes - tab separated in 2 or 3 columns 
      (FASTA file, genome ID, translation table [optional])
    inputBinding:
      position: 101
      prefix: --batchfile
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create intermediate files for debugging purposes
    inputBinding:
      position: 101
      prefix: --debug
  - id: extension
    type:
      - 'null'
      - string
    doc: extension of files to process, gz = gzipped
    inputBinding:
      position: 101
      prefix: --extension
  - id: force
    type:
      - 'null'
      - boolean
    doc: continue processing if an error occurs on a single genome
    inputBinding:
      position: 101
      prefix: --force
  - id: genes
    type:
      - 'null'
      - boolean
    doc: 'indicates input files contain predicted proteins as amino acids (skip gene
      calling).Warning: This flag will skip the ANI comparison steps (ANI screen and
      classification).'
    inputBinding:
      position: 101
      prefix: --genes
  - id: genome_dir
    type: Directory
    doc: directory containing genome files in FASTA format
    inputBinding:
      position: 101
      prefix: --genome_dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for all output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify alternative directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: write_single_copy_genes
    type:
      - 'null'
      - boolean
    doc: output unaligned single-copy marker genes
    inputBinding:
      position: 101
      prefix: --write_single_copy_genes
outputs:
  - id: out_dir
    type: Directory
    doc: directory to output files
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
