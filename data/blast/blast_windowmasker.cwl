cwlVersion: v1.2
class: CommandLineTool
baseCommand: windowmasker
label: blast_windowmasker
doc: Window based sequence masker
inputs:
  - id: ustat
    type: File
    doc: file with unit counts
    inputBinding:
      position: 101
      prefix: -ustat
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file name (not optional if used with -mk_counts or -convert 
      options)
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file
    type: string
    doc: output file name
    inputBinding:
      position: 101
      prefix: -out
  - id: check_duplicates
    type:
      - 'null'
      - boolean
    doc: check for duplicate sequences
    inputBinding:
      position: 101
      prefix: -checkdup
  - id: input_is_a_list
    type:
      - 'null'
      - boolean
    doc: indicates that -input represents a file containing a list of names of 
      fasta files to process, one name per line
    inputBinding:
      position: 101
      prefix: -fa_list
  - id: available_memory
    type:
      - 'null'
      - int
    doc: memory available for mk_counts option in megabytes
    inputBinding:
      position: 101
      prefix: -mem
  - id: info_string
    type:
      - 'null'
      - string
    doc: add metadata to the counts file
    inputBinding:
      position: 101
      prefix: -meta
  - id: unit_length
    type:
      - 'null'
      - int
    doc: number of bases in a unit
    inputBinding:
      position: 101
      prefix: -unit
  - id: genome_size
    type:
      - 'null'
      - int
    doc: total size of the genome
    inputBinding:
      position: 101
      prefix: -genome_size
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size
    inputBinding:
      position: 101
      prefix: -window
  - id: t_extend
    type:
      - 'null'
      - int
    doc: window score above which it is allowed to extend masking
    inputBinding:
      position: 101
      prefix: -t_extend
  - id: t_threshold
    type:
      - 'null'
      - int
    doc: window score threshold used to trigger masking
    inputBinding:
      position: 101
      prefix: -t_thres
  - id: set_t_high
    type:
      - 'null'
      - int
    doc: alternative high score for a unit if theoriginal unit score is more 
      than highscore
    inputBinding:
      position: 101
      prefix: -set_t_high
  - id: set_t_low
    type:
      - 'null'
      - int
    doc: alternative low score for a unit if theoriginal unit score is lower 
      than lowscore
    inputBinding:
      position: 101
      prefix: -set_t_low
  - id: parse_seqids
    type:
      - 'null'
      - boolean
    doc: Parse Seq-ids in FASTA input
    inputBinding:
      position: 101
      prefix: -parse_seqids
  - id: output_format
    type:
      - 'null'
      - string
    doc: controls the format of the masker output (for masking stage only)
    inputBinding:
      position: 101
      prefix: -outfmt
  - id: t_high
    type:
      - 'null'
      - int
    doc: maximum useful unit score
    inputBinding:
      position: 101
      prefix: -t_high
  - id: t_high_pct
    type:
      - 'null'
      - float
    doc: maximum useful unit score as percentage
    inputBinding:
      position: 101
      prefix: -t_high_pct
  - id: t_threshold_pct
    type:
      - 'null'
      - float
    doc: window score threshold used to trigger masking as percentage
    inputBinding:
      position: 101
      prefix: -t_thres_pct
  - id: t_extend_pct
    type:
      - 'null'
      - float
    doc: window score above which it is allowed to extend masking as percentage
    inputBinding:
      position: 101
      prefix: -t_extend_pct
  - id: t_low
    type:
      - 'null'
      - int
    doc: minimum useful unit score
    inputBinding:
      position: 101
      prefix: -t_low
  - id: t_low_pct
    type:
      - 'null'
      - float
    doc: minimum useful unit score as percentage
    inputBinding:
      position: 101
      prefix: -t_low_pct
  - id: input_format
    type:
      - 'null'
      - string
    doc: controls the format of the masker input
    inputBinding:
      position: 101
      prefix: -infmt
  - id: exclude_id_list
    type:
      - 'null'
      - File
    doc: file containing the list of ids to exclude from processing
    inputBinding:
      position: 101
      prefix: -exclude_ids
  - id: id_list
    type:
      - 'null'
      - File
    doc: file containing the list of ids to process
    inputBinding:
      position: 101
      prefix: -ids
  - id: text_match_ids
    type:
      - 'null'
      - boolean
    doc: match ids as strings
    inputBinding:
      position: 101
      prefix: -text_match
  - id: unit_counts_format
    type:
      - 'null'
      - string
    doc: controls the format of the output file containing the unit counts (for 
      counts generation and conversion only)
    inputBinding:
      position: 101
      prefix: -sformat
  - id: available_memory_output
    type:
      - 'null'
      - int
    doc: target size of the output file containing the unit counts
    inputBinding:
      position: 101
      prefix: -smem
  - id: use_dust
    type:
      - 'null'
      - boolean
    doc: combine window masking with dusting
    inputBinding:
      position: 101
      prefix: -dust
  - id: dust_level
    type:
      - 'null'
      - int
    doc: dust minimum level
    inputBinding:
      position: 101
      prefix: -dust_level
  - id: mk_counts
    type:
      - 'null'
      - boolean
    doc: generate frequency counts for a database
    inputBinding:
      position: 101
      prefix: -mk_counts
  - id: convert
    type:
      - 'null'
      - boolean
    doc: convert counts between different formats
    inputBinding:
      position: 101
      prefix: -convert
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast:2.17.0--h66d330f_0
s:url: https://blast.ncbi.nlm.nih.gov/doc/blast-help/
$namespaces:
  s: https://schema.org/
