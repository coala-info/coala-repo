cwlVersion: v1.2
class: CommandLineTool
baseCommand: preprocess_dataset
label: sshmm_preprocess_dataset
doc: "Pipeline for the preparation of a CLIP-Seq dataset in BED format. The pipeline
  consists of the following steps:\n1 - Filter BED file\n2 - Elongate BED file for
  later structure prediction\n3 - Fetch genomic sequences for elongated BED file\n\
  4 - Produce FASTA file with genomic sequences in viewpoint format\n5 - Secondary
  structure prediction with RNAshapes\n6 - Secondary structure prediction with RNAstructures\n\
  \nTool homepage: https://github.molgen.mpg.de/heller/ssHMM"
inputs:
  - id: working_dir
    type: Directory
    doc: working/output directory
    inputBinding:
      position: 1
  - id: dataset_name
    type: string
    doc: dataset name
    inputBinding:
      position: 2
  - id: input
    type: File
    doc: input file in .bed format
    inputBinding:
      position: 3
  - id: genome
    type: File
    doc: reference genome in FASTA format
    inputBinding:
      position: 4
  - id: genome_sizes
    type: File
    doc: chromosome sizes of reference genome (e.g. from http:/ 
      /hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19. chrom.sizes)
    inputBinding:
      position: 5
  - id: disable_filtering
    type:
      - 'null'
      - boolean
    doc: skip the filtering step
    inputBinding:
      position: 106
      prefix: --disable_filtering
  - id: disable_rna_shapes
    type:
      - 'null'
      - boolean
    doc: skip secondary structure prediction with RNAshapes
    inputBinding:
      position: 106
      prefix: --disable_RNAshapes
  - id: disable_rna_structure
    type:
      - 'null'
      - boolean
    doc: skip secondary structure prediction with RNAstructures
    inputBinding:
      position: 106
      prefix: --disable_RNAstructure
  - id: elongation
    type:
      - 'null'
      - int
    doc: 'elongation: span for up- and downstream elongation of binding sites (default:
      20)'
    default: 20
    inputBinding:
      position: 106
      prefix: --elongation
  - id: generate_negative
    type:
      - 'null'
      - boolean
    doc: generate a negative set for classification
    inputBinding:
      position: 106
      prefix: --generate_negative
  - id: genome_genes
    type:
      - 'null'
      - File
    doc: 'negative set generation: gene boundaries'
    inputBinding:
      position: 106
      prefix: --genome_genes
  - id: max_length
    type:
      - 'null'
      - int
    doc: 'filtering: maximum binding site length (default: 75)'
    default: 75
    inputBinding:
      position: 106
      prefix: --max_length
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'filtering: minimum binding site length (default: 8)'
    default: 8
    inputBinding:
      position: 106
      prefix: --min_length
  - id: min_score
    type:
      - 'null'
      - float
    doc: 'filtering: minimum score for binding site (default: 0.0)'
    default: 0.0
    inputBinding:
      position: 106
      prefix: --min_score
  - id: skip_check
    type:
      - 'null'
      - boolean
    doc: skip check for installed prerequisites
    inputBinding:
      position: 106
      prefix: --skip_check
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshmm:1.0.7--py27_0
stdout: sshmm_preprocess_dataset.out
