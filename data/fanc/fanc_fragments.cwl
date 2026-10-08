cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - fragments
label: fanc_fragments
doc: "In-silico genome digestion: write restriction fragments (or fixed-size bins) of a genome in BED format.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type: File
    doc: "Genome file (FASTA or FAN-C hdf5 genome)."
    inputBinding:
      position: 1
  - id: re_or_bin_size
    type: string
    doc: "Restriction enzyme name (e.g. HindIII, or 'HindIII,MboI') or bin size."
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "Output BED file with restriction fragments."
    inputBinding:
      position: 3
  - id: chromosomes
    type:
      - 'null'
      - string
    doc: "Comma-separated list of chromosomes to include in fragments BED file. Other chromosomes will be excluded. The order of chromosomes will be as stated in the list."
    inputBinding:
      position: 20
      prefix: --chromosomes
outputs:
  - id: fragments
    type: File
    doc: "Restriction fragments (BED)."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
