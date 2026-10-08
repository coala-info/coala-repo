cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - motifs
label: gimmemotifs-minimal_motifs
doc: "Identify enriched motifs (known and/or de novo)\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: background
    type:
      - 'null'
      - string
    doc: "Background type (random,genomic,gc,promoter,custom) or a file with background sequences (FASTA, BED or regions)"
    inputBinding:
      position: 1
      prefix: --background
  - id: genome
    type:
      - 'null'
      - File
    doc: "Genome fasta file (staged writable; index files are created next to it)"
    inputBinding:
      position: 1
      prefix: -g
  - id: denovo
    type:
      - 'null'
      - boolean
    doc: "Only use de novo motifs"
    inputBinding:
      position: 1
      prefix: --denovo
  - id: known
    type:
      - 'null'
      - boolean
    doc: "Only use known motifs"
    inputBinding:
      position: 1
      prefix: --known
  - id: noreport
    type:
      - 'null'
      - boolean
    doc: "Don't create a HTML report."
    inputBinding:
      position: 1
      prefix: --noreport
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
  - id: nthreads
    type:
      - 'null'
      - int
    doc: "Number of threads (default 12)"
    inputBinding:
      position: 1
      prefix: --nthreads
  - id: pfmfile
    type:
      - 'null'
      - File
    doc: "PFM file with motifs for known motifs (default: gimme.vertebrate.v5.0.pfm)"
    inputBinding:
      position: 1
      prefix: -p
  - id: tools
    type:
      - 'null'
      - string
    doc: "Tools to use for de novo motifs, any combination of AMD,BioProspector,ChIPMunk,HMS,Improbizer,MDmodule,MotifSampler,Posmo (default BioProspector,Homer,MEME)"
    inputBinding:
      position: 1
      prefix: --tools
  - id: analysis
    type:
      - 'null'
      - string
    doc: "Analysis type: small, medium, large, xl (xl)"
    inputBinding:
      position: 1
      prefix: --analysis
  - id: keepintermediate
    type:
      - 'null'
      - boolean
    doc: "Don't delete intermediate files"
    inputBinding:
      position: 1
      prefix: --keepintermediate
  - id: singlestrand
    type:
      - 'null'
      - boolean
    doc: "Only predict motifs for single + strand (default is both)"
    inputBinding:
      position: 1
      prefix: --singlestrand
  - id: fraction
    type:
      - 'null'
      - float
    doc: "Fraction of peaks to use for motif prediction set (0.2). The rest is used as validation set."
    inputBinding:
      position: 1
      prefix: --fraction
  - id: size
    type:
      - 'null'
      - int
    doc: "Region size to use for motif prediction (200). Set to 0 to use the size of the input regions."
    inputBinding:
      position: 1
      prefix: --size
  - id: input_file
    type: File
    doc: "FASTA, BED, narrowPeak or region file."
    inputBinding:
      position: 100
  - id: outdir
    type: string
    doc: "Output directory."
    inputBinding:
      position: 101
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory with the motifs and reports"
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
