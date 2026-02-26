cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2_dbb
label: metaxa_metaxa2_dbb
doc: "Metaxa2 Database Builder - builds a classification database for Metaxa2 from
  reference sequences and taxonomic information.\n\nTool homepage: http://microbiology.se/software/metaxa2/"
inputs:
  - id: archaeal_file
    type:
      - 'null'
      - File
    doc: DNA FASTA file containing archaeal reference sequences to be used for 
      classification (cannot be combined with the -i option)
    inputBinding:
      position: 101
      prefix: -a
  - id: auto_detect_cutoff
    type:
      - 'null'
      - boolean
    doc: Auto-detect conservation score cutoff, on (T) by default
    default: true
    inputBinding:
      position: 101
      prefix: -A
  - id: auto_rep
    type:
      - 'null'
      - boolean
    doc: Choose a reference sequence automatically (requires Usearch to be 
      installed), on (T) by default
    default: true
    inputBinding:
      position: 101
      prefix: --auto_rep
  - id: bacterial_file
    type:
      - 'null'
      - File
    doc: DNA FASTA file containing bacterial reference sequences to be used for 
      classification (cannot be combined with the -i option)
    inputBinding:
      position: 101
      prefix: -b
  - id: chloroplast_file
    type:
      - 'null'
      - File
    doc: DNA FASTA file containing chloroplast reference sequences to be used 
      for classification (cannot be combined with the -i option)
    inputBinding:
      position: 101
      prefix: -c
  - id: conservation_cutoff
    type:
      - 'null'
      - int
    doc: Conservation score cutoff, not used unless -A is set to false (F)
    default: 4
    inputBinding:
      position: 101
      prefix: -C
  - id: correct_taxonomy
    type:
      - 'null'
      - boolean
    doc: Will try to correct the taxonomic information at order, family, genus 
      and species level, off (F) by default
    default: false
    inputBinding:
      position: 101
      prefix: --correct_taxonomy
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to use (will be passed on to other programs)
    default: 1
    inputBinding:
      position: 101
      prefix: --cpu
  - id: cutoffs
    type:
      - 'null'
      - string
    doc: A string of number defining the cutoffs at different taxonomic levels. 
      Will turn off automatic calculation of cutoffs.
    inputBinding:
      position: 101
      prefix: --cutoffs
  - id: db_eval
    type:
      - 'null'
      - Directory
    doc: Skips building the database, and only runs the evaluation on the 
      specified database, not used by default
    inputBinding:
      position: 101
      prefix: --db
  - id: dereplicate
    type:
      - 'null'
      - string
    doc: Will dereplicate the input data using Usearch before building the 
      database, using the specified identity threshold or off (F)
    default: F
    inputBinding:
      position: 101
      prefix: --dereplicate
  - id: eukaryote_file
    type:
      - 'null'
      - File
    doc: DNA FASTA file containing eukaryote reference sequences to be used for 
      classification (cannot be combined with the -i option)
    inputBinding:
      position: 101
      prefix: -e
  - id: evaluate
    type:
      - 'null'
      - boolean
    doc: Statistically evaluate the performance of the database built. This 
      increases the time requirement for the process dramatically, off (F) by 
      default
    default: false
    inputBinding:
      position: 101
      prefix: --evaluate
  - id: filter_level
    type:
      - 'null'
      - int
    doc: Will filter out sequences with taxonomic information lower than the 
      specified level
    default: 0
    inputBinding:
      position: 101
      prefix: --filter_level
  - id: filter_uncultured
    type:
      - 'null'
      - boolean
    doc: Will try to filter out sequences that are derived from uncultured 
      species, off (F) by default
    default: false
    inputBinding:
      position: 101
      prefix: --filter_uncultured
  - id: full_length
    type:
      - 'null'
      - int
    doc: number of basepairs to use for full-length definition (set to zero to 
      disable full-length extraction)
    default: 100
    inputBinding:
      position: 101
      prefix: --full_length
  - id: gene_name
    type:
      - 'null'
      - string
    doc: Gene name for the database
    inputBinding:
      position: 101
      prefix: -g
  - id: hmm_directory
    type:
      - 'null'
      - Directory
    doc: Use HMMs from the specified directory instead of computing new ones 
      (i.e. only build a new classification database), not used by default
    inputBinding:
      position: 101
      prefix: -p
  - id: input_file
    type: File
    doc: DNA FASTA file containing the reference sequences of a single gene to 
      be used for classification (overrides specific input options below)
    inputBinding:
      position: 101
      prefix: -i
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of iterations for the statistical evaluation
    default: 10
    inputBinding:
      position: 101
      prefix: --iterations
  - id: look_ahead_length
    type:
      - 'null'
      - int
    doc: Look-ahead length (the number of residues to consider when determining 
      the start and end of conserved regions)
    default: 5
    inputBinding:
      position: 101
      prefix: -L
  - id: metazoan_mitochondrial_file
    type:
      - 'null'
      - File
    doc: DNA FASTA file containing metazoan mitochondrial reference sequences to
      be used for classification (cannot be combined with the -i option)
    inputBinding:
      position: 101
      prefix: -n
  - id: min_conserved_proportion
    type:
      - 'null'
      - float
    doc: Minimal conserved proportion of the alignment (until a lower 
      conservation cutoff is considered)
    default: 0.6
    inputBinding:
      position: 101
      prefix: -P
  - id: min_conserved_region_length
    type:
      - 'null'
      - int
    doc: Minimal conserved region length
    default: 20
    inputBinding:
      position: 101
      prefix: -M
  - id: mitochondrial_file
    type:
      - 'null'
      - File
    doc: DNA FASTA file containing mitochondrial reference sequences to be used 
      for classification (cannot be combined with the -i option)
    inputBinding:
      position: 101
      prefix: -m
  - id: mode
    type:
      - 'null'
      - string
    doc: Selects the mode in which the profile database is built (divergent, 
      conserved, hybrid)
    default: divergent
    inputBinding:
      position: 101
      prefix: --mode
  - id: noise_cutoff
    type:
      - 'null'
      - float
    doc: Noise cutoff (minimal proportion of sequences required to be considered
      at each position). A number between 0 and 1
    default: 0.1
    inputBinding:
      position: 101
      prefix: -N
  - id: other_file
    type:
      - 'null'
      - File
    doc: DNA FASTA file containing reference sequences of other origins to be 
      used for classification (cannot be combined with the -i option)
    inputBinding:
      position: 101
      prefix: --other
  - id: plus
    type:
      - 'null'
      - boolean
    doc: Use BLAST+ instead of legacy BLAST, off (F) by default
    default: false
    inputBinding:
      position: 101
      prefix: --plus
  - id: representative_sequence
    type:
      - 'null'
      - string
    doc: ID of the sequence that should be used as the representative sequence 
      of the gene; if blank, the first sequence in the input file is used
    inputBinding:
      position: 101
      prefix: -r
  - id: sample
    type:
      - 'null'
      - int
    doc: The number of sequences to aim to investigate when determining 
      taxonomic cutoffs
    default: 1000
    inputBinding:
      position: 101
      prefix: --sample
  - id: save_raw
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files after the program finishes, off (F) by default
    default: false
    inputBinding:
      position: 101
      prefix: --save_raw
  - id: single_profile
    type:
      - 'null'
      - boolean
    doc: Build only one single HMM for the entire alignment from the input 
      sequences, off (F) by default
    default: false
    inputBinding:
      position: 101
      prefix: --single_profile
  - id: taxonomy_file
    type:
      - 'null'
      - File
    doc: 'Taxonomy file containing taxonomic information to be parsed in any of the
      following formats: Metaxa2, FASTA, ASN1, NCBI XML, INSD XML'
    inputBinding:
      position: 101
      prefix: -t
  - id: test_sets
    type:
      - 'null'
      - type: array
        items: string
    doc: Proportion of sequences to leave out for testing. Several values can be
      specified, separated by commas
    default: '0.1'
    inputBinding:
      position: 101
      prefix: --test_sets
outputs:
  - id: output_directory
    type: Directory
    doc: Directory name for the output files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
