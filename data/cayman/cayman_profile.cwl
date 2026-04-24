cwlVersion: v1.2
class: CommandLineTool
baseCommand: cayman profile
label: cayman_profile
doc: "Profile reads against an annotation database and BWA index.\n\nTool homepage:
  https://github.com/zellerlab/cayman"
inputs:
  - id: annotation_db
    type: File
    doc: Path to a text file containing the domain annotation. This needs to be 
      a 4-column file such as bed4.
    inputBinding:
      position: 1
  - id: bwa_index
    type: Directory
    doc: Path to the bwa reference index.
    inputBinding:
      position: 2
  - id: cpus_for_alignment
    type:
      - 'null'
      - int
    doc: Number of CPUs to use for alignment.
    inputBinding:
      position: 103
      prefix: --cpus_for_alignment
  - id: db_format
    type:
      - 'null'
      - string
    doc: Format of the annotation database.
    inputBinding:
      position: 103
      prefix: --db_format
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum sequence identity [n_match/length] for an alignment to be 
      considered.
    inputBinding:
      position: 103
      prefix: --min_identity
  - id: min_seqlen
    type:
      - 'null'
      - int
    doc: Minimum read length [bp] for an alignment to be considered.
    inputBinding:
      position: 103
      prefix: --min_seqlen
  - id: orphans
    type:
      - 'null'
      - type: array
        items: File
    doc: An orphan read fastq file. Multiple files can be separated by spaces.
    inputBinding:
      position: 103
      prefix: --orphans
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 103
      prefix: --out_prefix
  - id: reads1
    type:
      - 'null'
      - type: array
        items: File
    doc: A forward/R1 read fastq file. Multiple files can be separated by 
      spaces.
    inputBinding:
      position: 103
      prefix: '-1'
  - id: reads2
    type:
      - 'null'
      - type: array
        items: File
    doc: A reverse/R2 read fastq file. Multiple files can be separated by 
      spaces.
    inputBinding:
      position: 103
      prefix: '-2'
  - id: singles
    type:
      - 'null'
      - type: array
        items: File
    doc: A single-end library read fastq file. Multiple files can be separated 
      by spaces.
    inputBinding:
      position: 103
      prefix: --singles
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cayman:0.10.2--pyh7e72e81_0
stdout: cayman_profile.out
