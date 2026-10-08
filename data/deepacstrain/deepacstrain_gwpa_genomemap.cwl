cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
  - gwpa
  - genomemap
label: deepacstrain_gwpa_genomemap
doc: "Generate a genome-wide phenotype potential map.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: dir_fragmented_genomes
    type: Directory
    doc: "Directory containing the fragmented genomes (.fasta)"
    inputBinding:
      position: 101
      prefix: --dir-fragmented-genomes
  - id: dir_fragmented_genomes_preds
    type: Directory
    doc: "Directory containing the predictions (.npy) of the fragmented genomes"
    inputBinding:
      position: 101
      prefix: --dir-fragmented-genomes-preds
  - id: genomes_dir
    type: Directory
    doc: "Directory containing genomes (.genome)"
    inputBinding:
      position: 101
      prefix: --genomes-dir
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "bedgraph"
    inputBinding:
      position: 101
      prefix: --out-dir
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
