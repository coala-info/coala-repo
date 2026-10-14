cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - database
label: philosopher_database
doc: "Target-Decoy database formatting\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: add_contaminants
    type:
      - 'null'
      - boolean
    doc: "add common contaminants"
    inputBinding:
      position: 100
      prefix: --contam
  - id: add_custom_sequences
    type:
      - 'null'
      - File
    doc: "add custom sequences (UniProt FASTA format only)"
    inputBinding:
      position: 100
      prefix: --add
      valueFrom: $(self.basename)
  - id: add_isoforms
    type:
      - 'null'
      - boolean
    doc: "add isoform sequences"
    inputBinding:
      position: 100
      prefix: --isoform
  - id: annotate
    type:
      - 'null'
      - File
    doc: "process a ready-to-use database"
    inputBinding:
      position: 100
      prefix: --annotate
      valueFrom: $(self.basename)
  - id: contaminant_prefix
    type:
      - 'null'
      - boolean
    doc: "mark the contaminant sequences with a prefix tag"
    inputBinding:
      position: 100
      prefix: --contamprefix
  - id: custom_database
    type:
      - 'null'
      - File
    doc: "use a pre-formatted custom database"
    inputBinding:
      position: 100
      prefix: --custom
      valueFrom: $(self.basename)
  - id: debug_sequence_classification
    type:
      - 'null'
      - boolean
    doc: "debug the sequence classification for each FASTA record"
    inputBinding:
      position: 100
      prefix: --verbose
  - id: decoy_mode
    type:
      - 'null'
      - int
    doc: "define the decoy generating mode, 0: revere sequence (default), 1:reverse and shift KR, 2:reverse and swap Kr"
    inputBinding:
      position: 100
      prefix: --decoymode
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: "define a decoy prefix"
    inputBinding:
      position: 100
      prefix: --prefix
  - id: enzyme
    type:
      - 'null'
      - string
    doc: "enzyme for digestion (trypsin, lys_c, lys_n, glu_c, chymotrypsin)"
    inputBinding:
      position: 100
      prefix: --enzyme
  - id: no_decoys
    type:
      - 'null'
      - boolean
    doc: "don't add decoys to the database"
    inputBinding:
      position: 100
      prefix: --nodecoys
  - id: reviewed_sequences
    type:
      - 'null'
      - boolean
    doc: "use only reviwed sequences from Swiss-Prot"
    inputBinding:
      position: 100
      prefix: --reviewed
  - id: uniprot_id
    type:
      - 'null'
      - string
    doc: "UniProt proteome ID"
    inputBinding:
      position: 100
      prefix: --id
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (the .meta folder written by an earlier step); it is staged writable as .meta in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Target-decoy FASTA files written to the working directory (date-decoys-name.fasta.fas)"
    outputBinding:
      glob: '*.fas'
  - id: workspace_out
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (.meta folder) after this step; pass it to the next step"
    outputBinding:
      glob: .meta
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .meta
        entry: $(inputs.workspace)
        writable: true
      - '${ return inputs.custom_database ? [inputs.custom_database] : []; }'
      - '${ return inputs.add_custom_sequences ? [inputs.add_custom_sequences] : []; }'
      - '${ return inputs.annotate ? [inputs.annotate] : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
    dockerOutputDirectory: /work
stdout: philosopher_database.out
