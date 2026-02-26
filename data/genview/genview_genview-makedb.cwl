cwlVersion: v1.2
class: CommandLineTool
baseCommand: genview-makedb
label: genview_genview-makedb
doc: "Creates sqlite3 database with genetic environment from genomes containing the
  provided reference gene(s).\n\nTool homepage: https://github.com/EbmeyerSt/GEnView.git"
inputs:
  - id: accessions
    type:
      - 'null'
      - File
    doc: csv file containing one genome accession number per row, cannot be 
      specied at the same time as --taxa
    inputBinding:
      position: 101
      prefix: --accessions
  - id: assemblies
    type:
      - 'null'
      - boolean
    doc: 'Search NCBI Assembly database '
    inputBinding:
      position: 101
      prefix: --assemblies
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Erase files from previous genview runs from target directory
    inputBinding:
      position: 101
      prefix: --clean
  - id: database
    type: File
    doc: fasta/multifasta file containing amino acid sequences of translated 
      genes to be annotated
    inputBinding:
      position: 101
      prefix: --database
  - id: flanking_length
    type:
      - 'null'
      - int
    doc: Max length of flanking regions to annotate
    inputBinding:
      position: 101
      prefix: --flanking_length
  - id: identity
    type:
      - 'null'
      - int
    doc: identity cutoff for hits to be saved to the database (e.g 80 for 80% 
      cutoff)
    inputBinding:
      position: 101
      prefix: --identity
  - id: kraken2
    type:
      - 'null'
      - Directory
    doc: Path to kraken2 database. Uses kraken2 to classify metagenomic 
      long-reads.
    inputBinding:
      position: 101
      prefix: --kraken2
  - id: local
    type:
      - 'null'
      - Directory
    doc: path to local genomes
    inputBinding:
      position: 101
      prefix: --local
  - id: log
    type:
      - 'null'
      - boolean
    doc: Write log file for debugging
    inputBinding:
      position: 101
      prefix: --log
  - id: plasmids
    type:
      - 'null'
      - boolean
    doc: Search NCBI Refseq plasmid database
    inputBinding:
      position: 101
      prefix: --plasmids
  - id: processes
    type:
      - 'null'
      - int
    doc: number of cores to run the script on
    inputBinding:
      position: 101
      prefix: --processes
  - id: save_tmps
    type:
      - 'null'
      - boolean
    doc: keep temporary files
    inputBinding:
      position: 101
      prefix: --save_tmps
  - id: subject_coverage
    type:
      - 'null'
      - int
    doc: minimum coverage for a hit to be saved to db (e.g 80 for 80% cutoff)
    inputBinding:
      position: 101
      prefix: --subject_coverage
  - id: target_directory
    type: Directory
    doc: path to output directory
    inputBinding:
      position: 101
      prefix: --target_directory
  - id: taxa
    type:
      - 'null'
      - type: array
        items: string
    doc: taxon/taxa names to download genomes for - use "all" do download all 
      available genomes, cannot be specified at the same time as --accessions
    inputBinding:
      position: 101
      prefix: --taxa
  - id: uniprot_cutoff
    type:
      - 'null'
      - int
    doc: '% identity threshold for annotating orfs aurrounding the target sequence,
      default 60'
    default: 60
    inputBinding:
      position: 101
      prefix: --uniprot_cutoff
  - id: uniprot_db
    type:
      - 'null'
      - File
    doc: Path to uniprotKB database
    inputBinding:
      position: 101
      prefix: --uniprot_db
  - id: update
    type:
      - 'null'
      - boolean
    doc: update an existing genview database with new genomes
    inputBinding:
      position: 101
      prefix: --update
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genview:0.2--pyhdfd78af_0
stdout: genview_genview-makedb.out
