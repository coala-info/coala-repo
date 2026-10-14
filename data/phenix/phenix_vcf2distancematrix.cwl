cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phenix.py
  - vcf2distancematrix
label: phenix_vcf2distancematrix
doc: "Combine multiple VCFs into a distance matrix. Distance measures according to five different models are available: number of differences, Jukes-Cantor (jc69), Tajima-Nei (k80), Kimura 2-parameter (tn84) and Tamura 3-parameter (t93).\n\nTool homepage: https://github.com/phe-bioinformatics/PHEnix"
inputs:
  - id: directory
    type:
      - 'null'
      - Directory
    doc: "Path to the directory with .vcf files. Input option 1."
    inputBinding:
      position: 1
      prefix: --directory
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of VCF files to process. Input option 2."
    inputBinding:
      position: 2
      prefix: --input
  - id: alignment_input
    type:
      - 'null'
      - File
    doc: "Multi fasta file with whole genome input alignment. Input option 3."
    inputBinding:
      position: 3
      prefix: --alignment-input
  - id: out
    type: string
    doc: "Path to the matrix output file in given format. [REQUIRED. default format is tab separated. use format to change format]"
    inputBinding:
      position: 4
      prefix: --out
  - id: deletion
    type:
      - 'null'
      - string
    doc: "Method of recombination filtering. Either pairwise or complete [pairwise]"
    inputBinding:
      position: 5
      prefix: --deletion
  - id: substitution
    type:
      - 'null'
      - string
    doc: "Substitution model. Either number_of_differences, jc69, k80, tn84 or t93 [number_of_differences]"
    inputBinding:
      position: 6
      prefix: --substitution
  - id: include
    type:
      - 'null'
      - File
    doc: "Only include positions in BED file in the FASTA"
    inputBinding:
      position: 7
      prefix: --include
  - id: exclude
    type:
      - 'null'
      - File
    doc: "Exclude any positions specified in the BED file."
    inputBinding:
      position: 8
      prefix: --exclude
  - id: remove_recombination
    type:
      - 'null'
      - boolean
    doc: "Attempt to remove recombination from distance matrix. [don't]"
    inputBinding:
      position: 9
      prefix: --remove-recombination
  - id: refgenome
    type:
      - 'null'
      - File
    doc: "Reference genome used for SNP calling [Required for recombination removal]."
    inputBinding:
      position: 10
      prefix: --refgenome
  - id: refgenomename
    type:
      - 'null'
      - string
    doc: "Name of reference genome in input alignment [Required if input option 3 is used and reference is not named reference]."
    inputBinding:
      position: 11
      prefix: --refgenomename
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Density threshold above mean density for relevant pair. [1.0]."
    inputBinding:
      position: 12
      prefix: --threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use. [1]."
    inputBinding:
      position: 13
      prefix: --threads
  - id: format
    type:
      - 'null'
      - string
    doc: "Change format for output file. Available options csv, tsv and mega. [tsv]"
    inputBinding:
      position: 14
      prefix: --format
  - id: tree
    type:
      - 'null'
      - string
    doc: "Make an NJ tree and write it to the given file in newick format. [Default: Don't make tree, only matrix]"
    inputBinding:
      position: 15
      prefix: --tree
  - id: with_stats
    type:
      - 'null'
      - boolean
    doc: "Write additional files with information on removed recombinant SNPs. [don't]"
    inputBinding:
      position: 16
      prefix: --with-stats
outputs:
  - id: matrix
    type:
      - File
    doc: "Distance matrix"
    outputBinding:
      glob: $(inputs.out)
  - id: tree_file
    type:
      - 'null'
      - File
    doc: "Neighbour joining tree in newick format"
    outputBinding:
      glob: $(inputs.tree)
  - id: stats_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Additional files about removed recombinant SNPs (with_stats)"
    outputBinding:
      glob: $(inputs.out).*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
