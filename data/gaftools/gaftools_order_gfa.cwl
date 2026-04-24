cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gaftools
  - order_gfa
label: gaftools_order_gfa
doc: "Order bubbles in the GFA by adding BO and NO tags.\n\nTool homepage: https://github.com/marschall-lab/gaftools"
inputs:
  - id: graph
    type: File
    doc: Input rGFA file
    inputBinding:
      position: 1
  - id: by_chrom
    type:
      - 'null'
      - boolean
    doc: Outputs each chromosome as a separate GFA, otherwise, all chromosomes 
      in one GFA file
    inputBinding:
      position: 102
      prefix: --by-chrom
  - id: chromosome_order
    type:
      - 'null'
      - string
    doc: "Order in which to arrange chromosomes in terms of BO sorting. By default,
      it is arranged in the lexicographic order of identified component names. Expecting
      comma-separated list. Example: 'chr1,chr2,chr3'"
    inputBinding:
      position: 102
      prefix: --chromosome-order
  - id: ignore_branching
    type:
      - 'null'
      - boolean
    doc: Force the order even when branching paths occur in the scaffold graph. 
      Alternative alleles will not be ordered
    inputBinding:
      position: 102
      prefix: --ignore-branching
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output Directory to store all the GFA and CSV files. Default location 
      is a "out" folder from the directory of execution.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: output_scaffold
    type:
      - 'null'
      - boolean
    doc: Output the scaffold graph in GFA format. The scaffold graph is the 
      graph created from collapsing all the biconnected components.
    inputBinding:
      position: 102
      prefix: --output-scaffold
  - id: without_sequence
    type:
      - 'null'
      - boolean
    doc: Strip sequences from the output graph (for less memory usage and easier
      visualization).
    inputBinding:
      position: 102
      prefix: --without-sequence
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
stdout: gaftools_order_gfa.out
