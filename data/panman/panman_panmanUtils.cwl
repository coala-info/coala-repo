cwlVersion: v1.2
class: CommandLineTool
baseCommand: panmanUtils
label: panman_panmanUtils
doc: "Utility tool for PanMAN (Pangenome Mutation Adjacency Network) files, supporting
  construction, conversion, and analysis of pangenome data.\n\nTool homepage: https://github.com/TurakhiaLab/panman"
inputs:
  - id: aa_translation
    type:
      - 'null'
      - boolean
    doc: Extract amino acid translations in TSV file
    inputBinding:
      position: 101
      prefix: --aa-translation
  - id: acr
    type:
      - 'null'
      - string
    doc: ACR method [fitch(default), mppa]
    default: fitch
    inputBinding:
      position: 101
      prefix: --acr
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Annotate nodes of the input PanMAN based on the list provided in the input-file
      (TSV)
    inputBinding:
      position: 101
      prefix: --annotate
  - id: create_network
    type:
      - 'null'
      - type: array
        items: File
    doc: Create PanMAN with network of trees from single or multiple PanMAN files
    inputBinding:
      position: 101
      prefix: --create-network
  - id: end
    type:
      - 'null'
      - int
    doc: End coordinate of protein translation/End coordinate for indexing
    inputBinding:
      position: 101
      prefix: --end
  - id: extended_newick
    type:
      - 'null'
      - boolean
    doc: Print PanMAN's network in extended-newick format
    inputBinding:
      position: 101
      prefix: --extended-newick
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Print tip sequences (FASTA format)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fasta_aligned
    type:
      - 'null'
      - boolean
    doc: Print MSA of sequences for each PanMAT in a PanMAN (FASTA format)
    inputBinding:
      position: 101
      prefix: --fasta-aligned
  - id: gfa
    type:
      - 'null'
      - boolean
    doc: Convert any PanMAT in a PanMAN to a GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: index
    type:
      - 'null'
      - string
    doc: Generating indexes and print sequence (passed as reference) between x:y
    inputBinding:
      position: 101
      prefix: --index
  - id: input_file
    type:
      - 'null'
      - File
    doc: Path to the input file, required for --subnet, --annotate, and --create-network
    inputBinding:
      position: 101
      prefix: --input-file
  - id: input_gfa
    type:
      - 'null'
      - File
    doc: Input GFA file to build a PanMAN
    inputBinding:
      position: 101
      prefix: --input-gfa
  - id: input_msa
    type:
      - 'null'
      - File
    doc: Input MSA file (FASTA format) to build a PanMAN
    inputBinding:
      position: 101
      prefix: --input-msa
  - id: input_newick
    type:
      - 'null'
      - string
    doc: Input tree topology as Newick string
    inputBinding:
      position: 101
      prefix: --input-newick
  - id: input_pangraph
    type:
      - 'null'
      - File
    doc: Input PanGraph JSON file to build a PanMAN
    inputBinding:
      position: 101
      prefix: --input-pangraph
  - id: input_panman
    type:
      - 'null'
      - File
    doc: Input PanMAN file path
    inputBinding:
      position: 101
      prefix: --input-panman
  - id: low_mem_mode
    type:
      - 'null'
      - boolean
    doc: Perform Fitch Algrorithm in batch to save memory consumption
    inputBinding:
      position: 101
      prefix: --low-mem-mode
  - id: maf
    type:
      - 'null'
      - boolean
    doc: Print m-WGA for each PanMAT in a PanMAN (MAF format)
    inputBinding:
      position: 101
      prefix: --maf
  - id: newick
    type:
      - 'null'
      - boolean
    doc: Print newick string of all trees in a PanMAN
    inputBinding:
      position: 101
      prefix: --newick
  - id: print_mutations
    type:
      - 'null'
      - boolean
    doc: Print mutations from root to each node
    inputBinding:
      position: 101
      prefix: --printMutations
  - id: print_tips
    type:
      - 'null'
      - string
    doc: Print PanMAN Tips
    inputBinding:
      position: 101
      prefix: --printTips
  - id: ref_file
    type:
      - 'null'
      - File
    doc: reference sequence file
    inputBinding:
      position: 101
      prefix: --refFile
  - id: reference
    type:
      - 'null'
      - string
    doc: Identifier of reference sequence for PanMAN construction (optional), VCF
      extract (required), or reroot (required)
    inputBinding:
      position: 101
      prefix: --reference
  - id: reroot
    type:
      - 'null'
      - boolean
    doc: Reroot a PanMAT in a PanMAN based on the input sequence id (--reference)
    inputBinding:
      position: 101
      prefix: --reroot
  - id: start
    type:
      - 'null'
      - int
    doc: Start coordinate of protein translation/Start coordinate for indexing
    inputBinding:
      position: 101
      prefix: --start
  - id: subnet
    type:
      - 'null'
      - boolean
    doc: Extract subnet of given PanMAN to a new PanMAN file based on the list of
      nodes provided in the input-file
    inputBinding:
      position: 101
      prefix: --subnet
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Print PanMAN summary
    inputBinding:
      position: 101
      prefix: --summary
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: to_usher
    type:
      - 'null'
      - boolean
    doc: Convert a PanMAT in PanMAN to Usher-MAT
    inputBinding:
      position: 101
      prefix: --toUsher
  - id: tree_id
    type:
      - 'null'
      - string
    doc: Tree ID, required for --vcf
    inputBinding:
      position: 101
      prefix: --treeID
  - id: vcf
    type:
      - 'null'
      - boolean
    doc: Print variations of all sequences from any PanMAT in a PanMAN (VCF format)
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Prefix of the output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panman:0.1.4--hac847a2_0
