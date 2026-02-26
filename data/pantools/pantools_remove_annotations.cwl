cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - remove_annotations
label: pantools_remove_annotations
doc: "Remove all the genomic features that belong to annotations.\n\nTool homepage:
  https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory.
    inputBinding:
      position: 1
  - id: annotations_file
    type:
      - 'null'
      - File
    doc: A text file with the identifiers of annotations to be removed, each on 
      a separate line.
    inputBinding:
      position: 102
      prefix: --annotations
  - id: exclude
    type:
      - 'null'
      - string
    doc: A selection of genomes excluded from the removal of annotations.
    inputBinding:
      position: 102
      prefix: -e
  - id: include
    type:
      - 'null'
      - string
    doc: A selection of genomes for which all annotations will be removed.
    inputBinding:
      position: 102
      prefix: -i
  - id: selection_file
    type:
      - 'null'
      - File
    doc: Text file with rules to use a specific set of genomes and sequences. 
      This automatically lowers the threshold for core genes.
    inputBinding:
      position: 102
      prefix: --selection-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_remove_annotations.out
