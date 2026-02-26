cwlVersion: v1.2
class: CommandLineTool
baseCommand: coregenebuilder
label: coregenebuilder
doc: "CoreGeneBuilder extracts a core genome or a persistent genome from a set of
  bacterial genomes. The core genome is the set of homologous genes (protein families)
  shared by all genomes. The persistent genome is the set of homologous genes (protein
  families) shared by less than 100% of the genomes.\n\nTool homepage: https://github.com/C3BI-pasteur-fr/CoreGeneBuilder"
inputs:
  - id: contig_id_prefix
    type:
      - 'null'
      - string
    doc: "prefix string of contig ids found in the reference genome fasta and genbank
      files (eg id in fields LOCUS and ACCESSION of genbank file) (ex : 'NC_'; 'NZ_'
      ; 'AKAC' ; etc)"
    inputBinding:
      position: 101
      prefix: -e
  - id: core_genes_presence_percent
    type:
      - 'null'
      - int
    doc: "core genes are present at least in p% of the genomes (default : 95) -- if
      '-p 100' is supplied, core gene set is output; else if 'p' is lower than 100,
      persistent gene set is output"
    default: 95
    inputBinding:
      position: 101
      prefix: -p
  - id: cut_n_mers
    type:
      - 'null'
      - int
    doc: "cut sequences with mers of 'N' of size '-N' (scaffolds) into contigs (default
      : 10); if -1, no filter"
    default: 10
    inputBinding:
      position: 101
      prefix: -N
  - id: filter_max_sequences
    type:
      - 'null'
      - int
    doc: 'filtering out genomes having number of sequences above this value (default
      : -1); if -1, no filter'
    default: -1
    inputBinding:
      position: 101
      prefix: -c
  - id: filter_min_n50
    type:
      - 'null'
      - int
    doc: 'filtering out genomes having N50 below this N50 value (bp) (default : 0);
      if 0, no filter'
    default: 0
    inputBinding:
      position: 101
      prefix: -y
  - id: filter_min_seq_length
    type:
      - 'null'
      - int
    doc: 'filtering out genomic sequences below this length value (bp) (default :
      500); if 0, no filter'
    default: 500
    inputBinding:
      position: 101
      prefix: -f
  - id: input_directory
    type: Directory
    doc: directory where are stored input and output files, it must contain at 
      least a directory called assemblies where are genomic sequence fasta files
    inputBinding:
      position: 101
      prefix: -d
  - id: name_of_4_chars
    type: string
    doc: 'four letter name (ex : esco (es:escherichia; co:coli))'
    inputBinding:
      position: 101
      prefix: -n
  - id: num_genomes_for_core
    type:
      - 'null'
      - int
    doc: 'number of genomes to select for core genome construction (default : -1);
      if -1, no selection (all genomes are kept)'
    default: -1
    inputBinding:
      position: 101
      prefix: -s
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'number of threads used during diversity and annotation steps (default :
      1)'
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: protein_length_ratio
    type:
      - 'null'
      - float
    doc: 'protein length ratio (default : 1.2) -- core genome construction step'
    default: 1.2
    inputBinding:
      position: 101
      prefix: -l
  - id: reference_genome_fasta
    type:
      - 'null'
      - File
    doc: reference genome fasta file -- annotation and core genome construction 
      steps
    inputBinding:
      position: 101
      prefix: -g
  - id: reference_genome_genbank
    type:
      - 'null'
      - File
    doc: reference genome genbank file -- annotation step
    inputBinding:
      position: 101
      prefix: -a
  - id: remove_previous_files
    type:
      - 'null'
      - int
    doc: 'if 1, remove files from precedent run of this pipeline inside directory
      <input_directory> (default : 0)'
    default: 0
    inputBinding:
      position: 101
      prefix: -r
  - id: similarity_percent
    type:
      - 'null'
      - int
    doc: 'similarity percent (default : 80) -- core genome construction step'
    default: 80
    inputBinding:
      position: 101
      prefix: -i
  - id: steps_to_run
    type:
      - 'null'
      - string
    doc: "steps to run ; ex : '-z DAC' or '-z DA' or '-z D' ; D : diversity - A :
      annotation - C : coregenome (default: DAC)"
    default: DAC
    inputBinding:
      position: 101
      prefix: -z
  - id: synteny_radius
    type:
      - 'null'
      - int
    doc: 'synteny - radius size around each analyzed homologous gene (a number of
      genes) (default : 5) -- window_size=(radius_size * 2 + 1)'
    default: 5
    inputBinding:
      position: 101
      prefix: -R
  - id: synteny_threshold
    type:
      - 'null'
      - int
    doc: 'synteny - synteny threshold : minimal number of syntenic genes found in
      the neighborhood of a given homologous gene, the boundaries of explored neighborood
      are defined by window size (option -R); (default : 4); if 0, no synteny criteria
      is applied'
    default: 4
    inputBinding:
      position: 101
      prefix: -S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/coregenebuilder:v1.0_cv2
stdout: coregenebuilder.out
