cwlVersion: v1.2
class: CommandLineTool
baseCommand: omark
label: omark
doc: "Compute an OMA quality score from the OMAmer file of a proteome.\n\nTool homepage:
  https://github.com/DessimozLab/omark"
inputs:
  - id: database
    type: string
    doc: The OMAmer database.
    inputBinding:
      position: 101
      prefix: --database
  - id: ete_ncbi_db
    type:
      - 'null'
      - File
    doc: Path to the ete3 NCBI database to be used. Default will use the default
      location at ~/.etetoolkit/taxa.sqlite
    default: ~/.etetoolkit/taxa.sqlite
    inputBinding:
      position: 101
      prefix: --ete_ncbi_db
  - id: input_file
    type: File
    doc: Input OMAmer file - obtained as output from an OMAmer search.
    inputBinding:
      position: 101
      prefix: --file
  - id: isoform_file
    type:
      - 'null'
      - File
    doc: A semi-colon separated file, listing all isoforoms of each genes, with 
      one gene per line.
    inputBinding:
      position: 101
      prefix: --isoform_file
  - id: min_n_species
    type:
      - 'null'
      - int
    doc: The minimal number of species in the database belonging to a clade to 
      select it as an ancestral lineage
    inputBinding:
      position: 101
      prefix: --min_n_species
  - id: og_fasta
    type:
      - 'null'
      - File
    doc: Original FASTA file
    inputBinding:
      position: 101
      prefix: --og_fasta
  - id: output_chogs
    type:
      - 'null'
      - boolean
    doc: Switch OMArk mode to only computing a list of conserved HOGs and output
      it as list. Can be used to obtain a set of genes on which to train
    inputBinding:
      position: 101
      prefix: --output_cHOGs
  - id: summarize_db
    type:
      - 'null'
      - boolean
    doc: Switch OMArk mode to summarize the clade content of the OMAmer DB 
      (Number of species per clade, number of HOGs used,...). This mode will 
      take a few hours to run. Refer to the data availableat 
      https://omabrowser.org/oma/current/ if you are using the default database.
    inputBinding:
      position: 101
      prefix: --summarize_db
  - id: taxid
    type:
      - 'null'
      - string
    doc: Taxonomic identifier
    inputBinding:
      position: 101
      prefix: --taxid
  - id: taxonomic_rank
    type:
      - 'null'
      - string
    doc: The narrowest taxonomic rank (genus, order, family...) that should be 
      used as ancestral lineage.
    inputBinding:
      position: 101
      prefix: --taxonomic_rank
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on logging information about OMArk process
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: The folder containing output data the script wilp generate.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/omark:0.4.1--pyh7e72e81_0
