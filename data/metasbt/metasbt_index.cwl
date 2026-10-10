cwlVersion: v1.2
class: CommandLineTool
baseCommand: [metasbt, index]
label: metasbt_index
doc: "Index a set of reference genomes. This is used to build a first baseline of a MetaSBT database. Genomes must be known with a fully defined taxonomic label, from the kingdom up to the species level.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.workdir)
        entry: "$({class: 'Directory', basename: inputs.workdir, listing: []})"
        writable: true
      - "$(inputs.reference_genomes ? inputs.reference_genomes : [])"
inputs:
  - id: workdir
    type: string
    doc: "Path to the working directory (created before the run)."
    inputBinding:
      position: 101
      prefix: "--workdir"
  - id: database
    type: string
    doc: "The database name."
    inputBinding:
      position: 101
      prefix: "--database"
  - id: references
    type: File
    doc: "Path to the tab-separated-values file with the list of reference genomes. It must contain two columns. The first one with the path to the actual reference genomes. The second one with their fully defined taxonomic label in the following form: k__Kingdom|p__Phylum|c__Class|o__Order|f__Family|g__Genus|s__Species"
    inputBinding:
      position: 101
      prefix: "--references"
  - id: reference_genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: "The genome files named in the references table; they are staged in the working directory so that the names in the table resolve."
  - id: dereplicate
    type:
      - 'null'
      - float
    doc: "Dereplicate genomes based of their ANI distance according the specified threshold. The dereplication process is triggered in case of a threshold >0.0. (default: 0.0)"
    inputBinding:
      position: 101
      prefix: "--dereplicate"
  - id: nproc
    type:
      - 'null'
      - int
    doc: "Process the input genomes in parallel. (default: 20)"
    inputBinding:
      position: 101
      prefix: "--nproc"
  - id: pack
    type:
      - 'null'
      - boolean
    doc: "Pack the database into a compressed tarball. (default: False)"
    inputBinding:
      position: 101
      prefix: "--pack"
  - id: filter_size
    type:
      - 'null'
      - int
    doc: "This is the size of the bloom filters. It automatically estimates a proper bloom filter size if not provided."
    inputBinding:
      position: 101
      prefix: "--filter-size"
  - id: increase_filter_size
    type:
      - 'null'
      - float
    doc: "Increase the estimated filter size by the specified percentage. It is highly recommended to increase the filter size by a good percentage in case you are planning to update the index with new genomes. (default: 50.0)"
    inputBinding:
      position: 101
      prefix: "--increase-filter-size"
  - id: min_kmer_occurrences
    type:
      - 'null'
      - int
    doc: "Minimum number of occurrences of kmers to be considered for estimating the bloom filter size and for building the bloom filter files. (default: 2)"
    inputBinding:
      position: 101
      prefix: "--min-kmer-occurrences"
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: "The kmer size. It automatically estimates a proper bloom filter size if not provided."
    inputBinding:
      position: 101
      prefix: "--kmer-size"
  - id: limit_kmer_size
    type:
      - 'null'
      - int
    doc: "Limit the estimation of the optimal kmer size with kitsune to this size at most. (default: 32)"
    inputBinding:
      position: 101
      prefix: "--limit-kmer-size"
  - id: completeness
    type:
      - 'null'
      - float
    doc: "Percentage threshold on genomes completeness. (default: 0.0)"
    inputBinding:
      position: 101
      prefix: "--completeness"
  - id: contamination
    type:
      - 'null'
      - float
    doc: "Percentage threshold on genomes contamination. (default: 100.0)"
    inputBinding:
      position: 101
      prefix: "--contamination"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: workdir_out
    type: Directory
    doc: "Working directory with the database and the results"
    outputBinding:
      glob: "$(inputs.workdir)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
    dockerOutputDirectory: /metasbt_work
stdout: metasbt_index.out
