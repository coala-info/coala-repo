cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylocsf++
  - score-msa
label: phylocsfpp_score-msa
doc: "Computes PhyloCSF scores and confidence scores for whole alignments in MAF files. Output is written to bed file(s). Optionally the ancestral sequence composition score can be computed as well. Only one forward frame is computed, i.e., for other frames reverse the alignments and/or remove the first one or two bases.\n\nTool homepage: https://github.com/cpockrandt/PhyloCSFpp"
inputs:
  - id: strategy
    type:
      - 'null'
      - string
    doc: "PhyloCSF scoring algorithm: MLE, FIXED or OMEGA. Default: MLE"
    inputBinding:
      position: 1
      prefix: "--strategy"
  - id: comp_phylo
    type:
      - 'null'
      - int
    doc: "Compute the PhyloCSF score for each alignment (0 or 1). Default: 1"
    inputBinding:
      position: 1
      prefix: "--comp-phylo"
  - id: comp_anc
    type:
      - 'null'
      - int
    doc: "Compute the ancestral sequence composition score (0 or 1; only in MLE and FIXED mode). Default: 0"
    inputBinding:
      position: 1
      prefix: "--comp-anc"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Parallelize scoring of multiple MSAs in a file. Default: 20"
    inputBinding:
      position: 1
      prefix: "--threads"
  - id: output
    type: string
    doc: "Directory where the scores will be written to. If it does not exist, it will be created."
    inputBinding:
      position: 1
      prefix: "--output"
  - id: mapping
    type:
      - 'null'
      - File
    doc: "If the MSAs don't use common species names (like Human, Chimp, etc.) you can pass a two-column tsv file with a name mapping."
    inputBinding:
      position: 1
      prefix: "--mapping"
  - id: species
    type:
      - 'null'
      - string
    doc: "Comma separated list of species to reduce <model> to a subset of species to improve running time, e.g., \"Human,Chimp,Seaturtle\""
    inputBinding:
      position: 1
      prefix: "--species"
  - id: genome_length
    type:
      - 'null'
      - int
    doc: "Total genome length (needed for --output-phylo)."
    inputBinding:
      position: 1
      prefix: "--genome-length"
  - id: coding_exons
    type:
      - 'null'
      - File
    doc: "BED-like file (chrom name, strand, phase, start, end) with coordinates of coding exons (needed for --output-phylo)."
    inputBinding:
      position: 1
      prefix: "--coding-exons"
  - id: model
    type: string
    doc: "Path to parameter files, or one of the predefined models: 21mosquitoes, 58mammals, 7yeast, 29mammals, 53birds, 49birds, 100vertebrates, 23flies, 12flies, 26worms, 20flies."
    inputBinding:
      position: 2
  - id: alignments
    type:
      type: array
      items: File
    doc: "One or more files containing multiple sequence alignments. Formats: MAF and multi FASTA. Multiple MSAs can be stored in a single file separated by empty lines."
    inputBinding:
      position: 3
outputs:
  - id: scores
    type:
      - 'null'
      - Directory
    doc: "Scores in BED-like files"
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
stdout: phylocsfpp_score-msa.out
