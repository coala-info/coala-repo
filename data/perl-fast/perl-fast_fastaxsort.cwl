cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaxsort
label: perl-fast_fastaxsort
doc: "Sort sequence records taxonomically using NCBI taxonomic data.\n\nTool homepage:
  http://metacpan.org/pod/FAST"
inputs:
  - id: nodes_file
    type:
      - 'null'
      - File
    doc: NCBI nodes.dmp file
    inputBinding:
      position: 1
  - id: names_file
    type:
      - 'null'
      - File
    doc: NCBI names.dmp file (not used in --tax-id-mode)
    inputBinding:
      position: 2
  - id: multifasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input multifasta files
    inputBinding:
      position: 3
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Add FAST taxonomic addresses in dot-hex notation to sequence record descriptions
    inputBinding:
      position: 104
      prefix: --annotate
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile.
    inputBinding:
      position: 104
      prefix: --comment
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Use fastq format as input and output.
    inputBinding:
      position: 104
      prefix: --fastq
  - id: field
    type:
      - 'null'
      - int
    doc: Sort sequence records by values at a specific field index (1-based or negative
      for backwards).
    inputBinding:
      position: 104
      prefix: --field
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input (e.g., see fasconvert formats).
    default: fasta
    inputBinding:
      position: 104
      prefix: --format
  - id: identifier
    type:
      - 'null'
      - boolean
    doc: Taxa are sorted using sequence identifiers (default uses whole descriptions)
    inputBinding:
      position: 104
      prefix: --identifier
  - id: index
    type:
      - 'null'
      - boolean
    doc: Instead of printing the sorted sequence records, print a key that maps fastaxsort
      taxonomically generated taxonomic addresses to NCBI taxonomic names or IDs.
    inputBinding:
      position: 104
      prefix: --index
  - id: join
    type:
      - 'null'
      - string
    doc: Use [string] to append FAST taxonomic addresses to sequence record descriptions,
      instead of default " ".
    inputBinding:
      position: 104
      prefix: --join
  - id: log
    type:
      - 'null'
      - boolean
    doc: Creates, or appends to, a generic FAST logfile in the current working directory.
    inputBinding:
      position: 104
      prefix: --log
  - id: logname
    type:
      - 'null'
      - string
    doc: Use [string] as the name of the logfile.
    default: FAST.log.txt
    inputBinding:
      position: 104
      prefix: --logname
  - id: moltype
    type:
      - 'null'
      - string
    doc: Specify the type of sequence on input (dna|rna|protein).
    inputBinding:
      position: 104
      prefix: --moltype
  - id: split_on_regex
    type:
      - 'null'
      - string
    doc: Use regex <regex> to split descriptions/identifiers for the -f option.
    inputBinding:
      position: 104
      prefix: --split-on-regex
  - id: tax_id_mode
    type:
      - 'null'
      - boolean
    doc: NCBI Taxonomic data in sequence records are IDs, not names.
    inputBinding:
      position: 104
      prefix: --tax-id-mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fastaxsort.out
