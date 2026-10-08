cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastoma-collect-subhogs
label: fastoma_collect_subhogs
doc: "Collect all computed HOGs and combine them into a single OrthoXML file.\n\nTool homepage: https://github.com/DessimozLab/FastOMA"
inputs:
  - id: pickle_folder
    type: Directory
    doc: Folder containing the pickle files. Will be searched recursively
    inputBinding:
      position: 1
      prefix: --pickle-folder
  - id: roothogs_folder
    type: Directory
    doc: Folder containing the omamer roothogs
    inputBinding:
      position: 2
      prefix: --roothogs-folder
  - id: gene_id_pickle_file
    type: File
    doc: File containing the gene-id dictionary in pickle format
    inputBinding:
      position: 3
      prefix: --gene-id-pickle-file
  - id: species_tree
    type: File
    doc: Path to the species tree used to infer the hogs
    inputBinding:
      position: 4
      prefix: --species-tree
  - id: out
    type:
      - 'null'
      - string
    doc: Output filename in orthoxml
    inputBinding:
      position: 5
      prefix: --out
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 6
      prefix: -v
  - id: roothog_tsv
    type:
      - 'null'
      - string
    doc: "If specified, a tsv file with the given path will be produced containing the roothog assignments. In addition, a folder named RootHOGsFasta will be generated with one fasta file per inferred RootHOG."
    inputBinding:
      position: 7
      prefix: --roothog-tsv
  - id: marker_groups_fasta
    type:
      - 'null'
      - string
    doc: "If specified, a folder named OrthologousFasta and a TSV file with the name provided in this argument will be generated that contains single copy groups, i.e. groups which have at most one gene per species."
    inputBinding:
      position: 8
      prefix: --marker-groups-fasta
  - id: id_transform
    type:
      - 'null'
      - type: enum
        symbols:
          - UniProt
          - noop
    doc: "ID transformer from fasta files to orthoxml protein IDs. noop: no transformation (entire fasta header ID); UniProt: '>sp|P68250|1433B_BOVIN' --> P68250"
    inputBinding:
      position: 9
      prefix: --id-transform
outputs:
  - id: orthoxml
    type:
      - 'null'
      - File
    doc: Combined HOGs in OrthoXML format.
    outputBinding:
      glob: $(inputs.out)
  - id: roothog_assignments
    type:
      - 'null'
      - File
    doc: Roothog assignments as TSV file.
    outputBinding:
      glob: $(inputs.roothog_tsv)
  - id: roothogs_fasta
    type:
      - 'null'
      - Directory
    doc: One fasta file per inferred RootHOG.
    outputBinding:
      glob: RootHOGsFasta
  - id: marker_groups
    type:
      - 'null'
      - File
    doc: TSV file of single copy groups.
    outputBinding:
      glob: $(inputs.marker_groups_fasta)
  - id: orthologous_fasta
    type:
      - 'null'
      - Directory
    doc: One fasta file per single copy group.
    outputBinding:
      glob: OrthologousFasta
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
stdout: fastoma_collect_subhogs.out
