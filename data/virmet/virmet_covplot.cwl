cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virmet
  - covplot
label: virmet_covplot
doc: "Create coverage plots by realigning all viral reads found by wolfpack for one organism.\n\nTool homepage: https://github.com/medvir/VirMet"
inputs:
  - id: outdir
    type: Directory
    doc: path with the results of virmet wolfpack (it holds viral_reads.fastq.gz and orgs_list.tsv); the plots are written inside it
    inputBinding:
      position: 101
      prefix: --outdir
  - id: organism
    type: string
    doc: ssciname of the organism of interest
    inputBinding:
      position: 101
      prefix: --organism
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: path to find and use the Virmet database
    inputBinding:
      position: 101
      prefix: --dbdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virmet:2.0.1--pyhdfd78af_0
stdout: virmet_covplot.out
