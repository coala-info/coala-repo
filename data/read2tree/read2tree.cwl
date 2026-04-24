cwlVersion: v1.2
class: CommandLineTool
baseCommand: read2tree
label: read2tree
doc: "read2tree is a pipeline allowing to use read data in combination with an OMA
  standalone output run to produce high quality trees.\n\nTool homepage: https://github.com/DessimozLab/read2tree"
inputs:
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Reads to be mapped to reference. If paired end add separated by space.
    inputBinding:
      position: 1
  - id: coverage
    type:
      - 'null'
      - int
    doc: coverage in X. Only considered if --sample reads is selected.
    inputBinding:
      position: 102
      prefix: --coverage
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Changes to debug mode: * bam files are saved!* reads are saved by mapping
      to OG'
    inputBinding:
      position: 102
      prefix: --debug
  - id: dna_reference
    type:
      - 'null'
      - File
    doc: 'Reference file that contains nucleotide sequences (fasta, hdf5). If not
      given it will usethe RESTapi and retrieve sequences from http://omabrowser.org
      directly. NOTE: internet connection required!'
    inputBinding:
      position: 102
      prefix: --dna_reference
  - id: genome_len
    type:
      - 'null'
      - int
    doc: Genome size in bp.
    inputBinding:
      position: 102
      prefix: --genome_len
  - id: ignore_species
    type:
      - 'null'
      - string
    doc: Ignores species part of the OMA standalone pipeline. Input is comma 
      separated list without spaces, e.g. XXX,YYY,AAA.
    inputBinding:
      position: 102
      prefix: --ignore_species
  - id: keep_all_ogs
    type:
      - 'null'
      - boolean
    doc: Keep all orthologs after addition of mapped seq, which means also the 
      OGs that have no mapped sequence. Otherwise only OGs are used that have 
      the mapped sequence for alignment and tree inference.
    inputBinding:
      position: 102
      prefix: --keep_all_ogs
  - id: min_cons_coverage
    type:
      - 'null'
      - int
    doc: Minimum number of nucleotides at column.
    inputBinding:
      position: 102
      prefix: --min_cons_coverage
  - id: min_species
    type:
      - 'null'
      - int
    doc: Min number of species in selected orthologous groups. If not selected 
      it will be estimated such that around 1000 OGs are available.
    inputBinding:
      position: 102
      prefix: --min_species
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    inputBinding:
      position: 102
      prefix: --output_path
  - id: read_type
    type:
      - 'null'
      - string
    doc: 'Minimap2 command-line options for mapping reads to reference. Examples:
      -ax sr , -ax map-hifi , -ax map-pb or -ax map-ont'
    inputBinding:
      position: 102
      prefix: --read_type
  - id: remove_species_mapping
    type:
      - 'null'
      - string
    doc: Remove species present in data set after mapping step completed and 
      only do analysis on subset. Input is comma separated list without spaces, 
      e.g. XXX,YYY,AAA.
    inputBinding:
      position: 102
      prefix: --remove_species_mapping
  - id: remove_species_ogs
    type:
      - 'null'
      - string
    doc: Remove species present in data set after mapping step completed to 
      build OGs. Input is comma separated list without spaces, e.g. XXX,YYY,AAA.
    inputBinding:
      position: 102
      prefix: --remove_species_ogs
  - id: sample_reads
    type:
      - 'null'
      - boolean
    doc: Splits reads as defined by split_len (200) and split_overlap (0) 
      parameters.
    inputBinding:
      position: 102
      prefix: --sample_reads
  - id: sc_threshold
    type:
      - 'null'
      - float
    doc: Parameter for selection of sequences from mapping by completeness 
      compared to its reference sequence (number of ACGT basepairs vs length of 
      sequence). By default, all sequences are selected.
    inputBinding:
      position: 102
      prefix: --sc_threshold
  - id: sequence_selection_mode
    type:
      - 'null'
      - string
    doc: Possibilities are cov and cov_sc for mapped sequence.
    inputBinding:
      position: 102
      prefix: --sequence_selection_mode
  - id: species_name
    type:
      - 'null'
      - string
    doc: Name of species for mapped sequence.
    inputBinding:
      position: 102
      prefix: --species_name
  - id: standalone_path
    type:
      - 'null'
      - Directory
    doc: Path to oma standalone directory.
    inputBinding:
      position: 102
      prefix: --standalone_path
  - id: step
    type:
      - 'null'
      - string
    doc: Step of the pipeline
    inputBinding:
      position: 102
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for gene marker alignment (mafft) and read mapping 
      (minimap2) and tree inference (iqtree)
    inputBinding:
      position: 102
      prefix: --threads
  - id: tree
    type:
      - 'null'
      - boolean
    doc: Compute tree, otherwise just output concatenated alignment!
    inputBinding:
      position: 102
      prefix: --tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/read2tree:2.0.1--pyhdfd78af_0
stdout: read2tree.out
