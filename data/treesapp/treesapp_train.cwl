cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesapp_train
label: treesapp_train
doc: "Model evolutionary distances across taxonomic ranks.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: An input file containing DNA or protein sequences in either FASTA or 
      FASTQ format
    inputBinding:
      position: 1
  - id: refpkg_paths
    type:
      type: array
      items: File
    doc: Path to the reference package pickle (.pkl) file.
    inputBinding:
      position: 2
  - id: accession_to_lineage_file
    type:
      - 'null'
      - File
    doc: Path to a file that maps sequence accessions to taxonomic lineages, 
      possibly made by `treesapp create`...
    inputBinding:
      position: 103
      prefix: --accession2lin
  - id: accession_to_taxid_file
    type:
      - 'null'
      - File
    doc: Path to an NCBI accession2taxid file for more rapid 
      accession-to-lineage mapping.
    inputBinding:
      position: 103
      prefix: --accession2taxid
  - id: annot_map_file
    type:
      - 'null'
      - File
    doc: Path to a tabular file mapping reference (refpkg) package names being 
      tested to database corresponding sequence names, indicating a true 
      positive relationship. First column is the refpkg name, second is the 
      orthologous group name and third is the query sequence name.
    inputBinding:
      position: 103
      prefix: --annot_map
  - id: classifier_type
    type:
      - 'null'
      - string
    doc: 'Specify the kind of classifier to be trained: one-class classifier (OCC)
      or a binary classifier (bin).'
    inputBinding:
      position: 103
      prefix: --classifier
  - id: delete_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Delete all intermediate files to save disk space.
    inputBinding:
      position: 103
      prefix: --delete
  - id: grid_search
    type:
      - 'null'
      - boolean
    doc: Perform a grid search across hyperparameters. Binary classifier only.
    inputBinding:
      position: 103
      prefix: --grid_search
  - id: max_examples
    type:
      - 'null'
      - int
    doc: Limits the number of examples used for training models.
    inputBinding:
      position: 103
      prefix: --max_examples
  - id: min_seq_length
    type:
      - 'null'
      - int
    doc: minimal sequence length after alignment trimming
    inputBinding:
      position: 103
      prefix: --min_seq_length
  - id: molecule_type
    type:
      - 'null'
      - string
    doc: Type of input sequences (prot = protein; dna = nucleotide; rrna = 
      rRNA). TreeSAPP will guess by default but this may be required if 
      ambiguous.
    inputBinding:
      position: 103
      prefix: --molecule
  - id: num_threads
    type:
      - 'null'
      - int
    doc: The number of CPU threads or parallel processes to use in various 
      pipeline steps
    inputBinding:
      position: 103
      prefix: --num_procs
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrites previously written output files and directories
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: profile_hmm
    type:
      - 'null'
      - boolean
    doc: Input sequences will be purified with the reference package's profile 
      HMM.
    inputBinding:
      position: 103
      prefix: --profile
  - id: seqs_to_lineage_file
    type:
      - 'null'
      - File
    doc: Path to a file mapping sequence names to taxonomic lineages.
    inputBinding:
      position: 103
      prefix: --seqs2lineage
  - id: stage
    type:
      - 'null'
      - string
    doc: The stage(s) for TreeSAPP to execute
    inputBinding:
      position: 103
      prefix: --stage
  - id: svm_kernel
    type:
      - 'null'
      - string
    doc: Specifies the kernel type to be used in the SVM algorithm. It must be 
      either 'lin' 'poly' or 'rbf'.
    inputBinding:
      position: 103
      prefix: --svm_kernel
  - id: taxonomic_ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of the taxonomic ranks (space-separated) to test.
      - class
      - species
    inputBinding:
      position: 103
      prefix: --taxonomic_ranks
  - id: trim_align
    type:
      - 'null'
      - boolean
    doc: Flag to turn on position masking of the multiple sequence alignment
    inputBinding:
      position: 103
      prefix: --trim_align
  - id: tsne
    type:
      - 'null'
      - boolean
    doc: Generate a tSNE plot. Output will be in the same directory as the model
      file. Binary classifier only.
    inputBinding:
      position: 103
      prefix: --tsne
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints a more verbose runtime log
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to an output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
