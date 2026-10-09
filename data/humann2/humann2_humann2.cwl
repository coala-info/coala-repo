cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2
label: humann2_humann2
doc: "HUMAnN2 : HMP Unified Metabolic Analysis Network 2\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: input
    type: File
    doc: "input file of type {fastq,fastq.gz,fasta,fasta.gz,sam,bam,blastm8,genetable,biom}"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: output_path
    type: string
    doc: "directory to write output files"
    inputBinding:
      position: 102
      prefix: "--output"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "additional output is printed"
    inputBinding:
      position: 103
      prefix: "--verbose"
  - id: resume
    type:
      - 'null'
      - boolean
    doc: "bypass commands if the output files exist"
    inputBinding:
      position: 104
      prefix: "--resume"
  - id: bypass_prescreen
    type:
      - 'null'
      - boolean
    doc: "bypass the prescreen step and run on the full ChocoPhlAn database"
    inputBinding:
      position: 105
      prefix: "--bypass-prescreen"
  - id: bypass_nucleotide_index
    type:
      - 'null'
      - boolean
    doc: "bypass the nucleotide index step and run on the indexed ChocoPhlAn database"
    inputBinding:
      position: 106
      prefix: "--bypass-nucleotide-index"
  - id: bypass_translated_search
    type:
      - 'null'
      - boolean
    doc: "bypass the translated search step"
    inputBinding:
      position: 107
      prefix: "--bypass-translated-search"
  - id: bypass_nucleotide_search
    type:
      - 'null'
      - boolean
    doc: "bypass the nucleotide search steps"
    inputBinding:
      position: 108
      prefix: "--bypass-nucleotide-search"
  - id: nucleotide_database
    type:
      - 'null'
      - Directory
    doc: "directory containing the nucleotide database [DEFAULT: demo ChocoPhlAn database of the image]"
    inputBinding:
      position: 109
      prefix: "--nucleotide-database"
  - id: annotation_gene_index
    type:
      - 'null'
      - int
    doc: "the index of the gene in the sequence annotation [DEFAULT: 8]"
    inputBinding:
      position: 110
      prefix: "--annotation-gene-index"
  - id: protein_database
    type:
      - 'null'
      - Directory
    doc: "directory containing the protein database [DEFAULT: demo UniRef database of the image]"
    inputBinding:
      position: 111
      prefix: "--protein-database"
  - id: evalue
    type:
      - 'null'
      - float
    doc: "the evalue threshold to use with the translated search [DEFAULT: 1.0]"
    inputBinding:
      position: 112
      prefix: "--evalue"
  - id: search_mode
    type:
      - 'null'
      - string
    doc: "search for uniref50 or uniref90 gene families"
    inputBinding:
      position: 113
      prefix: "--search-mode"
  - id: metaphlan
    type:
      - 'null'
      - string
    doc: "directory containing the MetaPhlAn software [DEFAULT: $PATH]"
    inputBinding:
      position: 114
      prefix: "--metaphlan"
  - id: metaphlan_options
    type:
      - 'null'
      - string
    doc: "options to be provided to the MetaPhlAn software"
    inputBinding:
      position: 115
      prefix: "--metaphlan-options"
  - id: o_log
    type:
      - 'null'
      - string
    doc: "log file [DEFAULT: temp/sample.log]"
    inputBinding:
      position: 116
      prefix: "--o-log"
  - id: log_level
    type:
      - 'null'
      - string
    doc: "level of messages to display in log: DEBUG, INFO, WARNING, ERROR or CRITICAL"
    inputBinding:
      position: 117
      prefix: "--log-level"
  - id: remove_temp_output
    type:
      - 'null'
      - boolean
    doc: "remove temp output files"
    inputBinding:
      position: 118
      prefix: "--remove-temp-output"
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads/processes [DEFAULT: 1]"
    inputBinding:
      position: 119
      prefix: "--threads"
  - id: prescreen_threshold
    type:
      - 'null'
      - float
    doc: "minimum percentage of reads matching a species [DEFAULT: 0.01]"
    inputBinding:
      position: 120
      prefix: "--prescreen-threshold"
  - id: identity_threshold
    type:
      - 'null'
      - float
    doc: "identity threshold for alignments [DEFAULT: 50.0]"
    inputBinding:
      position: 121
      prefix: "--identity-threshold"
  - id: translated_subject_coverage_threshold
    type:
      - 'null'
      - float
    doc: "subject coverage threshold for translated alignments [DEFAULT: 50.0]"
    inputBinding:
      position: 122
      prefix: "--translated-subject-coverage-threshold"
  - id: translated_query_coverage_threshold
    type:
      - 'null'
      - float
    doc: "query coverage threshold for translated alignments [DEFAULT: 90.0]"
    inputBinding:
      position: 123
      prefix: "--translated-query-coverage-threshold"
  - id: bowtie2
    type:
      - 'null'
      - string
    doc: "directory containing the bowtie2 executable"
    inputBinding:
      position: 124
      prefix: "--bowtie2"
  - id: usearch
    type:
      - 'null'
      - string
    doc: "directory containing the usearch executable"
    inputBinding:
      position: 125
      prefix: "--usearch"
  - id: rapsearch
    type:
      - 'null'
      - string
    doc: "directory containing the rapsearch executable"
    inputBinding:
      position: 126
      prefix: "--rapsearch"
  - id: diamond
    type:
      - 'null'
      - string
    doc: "directory containing the diamond executable"
    inputBinding:
      position: 127
      prefix: "--diamond"
  - id: taxonomic_profile
    type:
      - 'null'
      - File
    doc: "a taxonomic profile (the output file created by metaphlan) [DEFAULT: file will be created]"
    inputBinding:
      position: 128
      prefix: "--taxonomic-profile"
  - id: id_mapping
    type:
      - 'null'
      - File
    doc: "id mapping file for alignments"
    inputBinding:
      position: 129
      prefix: "--id-mapping"
  - id: translated_alignment
    type:
      - 'null'
      - string
    doc: "software to use for translated alignment: usearch, rapsearch or diamond"
    inputBinding:
      position: 130
      prefix: "--translated-alignment"
  - id: xipe
    type:
      - 'null'
      - string
    doc: "turn on/off the xipe computation: on or off [DEFAULT: off]"
    inputBinding:
      position: 131
      prefix: "--xipe"
  - id: minpath
    type:
      - 'null'
      - string
    doc: "turn on/off the minpath computation: on or off [DEFAULT: on]"
    inputBinding:
      position: 132
      prefix: "--minpath"
  - id: pick_frames
    type:
      - 'null'
      - string
    doc: "turn on/off the pick_frames computation: on or off [DEFAULT: off]"
    inputBinding:
      position: 133
      prefix: "--pick-frames"
  - id: gap_fill
    type:
      - 'null'
      - string
    doc: "turn on/off the gap fill computation: on or off [DEFAULT: on]"
    inputBinding:
      position: 134
      prefix: "--gap-fill"
  - id: output_format
    type:
      - 'null'
      - string
    doc: "the format of the output files: tsv or biom"
    inputBinding:
      position: 135
      prefix: "--output-format"
  - id: output_max_decimals
    type:
      - 'null'
      - int
    doc: "the number of decimals to output [DEFAULT: 10]"
    inputBinding:
      position: 136
      prefix: "--output-max-decimals"
  - id: output_basename
    type:
      - 'null'
      - string
    doc: "the basename for the output files [DEFAULT: input file basename]"
    inputBinding:
      position: 137
      prefix: "--output-basename"
  - id: remove_stratified_output
    type:
      - 'null'
      - boolean
    doc: "remove stratification from output"
    inputBinding:
      position: 138
      prefix: "--remove-stratified-output"
  - id: remove_column_description_output
    type:
      - 'null'
      - boolean
    doc: "remove the description in the output column"
    inputBinding:
      position: 139
      prefix: "--remove-column-description-output"
  - id: input_format
    type:
      - 'null'
      - string
    doc: "the format of the input file: fastq, fastq.gz, fasta, fasta.gz, sam, bam, blastm8, genetable or biom"
    inputBinding:
      position: 140
      prefix: "--input-format"
  - id: pathways_database
    type:
      - 'null'
      - File
    doc: "mapping file to use for pathway computations [DEFAULT: metacyc database]"
    inputBinding:
      position: 141
      prefix: "--pathways-database"
  - id: pathways
    type:
      - 'null'
      - string
    doc: "the database to use for pathway computations: metacyc or unipathway"
    inputBinding:
      position: 142
      prefix: "--pathways"
  - id: memory_use
    type:
      - 'null'
      - string
    doc: "the amount of memory to use: minimum or maximum"
    inputBinding:
      position: 143
      prefix: "--memory-use"
outputs:
  - id: output
    type: Directory
    doc: "directory with the gene families, pathway abundance and pathway coverage tables"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
