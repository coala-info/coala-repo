cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylocsf++
  - annotate-with-mmseqs
label: phylocsfpp_annotate-with-mmseqs
doc: "Computes PhyloCSF scores for CDS features in GFF/GTF files and outputs them in the same format. Requires MMseqs2 to be installed and a set of reference genomes to compute multiple sequence alignments from scratch. To get an average score over all codons of posterior probabilities (similar to annotate-with-tracks), use --strategy FIXED_MEAN.\n\nTool homepage: https://github.com/cpockrandt/PhyloCSFpp"
inputs:
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
    doc: "Directory where the output GFF/GTF will be written to. If it does not exist, it will be created."
    inputBinding:
      position: 1
      prefix: "--output"
  - id: strategy
    type:
      - 'null'
      - string
    doc: "PhyloCSF scoring algorithm: MLE, FIXED, OMEGA or FIXED_MEAN. Default: MLE"
    inputBinding:
      position: 1
      prefix: "--strategy"
  - id: mmseqs_bin
    type:
      - 'null'
      - string
    doc: "Path to MMseqs2 binary. Default: mmseqs"
    inputBinding:
      position: 1
      prefix: "--mmseqs-bin"
  - id: genome_length
    type:
      - 'null'
      - int
    doc: "Total genome length (needed for --strategy FIXED_MEAN)."
    inputBinding:
      position: 1
      prefix: "--genome-length"
  - id: coding_exons
    type:
      - 'null'
      - File
    doc: "BED-like file (chrom name, strand, phase, start, end) with coordinates of coding exons (needed for --strategy FIXED_MEAN)."
    inputBinding:
      position: 1
      prefix: "--coding-exons"
  - id: mapping
    type:
      - 'null'
      - File
    doc: "If the MSAs don't use common species names (like Human, Chimp, etc.) you can pass a two-column tsv file with a name mapping."
    inputBinding:
      position: 1
      prefix: "--mapping"
  - id: genome_file
    type: File
    doc: "Two-column tsv file with species name and path to its genomic fasta file. First line has to be the reference genome of the GFF file."
    inputBinding:
      position: 2
  - id: model
    type: string
    doc: "Path to parameter files, or one of the predefined models: 21mosquitoes, 58mammals, 7yeast, 29mammals, 53birds, 49birds, 100vertebrates, 23flies, 12flies, 26worms, 20flies."
    inputBinding:
      position: 3
  - id: gff_files
    type:
      type: array
      items: File
    doc: "One or more GFF/GTF files with coding exons to be scored."
    inputBinding:
      position: 4
outputs:
  - id: annotated
    type:
      - 'null'
      - Directory
    doc: "Annotated GFF/GTF files"
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
stdout: phylocsfpp_annotate-with-mmseqs.out
