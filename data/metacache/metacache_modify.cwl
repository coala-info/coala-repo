cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacache
  - modify
label: metacache_modify
doc: "Add reference sequences and/or taxonomy to an existing MetaCache database.\n\nTool homepage: https://github.com/muellan/metacache"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        return (inputs.database_files || []).map(function (f) { return {entryname: f.basename, entry: f, writable: true}; });
      }
inputs:
  - id: database
    type: string
    doc: "Name of the existing database"
    inputBinding:
      position: 1
  - id: database_files
    type:
      type: array
      items: File
    doc: "Database files (<database>.meta and <database>.cache0, .cache1, ...) staged in the working directory"
  - id: sequence_files
    type:
      type: array
      items:
        - File
        - Directory
    doc: "FASTA or FASTQ files, or directories, with the sequences to add"
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
  - id: reset_taxa
    type: 
      - 'null'
      - boolean
    doc: "Attempts to re-rank all sequences after the main build phase using '.accession2taxid' files. This will reset the taxon id of a reference sequence even if a taxon id could be obtained from other sources during the build phase. default: off"
    inputBinding:
      position: 103
      prefix: -reset-taxa
  - id: max_locations_per_feature
    type: 
      - 'null'
      - int
    doc: "maximum number of reference sequence locations to be stored per feature; If the value is too high it will significantly impact querying speed. Note that an upper hard limit is always imposed by the data type used for the hash table bucket size (set with compilation macro '-DMC_LOCATION_LIST_SIZE_TYP"
    inputBinding:
      position: 104
      prefix: -max-locations-per-feature
  - id: remove_overpopulated_features
    type: 
      - 'null'
      - boolean
    doc: "Removes all features that have reached the maximum allowed amount of locations per feature. This can improve querying speed and can be used to remove non-discriminative features. default: off Not available in the GPU version."
    inputBinding:
      position: 105
      prefix: -remove-overpopulated-features
  - id: remove_ambig_features
    type: 
      - 'null'
      - string
    doc: "Removes all features that have more distinct reference sequence on the given taxonomic rank than set by '-max-ambig-per-feature'. This can decrease the database size significantly at the expense of sensitivity. Note that the lower the given taxonomic rank is, the more pronounced the effect will be. "
    inputBinding:
      position: 106
      prefix: -remove-ambig-features
  - id: max_ambig_per_feature
    type: 
      - 'null'
      - int
    doc: "Maximum number of allowed different reference sequence taxa per feature if option '-remove-ambig-features' is used. Not available in the GPU version."
    inputBinding:
      position: 107
      prefix: -max-ambig-per-feature
  - id: max_load_fac
    type: 
      - 'null'
      - float
    doc: "maximum hash table load factor; This can be used to trade off larger memory consumption for speed and vice versa. A lower load factor will improve speed, a larger one will improve memory efficiency. default: 0.800000 Not available in the GPU version."
    inputBinding:
      position: 108
      prefix: -max-load-fac
  - id: silent
    type: 
      - 'null'
      - boolean
    doc: "information level: silent => none"
    inputBinding:
      position: 150
      prefix: -silent
  - id: verbose
    type: 
      - 'null'
      - boolean
    doc: "information level: verbose => most detailed"
    inputBinding:
      position: 151
      prefix: -verbose
outputs:
  - id: database_files
    type: File[]
    doc: "Modified database files"
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
stdout: metacache_modify.out
