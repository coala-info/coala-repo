cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgv-download-dataset
label: pygenomeviz_pgv-download-dataset
doc: "Download pyGenomeViz genbank dataset\n\nTool homepage: https://github.com/moshi4/pyGenomeViz/"
inputs:
  - id: name
    type: string
    doc: "Dataset name: escherichia_phage, erwinia_phage, enterobacteria_phage, escherichia_coli or mycoplasma_gallisepticum"
    inputBinding:
      position: 1
      prefix: --name
  - id: outdir
    type: ['null', string]
    doc: "Output directory (Default: .)"
    inputBinding:
      position: 2
      prefix: --outdir
outputs:
  - id: genbank_files
    type: File[]
    doc: "Downloaded GenBank files"
    outputBinding:
      glob: "$(inputs.outdir ? inputs.outdir + '/*.gbk' : '*.gbk')"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
