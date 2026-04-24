cwlVersion: v1.2
class: CommandLineTool
baseCommand: align-families.py
label: dunovo_align-families.py
doc: "Read in sorted FASTQ data and do multiple sequence alignments of each family.\n\
  \nTool homepage: https://github.com/galaxyproject/dunovo"
inputs:
  - id: read_families_tsv
    type: File
    doc: "The input reads, sorted into families. One\n                        line
      per read pair, 8 tab-delimited columns:\n                        1. canonical
      barcode\n                        2. barcode order (\"ab\" for alpha+beta, \"\
      ba\"\n                        for beta-alpha)\n                        3. read
      1 name\n                        4. read 1 sequence\n                       \
      \ 5. read 1 quality scores\n                        6. read 2 name\n       \
      \                 7. read 2 sequence\n                        8. read 2 quality
      scores"
    inputBinding:
      position: 1
  - id: aligner
    type:
      - 'null'
      - string
    doc: "The multiple sequence aligner to use. Default:\n                       \
      \ kalign"
    inputBinding:
      position: 102
      prefix: --aligner
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --debug
  - id: galaxy
    type:
      - 'null'
      - boolean
    doc: "Tell the script it's running on Galaxy.\n                        Currently
      this only affects data reported when\n                        phoning home."
    inputBinding:
      position: 102
      prefix: --galaxy
  - id: no_check_ids
    type:
      - 'null'
      - boolean
    doc: "Don't check to make sure read pairs have\n                        identical
      ids. By default, if this encounters\n                        a pair of reads
      in families.tsv with ids that\n                        aren't identical (minus
      an ending /1 or /2),\n                        it will throw an error."
    inputBinding:
      position: 102
      prefix: --no-check-ids
  - id: phone_home
    type:
      - 'null'
      - boolean
    doc: "Report helpful usage data to the developer, to\n                       \
      \ better understand the use cases and\n                        performance of
      the tool. The only data which\n                        will be recorded is the
      name and version of\n                        the tool, the size of the input
      data, the time\n                        and memory taken to process it, and
      the IP\n                        address of the machine running it. Also, if\n\
      \                        the script fails, it will report the name of\n    \
      \                    the exception thrown and the line of code it\n        \
      \                occurred in. No filenames are sent, and the\n             \
      \           only parameters reported are --aligner,\n                      \
      \  --processes, and --queue-size, which are\n                        necessary
      to evaluate performance. All the\n                        reporting and recording
      code is available at\n                        https://github.com/NickSto/ET."
    inputBinding:
      position: 102
      prefix: --phone-home
  - id: processes
    type:
      - 'null'
      - string
    doc: "Number of worker subprocesses to use. If 0, no\n                       \
      \ subprocesses will be started and everything\n                        will
      be done inside one process. Give \"auto\"\n                        to use as
      many processes as there are CPU\n                        cores. Default: 0."
    inputBinding:
      position: 102
      prefix: --processes
  - id: queue_size
    type:
      - 'null'
      - int
    doc: "How long to go accumulating responses from\n                        worker
      subprocesses before dealing with all of\n                        them. Default:
      8 * the number of worker\n                        --processes."
    inputBinding:
      position: 102
      prefix: --queue-size
  - id: quiet
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --quiet
  - id: test
    type:
      - 'null'
      - boolean
    doc: "If reporting usage data, mark this as a test\n                        run."
    inputBinding:
      position: 102
      prefix: --test
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: "Print log messages to this file instead of to\n                      stderr.
      NOTE: Will overwrite the file."
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
