cwlVersion: v1.2
class: CommandLineTool
baseCommand: unassigner
label: unassigner
doc: "Assigns sequences to their closest type strain, or flags them as unassigned.\n\
  \nTool homepage: https://github.com/PennChopMicrobiomeProgram/unassigner"
inputs:
  - id: query_fasta
    type: File
    doc: Query sequences FASTA file
    inputBinding:
      position: 1
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the reference database. If not provided, the 
      default database is used.
    inputBinding:
      position: 102
      prefix: --db_dir
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPUs to use during sequence aligment (default: use all the CPUs)'
    inputBinding:
      position: 102
      prefix: --num_cpus
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory (default: basename of query sequences FASTA file, plus
      '_unassigned')."
    inputBinding:
      position: 102
      prefix: --output_dir
  - id: ref_mismatch_positions
    type:
      - 'null'
      - File
    doc: File of mismatch positions in reference database. The file may be 
      compressed in gzip format.
    inputBinding:
      position: 102
      prefix: --ref_mismatch_positions
  - id: soft_threshold
    type:
      - 'null'
      - boolean
    doc: Use soft threshold algorithm.
    inputBinding:
      position: 102
      prefix: --soft_threshold
  - id: threshold
    type:
      - 'null'
      - float
    doc: Sequence identity threshold for ruling out species-level compatibility.
      Default value is 0.975 for the standard algorithm and 0.991 for the soft 
      threshold algorithm.
    inputBinding:
      position: 102
      prefix: --threshold
  - id: type_strain_fasta
    type:
      - 'null'
      - File
    doc: DEPRECATED. FASTA file containing sequences of type strains. If not 
      provided, the default database is used. Note that this WILL NOT DOWNLOAD a
      new db.
    inputBinding:
      position: 102
      prefix: --type_strain_fasta
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Activate verbose mode.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unassigner:1.1.0--pyh7e72e81_0
stdout: unassigner.out
