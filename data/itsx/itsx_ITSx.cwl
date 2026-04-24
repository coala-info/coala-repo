cwlVersion: v1.2
class: CommandLineTool
baseCommand: ITSx
label: itsx_ITSx
doc: "ITSx - ITSx is a tool for the automated identification of eukaryotic Internal
  Transcribed Spacer (ITS) sequences.\n\nTool homepage: http://microbiology.se/software/itsx/"
inputs:
  - id: add_date_stamp
    type:
      - 'null'
      - boolean
    doc: Adds a date and time stamp to the output directory, off (F) by default
    inputBinding:
      position: 101
      prefix: --date
  - id: allow_reorder
    type:
      - 'null'
      - boolean
    doc: Allows profiles to be in the wrong order on extracted sequences, off 
      (F) by default
    inputBinding:
      position: 101
      prefix: --allow_reorder
  - id: allow_single_domain
    type:
      - 'null'
      - string
    doc: Allow inclusion of sequences that only find a single domain, given that
      they meet the given E-value and score thresholds, on with parameters 
      1e-9,0 by default
    inputBinding:
      position: 101
      prefix: --allow_single_domain
  - id: anchor_bases
    type:
      - 'null'
      - string
    doc: Saves an additional number of bases before and after each extracted 
      region. If set to 'HMM' all bases matching the corresponding HMM will be 
      output
    inputBinding:
      position: 101
      prefix: --anchor
  - id: bugs
    type:
      - 'null'
      - boolean
    doc: displays the bug fixes and known bugs in this version of ITSx
    inputBinding:
      position: 101
      prefix: --bugs
  - id: check_complement
    type:
      - 'null'
      - boolean
    doc: Checks both DNA strands against the database, creating reverse 
      complements, on (T) by default
    inputBinding:
      position: 101
      prefix: --complement
  - id: cpu_threads
    type:
      - 'null'
      - int
    doc: the number of CPU threads to use
    inputBinding:
      position: 101
      prefix: --cpu
  - id: domain_evalue_cutoff
    type:
      - 'null'
      - float
    doc: Domain E-value cutoff for a sequence to be included in the output
    inputBinding:
      position: 101
      prefix: -E
  - id: domain_score_cutoff
    type:
      - 'null'
      - int
    doc: Domain score cutoff for a sequence to be included in the output
    inputBinding:
      position: 101
      prefix: -S
  - id: graph_scale
    type:
      - 'null'
      - float
    doc: Sets the scale of the graph output, if value is zero, a percentage view
      is shown
    inputBinding:
      position: 101
      prefix: --graph_scale
  - id: input_file
    type: File
    doc: DNA FASTA input file to investigate
    inputBinding:
      position: 101
      prefix: -i
  - id: license
    type:
      - 'null'
      - boolean
    doc: displays licensing information
    inputBinding:
      position: 101
      prefix: --license
  - id: min_domains
    type:
      - 'null'
      - int
    doc: The minimal number of domains that must match a sequence before it is 
      included
    inputBinding:
      position: 101
      prefix: -N
  - id: min_length_concat
    type:
      - 'null'
      - int
    doc: Minimum length the ITS regions must be to be outputted in the 
      concatenated file (see above)
    inputBinding:
      position: 101
      prefix: --minlen
  - id: multi_thread_hmmer
    type:
      - 'null'
      - boolean
    doc: Multi-thread the HMMER-search, on (T) if number of CPUs (--cpu option >
      1), else off (F) by default
    inputBinding:
      position: 101
      prefix: --multi_thread
  - id: output_concatenated
    type:
      - 'null'
      - boolean
    doc: Saves a FASTA-file with concatenated ITS sequences (with 5.8S removed),
      off (F) by default
    inputBinding:
      position: 101
      prefix: --concat
  - id: output_detailed_results
    type:
      - 'null'
      - boolean
    doc: Saves a tab-separated list of all results, off (F) by default
    inputBinding:
      position: 101
      prefix: --detailed_results
  - id: output_fasta
    type:
      - 'null'
      - boolean
    doc: FASTA-format output of extracted ITS sequences, on (T) by default
    inputBinding:
      position: 101
      prefix: --fasta
  - id: output_graphical
    type:
      - 'null'
      - boolean
    doc: "'Graphical' output, on (T) by default"
    inputBinding:
      position: 101
      prefix: --graphical
  - id: output_not_found
    type:
      - 'null'
      - boolean
    doc: Saves a list of non-found entries, on (T) by default
    inputBinding:
      position: 101
      prefix: --not_found
  - id: output_only_full
    type:
      - 'null'
      - boolean
    doc: If true, output is limited to full-length regions, off (F) by default
    inputBinding:
      position: 101
      prefix: --only_full
  - id: output_positions
    type:
      - 'null'
      - boolean
    doc: Table format output containing the positions ITS sequences were found 
      in, on (T) by default
    inputBinding:
      position: 101
      prefix: --positions
  - id: output_summary
    type:
      - 'null'
      - boolean
    doc: Summary of results output, on (T) by default
    inputBinding:
      position: 101
      prefix: --summary
  - id: output_table
    type:
      - 'null'
      - boolean
    doc: Table format output of sequences containing probable ITS sequences, off
      (F) by default
    inputBinding:
      position: 101
      prefix: --table
  - id: partial_its_cutoff
    type:
      - 'null'
      - int
    doc: Saves additional FASTA-files for full and partial ITS sequences longer 
      than the specified cutoff, default = 0 (off)
    inputBinding:
      position: 101
      prefix: --partial
  - id: preserve_headers
    type:
      - 'null'
      - boolean
    doc: Preserve sequence headers in input file instead of printing out ITSx 
      headers, off (F) by default
    inputBinding:
      position: 101
      prefix: --preserve
  - id: profile_dir
    type:
      - 'null'
      - Directory
    doc: A path to a directory of HMM-profile collections representing ITS 
      conserved regions, default is in the same directory as ITSx itself
    inputBinding:
      position: 101
      prefix: -p
  - id: profile_set
    type:
      - 'null'
      - string
    doc: Profile set to use for the search, see the User's Guide 
      (comma-separated), default is all
    inputBinding:
      position: 101
      prefix: -t
  - id: require_anchor
    type:
      - 'null'
      - string
    doc: Requires the complete anchor to found in order to be included in the 
      output sequences (see --anchor above). Cannot be used together with the 
      --anchor option
    inputBinding:
      position: 101
      prefix: --require_anchor
  - id: reset_db
    type:
      - 'null'
      - boolean
    doc: Re-creates the HMM-database before ITSx is run, off (F) by default
    inputBinding:
      position: 101
      prefix: --reset
  - id: save_raw_data
    type:
      - 'null'
      - boolean
    doc: Saves all raw data for searches etc. instead of removing it on finish, 
      off (F) by default
    inputBinding:
      position: 101
      prefix: --save_raw
  - id: save_regions
    type:
      - 'null'
      - string
    doc: A comma separated list of regions to output separate FASTA files for
    inputBinding:
      position: 101
      prefix: --save_regions
  - id: search_evalue
    type:
      - 'null'
      - float
    doc: The E-value cutoff used in the HMMER search, high numbers may slow down
      the process, cannot be used with the --search_score option, default is to 
      use score cutoff, not E-value
    inputBinding:
      position: 101
      prefix: --search_eval
  - id: search_score
    type:
      - 'null'
      - int
    doc: The score cutoff used in the HMMER search, low numbers may slow down 
      the process, cannot be used with the --search_eval option
    inputBinding:
      position: 101
      prefix: --search_score
  - id: selection_priority
    type:
      - 'null'
      - string
    doc: Selects what will be of highest priority when determining the origin of
      the sequence
    inputBinding:
      position: 101
      prefix: --selection_priority
  - id: suppress_progress
    type:
      - 'null'
      - boolean
    doc: Supresses printing progress info to stderr, off (F) by default
    inputBinding:
      position: 101
      prefix: --silent
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: Custom directory to put the temporary files in
    inputBinding:
      position: 101
      prefix: --temp
  - id: truncate_fasta
    type:
      - 'null'
      - boolean
    doc: Truncates the FASTA output to only contain the actual ITS sequences 
      found, on (T) by default
    inputBinding:
      position: 101
      prefix: --truncate
  - id: use_heuristics
    type:
      - 'null'
      - boolean
    doc: Selects whether to use HMMER's heuristic filtering, off (F) by default
    inputBinding:
      position: 101
      prefix: --heuristics
  - id: use_nhmmer
    type:
      - 'null'
      - boolean
    doc: Selects whether to use nhmmer instead of hmmsearch for HMMER searches, 
      off (F) by default
    inputBinding:
      position: 101
      prefix: --nhmmer
  - id: use_stdin
    type:
      - 'null'
      - boolean
    doc: Use input from standard input instead of an input file, off (F) by 
      default
    inputBinding:
      position: 101
      prefix: --stdin
outputs:
  - id: output_file
    type: File
    doc: Base for the names of output file(s)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itsx:1.1.3--hdfd78af_1
