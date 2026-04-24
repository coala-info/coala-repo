cwlVersion: v1.2
class: CommandLineTool
baseCommand: amrfinder
label: ncbi-amrfinderplus_amrfinder
doc: "Identify AMR and virulence genes in proteins and/or contigs and print a report\n\
  \nTool homepage: https://github.com/ncbi/amr/wiki"
inputs:
  - id: annotation_format
    type:
      - 'null'
      - string
    doc: 'Type of GFF file: bakta, genbank, microscope, patric, pgap, prodigal, prokka,
      pseudomonasdb, rast, standard'
    inputBinding:
      position: 101
      prefix: --annotation_format
  - id: blast_bin
    type:
      - 'null'
      - Directory
    doc: 'Directory for BLAST. Deafult: $BLAST_BIN'
    inputBinding:
      position: 101
      prefix: --blast_bin
  - id: coverage_min
    type:
      - 'null'
      - float
    doc: Minimum coverage of the reference protein (0..1)
    inputBinding:
      position: 101
      prefix: --coverage_min
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Alternative directory with AMRFinder database.
    inputBinding:
      position: 101
      prefix: --database
  - id: database_version
    type:
      - 'null'
      - boolean
    doc: Print database version and exit
    inputBinding:
      position: 101
      prefix: --database_version
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Integrity checks
    inputBinding:
      position: 101
      prefix: --debug
  - id: force_update
    type:
      - 'null'
      - boolean
    doc: Force updating the AMRFinder database
    inputBinding:
      position: 101
      prefix: --force_update
  - id: gff_file
    type:
      - 'null'
      - File
    doc: GFF file for protein locations (can be gzipped). Locations are in the 
      --nucleotide file. Protein ids should be in the attribute 'Name=<id>' (9th
      field) of the rows with type 'CDS' or 'gene' (3rd field).
    inputBinding:
      position: 101
      prefix: --gff
  - id: gpipe_org
    type:
      - 'null'
      - boolean
    doc: NCBI internal GPipe organism names
    inputBinding:
      position: 101
      prefix: --gpipe_org
  - id: hmmer_bin
    type:
      - 'null'
      - Directory
    doc: Directory for HMMer
    inputBinding:
      position: 101
      prefix: --hmmer_bin
  - id: ident_min
    type:
      - 'null'
      - float
    doc: Minimum proportion of identical amino acids in alignment for hit 
      (0..1). -1 means use a curated threshold if it exists and 0.9 otherwise
    inputBinding:
      position: 101
      prefix: --ident_min
  - id: list_organisms
    type:
      - 'null'
      - boolean
    doc: Print the list of all possible taxonomy groups for mutations 
      identification and exit
    inputBinding:
      position: 101
      prefix: --list_organisms
  - id: log
    type:
      - 'null'
      - File
    doc: Error log file, appended, opened on application start
    inputBinding:
      position: 101
      prefix: --log
  - id: mutation_all_file
    type:
      - 'null'
      - File
    doc: File to report all mutations
    inputBinding:
      position: 101
      prefix: --mutation_all
  - id: name
    type:
      - 'null'
      - string
    doc: Text to be added as the first column "name" to all rows of the report, 
      for example it can be an assembly name
    inputBinding:
      position: 101
      prefix: --name
  - id: nucleotide_fasta
    type:
      - 'null'
      - File
    doc: Input nucleotide FASTA file (can be gzipped)
    inputBinding:
      position: 101
      prefix: --nucleotide
  - id: nucleotide_flank5_size
    type:
      - 'null'
      - int
    doc: 5' flanking sequence size for NUC_FLANK5_FASTA_OUT
    inputBinding:
      position: 101
      prefix: --nucleotide_flank5_size
  - id: organism
    type:
      - 'null'
      - string
    doc: Taxonomy group. To see all possible taxonomy groups use the 
      --list_organisms flag
    inputBinding:
      position: 101
      prefix: --organism
  - id: parm
    type:
      - 'null'
      - string
    doc: 'amr_report parameters for testing: -nosame -noblast -skip_hmm_check -bed'
    inputBinding:
      position: 101
      prefix: --parm
  - id: pgap
    type:
      - 'null'
      - boolean
    doc: Input files PROT_FASTA, NUC_FASTA and GFF_FILE are created by the NCBI 
      PGAP
    inputBinding:
      position: 101
      prefix: --pgap
  - id: plus
    type:
      - 'null'
      - boolean
    doc: Add the plus genes to the report
    inputBinding:
      position: 101
      prefix: --plus
  - id: print_node
    type:
      - 'null'
      - boolean
    doc: Print hierarchy node (family)
    inputBinding:
      position: 101
      prefix: --print_node
  - id: protein_fasta
    type:
      - 'null'
      - File
    doc: Input protein FASTA file (can be gzipped)
    inputBinding:
      position: 101
      prefix: --protein
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress messages to STDERR
    inputBinding:
      position: 101
      prefix: --quiet
  - id: report_all_equal
    type:
      - 'null'
      - boolean
    doc: Report all equally-scoring BLAST and HMM matches
    inputBinding:
      position: 101
      prefix: --report_all_equal
  - id: report_common
    type:
      - 'null'
      - boolean
    doc: Report proteins common to a taxonomy group
    inputBinding:
      position: 101
      prefix: --report_common
  - id: threads
    type:
      - 'null'
      - int
    doc: Max. number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: translation_table
    type:
      - 'null'
      - int
    doc: NCBI genetic code for translated BLAST
    inputBinding:
      position: 101
      prefix: --translation_table
  - id: update
    type:
      - 'null'
      - boolean
    doc: Update the AMRFinder database
    inputBinding:
      position: 101
      prefix: --update
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to OUTPUT_FILE instead of STDOUT
    outputBinding:
      glob: $(inputs.output_file)
  - id: protein_output
    type:
      - 'null'
      - File
    doc: Output protein FASTA file of reported proteins
    outputBinding:
      glob: $(inputs.protein_output)
  - id: nucleotide_output
    type:
      - 'null'
      - File
    doc: Output nucleotide FASTA file of reported nucleotide sequences
    outputBinding:
      glob: $(inputs.nucleotide_output)
  - id: nucleotide_flank5_output
    type:
      - 'null'
      - File
    doc: Output nucleotide FASTA file of reported nucleotide sequences with 5' 
      flanking sequences
    outputBinding:
      glob: $(inputs.nucleotide_flank5_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-amrfinderplus:4.2.7--hf69ffd2_0
