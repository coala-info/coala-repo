cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdbtk classify
label: gtdbtk_classify
doc: "Classify genomes using GTDB-Tk\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: align_dir
    type: Directory
    doc: output directory of 'align' command
    inputBinding:
      position: 101
      prefix: --align_dir
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
  - id: full_tree
    type:
      - 'null'
      - boolean
    doc: use the unsplit bacterial tree for the classify step; this is the 
      original GTDB-Tk approach (version < 2) and requires more than 320 GB of 
      RAM to load the reference tree
    inputBinding:
      position: 101
      prefix: --full_tree
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
  - id: min_af
    type:
      - 'null'
      - float
    doc: minimum alignment fraction to assign genome to a species cluster
    inputBinding:
      position: 101
      prefix: --min_af
  - id: out_dir
    type: Directory
    doc: directory to output files
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: pplacer_cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use during pplacer placement
    inputBinding:
      position: 101
      prefix: --pplacer_cpus
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for all output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: scratch_dir
    type:
      - 'null'
      - Directory
    doc: reduce pplacer memory usage by writing to disk (slower).
    inputBinding:
      position: 101
      prefix: --scratch_dir
  - id: skip_ani_screen
    type:
      - 'null'
      - boolean
    doc: Skip the skani ANI screening step to classify genomes.
    inputBinding:
      position: 101
      prefix: --skip_ani_screen
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify alternative directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
stdout: gtdbtk_classify.out
