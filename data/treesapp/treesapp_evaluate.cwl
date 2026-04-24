cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesapp evaluate
label: treesapp_evaluate
doc: "Evaluate classification performance using clade-exclusion analysis.\n\nTool
  homepage: https://github.com/hallamlab/TreeSAPP"
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
  - id: accession2lin_file
    type:
      - 'null'
      - File
    doc: Path to a file that maps sequence accessions to taxonomic lineages, 
      possibly made by `treesapp create`...
    inputBinding:
      position: 103
      prefix: --accession2lin
  - id: accession2taxid_file
    type:
      - 'null'
      - File
    doc: Path to an NCBI accession2taxid file for more rapid 
      accession-to-lineage mapping.
    inputBinding:
      position: 103
      prefix: --accession2taxid
  - id: classification_tool
    type:
      - 'null'
      - string
    doc: 'Classify using one of the tools: treesapp [DEFAULT], graftm, or diamond.'
    inputBinding:
      position: 103
      prefix: --tool
  - id: delete_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Delete all intermediate files to save disk space.
    inputBinding:
      position: 103
      prefix: --delete
  - id: execution_stage
    type:
      - 'null'
      - string
    doc: The stage(s) for TreeSAPP to execute
    inputBinding:
      position: 103
      prefix: --stage
  - id: fresh
    type:
      - 'null'
      - boolean
    doc: Recalculate a fresh phylogenetic tree with the target clades removed 
      instead of removing the leaves corresponding to targets from the reference
      tree.
    inputBinding:
      position: 103
      prefix: --fresh
  - id: max_evol_distance
    type:
      - 'null'
      - float
    doc: The maximum total evolutionary distance between a query and 
      reference(s), beyond which EPA placements are unclassified.
    inputBinding:
      position: 103
      prefix: --max_evol_distance
  - id: max_pendant_length
    type:
      - 'null'
      - float
    doc: The maximum pendant length distance threshold, beyond which EPA 
      placements are unclassified.
    inputBinding:
      position: 103
      prefix: --max_pendant_length
  - id: min_like_weight_ratio
    type:
      - 'null'
      - float
    doc: The minimum likelihood weight ratio required for an EPA placement.
    inputBinding:
      position: 103
      prefix: --min_like_weight_ratio
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
  - id: placement_summary
    type:
      - 'null'
      - string
    doc: Controls the algorithm for consolidating multiple phylogenetic 
      placements. Max LWR will take use the phylogenetic placement with greatest
      LWR. aELW uses the taxon with greatest accumulated LWR across placements.
    inputBinding:
      position: 103
      prefix: --placement_summary
  - id: slice_length
    type:
      - 'null'
      - int
    doc: Arbitrarily slice the input sequences to this length. Useful for 
      testing classification accuracy for fragments.
    inputBinding:
      position: 103
      prefix: --length
  - id: taxonomic_ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of the taxonomic ranks (space-separated) to test.
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
