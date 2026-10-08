cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - motif2factors
label: gimmemotifs-minimal_motif2factors
doc: "Generate a motif database based on orthology for any species\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: new_reference
    type:
      type: array
      items: string
    doc: "The assembly the new motif2factors file will be based on."
    inputBinding:
      position: 1
      prefix: --new-reference
  - id: database
    type:
      - 'null'
      - string
    doc: "The database you want to change convert to your species of interest. (default is gimme.vertebrate.v5.0)"
    inputBinding:
      position: 1
      prefix: --database
  - id: database_references
    type:
      - 'null'
      - type: array
        items: string
    doc: "The assembly(s) on which the orginal motif2factors is based on. (default is human and mouse)"
    inputBinding:
      position: 1
      prefix: --database-references
  - id: ortholog_references
    type:
      - 'null'
      - type: array
        items: string
    doc: "Extra assemblies for better orthology inference between the new reference and database reference. (default is a range of vertebrate species)"
    inputBinding:
      position: 1
      prefix: --ortholog-references
  - id: genomes_dir
    type:
      - 'null'
      - string
    doc: "Where to find/store genomepy genomes. Defaults to the genomepy config settings."
    inputBinding:
      position: 1
      prefix: --genomes_dir
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: "Where to place intermediate files. Defaults to system temp."
    inputBinding:
      position: 1
      prefix: --tmpdir
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Where to save the results to. Defaults to current working directory."
    inputBinding:
      position: 1
      prefix: --outdir
  - id: strict
    type:
      - 'null'
      - boolean
    doc: "Strict: base gene names only on what is in the annotation file"
    inputBinding:
      position: 1
      prefix: --strict
  - id: medium
    type:
      - 'null'
      - boolean
    doc: "Medium: base on annotation file, as well as on mygene.info name and symbol query"
    inputBinding:
      position: 1
      prefix: --medium
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: "Lenient (default): based on annotation file and mygene.info name, symbol, alias, other_names, accession, refseq and ensembl"
    inputBinding:
      position: 1
      prefix: --lenient
  - id: threads
    type:
      - 'null'
      - int
    doc: "Maximum number of parallel threads used."
    inputBinding:
      position: 1
      prefix: --threads
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: "Keep temporary files, do not delete tmpdir."
    inputBinding:
      position: 1
      prefix: --keep-intermediate
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory with the generated motif2factors files"
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
