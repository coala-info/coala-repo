cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract-codon-alignment
label: extract_genome_region
doc: "Extracts codon alignments from genomic sequences.\n\nTool homepage: https://github.com/xguse/extract-genome-region"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file containing genomic sequences.
    inputBinding:
      position: 1
  - id: gene_list
    type: File
    doc: File containing a list of genes to extract.
    inputBinding:
      position: 2
  - id: flank_size
    type:
      - 'null'
      - int
    doc: Number of flanking bases to include around the gene region.
    default: 0
    inputBinding:
      position: 103
      prefix: --flank-size
  - id: min_codon_length
    type:
      - 'null'
      - int
    doc: Minimum length of a codon region to be considered valid.
    default: 100
    inputBinding:
      position: 103
      prefix: --min-codon-length
  - id: strand
    type:
      - 'null'
      - string
    doc: Strand to consider for gene annotation ('forward', 'reverse', or 
      'both').
    default: both
    inputBinding:
      position: 103
      prefix: --strand
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to save the extracted codon alignments.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract-codon-alignment:0.0.1--py_0
