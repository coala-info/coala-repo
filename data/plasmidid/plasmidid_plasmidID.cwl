cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidID
label: plasmidid_plasmidID
doc: "reconstruct and annotate the most likely plasmids present in one sample\n\n\
  Tool homepage: https://github.com/BU-ISCIII/plasmidID"
inputs:
  - id: alignment_identity
    type:
      - 'null'
      - int
    doc: minimun identity percentage aligned for a contig to annotate
    default: 90
    inputBinding:
      position: 101
      prefix: --alignment-identity
  - id: alignment_percentage
    type:
      - 'null'
      - int
    doc: minimun length percentage aligned for a contig to annotate
    default: 20
    inputBinding:
      position: 101
      prefix: --alignment-percentage
  - id: annotate
    type:
      - 'null'
      - File
    doc: file with configuration file for specific annotation
    inputBinding:
      position: 101
      prefix: --annotate
  - id: cluster
    type:
      - 'null'
      - float
    doc: kmer identity to cluster plasmids into the same representative sequence
      (0 means identical) (0-1)
    default: 0.5
    inputBinding:
      position: 101
      prefix: --cluster
  - id: config_directory
    type:
      - 'null'
      - Directory
    doc: directory holding config files
    default: config_files/
    inputBinding:
      position: 101
      prefix: --config-directory
  - id: config_file_individual
    type:
      - 'null'
      - string
    doc: file name of the individual file used to reconstruct
    inputBinding:
      position: 101
      prefix: --config-file-individual
  - id: contigs
    type:
      - 'null'
      - File
    doc: file with contigs. If supplied, plasmidID will not assembly reads
    inputBinding:
      position: 101
      prefix: --contigs
  - id: coverage_cutoff
    type:
      - 'null'
      - int
    doc: minimun coverage percentage to select a plasmid as scafold (0-100)
    default: 80
    inputBinding:
      position: 101
      prefix: --coverage-cutoff
  - id: coverage_summary
    type:
      - 'null'
      - int
    doc: minimun coverage percentage to include plasmids in summary image 
      (0-100)
    default: 90
    inputBinding:
      position: 101
      prefix: --coverage-summary
  - id: database
    type: File
    doc: database to map and reconstruct (mandatory)
    inputBinding:
      position: 101
      prefix: --database
  - id: explore
    type:
      - 'null'
      - boolean
    doc: Relaxes default parameters to find less reliable relationships within 
      data supplied and database
    inputBinding:
      position: 101
      prefix: --explore
  - id: extend_annotation
    type:
      - 'null'
      - int
    doc: look for annotation over regions with no homology found (base pairs)
    default: 500
    inputBinding:
      position: 101
      prefix: --extend-annotation
  - id: group_name
    type:
      - 'null'
      - string
    doc: group name (optional). If unset, samples will be gathered in NO_GROUP 
      group
    inputBinding:
      position: 101
      prefix: --group
  - id: kmer
    type:
      - 'null'
      - float
    doc: identity to filter plasmids from the database with kmer approach (0-1)
    default: 0.95
    inputBinding:
      position: 101
      prefix: --kmer
  - id: length_total
    type:
      - 'null'
      - int
    doc: minimun alignment length to filter blast analysis
    inputBinding:
      position: 101
      prefix: --length-total
  - id: memory
    type:
      - 'null'
      - int
    doc: max memory allowed to use
    inputBinding:
      position: 101
      prefix: --memory
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Reads supplied will not be quality trimmed
    inputBinding:
      position: 101
      prefix: --no-trim
  - id: only_reconstruct
    type:
      - 'null'
      - boolean
    doc: "Database supplied will not be filtered and all sequences will be used as
      scaffold\n                        This option does not require R1 and R2, instead
      a contig file can be supplied"
    inputBinding:
      position: 101
      prefix: --only-reconstruct
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory, by default is the current directory
    inputBinding:
      position: 101
      prefix: -o
  - id: quick_mode
    type:
      - 'null'
      - boolean
    doc: Undo winner takes it all algorithm when clustering by kmer - QUICKER 
      MODE
    inputBinding:
      position: 101
      prefix: -w
  - id: r1
    type: File
    doc: reads corresponding to paired-end R1 (mandatory)
    inputBinding:
      position: 101
      prefix: --R1
  - id: r2
    type: File
    doc: reads corresponding to paired-end R2 (mandatory)
    inputBinding:
      position: 101
      prefix: --R2
  - id: sample_name
    type: string
    doc: sample name (mandatory), less than 37 characters
    inputBinding:
      position: 101
      prefix: --sample
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: trimmomatic_directory
    type:
      - 'null'
      - Directory
    doc: Indicate directory holding trimmomatic .jar executable
    inputBinding:
      position: 101
      prefix: --trimmomatic-directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidid:1.6.5--hdfd78af_0
stdout: plasmidid_plasmidID.out
