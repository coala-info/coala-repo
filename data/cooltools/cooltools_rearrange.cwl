cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - rearrange
label: cooltools_rearrange
doc: "Rearrange data from a cooler according to a new genomic view\n\nTool homepage:
  https://github.com/mirnylab/cooltools"
inputs:
  - id: in_path
    type: File
    doc: .cool file (or URI) with data to rearrange.
    inputBinding:
      position: 1
  - id: assembly
    type:
      - 'null'
      - string
    doc: The name of the assembly for the new cooler. If None, uses the same as 
      in the original cooler.
    inputBinding:
      position: 102
      prefix: --assembly
  - id: chunksize
    type:
      - 'null'
      - int
    doc: The number of pixels loaded and processed per step of computation.
    default: 10000000
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: mode
    type:
      - 'null'
      - string
    doc: '(w)rite or (a)ppend to the output file (default: w)'
    default: w
    inputBinding:
      position: 102
      prefix: --mode
  - id: new_chrom_col
    type:
      - 'null'
      - string
    doc: Column name in the view with new chromosome names. If not provided and 
      there is no column named 'new_chrom' in the view file, uses original 
      chromosome names
    inputBinding:
      position: 102
      prefix: --new-chrom-col
  - id: orientation_col
    type:
      - 'null'
      - string
    doc: Columns name in the view with orientations of each region (+ or -). If 
      not providedand there is no column named 'strand' in the view file, 
      assumes all are forward oriented
    inputBinding:
      position: 102
      prefix: --orientation-col
  - id: view
    type: File
    doc: Path to a BED-like file which defines which regions of the chromosomes 
      to use and in what order. Using --new-chrom-col and --orientation-col you 
      can specify the new chromosome names and whether to invert each region 
      (optional)
    inputBinding:
      position: 102
      prefix: --view
outputs:
  - id: out_path
    type: File
    doc: .cool file (or URI) to save the rearrange data.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
