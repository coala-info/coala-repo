cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylocsf++
  - build-tracks
label: phylocsfpp_build-tracks
doc: "Computes PhyloCSF tracks for each codon and all 6 frames from alignment files in MAF format as well as the power track containing the branch length scores (confidence of the PhyloCSF scores). Optionally the PhyloCSF scores can be smoothened and posterior probabilities can be computed. Outputs wig files.\n\nTool homepage: https://github.com/cpockrandt/PhyloCSFpp"
inputs:
  - id: output_raw_phylo
    type:
      - 'null'
      - int
    doc: "Compute all 6 unsmoothened PhyloCSF tracks (0 or 1). Default: 1"
    inputBinding:
      position: 1
      prefix: "--output-raw-phylo"
  - id: output_phylo
    type:
      - 'null'
      - int
    doc: "Compute all 6 smoothened PhyloCSF tracks (0 or 1). Requires coding exon coordinates and genome length. Default: 0"
    inputBinding:
      position: 1
      prefix: "--output-phylo"
  - id: output_regions
    type:
      - 'null'
      - int
    doc: "Generate bed files with coordinates of potential protein coding regions (0 or 1). Requires coding exon coordinates and genome length. Default: 0"
    inputBinding:
      position: 1
      prefix: "--output-regions"
  - id: power_threshold
    type:
      - 'null'
      - float
    doc: "Minimum confidence score to output PhyloCSF score. Default: 0.1"
    inputBinding:
      position: 1
      prefix: "--power-threshold"
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
  - id: threads
    type:
      - 'null'
      - int
    doc: "Parallelize scoring of multiple MSAs in a file using multiple threads. Default: 20"
    inputBinding:
      position: 1
      prefix: "--threads"
  - id: output
    type: string
    doc: "Directory where tracks in wig format will be written to. If it does not exist, it will be created."
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
  - id: tracks
    type:
      - 'null'
      - Directory
    doc: "Tracks in wig format"
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
stdout: phylocsfpp_build-tracks.out
