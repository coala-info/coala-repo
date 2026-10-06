cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - architeuthis
  - mapping
  - filter
label: architeuthis_mapping_filter
doc: "Filter Kraken output based on read quality.\n\nTool homepage: https://github.com/cdiener/architeuthis"
inputs:
  - id: kraken_output
    type: File
    doc: Kraken2 read-level output file to filter.
    inputBinding:
      position: 10
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: The path to the taxonomy dumps (NCBI taxdump folder with names.dmp and nodes.dmp).
    inputBinding:
      position: 1
      prefix: --data-dir
  - id: format
    type:
      - 'null'
      - string
    doc: The taxonomic ranks to consider during scoring. (default "d__{domain|acellularroot|superkingdom};p__{phylum};c__{class};o__{order};f__{family};g__{genus};s__{species}")
    inputBinding:
      position: 1
      prefix: --format
  - id: max_entropy
    type:
      - 'null'
      - float
    doc: Maximum entropy for kmer classifications at classified rank. (default 0.1)
    inputBinding:
      position: 1
      prefix: --max-entropy
  - id: max_multiplicity
    type:
      - 'null'
      - int
    doc: Maximum number of alternative classifications on the classified rank. (default
      2)
    inputBinding:
      position: 1
      prefix: --max-multiplicity
  - id: min_consistency
    type:
      - 'null'
      - float
    doc: Minimum consistency of the read classification. (default 0.9)
    inputBinding:
      position: 1
      prefix: --min-consistency
  - id: out
    type: string
    doc: The output file (Kraken format). (default "filtered.k2")
    inputBinding:
      position: 1
      prefix: --out
    default: filtered.k2
  - id: db
    type:
      - 'null'
      - Directory
    doc: path to the Kraken database [optional]
    inputBinding:
      position: 1
      prefix: --db
outputs:
  - id: output
    type: File
    doc: The filtered Kraken output (a subset of the input reads).
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
