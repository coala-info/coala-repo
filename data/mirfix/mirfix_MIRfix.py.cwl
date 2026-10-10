cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MIRfix.py
label: mirfix_MIRfix.py
doc: "MIRfix automatically curates miRNA datasets by improving alignments of their precursors, the consistency of the annotation of mature miR and miR* sequence, and the phylogenetic coverage. MIRfix produces alignments that are comparable across families and sets the stage for improved homology search as well as quantitative analyses.\n\nTool homepage: https://github.com/Bierinformatik/MIRfix"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of parallel processes to run
    inputBinding:
      position: 101
      prefix: --cores
  - id: families
    type: File
    doc: List of families to work on (one family name per line)
    inputBinding:
      position: 101
      prefix: --families
  - id: famdir
    type: Directory
    doc: Directory where the family files (<family>.fa) are located. MIRfix writes alignment files into it, so a writable copy is used
    inputBinding:
      position: 101
      prefix: --famdir
      valueFrom: $(self.basename + '/')
  - id: genomes
    type: File
    doc: File listing the genome FASTA files to parse (one path per line, relative to the working directory or absolute)
    inputBinding:
      position: 101
      prefix: --genomes
  - id: genome_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome FASTA files named in the genomes list; they are staged in the working directory
  - id: mapping
    type: File
    doc: Mapping between precursors and families. MIRfix appends to this file, so a writable copy is used
    inputBinding:
      position: 101
      prefix: --mapping
      valueFrom: $(self.basename)
  - id: mature
    type: File
    doc: FASTA file containing mature sequences. MIRfix appends to this file, so a writable copy is used
    inputBinding:
      position: 101
      prefix: --mature
      valueFrom: $(self.basename)
  - id: matured_dir
    type:
      - 'null'
      - Directory
    doc: Directory of matures
    inputBinding:
      position: 101
      prefix: --maturedir
      valueFrom: $(self.path + '/')
  - id: extension
    type:
      - 'null'
      - int
    doc: Extension of nucleotides for precursor cutting
    inputBinding:
      position: 101
      prefix: --extension
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force MIRfix to overwrite existing output directories
    inputBinding:
      position: 101
      prefix: --force
  - id: logdir
    type:
      - 'null'
      - string
    doc: Directory to write logfiles to
    inputBinding:
      position: 101
      prefix: --logdir
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - WARNING
          - ERROR
          - INFO
          - DEBUG
          - CRITICAL
    doc: Set log level
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: outdir_path
    type: string
    doc: Directory for output
    inputBinding:
      position: 102
      prefix: --outdir
      valueFrom: $(self.replace(/\/*$/, '/'))
outputs:
  - id: outdir
    type: Directory
    doc: Directory for output
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: logdir_dir
    type:
      - 'null'
      - Directory
    doc: Directory with log files
    outputBinding:
      glob: $(inputs.logdir)
  - id: updated_mature
    type:
      - 'null'
      - File
    doc: Mature sequence file as updated by MIRfix
    outputBinding:
      glob: $(inputs.mature.basename)
  - id: updated_mapping
    type:
      - 'null'
      - File
    doc: Mapping file as updated by MIRfix
    outputBinding:
      glob: $(inputs.mapping.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.famdir.basename)
        entry: $(inputs.famdir)
        writable: true
      - entryname: $(inputs.mapping.basename)
        entry: $(inputs.mapping)
        writable: true
      - entryname: $(inputs.mature.basename)
        entry: $(inputs.mature)
        writable: true
      - '$(inputs.genome_files ? inputs.genome_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirfix:2.1.1--hdfd78af_0
