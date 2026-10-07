cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - tree
label: checkm-genome_tree
doc: "Place bins in the genome tree.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: bin_input
    type:
      - Directory
      - File
    doc: 'directory containing bins (fasta format) or path to file describing
      genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome
      translation file (pep)]'
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    doc: 'directory to write output files'
    inputBinding:
      position: 2
  - id: reduced_tree
    type:
      - 'null'
      - boolean
    doc: 'use reduced tree (requires <16GB of memory) for determining lineage of each
      bin'
    inputBinding:
      position: 101
      prefix: --reduced_tree
  - id: ali
    type:
      - 'null'
      - boolean
    doc: 'generate HMMER alignment file for each bin'
    inputBinding:
      position: 101
      prefix: --ali
  - id: nt
    type:
      - 'null'
      - boolean
    doc: 'generate nucleotide gene sequences for each bin'
    inputBinding:
      position: 101
      prefix: --nt
  - id: genes
    type:
      - 'null'
      - boolean
    doc: 'bins contain genes as amino acids instead of nucleotide contigs'
    inputBinding:
      position: 101
      prefix: --genes
  - id: extension
    type:
      - 'null'
      - string
    doc: 'extension of bins (other files in directory are ignored) (default: fna)'
    inputBinding:
      position: 101
      prefix: --extension
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: pplacer_threads
    type:
      - 'null'
      - int
    doc: 'number of threads used by pplacer (memory usage increases linearly with
      additional threads) (default: 1)'
    inputBinding:
      position: 101
      prefix: --pplacer_threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'suppress console output'
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: 'specify an alternative directory for temporary files'
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: output_dir_out
    type: Directory
    doc: 'directory to write output files'
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
