cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx create-regions-bed
label: pypgx_create-regions-bed
doc: "Create a BED file which contains all regions used by PyPGx.\n\nTool homepage:
  https://github.com/sbslee/pypgx"
inputs:
  - id: add_chr_prefix
    type:
      - 'null'
      - boolean
    doc: Whether to add the 'chr' string in contig names.
    inputBinding:
      position: 101
      prefix: --add-chr-prefix
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Reference genome assembly (default: 'GRCh37') (choices: 'GRCh37', 'GRCh38')."
    default: GRCh37
    inputBinding:
      position: 101
      prefix: --assembly
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified genes. Ignored when --genes is not used.
    inputBinding:
      position: 101
      prefix: --exclude
  - id: genes
    type:
      - 'null'
      - type: array
        items: string
    doc: List of genes to include.
    inputBinding:
      position: 101
      prefix: --genes
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Whether to merge overlapping intervals (gene names will be removed 
      too).
    inputBinding:
      position: 101
      prefix: --merge
  - id: sv_genes
    type:
      - 'null'
      - boolean
    doc: Whether to only return target genes whose at least one star allele is 
      defined by structural variation
    inputBinding:
      position: 101
      prefix: --sv-genes
  - id: target_genes
    type:
      - 'null'
      - boolean
    doc: Whether to only return target genes, excluding control genes and 
      paralogs.
    inputBinding:
      position: 101
      prefix: --target-genes
  - id: var_genes
    type:
      - 'null'
      - boolean
    doc: Whether to only return target genes whose at least one star allele is 
      defined by SNVs/indels.
    inputBinding:
      position: 101
      prefix: --var-genes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_create-regions-bed.out
