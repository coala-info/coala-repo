cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgMLST
  - remove
label: pymlst_wgMLST_remove
doc: "Removes STRAINS or GENES from a wgMLST DATABASE.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database
    type: File
    doc: "Path to the wgMLST database (SQLite file); a modified copy is returned"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: genes_or_strains
    type: ['null', 'string[]']
    doc: "Names of the strains or genes to remove"
    inputBinding:
      position: 2
  - id: strains
    type: ['null', boolean]
    doc: "Choose strains as the items to remove (default)."
    inputBinding:
      position: 10
      prefix: --strains
  - id: genes
    type: ['null', boolean]
    doc: "Choose genes as the items to remove."
    inputBinding:
      position: 10
      prefix: --genes
  - id: file
    type: ['null', File]
    doc: "File list of genes or strains to removed on the wgMLST database."
    inputBinding:
      position: 10
      prefix: --file
outputs:
  - id: updated_database
    type: File
    doc: "The wgMLST database after removal"
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
stdout: pymlst_wgMLST_remove.out
