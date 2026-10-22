cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - create
label: taxtastic_taxit_create
doc: "Create a reference package (refpkg) for pplacer from an alignment, tree and taxonomy\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: 'Delete an existing reference package'
    inputBinding:
      position: 1
      prefix: --clobber
  - id: package_name
    type: string
    doc: 'Name of refpkg to create'
    inputBinding:
      position: 1
      prefix: --package-name
  - id: locus
    type: string
    doc: 'The locus described by the reference package'
    inputBinding:
      position: 1
      prefix: --locus
  - id: author
    type:
      - 'null'
      - string
    doc: 'Person who created the reference package'
    inputBinding:
      position: 1
      prefix: --author
  - id: description
    type:
      - 'null'
      - string
    doc: 'An arbitrary description field'
    inputBinding:
      position: 1
      prefix: --description
  - id: package_version
    type:
      - 'null'
      - string
    doc: 'Release version for the reference package'
    inputBinding:
      position: 1
      prefix: --package-version
  - id: aln_fasta
    type:
      - 'null'
      - File
    doc: 'Multiple alignment in fasta format'
    inputBinding:
      position: 1
      prefix: --aln-fasta
  - id: seq_info
    type:
      - 'null'
      - File
    doc: 'Csv file describing the aligned reference sequences, minimally containing the fields seqname and tax_id'
    inputBinding:
      position: 1
      prefix: --seq-info
  - id: mask
    type:
      - 'null'
      - File
    doc: 'Text file containing a mask'
    inputBinding:
      position: 1
      prefix: --mask
  - id: model_file
    type:
      - 'null'
      - File
    doc: 'File containing model information, usually the .bestModel file'
    inputBinding:
      position: 1
      prefix: --model-file
  - id: profile
    type:
      - 'null'
      - File
    doc: 'Alignment profile'
    inputBinding:
      position: 1
      prefix: --profile
  - id: readme
    type:
      - 'null'
      - File
    doc: 'README file describing the reference package'
    inputBinding:
      position: 1
      prefix: --readme
  - id: tree_stats
    type:
      - 'null'
      - File
    doc: 'File containing tree statistics (for example RAxML_info.whatever)'
    inputBinding:
      position: 1
      prefix: --tree-stats
  - id: aln_sto
    type:
      - 'null'
      - File
    doc: 'Multiple alignment in Stockholm format'
    inputBinding:
      position: 1
      prefix: --aln-sto
  - id: tree_file
    type:
      - 'null'
      - File
    doc: 'Phylogenetic tree in newick format'
    inputBinding:
      position: 1
      prefix: --tree-file
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: 'Csv file defining the taxonomy (output of taxit taxtable)'
    inputBinding:
      position: 1
      prefix: --taxonomy
  - id: stats_type
    type:
      - 'null'
      - string
    doc: 'Stats file type: PhyML, FastTree or RAxML (default: guessed from file contents)'
    inputBinding:
      position: 1
      prefix: --stats-type
  - id: frequency_type
    type:
      - 'null'
      - string
    doc: 'Residue frequency type from the model: empirical or model'
    inputBinding:
      position: 1
      prefix: --frequency-type
  - id: no_reroot
    type:
      - 'null'
      - boolean
    doc: 'Do not reroot the reference package using rppr reroot'
    inputBinding:
      position: 1
      prefix: --no-reroot
  - id: rppr
    type:
      - 'null'
      - string
    doc: 'Name of the rppr executable (default: rppr)'
    inputBinding:
      position: 1
      prefix: --rppr
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: refpkg_dir
    type:
      - 'null'
      - Directory
    doc: 'The new reference package'
    outputBinding:
      glob: $(inputs.package_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_create.out
