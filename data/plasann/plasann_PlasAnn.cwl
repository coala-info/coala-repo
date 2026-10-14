cwlVersion: v1.2
class: CommandLineTool
baseCommand: PlasAnn
label: plasann_PlasAnn
doc: "PlasAnn v1.1.6 - Comprehensive Plasmid Annotation Pipeline\n\nTool homepage:
  https://github.com/ajlopatkin/PlasAnn"
inputs:
  - id: input
    type: File
    doc: Input FASTA or GenBank file. It is staged in the working directory because PlasAnn writes Prodigal results beside the input file.
    inputBinding:
      position: 101
      prefix: --input
      valueFrom: $(self.basename)
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum identity percentage for UniProt BLAST hits
    inputBinding:
      position: 101
      prefix: --min-identity
  - id: name
    type:
      - 'null'
      - string
    doc: Custom name for output subfolder (single files only - ignored for 
      folders)
    inputBinding:
      position: 101
      prefix: --name
  - id: output
    type:
      - 'null'
      - string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Use Prodigal on GenBank sequence (ignore existing annotations)
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: retain
    type:
      - 'null'
      - boolean
    doc: Use GenBank annotations with fallback to translation (default)
    inputBinding:
      position: 101
      prefix: --retain
  - id: type
    type:
      - 'null'
      - string
    doc: 'Input type: fasta, genbank, or auto (auto-detect from folder)'
    inputBinding:
      position: 101
      prefix: --type
  - id: uniprot_blast
    type:
      - 'null'
      - boolean
    doc: Run optional UniProt BLAST annotation (slow but comprehensive)
    inputBinding:
      position: 101
      prefix: --uniprot-blast
  - id: uniprot_tsv
    type:
      - 'null'
      - File
    doc: Path to UniProt TSV file
    inputBinding:
      position: 101
      prefix: --uniprot-tsv
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasann:1.1.6--pyhdfd78af_0
stdout: plasann_PlasAnn.out
