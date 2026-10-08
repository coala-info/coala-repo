cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
  - gwpa
  - fenrichment
label: deepacstrain_gwpa_fenrichment
doc: "Run filter enrichment analysis.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: bed_dir
    type: Directory
    doc: "Input directory with filter activation values for a species (.bed)"
    inputBinding:
      position: 101
      prefix: --bed-dir
  - id: gff
    type: File
    doc: "Gff file of species"
    inputBinding:
      position: 101
      prefix: --gff
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "fenrichment"
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: motif_length
    type:
      - 'null'
      - int
    doc: "Motif length"
    inputBinding:
      position: 101
      prefix: --motif-length
  - id: n_cpus
    type:
      - 'null'
      - int
    doc: "Number of CPU cores."
    inputBinding:
      position: 101
      prefix: --n-cpus
  - id: extended
    type:
      - 'null'
      - boolean
    doc: "Check for multiple CDSs per gene and unnamed genes."
    inputBinding:
      position: 101
      prefix: --extended
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
