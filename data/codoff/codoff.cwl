cwlVersion: v1.2
class: CommandLineTool
baseCommand: codoff
label: codoff
doc: "This program compares the codon-usage distribution of a focal-region/BGC to
  the codon usage of the background genome. It reports the cosine distance and Spearman
  correlation between the two profiles, as well as a discordance percentile indicating
  how unusual the focal region's codon usage is compared to similarly sized genomic
  windows.\n\nTool homepage: https://github.com/Kalan-Lab/codoff"
inputs:
  - id: end_coord
    type:
      - 'null'
      - int
    doc: End coordinate for focal region.
    inputBinding:
      position: 101
      prefix: --end-coord
  - id: focal_genbanks
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to focal region GenBank(s) for isolate. Locus tags must match with
      tags in full-genome GenBank.
    inputBinding:
      position: 101
      prefix: --focal-genbanks
  - id: full_genome
    type: File
    doc: Path to a full-genome in GenBank or FASTA format. If GenBank file 
      provided, CDS features are required.
    inputBinding:
      position: 101
      prefix: --full-genome
  - id: max_focal_cds_fraction
    type:
      - 'null'
      - float
    doc: 'Maximum allowed fraction of total genome CDS length for focal region [Default:
      0.05].'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --max-focal-cds-fraction
  - id: num_sims
    type:
      - 'null'
      - int
    doc: 'Number of simulations to run [Default: 10000].'
    default: 10000
    inputBinding:
      position: 101
      prefix: --num-sims
  - id: scaffold
    type:
      - 'null'
      - string
    doc: Scaffold identifier for focal region.
    inputBinding:
      position: 101
      prefix: --scaffold
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed for reproducible results [Default: 42].'
    default: 42
    inputBinding:
      position: 101
      prefix: --seed
  - id: start_coord
    type:
      - 'null'
      - int
    doc: Start coordinate for focal region.
    inputBinding:
      position: 101
      prefix: --start-coord
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Path to output file [Default is standard output].
    outputBinding:
      glob: $(inputs.outfile)
  - id: plot_outfile
    type:
      - 'null'
      - File
    doc: Plot output file name (will be in SVG format). If not provided, no plot
      will be made.
    outputBinding:
      glob: $(inputs.plot_outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codoff:1.2.3--pyhdfd78af_0
