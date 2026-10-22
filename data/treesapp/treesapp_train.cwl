cwlVersion: v1.2
class: CommandLineTool
baseCommand: [treesapp, train]
label: treesapp_train
doc: "Model evolutionary distances across taxonomic ranks.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: fastx_input
    type:
      type: array
      items: File
    doc: "Input file(s) containing DNA or protein sequences in FASTA or FASTQ format"
    inputBinding:
      position: 101
      prefix: --fastx_input
  - id: refpkg_path
    type:
      type: array
      items: File
    doc: "Path to the reference package pickle (.pkl) file(s)."
    inputBinding:
      position: 101
      prefix: --refpkg_path
  - id: profile
    type:
      - 'null'
      - boolean
    doc: "Input sequences will be purified with the reference package's profile HMM."
    inputBinding:
      position: 101
      prefix: --profile
  - id: output
    type:
      - 'null'
      - string
    doc: "Path to an output directory [DEFAULT = ./output/]"
    default: output
    inputBinding:
      position: 101
      prefix: --output
  - id: trim_align
    type:
      - 'null'
      - boolean
    doc: "Flag to turn on position masking of the multiple sequence alignment"
    inputBinding:
      position: 101
      prefix: --trim_align
  - id: min_seq_length
    type:
      - 'null'
      - int
    doc: "Minimal sequence length after alignment trimming [DEFAULT = 0]"
    inputBinding:
      position: 101
      prefix: --min_seq_length
  - id: molecule
    type:
      - 'null'
      - string
    doc: "Type of input sequences: prot, dna or rrna. TreeSAPP guesses by default."
    inputBinding:
      position: 101
      prefix: --molecule
  - id: annot_map
    type:
      - 'null'
      - File
    doc: "Tabular file mapping reference package names to database sequence names (true positives): refpkg name, orthologous group, query sequence name."
    inputBinding:
      position: 101
      prefix: --annot_map
  - id: accession2taxid
    type:
      - 'null'
      - File
    doc: "Path to an NCBI accession2taxid file for more rapid accession-to-lineage mapping."
    inputBinding:
      position: 101
      prefix: --accession2taxid
  - id: accession2lin
    type:
      - 'null'
      - File
    doc: "Path to a file that maps sequence accessions to taxonomic lineages, possibly made by `treesapp create`."
    inputBinding:
      position: 101
      prefix: --accession2lin
  - id: seqs2lineage
    type:
      - 'null'
      - File
    doc: "Path to a file mapping sequence names to taxonomic lineages."
    inputBinding:
      position: 101
      prefix: --seqs2lineage
  - id: taxonomic_ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: "Taxonomic ranks (space-separated) to test: domain, phylum, class, order, family, genus, species. [ DEFAULT = class species ]"
    inputBinding:
      position: 101
      prefix: --taxonomic_ranks
  - id: svm_kernel
    type:
      - 'null'
      - string
    doc: "Kernel type to be used in the SVM algorithm: lin, poly or rbf. [ DEFAULT = lin ]"
    inputBinding:
      position: 101
      prefix: --svm_kernel
  - id: max_examples
    type:
      - 'null'
      - int
    doc: "Limits the number of examples used for training models. [ DEFAULT = 1000 ]"
    inputBinding:
      position: 101
      prefix: --max_examples
  - id: grid_search
    type:
      - 'null'
      - boolean
    doc: "Perform a grid search across hyperparameters. Binary classifier only."
    inputBinding:
      position: 101
      prefix: --grid_search
  - id: tsne
    type:
      - 'null'
      - boolean
    doc: "Generate a tSNE plot. Binary classifier only."
    inputBinding:
      position: 101
      prefix: --tsne
  - id: classifier
    type:
      - 'null'
      - string
    doc: "Kind of classifier to train: occ (one-class) or bin (binary). [ DEFAULT = occ ]"
    inputBinding:
      position: 101
      prefix: --classifier
  - id: stage
    type:
      - 'null'
      - string
    doc: "The stage(s) to execute: continue, clean, search, lineages, place, train or update. [DEFAULT = continue]"
    inputBinding:
      position: 101
      prefix: --stage
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrites previously written output files and directories"
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Prints a more verbose runtime log"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: delete
    type:
      - 'null'
      - boolean
    doc: "Delete all intermediate files to save disk space."
    inputBinding:
      position: 101
      prefix: --delete
  - id: num_procs
    type:
      - 'null'
      - int
    doc: "The number of CPU threads or parallel processes to use in various pipeline steps [ DEFAULT = 2 ]"
    inputBinding:
      position: 101
      prefix: --num_procs
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Training output directory"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
