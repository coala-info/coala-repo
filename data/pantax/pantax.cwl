cwlVersion: v1.2
class: CommandLineTool
baseCommand: pantax
label: pantax
doc: "Strain-level metagenomic profiling using pangenome graphs with PanTax\n\nTool
  homepage: https://github.com/LuoGroup2023/PanTax"
inputs:
  - id: ani_threshold
    type:
      - 'null'
      - float
    doc: ANI threshold for sylph query result filter.
    inputBinding:
      position: 101
      prefix: --ani
  - id: best_autoindex
    type:
      - 'null'
      - boolean
    doc: Best autoindex, which corresponds to vg autoindex. (only used with -s)
    inputBinding:
      position: 101
      prefix: --best
  - id: construct_index
    type:
      - 'null'
      - boolean
    doc: Create the index only.
    inputBinding:
      position: 101
      prefix: --index
  - id: coverage_depth_difference
    type:
      - 'null'
      - float
    doc: Coverage depth difference between the strain and its species, with only
      one strain.
    inputBinding:
      position: 101
      prefix: -sd
  - id: create_database
    type:
      - 'null'
      - boolean
    doc: Create the database only.
    inputBinding:
      position: 101
      prefix: --create
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Keep the temporary folder for any situation.
    inputBinding:
      position: 101
      prefix: --debug
  - id: dstrain
    type:
      - 'null'
      - float
    doc: "dstrain. The divergence between first rough and second refined strain abundance
      estimates. The smaller, the stricter.\n                                    \
      \      (default: 0.46)"
    inputBinding:
      position: 101
      prefix: -fc
  - id: fast_alignment
    type:
      - 'null'
      - boolean
    doc: Long read fast alignment with vg instead of Graphaligner. (only used 
      with -l)
    inputBinding:
      position: 101
      prefix: --fast-aln
  - id: fast_create
    type:
      - 'null'
      - boolean
    doc: Create the database using genomes filtered by sylph query instead of 
      all genomes.
    inputBinding:
      position: 101
      prefix: --fast
  - id: fastq_input
    type:
      - 'null'
      - type: array
        items: File
    doc: Read and align FASTQ-format reads from FILE (two are allowed with -p).
    inputBinding:
      position: 101
      prefix: --fastq-in
  - id: force_rebuild
    type:
      - 'null'
      - boolean
    doc: Force to rebuild pangenome.
    inputBinding:
      position: 101
      prefix: --force
  - id: fstrain
    type:
      - 'null'
      - float
    doc: "fstrain. The fraction of strain-specific triplet nodes covered by reads
      for one strain. The larger, the stricter.\n                                \
      \          (default: short 0.3/ long 0.5)"
    inputBinding:
      position: 101
      prefix: -fr
  - id: genomes_information
    type: File
    doc: A list of reference genomes in specified format.
    inputBinding:
      position: 101
      prefix: --genomesInformation
  - id: gurobi_threads
    type:
      - 'null'
      - int
    doc: Gurobi threads.
    inputBinding:
      position: 101
      prefix: -gt
  - id: long_read_alignment
    type:
      - 'null'
      - boolean
    doc: Long read alignment.
    inputBinding:
      position: 101
      prefix: --long-read
  - id: long_read_type
    type:
      - 'null'
      - string
    doc: Long read type (hifi, clr, ontr9, ontr10). Set precise-clipping based 
      on read type.
    inputBinding:
      position: 101
      prefix: --long-read-type
  - id: lz4_serialized_zip_graph
    type:
      - 'null'
      - boolean
    doc: Serialized zip graph file saved with lz4 format (for save option).
    inputBinding:
      position: 101
      prefix: --lz
  - id: min_graph_node_coverage
    type:
      - 'null'
      - int
    doc: Graph nodes with sequence coverage depth more than <min_depth>.
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_strain_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage depth required per strain.
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: mlp_solver
    type:
      - 'null'
      - string
    doc: 'MLP solver. (options: gurobi, cbc, glpk, highs. default: gurobi)'
    inputBinding:
      position: 101
      prefix: --solver
  - id: next
    type:
      - 'null'
      - boolean
    doc: Keep the temporary folder for later use at the strain level (resume).
    inputBinding:
      position: 101
      prefix: --next
  - id: paired_end_alignment
    type:
      - 'null'
      - boolean
    doc: For paired-end alignment.
    inputBinding:
      position: 101
      prefix: --paired
  - id: pangenome_builder_executable
    type:
      - 'null'
      - File
    doc: Path to pangenome building tool executable file.
    inputBinding:
      position: 101
      prefix: -e
  - id: pantax_db
    type:
      - 'null'
      - Directory
    doc: Name for pantax DB
    inputBinding:
      position: 101
  - id: precise_clipping
    type:
      - 'null'
      - float
    doc: clip the alignment ends with arg as the identity cutoff between correct
      / wrong alignments.
    inputBinding:
      position: 101
      prefix: --precise-clipping
  - id: rescued_strain_retention_score
    type:
      - 'null'
      - float
    doc: Rescued strain retention score.
    inputBinding:
      position: 101
      prefix: -sr
  - id: save_species_graph
    type:
      - 'null'
      - boolean
    doc: Save species graph information.
    inputBinding:
      position: 101
      prefix: --save
  - id: shift_fraction
    type:
      - 'null'
      - boolean
    doc: 'Shifting fraction of strain-specific triplet nodes. (multi-species: off,
      single-species: on)'
    inputBinding:
      position: 101
      prefix: --shift
  - id: short_read_alignment
    type:
      - 'null'
      - boolean
    doc: Short read alignment.
    inputBinding:
      position: 101
      prefix: --short-read
  - id: species
    type:
      - 'null'
      - boolean
    doc: Species abundance calulation.
    inputBinding:
      position: 101
      prefix: --species
  - id: species_abundance_threshold
    type:
      - 'null'
      - float
    doc: Species with relative abundance above the threshold are used for strain
      abundance estimation.
    inputBinding:
      position: 101
      prefix: -a
  - id: species_level_abundance
    type:
      - 'null'
      - boolean
    doc: Species abundance calulation.
    inputBinding:
      position: 101
      prefix: --species-level
  - id: strain
    type:
      - 'null'
      - boolean
    doc: Strain abundance calulation.
    inputBinding:
      position: 101
      prefix: --strain
  - id: strain_level_abundance
    type:
      - 'null'
      - boolean
    doc: Strain abundance calulation.
    inputBinding:
      position: 101
      prefix: --strain-level
  - id: temporary_directory
    type:
      - 'null'
      - Directory
    doc: Temporary directory
    inputBinding:
      position: 101
      prefix: -T
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processes to run in parallel.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Detailed database build log.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: vg_executable
    type:
      - 'null'
      - File
    doc: Path to vg executable file.
    inputBinding:
      position: 101
      prefix: --vg
  - id: zstd_serialized_zip_graph
    type:
      - 'null'
      - boolean
    doc: Serialized zip graph file saved with zstd format (for save option).
    inputBinding:
      position: 101
      prefix: --zstd
outputs:
  - id: classified_output_prefix
    type:
      - 'null'
      - File
    doc: File for alignment output(prefix).
    outputBinding:
      glob: $(inputs.classified_output_prefix)
  - id: report_output_prefix
    type:
      - 'null'
      - File
    doc: File for read classification(binning) output(prefix).
    outputBinding:
      glob: $(inputs.report_output_prefix)
  - id: abundance_output_prefix
    type:
      - 'null'
      - File
    doc: File for abundance output(prefix).
    outputBinding:
      glob: $(inputs.abundance_output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantax:2.0.1--py310h3e1df6f_1
