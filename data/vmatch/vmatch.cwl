cwlVersion: v1.2
class: CommandLineTool
baseCommand: vmatch
label: vmatch
doc: "vmatch\n\nTool homepage: http://www.vmatch.de/"
inputs:
  - id: complete
    type:
      - 'null'
      - boolean
    doc: specify that query sequences must match completely
    inputBinding:
      position: 101
      prefix: -complete
  - id: direct_matches
    type:
      - 'null'
      - boolean
    doc: compute direct matches (default)
    inputBinding:
      position: 101
      prefix: -d
  - id: edit_distance
    type:
      - 'null'
      - int
    doc: specify the allowed edit distance > 0
    inputBinding:
      position: 101
      prefix: -e
  - id: edit_xdrop
    type:
      - 'null'
      - int
    doc: specify the xdrop value for edit distance extension
    inputBinding:
      position: 101
      prefix: -exdrop
  - id: evalue
    type:
      - 'null'
      - float
    doc: specify the maximum E-value of a match
    inputBinding:
      position: 101
      prefix: -evalue
  - id: hamming_distance
    type:
      - 'null'
      - int
    doc: specify the allowed hamming distance > 0
    inputBinding:
      position: 101
      prefix: -h
  - id: hamming_xdrop
    type:
      - 'null'
      - int
    doc: specify the xdrop value for hamming distance extension
    inputBinding:
      position: 101
      prefix: -hxdrop
  - id: least_score
    type:
      - 'null'
      - int
    doc: specify the minimum score of a match
    inputBinding:
      position: 101
      prefix: -leastscore
  - id: match_length
    type:
      - 'null'
      - int
    doc: specify that match must have the given length
    inputBinding:
      position: 101
      prefix: -l
  - id: min_identity
    type:
      - 'null'
      - int
    doc: specify minimum identity of match in range [1..100%]
    inputBinding:
      position: 101
      prefix: -identity
  - id: online
    type:
      - 'null'
      - boolean
    doc: run algorithms online without using the index
    inputBinding:
      position: 101
      prefix: -online
  - id: palindromic_matches
    type:
      - 'null'
      - boolean
    doc: compute palindromic (i.e. reverse complemented matches)
    inputBinding:
      position: 101
      prefix: -p
  - id: queries
    type:
      - 'null'
      - File
    doc: specify files containing queries to be matched
    inputBinding:
      position: 101
      prefix: -q
  - id: show_alignment
    type:
      - 'null'
      - boolean
    doc: show the alignment of matching sequences
    inputBinding:
      position: 101
      prefix: -s
  - id: show_description
    type:
      - 'null'
      - int
    doc: show sequence description of match (argument is the number of characters to show, 0 for the whole description)
    inputBinding:
      position: 101
      prefix: -showdesc
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 101
      prefix: -v
  - id: index_files
    type: File[]
    doc: "Index files written by mkvtree (staged in the working directory so the index name resolves)"
  - id: index_name
    type: string
    doc: "Name of the index (the mkvtree -indexname value)"
    inputBinding:
      position: 200
  - id: dnavsprot
    type:
      - 'null'
      - string
    doc: "perform six frame translation; codon translation table number in the range [1,23] (default 1)"
    inputBinding:
      position: 101
      prefix: -dnavsprot
  - id: tandem
    type:
      - 'null'
      - boolean
    doc: "compute right branching tandem repeats"
    inputBinding:
      position: 101
      prefix: -tandem
  - id: supermax
    type:
      - 'null'
      - boolean
    doc: "compute supermaximal matches"
    inputBinding:
      position: 101
      prefix: -supermax
  - id: mum
    type:
      - 'null'
      - boolean
    doc: "compute maximal unique matches"
    inputBinding:
      position: 101
      prefix: -mum
  - id: qnomatch
    type:
      - 'null'
      - boolean
    doc: "show all query substrings not containing a match"
    inputBinding:
      position: 101
      prefix: -qnomatch
  - id: qmaskmatch
    type:
      - 'null'
      - boolean
    doc: "mask all query substrings containing a match"
    inputBinding:
      position: 101
      prefix: -qmaskmatch
  - id: nonredundant
    type:
      - 'null'
      - boolean
    doc: "generate file with non-redundant set of sequences; only works together with -dbcluster"
    inputBinding:
      position: 101
      prefix: -nonredundant
  - id: allmax
    type:
      - 'null'
      - boolean
    doc: "show all maximal matches in the order of their computation"
    inputBinding:
      position: 101
      prefix: -allmax
  - id: information
    type:
      - 'null'
      - boolean
    doc: "give information about number of different matches"
    inputBinding:
      position: 101
      prefix: -i
  - id: show_filename
    type:
      - 'null'
      - boolean
    doc: "show filename where match occurs"
    inputBinding:
      position: 101
      prefix: -f
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: "show absolute positions"
    inputBinding:
      position: 101
      prefix: -absolute
  - id: nodist
    type:
      - 'null'
      - boolean
    doc: "do not show distance of match"
    inputBinding:
      position: 101
      prefix: -nodist
  - id: noevalue
    type:
      - 'null'
      - boolean
    doc: "do not show E-value of match"
    inputBinding:
      position: 101
      prefix: -noevalue
  - id: noscore
    type:
      - 'null'
      - boolean
    doc: "do not show score of match"
    inputBinding:
      position: 101
      prefix: -noscore
  - id: noidentity
    type:
      - 'null'
      - boolean
    doc: "do not show identity of match"
    inputBinding:
      position: 101
      prefix: -noidentity
  - id: dbnomatch
    type:
      - 'null'
      - string
    doc: "mask all database substrings containing a match; argument keepleft, keepright, keepleftifsamesequence or keeprightifsamesequence"
    inputBinding:
      position: 101
      prefix: -dbnomatch
  - id: dbmaskmatch
    type:
      - 'null'
      - string
    doc: "mask all database substrings containing a match; argument keepleft, keepright, keepleftifsamesequence or keeprightifsamesequence"
    inputBinding:
      position: 101
      prefix: -dbmaskmatch
  - id: dbcluster
    type:
      - 'null'
      - string
    doc: "cluster the database sequences: percentage of shorter string, percentage of larger string, optional filename prefix, optional (minclustersize, maxclustersize)"
    inputBinding:
      position: 101
      prefix: -dbcluster
  - id: pp
    type:
      - 'null'
      - string
    doc: "generic postprocessing of matches"
    inputBinding:
      position: 101
      prefix: -pp
  - id: selfun
    type:
      - 'null'
      - File
    doc: "shared object file containing selection function"
    inputBinding:
      position: 101
      prefix: -selfun
  - id: qspeedup
    type:
      - 'null'
      - int
    doc: "speedup level when matching queries (0: fast, 2: faster; default is 2)"
    inputBinding:
      position: 101
      prefix: -qspeedup
  - id: seedlength
    type:
      - 'null'
      - int
    doc: "specify the seed length"
    inputBinding:
      position: 101
      prefix: -seedlength
  - id: sort
    type:
      - 'null'
      - string
    doc: "sort the matches, mode la, ld, ia, id, ja, jd, ea, ed, sa, sd, ida or idd"
    inputBinding:
      position: 101
      prefix: -sort
  - id: best
    type:
      - 'null'
      - int
    doc: "show the best matches (those with smallest E-values); default is best 50"
    inputBinding:
      position: 101
      prefix: -best
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
    dockerOutputDirectory: /vmatch_work
stdout: vmatch.out
