cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - add_annotations
label: pantools_add_annotations
doc: "Construct or expand the annotations of an existing pangenome.\n\nTool homepage:\
  \ https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: annotations_file
    type: File
    doc: A text file with the identifiers of annotations to be included (genome number
      and path to a GFF3 file on each line).
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: gff_files
    type:
      - 'null'
      - type: array
        items: File
    doc: GFF3 files named in the annotations file. They are staged in the working
      directory, so the annotations file can name them by file name.
  - id: ignore_invalid_features
    type:
      - 'null'
      - boolean
    doc: Ignore GFF3 features that do not match the fasta.
    inputBinding:
      position: 102
      prefix: --ignore-invalid-features
  - id: connect
    type:
      - 'null'
      - boolean
    doc: Connect the annotated genomic features to nucleotide nodes in the DBG.
    inputBinding:
      position: 102
      prefix: --connect
  - id: assume_one_mrna_per_cds
    type:
      - 'null'
      - boolean
    doc: Assume that each CDS is part of a single mRNA in case the annotation file
      does not contain mRNA features between CDS and gene features.
    inputBinding:
      position: 102
      prefix: --assume-one-mrna-per-cds
outputs:
  - id: database
    type: Directory
    doc: The updated pangenome database
    outputBinding:
      glob: $(inputs.database_directory.basename)
  - id: log
    type: stdout
    doc: Standard output (run log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database_directory)
        writable: true
      - entry: $(inputs.annotations_file)
        writable: true
      - $(inputs.gff_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_add_annotations.log
