cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
  - gwpa
  - granking
label: deepacstrain_gwpa_granking
doc: "Generate gene rankings.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: patho_dir
    type: Directory
    doc: "Directory containing the pathogenicity scores over all genomic regions per species (.bedgraph)"
    inputBinding:
      position: 101
      prefix: --patho-dir
  - id: gff_dir
    type: Directory
    doc: "Directory containing the annotation data of the species (.gff)"
    inputBinding:
      position: 101
      prefix: --gff-dir
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "gene_rank"
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: extended
    type:
      - 'null'
      - boolean
    doc: "Check for multiple CDSs per gene and unnamed genes."
    inputBinding:
      position: 101
      prefix: --extended
  - id: n_cpus
    type:
      - 'null'
      - int
    doc: "Number of CPU cores."
    inputBinding:
      position: 101
      prefix: --n-cpus
outputs:
  - id: out
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0
