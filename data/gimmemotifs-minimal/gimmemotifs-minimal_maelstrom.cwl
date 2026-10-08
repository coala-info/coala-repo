cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - maelstrom
label: gimmemotifs-minimal_maelstrom
doc: "Find differential motifs\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: pfmfile
    type:
      - 'null'
      - File
    doc: "PFM file with motifs (default: gimme.vertebrate.v5.0.pfm)."
    inputBinding:
      position: 1
      prefix: --pfmfile
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: "Don't remove redundant motifs."
    inputBinding:
      position: 1
      prefix: --no-filter
  - id: filter_cutoff
    type:
      - 'null'
      - float
    doc: "Cutoff to select non-redundant motifs. Default is 0.8, increase this value to get fewer motifs."
    inputBinding:
      position: 1
      prefix: --filter_cutoff
  - id: methods
    type:
      - 'null'
      - string
    doc: "Run with specific methods (default all)"
    inputBinding:
      position: 1
      prefix: --methods
  - id: aggregation
    type:
      - 'null'
      - string
    doc: "How to combine motifs from individual methods. Default is int_stouffer; alternatively specify stuart."
    inputBinding:
      position: 1
      prefix: --aggregation
  - id: seed
    type:
      - 'null'
      - int
    doc: "set a random seed (default None)"
    inputBinding:
      position: 1
      prefix: --seed
  - id: nthreads
    type:
      - 'null'
      - int
    doc: "Number of threads (default 12)"
    inputBinding:
      position: 1
      prefix: --nthreads
  - id: nocenter
    type:
      - 'null'
      - boolean
    doc: "Don't mean-center the rows by default"
    inputBinding:
      position: 1
      prefix: --nocenter
  - id: rawscore
    type:
      - 'null'
      - boolean
    doc: "Don't z-score normalize motif scores"
    inputBinding:
      position: 1
      prefix: --rawscore
  - id: nogc
    type:
      - 'null'
      - boolean
    doc: "Don't use GC% bins"
    inputBinding:
      position: 1
      prefix: --nogc
  - id: all_motif_plots
    type:
      - 'null'
      - boolean
    doc: "Specify to plot all motifs"
    inputBinding:
      position: 1
      prefix: --all-motif-plots
  - id: no_motif_plots
    type:
      - 'null'
      - boolean
    doc: "Specify to plot no motifs"
    inputBinding:
      position: 1
      prefix: --no-motif-plots
  - id: input_file
    type: File
    doc: "file with regions and clusters"
    inputBinding:
      position: 100
  - id: genome
    type: File
    doc: "Genome fasta file (staged writable; index files are created next to it)"
    inputBinding:
      position: 101
  - id: outdir
    type: string
    doc: "output directory"
    inputBinding:
      position: 102
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory with the differential motif results"
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
