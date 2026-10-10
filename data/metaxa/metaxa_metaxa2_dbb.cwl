cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2_dbb
label: metaxa_metaxa2_dbb
doc: "Metaxa2 Database Builder builds a Metaxa2 classification database (HMM profiles and BLAST database) from reference sequences of a gene.\n\nTool homepage: http://microbiology.se/software/metaxa2/"
inputs:
  - id: output_directory
    type: string
    doc: "Directory name for the output files"
    inputBinding:
      position: 101
      prefix: -o
  - id: input_file
    type: ['null', File]
    doc: "DNA FASTA file with the reference sequences of a single gene to be used for classification (overrides the per-origin inputs below)"
    inputBinding:
      position: 101
      prefix: -i
  - id: gene_name
    type: ['null', string]
    doc: "Gene name for the database"
    inputBinding:
      position: 101
      prefix: -g
  - id: hmm_directory
    type: ['null', Directory]
    doc: "Use HMMs from this directory instead of computing new ones (only build a new classification database)"
    inputBinding:
      position: 101
      prefix: -p
  - id: taxonomy_file
    type: ['null', File]
    doc: "Taxonomy file in Metaxa2, FASTA, ASN1, NCBI XML or INSD XML format"
    inputBinding:
      position: 101
      prefix: -t
  - id: representative_sequence
    type: ['null', string]
    doc: "ID of the sequence used as the representative sequence of the gene; default is the first sequence in the input file"
    inputBinding:
      position: 101
      prefix: -r
  - id: auto_rep
    type: ['null', boolean]
    doc: "Choose a reference sequence automatically, requires Usearch (T or F), default T"
    inputBinding:
      position: 101
      prefix: --auto_rep
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: cpu
    type: ['null', int]
    doc: "Number of CPUs to use, default 1"
    inputBinding:
      position: 101
      prefix: --cpu
  - id: save_raw
    type: ['null', boolean]
    doc: "Keep intermediate files after the program finishes (T or F), default F"
    inputBinding:
      position: 101
      prefix: --save_raw
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: plus
    type: ['null', boolean]
    doc: "Use BLAST+ instead of legacy BLAST (T or F), default F"
    inputBinding:
      position: 101
      prefix: --plus
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: archaeal_file
    type: ['null', File]
    doc: "DNA FASTA file with archaeal reference sequences (cannot be combined with -i)"
    inputBinding:
      position: 101
      prefix: -a
  - id: bacterial_file
    type: ['null', File]
    doc: "DNA FASTA file with bacterial reference sequences (cannot be combined with -i)"
    inputBinding:
      position: 101
      prefix: -b
  - id: chloroplast_file
    type: ['null', File]
    doc: "DNA FASTA file with chloroplast reference sequences (cannot be combined with -i)"
    inputBinding:
      position: 101
      prefix: -c
  - id: eukaryote_file
    type: ['null', File]
    doc: "DNA FASTA file with eukaryote reference sequences (cannot be combined with -i)"
    inputBinding:
      position: 101
      prefix: -e
  - id: mitochondrial_file
    type: ['null', File]
    doc: "DNA FASTA file with mitochondrial reference sequences (cannot be combined with -i)"
    inputBinding:
      position: 101
      prefix: -m
  - id: metazoan_mitochondrial_file
    type: ['null', File]
    doc: "DNA FASTA file with metazoan mitochondrial reference sequences (cannot be combined with -i)"
    inputBinding:
      position: 101
      prefix: -n
  - id: other_file
    type: ['null', File]
    doc: "DNA FASTA file with reference sequences of other origins (cannot be combined with -i)"
    inputBinding:
      position: 101
      prefix: --other
  - id: full_length
    type: ['null', int]
    doc: "Number of basepairs for the full-length definition, zero disables full-length extraction, default 100"
    inputBinding:
      position: 101
      prefix: --full_length
  - id: conservation_cutoff
    type: ['null', int]
    doc: "Conservation score cutoff, default 4, not used unless -A is F"
    inputBinding:
      position: 101
      prefix: -C
  - id: noise_cutoff
    type: ['null', float]
    doc: "Noise cutoff (minimal proportion of sequences required at each position), 0 to 1, default 0.1"
    inputBinding:
      position: 101
      prefix: -N
  - id: auto_detect_cutoff
    type: ['null', boolean]
    doc: "Auto-detect the conservation score cutoff (T or F), default T"
    inputBinding:
      position: 101
      prefix: -A
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: min_conserved_proportion
    type: ['null', float]
    doc: "Minimal conserved proportion of the alignment, default 0.6"
    inputBinding:
      position: 101
      prefix: -P
  - id: look_ahead_length
    type: ['null', int]
    doc: "Look-ahead length when determining the start and end of conserved regions, default 5"
    inputBinding:
      position: 101
      prefix: -L
  - id: min_conserved_region_length
    type: ['null', int]
    doc: "Minimal conserved region length, default 20"
    inputBinding:
      position: 101
      prefix: -M
  - id: single_profile
    type: ['null', boolean]
    doc: "Build only one single HMM for the entire alignment (T or F), default F"
    inputBinding:
      position: 101
      prefix: --single_profile
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: mode
    type: ['null', string]
    doc: "Mode in which the profile database is built (divergent, conserved, hybrid), default divergent"
    inputBinding:
      position: 101
      prefix: --mode
  - id: dereplicate
    type: ['null', string]
    doc: "Dereplicate the input with Usearch at this identity threshold (ratio), or F; default F"
    inputBinding:
      position: 101
      prefix: --dereplicate
  - id: filter_uncultured
    type: ['null', boolean]
    doc: "Filter out sequences derived from uncultured species (T or F), default F"
    inputBinding:
      position: 101
      prefix: --filter_uncultured
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: filter_level
    type: ['null', int]
    doc: "Filter out sequences with taxonomic information lower than this level, default 0"
    inputBinding:
      position: 101
      prefix: --filter_level
  - id: correct_taxonomy
    type: ['null', boolean]
    doc: "Correct the taxonomic information at order, family, genus and species level (T or F), default F"
    inputBinding:
      position: 101
      prefix: --correct_taxonomy
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: cutoffs
    type: ['null', string]
    doc: "String of numbers with the cutoffs at the different taxonomic levels; turns off automatic calculation"
    inputBinding:
      position: 101
      prefix: --cutoffs
  - id: sample
    type: ['null', int]
    doc: "Number of sequences to investigate when determining taxonomic cutoffs, default 1000"
    inputBinding:
      position: 101
      prefix: --sample
  - id: evaluate
    type: ['null', boolean]
    doc: "Statistically evaluate the performance of the database built; slow (T or F), default F"
    inputBinding:
      position: 101
      prefix: --evaluate
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: iterations
    type: ['null', int]
    doc: "Number of iterations for the statistical evaluation, default 10"
    inputBinding:
      position: 101
      prefix: --iterations
  - id: test_sets
    type: ['null', string]
    doc: "Proportion of sequences to leave out for testing; several values separated by commas, default 0.1"
    inputBinding:
      position: 101
      prefix: --test_sets
  - id: db_eval
    type: ['null', Directory]
    doc: "Skip building the database and only run the evaluation on this database"
    inputBinding:
      position: 101
      prefix: --db
outputs:
  - id: output_directory_dir
    type: Directory
    doc: "Directory with the database files"
    outputBinding:
      glob: $(inputs.output_directory)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
stdout: metaxa_metaxa2_dbb.out
