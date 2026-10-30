cwlVersion: v1.2
class: CommandLineTool
baseCommand: prepTG
label: lsabgc_prepTG
doc: "Prepare a database of target genomes (GenBank or FASTA files) for searches with fai.\n\nTool homepage: https://github.com/Kalan-Lab/zol"
inputs:
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: "Directory with target genomes (either featuring GenBanks or FASTAs)."
    inputBinding:
      position: 1
      prefix: --input-dir
  - id: gtdb_taxon
    type:
      - 'null'
      - string
    doc: "Name of a GTDB valid genus or species to incorporate genomes from. Should be surrounded by quotes (e.g. 'Escherichia coli')."
    inputBinding:
      position: 1
      prefix: --gtdb-taxon
  - id: gtdb_release
    type:
      - 'null'
      - string
    doc: "GTDB release to use. [Current default is R226]."
    inputBinding:
      position: 1
      prefix: --gtdb-release
  - id: download_premade
    type:
      - 'null'
      - string
    doc: "Download and setup pre-made databases of representative genomes for specific taxon/genus. Provide name of the taxon, e.g. \"Escherichia\"."
    inputBinding:
      position: 1
      prefix: --download-premade
  - id: output_dir
    type: string
    doc: "Output directory, which can then be provided as input for the \"-tg\" argument in fai. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: rename_locus_tags
    type:
      - 'null'
      - boolean
    doc: "Whether to rename all locus tags for CDS features if provided GenBanks as input."
    inputBinding:
      position: 1
      prefix: --rename-locus-tags
  - id: error_no_lt
    type:
      - 'null'
      - boolean
    doc: "Do not rename locus tags if not found/other issue - will result in skipping inclusion of entire genome."
    inputBinding:
      position: 1
      prefix: --error-no-lt
  - id: error_no_translation
    type:
      - 'null'
      - boolean
    doc: "Do not skip CDS without translation - will result in skipping inclusion of entire genome."
    inputBinding:
      position: 1
      prefix: --error-no-translation
  - id: locus_tag_length
    type:
      - 'null'
      - int
    doc: "Length of locus tags to set. [Default is 3, allows for < ~18k genomes]."
    inputBinding:
      position: 1
      prefix: --locus-tag-length
  - id: gene_calling_method
    type:
      - 'null'
      - string
    doc: "Method to use for gene calling. Options are: pyrodigal, prodigal, or prodigal-gv. [Default is pyrodigal]."
    inputBinding:
      position: 1
      prefix: --gene-calling-method
  - id: meta_mode
    type:
      - 'null'
      - boolean
    doc: "Flag to use meta mode instead of single for pyrodigal/prodigal."
    inputBinding:
      position: 1
      prefix: --meta-mode
  - id: reference_proteome
    type:
      - 'null'
      - File
    doc: "Provide path to a reference proteome to use for protein/ gene-calling in target genomes - which should be in FASTA format."
    inputBinding:
      position: 1
      prefix: --reference-proteome
  - id: create_species_tree
    type:
      - 'null'
      - boolean
    doc: "Use skani to infer a neighbor-joing based species tree for the genomes."
    inputBinding:
      position: 1
      prefix: --create-species-tree
  - id: mge_annotation
    type:
      - 'null'
      - boolean
    doc: "Perform MGE annotation of proteins - for bacterial genomes only."
    inputBinding:
      position: 1
      prefix: --mge-annotation
  - id: collapsing_params
    type:
      - 'null'
      - string
    doc: "DIAMOND linclust parameters used for collapsing proteins for creating DIAMOND database. [Default is \"--approx-id 90 --mutual-cover 90\"]."
    inputBinding:
      position: 1
      prefix: --collapsing-params=
      separate: false
  - id: skip_diamond_linclust
    type:
      - 'null'
      - boolean
    doc: "Skip DIAMOND linclust clustering of proteins."
    inputBinding:
      position: 1
      prefix: --skip-diamond-linclust
  - id: recluster
    type:
      - 'null'
      - boolean
    doc: "Perform DIAMOND recluster to improve protein clustering."
    inputBinding:
      position: 1
      prefix: --recluster
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads to use. [Default is 1]."
    inputBinding:
      position: 1
      prefix: --threads
  - id: max_memory
    type:
      - 'null'
      - int
    doc: "Uses resource module to set soft memory limit. Provide in Giga-bytes. Configured in the shell environment. For DIAMOND linclust if this parameter is not set it will default to using a memory of 16GB. [Default is None]."
    inputBinding:
      position: 1
      prefix: --max-memory
outputs:
  - id: output_dir_dir
    type: Directory
    doc: Results directory written with --output-dir.
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
