cwlVersion: v1.2
class: CommandLineTool
baseCommand: MIRfix.py
label: mirfix_MIRfix.py
doc: "MIRfix automatically curates miRNA datasets by improving alignments of their
  precursors, the consistency of the annotation of mature miR and miR* sequence, and
  the phylogenetic coverage. MIRfix produces alignments that are comparable across
  families and sets the stage for improved homology search as well as quantitative
  analyses.\n\nTool homepage: https://github.com/Bierinformatik/MIRfix"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of parallel processes to run
    inputBinding:
      position: 101
      prefix: --cores
  - id: extension
    type:
      - 'null'
      - string
    doc: Extension of nucleotides for precursor cutting
    inputBinding:
      position: 101
      prefix: --extension
  - id: famdir
    type: Directory
    doc: Directory where family files are located
    inputBinding:
      position: 101
      prefix: --famdir
  - id: families
    type: string
    doc: Path to list of families to work on
    inputBinding:
      position: 101
      prefix: --families
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force MIRfix to overwrite existing output directories
    inputBinding:
      position: 101
      prefix: --force
  - id: genomes
    type: File
    doc: Genome FASTA files to parse
    inputBinding:
      position: 101
      prefix: --genomes
  - id: logdir
    type:
      - 'null'
      - Directory
    doc: Directory to write logfiles to
    inputBinding:
      position: 101
      prefix: --logdir
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set log level
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: mapping
    type: string
    doc: Mapping between precursor and families
    inputBinding:
      position: 101
      prefix: --mapping
  - id: mature
    type: File
    doc: FASTA files containing mature sequences
    inputBinding:
      position: 101
      prefix: --mature
  - id: matured_dir
    type:
      - 'null'
      - Directory
    doc: Directory of matures
    inputBinding:
      position: 101
      prefix: --maturedir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory for output
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirfix:2.1.1--hdfd78af_0
