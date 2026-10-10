cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacache
  - build
label: metacache_build
doc: "Build a new MetaCache database from reference sequences (usually genomes).\n\nTool homepage: https://github.com/muellan/metacache"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: database
    type: string
    doc: "Name of the database to create"
    inputBinding:
      position: 1
  - id: sequence_files
    type:
      type: array
      items:
        - File
        - Directory
    doc: "FASTA or FASTQ files, or directories searched for sequence files, with the reference genomes"
    inputBinding:
      position: 2
  - id: taxonomy
    type: 
      - 'null'
      - Directory
    doc: "directory with taxonomic hierarchy data (see NCBI's taxonomic data files)"
    inputBinding:
      position: 100
      prefix: -taxonomy
  - id: taxpostmap
    type: 
      - 'null'
      - File
    doc: "Files with sequence to taxon id mappings that are used as alternative source in a post processing step. default: 'nucl_(gb|wgs|est|gss).accession2taxid'"
    inputBinding:
      position: 101
      prefix: -taxpostmap
  - id: sequence_id_format
    type: 
      - 'null'
      - string
    doc: "Method used for extracting sequence IDs from filenames and sequence headers. Sequence IDs are also used to assign taxa to reference sequences. Available types are: smart       : try NCBI > genbank > filename ncbi        : NCBI-style accession/accession.version gi          : genbank identifier filena"
    inputBinding:
      position: 102
      prefix: -sequence-id-format
  - id: kmerlen
    type: 
      - 'null'
      - int
    doc: "number of nucleotides/characters in a k-mer default: 16"
    inputBinding:
      position: 103
      prefix: -kmerlen
  - id: sketchlen
    type: 
      - 'null'
      - int
    doc: "number of features (k-mer hashes) per sampling window default: 16"
    inputBinding:
      position: 104
      prefix: -sketchlen
  - id: winlen
    type: 
      - 'null'
      - int
    doc: "number of letters in each sampling window default: 127"
    inputBinding:
      position: 105
      prefix: -winlen
  - id: winstride
    type: 
      - 'null'
      - int
    doc: "distance between window starting positions default: 112 (w-k+1)"
    inputBinding:
      position: 106
      prefix: -winstride
  - id: reset_taxa
    type: 
      - 'null'
      - boolean
    doc: "Attempts to re-rank all sequences after the main build phase using '.accession2taxid' files. This will reset the taxon id of a reference sequence even if a taxon id could be obtained from other sources during the build phase. default: off"
    inputBinding:
      position: 107
      prefix: -reset-taxa
  - id: max_locations_per_feature
    type: 
      - 'null'
      - int
    doc: "maximum number of reference sequence locations to be stored per feature; If the value is too high it will significantly impact querying speed. Note that an upper hard limit is always imposed by the data type used for the hash table bucket size (set with compilation macro '-DMC_LOCATION_LIST_SIZE_TYP"
    inputBinding:
      position: 108
      prefix: -max-locations-per-feature
  - id: remove_overpopulated_features
    type: 
      - 'null'
      - boolean
    doc: "Removes all features that have reached the maximum allowed amount of locations per feature. This can improve querying speed and can be used to remove non-discriminative features. default: off Not available in the GPU version."
    inputBinding:
      position: 109
      prefix: -remove-overpopulated-features
  - id: remove_ambig_features
    type: 
      - 'null'
      - string
    doc: "Removes all features that have more distinct reference sequence on the given taxonomic rank than set by '-max-ambig-per-feature'. This can decrease the database size significantly at the expense of sensitivity. Note that the lower the given taxonomic rank is, the more pronounced the effect will be. "
    inputBinding:
      position: 110
      prefix: -remove-ambig-features
  - id: max_ambig_per_feature
    type: 
      - 'null'
      - int
    doc: "Maximum number of allowed different reference sequence taxa per feature if option '-remove-ambig-features' is used. Not available in the GPU version."
    inputBinding:
      position: 111
      prefix: -max-ambig-per-feature
  - id: max_load_fac
    type: 
      - 'null'
      - float
    doc: "maximum hash table load factor; This can be used to trade off larger memory consumption for speed and vice versa. A lower load factor will improve speed, a larger one will improve memory efficiency. default: 0.800000 Not available in the GPU version."
    inputBinding:
      position: 112
      prefix: -max-load-fac
  - id: parts
    type: 
      - 'null'
      - int
    doc: "Splits the database into multiple parts. Each part contains a separate hash table. default: 1"
    inputBinding:
      position: 113
      prefix: -parts
  - id: max_part_size
    type: 
      - 'null'
      - float
    doc: "Sets the maximum size of a database partition in gigabytes. default: no limit"
    inputBinding:
      position: 114
      prefix: -max-part-size
  - id: threads
    type: 
      - 'null'
      - int
    doc: "Sets the maximum number of parallel threads to use. More threads speed up the build process but require more memory. default (on this machine): 20"
    inputBinding:
      position: 115
      prefix: -threads
  - id: silent
    type: 
      - 'null'
      - boolean
    doc: "information level during build: silent => none"
    inputBinding:
      position: 150
      prefix: -silent
  - id: verbose
    type: 
      - 'null'
      - boolean
    doc: "information level during build: verbose => most detailed"
    inputBinding:
      position: 151
      prefix: -verbose
outputs:
  - id: database_files
    type: File[]
    doc: "Database files <database>.meta and <database>.cache*"
    outputBinding:
      glob: [$(inputs.database).meta, $(inputs.database).cache*]
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Standard error (progress and summary messages)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_build.out
