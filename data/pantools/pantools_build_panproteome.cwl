cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - build_panproteome
label: pantools_build_panproteome
doc: "Build a panproteome from a set of proteins. Required software: KMC 3.1.0 or\
  \ higher.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_name
    type: string
    doc: Path to the database root directory (created by the tool).
    inputBinding:
      position: 1
  - id: proteomes_file
    type: File
    doc: A text file containing paths to FASTA files of proteins to be added to the
      panproteome; each on a separate line.
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: protein_fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Protein FASTA files named in the proteomes file. They are staged in the working
      directory, so the proteomes file can name them by file name.
outputs:
  - id: database
    type: Directory
    doc: The new panproteome database
    outputBinding:
      glob: $(inputs.database_name)
  - id: log
    type: stdout
    doc: Standard output (run log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.proteomes_file)
        writable: true
      - $(inputs.protein_fasta_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_build_panproteome.log
