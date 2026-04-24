cwlVersion: v1.2
class: CommandLineTool
baseCommand: bold_identification
label: bold-identification_bold_identification
doc: "To identify taxa of given sequences from BOLD (http://www.boldsystems.org/).\n\
  Some sequences can fail to get taxon information, which can be caused by\nTimeoutException
  if your network to the BOLD server is bad.\nThose sequences will be output in the
  file '*.TimeoutException.fasta'.\n\nYou can:\n1) run another searching with the
  same command directly (but add -c option);\n2) lengthen the time to wait for each
  query (-t option);\n3) increase submission times (-r option) for a sequence.\n\n\
  Also, the sequences without BOLD matches will be output in the\nfile '*.NoBoldMatchError.fasta'\n\
  \nTool homepage: https://github.com/linzhi2013/bold_identification"
inputs:
  - id: chimera_check
    type:
      - 'null'
      - boolean
    doc: "For chimera check purpose. If set, for each sequence,\nI will query the
      BOLD database using the subsequences\nfrom 5'- and 3'-ends with a length of
      '-q <int>' bp,\nrespectively"
    inputBinding:
      position: 101
      prefix: -C
  - id: continuous_mode
    type:
      - 'null'
      - boolean
    doc: "continuous mode, jump over the ones already in \"-o\"\nfile, will resubmit
      all the remained. use \"-cc\" to\nalso jump over the ones in \"*.NoBoldMatchError.fasta\"\
      \nfile."
    inputBinding:
      position: 101
      prefix: -c
  - id: database
    type:
      - 'null'
      - string
    doc: database to search
    inputBinding:
      position: 101
      prefix: -d
  - id: debug_mode
    type:
      - 'null'
      - boolean
    doc: debug mode output
    inputBinding:
      position: 101
      prefix: -D
  - id: input_file
    type: string
    doc: input file name
    inputBinding:
      position: 101
      prefix: -i
  - id: input_format
    type:
      - 'null'
      - string
    doc: input file format
    inputBinding:
      position: 101
      prefix: -f
  - id: max_submission_time
    type:
      - 'null'
      - int
    doc: "Maximum submission time for a sequence, useful for\nhandling TimeOutException."
    inputBinding:
      position: 101
      prefix: -r
  - id: output_prefix
    type: string
    doc: outfile prefix
    inputBinding:
      position: 101
      prefix: -o
  - id: subsequence_length
    type:
      - 'null'
      - int
    doc: The length of subsequences for chimera check
    inputBinding:
      position: 101
      prefix: -q
  - id: top_hits
    type:
      - 'null'
      - int
    doc: how many first top hits will be output.
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bold-identification:0.0.27--py_0
stdout: bold-identification_bold_identification.out
