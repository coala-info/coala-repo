cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaseq-reads-downloader
label: atol-genome-launcher_rnaseq-reads-downloader
doc: "Downloads RNA-Seq reads based on a manifest file.\n\nTool homepage: https://github.com/TomHarrop/atol-genome-launcher"
inputs:
  - id: manifest
    type: File
    doc: Path to the manifest
    inputBinding:
      position: 1
  - id: outdir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 2
  - id: parallel_downloads
    type:
      - 'null'
      - int
    doc: Number of parallel downloads
    inputBinding:
      position: 103
      prefix: --parallel_downloads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-genome-launcher:0.4.1--pyhdfd78af_0
stdout: atol-genome-launcher_rnaseq-reads-downloader.out
