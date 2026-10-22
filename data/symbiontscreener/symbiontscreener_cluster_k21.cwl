cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sysc
  - cluster_k21
label: symbiontscreener_cluster_k21
doc: "Cluster offspring reads with a Bayesian Gaussian mixture model on trio k-mer density and GC/n-mer features.\n\nTool homepage: https://github.com/BGI-Qingdao/Symbiont-Screener"
inputs:
  - id: density_dir
    type: Directory
    doc: Output directory of density_k21 (step02.1.k21)
  - id: offspring
    type:
      type: array
      items: File
      inputBinding:
        prefix: --offspring
    doc: Offspring sequence file (gzip allowed if the name ends in .gz). Repeat for several files.
    inputBinding:
      position: 1
  - id: offspring_format
    type: ['null', string]
    doc: fasta or fastq (default fasta)
    inputBinding:
      position: 1
      prefix: --offspring_format
  - id: threshold1
    type: ['null', float]
    doc: Minimum density of parental k-mers (default 0.003)
    inputBinding:
      position: 1
      prefix: --threshold1
  - id: threshold2
    type: ['null', float]
    doc: Minimum density of shared k-mers (default 0.01)
    inputBinding:
      position: 1
      prefix: --threshold2
  - id: shortest
    type: ['null', int]
    doc: Shortest read length used for clustering (default 5000)
    inputBinding:
      position: 1
      prefix: --shortest
  - id: thread
    type: ['null', int]
    doc: Thread number (default 8)
    inputBinding:
      position: 1
      prefix: --thread
outputs:
  - id: step03_1_k21
    type: Directory
    doc: Cluster directory step03.1.k21 with final.result.txt
    outputBinding:
      glob: step03.1.k21
  - id: stdout
    type: stdout
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: step02.1.k21
        entry: $(inputs.density_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener_cluster_k21.stdout.txt
