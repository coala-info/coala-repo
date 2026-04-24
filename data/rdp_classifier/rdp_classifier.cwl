cwlVersion: v1.2
class: CommandLineTool
baseCommand: ClassifierCmd
label: rdp_classifier
doc: "Note this is the legacy command for one sample classification\n\nTool homepage:
  http://rdp.cme.msu.edu/"
inputs:
  - id: samplefile
    type: File
    doc: samplefile
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: "tab-delimited output format: [allrank|fixrank|biom|filterbyconf|db]. Default
      is allRank.\n                             allrank: outputs the results for all
      ranks applied for each sequence: seqname, orientation,\n                   \
      \          taxon name, rank, conf, ...\n                             fixrank:
      only outputs the results for fixed ranks in order: domain, phylum, class, order,\n\
      \                             family, genus\n                             biom:
      outputs rich dense biom format if OTU or metadata provided\n               \
      \              filterbyconf: only outputs the results for major ranks as in
      fixrank, results below the\n                             confidence cutoff were
      bin to a higher rank unclassified_node\n                             db: outputs
      the seqname, trainset_no, tax_id, conf."
    inputBinding:
      position: 102
      prefix: --format
  - id: gene
    type:
      - 'null'
      - string
    doc: "16srrna, fungallsu, fungalits_warcup, fungalits_unite. Default is 16srrna.
      This option can\n                             be overwritten by -t option"
    inputBinding:
      position: 102
      prefix: --gene
  - id: min_words
    type:
      - 'null'
      - int
    doc: "minimum number of words for each bootstrap trial. Default(maximum) is 1/8
      of the words of\n                             each sequence. Minimum is 5"
    inputBinding:
      position: 102
      prefix: --minWords
  - id: query_file
    type:
      - 'null'
      - boolean
    doc: legacy option, no longer needed
    inputBinding:
      position: 102
      prefix: --queryFile
  - id: train_propfile
    type:
      - 'null'
      - File
    doc: "property file containing the mapping of the training files if not using
      the default. Note: \n                             the training files and the
      property file should be in the same directory."
    inputBinding:
      position: 102
      prefix: --train_propfile
outputs:
  - id: output_file
    type: File
    doc: tab-delimited text output file for classification assignment.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-classifier:v2.10.2-4-deb_cv1
