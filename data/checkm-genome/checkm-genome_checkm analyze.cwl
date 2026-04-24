cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - analyze
label: checkm-genome_checkm analyze
doc: "Identify marker genes in bins and calculate genome statistics.\n\nTool homepage:
  https://github.com/Ecogenomics/CheckM"
inputs:
  - id: marker_file
    type: string
    doc: markers for assessing bins (marker set or HMM file)
    inputBinding:
      position: 1
  - id: bin_input
    type: string
    doc: directory containing bins (fasta format) or path to file describing 
      genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, 
      genome translation file (pep)]
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: directory to write output files
    inputBinding:
      position: 3
  - id: bin_extension
    type:
      - 'null'
      - string
    doc: extension of bins (other files in directory are ignored)
    inputBinding:
      position: 104
      prefix: --extension
  - id: generate_hmmer_alignment
    type:
      - 'null'
      - boolean
    doc: generate HMMER alignment file for each bin
    inputBinding:
      position: 104
      prefix: --ali
  - id: generate_nucleotide_sequences
    type:
      - 'null'
      - boolean
    doc: generate nucleotide gene sequences for each bin
    inputBinding:
      position: 104
      prefix: --nt
  - id: genes_as_amino_acids
    type:
      - 'null'
      - boolean
    doc: bins contain genes as amino acids instead of nucleotide contigs
    inputBinding:
      position: 104
      prefix: --genes
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress console output
    inputBinding:
      position: 104
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify an alternative directory for temporary files
    inputBinding:
      position: 104
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
stdout: checkm-genome_checkm analyze.out
