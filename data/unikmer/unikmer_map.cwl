cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unikmer
  - map
label: unikmer_map
doc: |-
  Mapping k-mers back to the genome and extract successive regions/subsequences

  Tool homepage: https://github.com/shenwei356/unikmer
inputs:
  - id: allow_multiple_mapped_kmers
    type: ['null', boolean]
    doc: "allow multiple mapped k-mers"
    inputBinding:
      position: 10
      prefix: --allow-multiple-mapped-kmers
  - id: circular
    type: ['null', boolean]
    doc: "circular genome. type \"unikmer uniqs -h\" for details"
    inputBinding:
      position: 10
      prefix: --circular
  - id: genome
    type:
      - 'null'
      - type: array
        items: File
    doc: "genomes in (gzipped) fasta file(s)"
    inputBinding:
      position: 10
      prefix: --genome
      itemSeparator: ','
  - id: max_gap_num
    type: ['null', int]
    doc: "max number of gaps (consecutive unmapped k-mers)"
    inputBinding:
      position: 10
      prefix: --max-gap-num
  - id: max_gap_size
    type: ['null', int]
    doc: "max gap size (the number of consecutive unmapped k-mers)"
    inputBinding:
      position: 10
      prefix: --max-gap-size
  - id: min_len
    type: ['null', int]
    doc: "minimum length of subsequence"
    inputBinding:
      position: 10
      prefix: --min-len
  - id: output_fasta
    type: ['null', boolean]
    doc: "output fasta format instead of BED3"
    inputBinding:
      position: 10
      prefix: --output-fasta
  - id: seq_name_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --seq-name-filter
    doc: "list of regular expressions for filtering out sequences by header/name, case ignored"
    inputBinding:
      position: 10
  - id: seqs_in_a_file_as_one_genome
    type: ['null', boolean]
    doc: "treat seqs in a genome file as one genome"
    inputBinding:
      position: 10
      prefix: --seqs-in-a-file-as-one-genome
  - id: compact
    type: ['null', boolean]
    doc: "write compact binary file with little loss of speed"
    inputBinding:
      position: 10
      prefix: --compact
  - id: compression_level
    type: ['null', int]
    doc: "compression level"
    inputBinding:
      position: 10
      prefix: --compression-level
  - id: data_dir
    type: ['null', Directory]
    doc: "directory containing NCBI Taxonomy files, including nodes.dmp, names.dmp, merged.dmp and delnodes.dmp"
    inputBinding:
      position: 10
      prefix: --data-dir
  - id: ignore_taxid
    type: ['null', boolean]
    doc: "ignore taxonomy information"
    inputBinding:
      position: 10
      prefix: --ignore-taxid
  - id: infile_list
    type: ['null', File]
    doc: "file of input files list (one file per line), if given, they are appended to files from cli arguments (names inside must match the staged files; give them also in listed_files)"
    inputBinding:
      position: 10
      prefix: --infile-list
  - id: max_taxid
    type: ['null', long]
    doc: "for smaller TaxIds, we can use less space to store TaxIds. default value is 1<<32-1, that's enough for NCBI Taxonomy TaxIds"
    inputBinding:
      position: 10
      prefix: --max-taxid
  - id: no_compress
    type: ['null', boolean]
    doc: "do not compress binary file (not recommended)"
    inputBinding:
      position: 10
      prefix: --no-compress
  - id: nocheck_file
    type: ['null', boolean]
    doc: "do not check binary file, when using process substitution or named pipe"
    inputBinding:
      position: 10
      prefix: --nocheck-file
  - id: threads
    type: ['null', int]
    doc: "number of CPUs to use"
    inputBinding:
      position: 10
      prefix: --threads
  - id: verbose
    type: ['null', boolean]
    doc: "print verbose information"
    inputBinding:
      position: 10
      prefix: --verbose
  - id: unik_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input k-mer binary (.unik) files. Required unless --infile-list is given."
    inputBinding:
      position: 200
  - id: out_prefix
    type: string
    doc: "Output file prefix (the wrapper requires a name; '-' for stdout is not supported)"
    inputBinding:
      position: 10
      prefix: --out-prefix
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the --infile-list file (staged into the working directory so the names resolve)."
outputs:
  - id: out_file
    type: File
    doc: Output file named out-prefix
    outputBinding:
      glob: $(inputs.out_prefix)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.listed_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
