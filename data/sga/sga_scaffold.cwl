cwlVersion: v1.2
class: CommandLineTool
baseCommand: scaffold
label: sga_scaffold
doc: "Construct scaffolds from CONTIGSFILE using distance estimates.\n\nTool homepage:
  https://github.com/jts/sga"
inputs:
  - id: contigs_file
    type: File
    doc: CONTIGSFILE
    inputBinding:
      position: 1
  - id: asqg_file
    type:
      - 'null'
      - File
    doc: optionally load the sequence graph from FILE
    inputBinding:
      position: 102
      prefix: --asqg-file
  - id: astatistic_file
    type:
      - 'null'
      - File
    doc: load Myers' A-statistic values from FILE. This is used to determine 
      unique and repetitive contigs with the -u/--unique-astat and 
      -r/--repeat-astat parameters
    inputBinding:
      position: 102
      prefix: --astatistic-file
  - id: mate_pair_file
    type:
      - 'null'
      - File
    doc: load links derived from mate-pair (long insert) libraries from FILE
    inputBinding:
      position: 102
      prefix: --mate-pair
  - id: max_sv_size
    type:
      - 'null'
      - int
    doc: collapse heterozygous structural variation if the event size is less 
      than N
    default: 0
    inputBinding:
      position: 102
      prefix: --max-sv-size
  - id: min_copy_number
    type:
      - 'null'
      - float
    doc: remove vertices with estimated copy number less than FLOAT
    default: 0.5
    inputBinding:
      position: 102
      prefix: --min-copy-number
  - id: min_length
    type:
      - 'null'
      - int
    doc: only use contigs at least N bp in length to build scaffolds
    inputBinding:
      position: 102
      prefix: --min-length
  - id: pe_file
    type:
      - 'null'
      - File
    doc: load links derived from paired-end (short insert) libraries from FILE
    inputBinding:
      position: 102
      prefix: --pe
  - id: remove_conflicting
    type:
      - 'null'
      - boolean
    doc: if two contigs have multiple distance estimates between them and they 
      do not agree, break the scaffold at this point
    inputBinding:
      position: 102
      prefix: --remove-conflicting
  - id: strict
    type:
      - 'null'
      - boolean
    doc: perform strict consistency checks on the scaffold links. If a vertex X 
      has multiple edges, a path will be searched for that contains every vertex
      linked to X. If no such path can be found, the edge of X are removed. This
      builds very conservative scaffolds that should be highly accurate.
    inputBinding:
      position: 102
      prefix: --strict
  - id: unique_astat
    type:
      - 'null'
      - float
    doc: Contigs with an a-statitic value about FLOAT will be considered unique
    default: 20.0
    inputBinding:
      position: 102
      prefix: --unique-astat
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: write the scaffolds to FILE
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
