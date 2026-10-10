cwlVersion: v1.2
class: CommandLineTool
baseCommand: compare_genes.py
label: midas_compare_genes
doc: "Compute gene-content distances between samples from the output of merge_midas.py genes for one species.\n\
  \nTool homepage: https://github.com/snayfach/MIDAS"
inputs:
  - id: out
    type: string
    doc: Path to output file.
    inputBinding:
      position: 101
      prefix: --out
  - id: max_genes
    type:
      - 'null'
      - int
    doc: Maximum number of genes to use. Useful for quick tests (use all).
    inputBinding:
      position: 101
      prefix: --max_genes
  - id: max_samples
    type:
      - 'null'
      - int
    doc: Maximum number of samples to use. Useful for quick tests (use all).
    inputBinding:
      position: 101
      prefix: --max_samples
  - id: distance
    type:
      - 'null'
      - string
    doc: 'Metric to use for computing distances: jaccard (default), euclidean or manhattan.'
    inputBinding:
      position: 101
      prefix: --distance
  - id: dtype
    type:
      - 'null'
      - string
    doc: 'Data type to use for comparing genes: presabs (default) or copynum.'
    inputBinding:
      position: 101
      prefix: --dtype
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Cutoff to use for determining presence absence (0.35).
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: indir
    type: Directory
    doc: Path to output from merge_midas.py genes for one species (directory named by species_id with
      genes_*.txt files).
    inputBinding:
      position: 201
outputs:
  - id: out_file
    type: File
    doc: Distance matrix.
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
