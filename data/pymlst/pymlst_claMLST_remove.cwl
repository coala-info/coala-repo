cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - claMLST
  - remove
label: pymlst_claMLST_remove
doc: "Removes ALLELE sequence from the GENE on a mlst DATABASE.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database
    type: File
    doc: "Path to the claMLST database (SQLite file); a modified copy is returned"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: gene
    type: string
    doc: "Name of the gene"
    inputBinding:
      position: 2
  - id: allele
    type: string
    doc: "Allele number to remove"
    inputBinding:
      position: 3
outputs:
  - id: updated_database
    type: File
    doc: "The claMLST database with the allele removed"
    outputBinding:
      glob: "$(inputs.database.basename)"
  - id: stdout
    type: stdout
    doc: "Standard output (result when no output file is given)"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_claMLST_remove.out
