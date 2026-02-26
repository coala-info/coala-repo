cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdbtk ani_rep
label: gtdbtk_ani_rep
doc: "Calculate ANI scores between genomes and assign them to species clusters.\n\n\
  Tool homepage: http://pypi.python.org/pypi/gtdbtk/"
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
    default: 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create intermediate files for debugging purposes
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: extension
    type:
      - 'null'
      - string
    doc: extension of files to process, gz = gzipped
    default: fna
    inputBinding:
      position: 101
      prefix: --extension
  - id: genome_dir
    type: Directory
    doc: directory containing genome files in FASTA format
    inputBinding:
      position: 101
      prefix: --genome_dir
  - id: min_af
    type:
      - 'null'
      - float
    doc: minimum alignment fraction to assign genome to a species cluster
    default: 0.5
    inputBinding:
      position: 101
      prefix: --min_af
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for all output files
    default: gtdbtk
    inputBinding:
      position: 101
      prefix: --prefix
  - id: skani_sketch_dir
    type:
      - 'null'
      - Directory
    doc: directory to store skani sketch db for reference genomes to reuse 
      across runs.If not provided, a temporary directory will be used. If 
      provided for the first time, the sketch db will be created in this 
      directory.
    inputBinding:
      position: 101
      prefix: --skani_sketch_dir
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify alternative directory for temporary files
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: out_dir
    type: Directory
    doc: directory to output files
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
