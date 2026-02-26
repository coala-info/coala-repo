cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtract
label: entrez-direct_xtract
doc: "Xtract uses command-line arguments to convert XML data into a tab-delimited
  table.\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: _based
    type:
      - 'null'
      - boolean
    doc: Zero-Based
    inputBinding:
      position: 101
      prefix: -0-based
  - id: _based
    type:
      - 'null'
      - boolean
    doc: One-Based
    inputBinding:
      position: 101
      prefix: -1-based
  - id: NAME
    type:
      - 'null'
      - string
    doc: Record value in named variable
    inputBinding:
      position: 101
      prefix: -NAME
  - id: STATS
    type:
      - 'null'
      - boolean
    doc: Accumulate values into variable
    inputBinding:
      position: 101
      prefix: --STATS
  - id: acc
    type:
      - 'null'
      - boolean
    doc: Accumulator
    inputBinding:
      position: 101
      prefix: -acc
  - id: accent
    type:
      - 'null'
      - boolean
    doc: Excise Unicode accents and diacritical marks
    inputBinding:
      position: 101
      prefix: -accent
  - id: accession
    type:
      - 'null'
      - boolean
    doc: Allow indexing of full accession.version
    inputBinding:
      position: 101
      prefix: -accession
  - id: aliases
    type:
      - 'null'
      - File
    doc: Mappings file for -classify operation
    inputBinding:
      position: 101
      prefix: -aliases
  - id: alnum
    type:
      - 'null'
      - boolean
    doc: Non-alphanumeric characters to space
    inputBinding:
      position: 101
      prefix: -alnum
  - id: alpha
    type:
      - 'null'
      - boolean
    doc: Non-alphabetic characters to space
    inputBinding:
      position: 101
      prefix: -alpha
  - id: and
    type:
      - 'null'
      - boolean
    doc: All tests must pass
    inputBinding:
      position: 101
      prefix: -and
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Unicode to numeric HTML character entities
    inputBinding:
      position: 101
      prefix: -ascii
  - id: atr
    type:
      - 'null'
      - string
    doc: Attribute key and element name
    inputBinding:
      position: 101
      prefix: -atr
  - id: att
    type:
      - 'null'
      - string
    doc: Attribute key and literal string
    inputBinding:
      position: 101
      prefix: -att
  - id: auth
    type:
      - 'null'
      - boolean
    doc: Changed GenBank authors to Medline form
    inputBinding:
      position: 101
      prefix: -auth
  - id: author
    type:
      - 'null'
      - boolean
    doc: Multi-step author cleanup
    inputBinding:
      position: 101
      prefix: -author
  - id: avg
    type:
      - 'null'
      - boolean
    doc: Arithmetic Mean
    inputBinding:
      position: 101
      prefix: -avg
  - id: awd
    type:
      - 'null'
      - string
    doc: Afterword to print after subset
    inputBinding:
      position: 101
      prefix: -awd
  - id: backward
    type:
      - 'null'
      - boolean
    doc: Print values in reverse order
    inputBinding:
      position: 101
      prefix: -backward
  - id: basic
    type:
      - 'null'
      - boolean
    doc: Convert superscripts and subscripts
    inputBinding:
      position: 101
      prefix: -basic
  - id: bin
    type:
      - 'null'
      - boolean
    doc: Binary
    inputBinding:
      position: 101
      prefix: -bin
  - id: bit
    type:
      - 'null'
      - boolean
    doc: Number of Bits Set
    inputBinding:
      position: 101
      prefix: -bit
  - id: bkt
    type:
      - 'null'
      - boolean
    doc: Wrap elements in bracketed fields
    inputBinding:
      position: 101
      prefix: -bkt
  - id: block
    type:
      - 'null'
      - string
    doc: Use of different argument names allows command-line control of nested 
      looping
    inputBinding:
      position: 101
      prefix: -block
  - id: cds2prot
    type:
      - 'null'
      - boolean
    doc: Translate coding region using -gcode and (1-based) -frame
    inputBinding:
      position: 101
      prefix: -cds2prot
  - id: chain
    type:
      - 'null'
      - boolean
    doc: Change_spaces_to_underscores
    inputBinding:
      position: 101
      prefix: -chain
  - id: classify
    type:
      - 'null'
      - boolean
    doc: Substring word or phrase matches to -aliases table
    inputBinding:
      position: 101
      prefix: -classify
  - id: clauses
    type:
      - 'null'
      - boolean
    doc: Break at phrase separators
    inputBinding:
      position: 101
      prefix: -clauses
  - id: clr
    type:
      - 'null'
      - boolean
    doc: Clear queued tab separator
    inputBinding:
      position: 101
      prefix: -clr
  - id: cls
    type:
      - 'null'
      - boolean
    doc: Close with ">"
    inputBinding:
      position: 101
      prefix: -cls
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress runs of spaces
    inputBinding:
      position: 101
      prefix: -compress
  - id: consists_of
    type:
      - 'null'
      - string
    doc: String must only contain specified characters
    inputBinding:
      position: 101
      prefix: -consists-of
  - id: contains
    type:
      - 'null'
      - string
    doc: Substring must be present
    inputBinding:
      position: 101
      prefix: -contains
  - id: contour
    type:
      - 'null'
      - string
    doc: Display XML paths to leaf nodes [delimiter]
    inputBinding:
      position: 101
      prefix: -contour
  - id: date
    type:
      - 'null'
      - boolean
    doc: YYYY/MM/DD from -unit "PubDate" -date "*"
    inputBinding:
      position: 101
      prefix: -date
  - id: dec
    type:
      - 'null'
      - boolean
    doc: Decrement
    inputBinding:
      position: 101
      prefix: -dec
  - id: decode
    type:
      - 'null'
      - boolean
    doc: Base64-decode object embedded in XML
    inputBinding:
      position: 101
      prefix: -decode
  - id: def
    type:
      - 'null'
      - string
    doc: Default placeholder for missing fields
    inputBinding:
      position: 101
      prefix: -def
  - id: deq
    type:
      - 'null'
      - boolean
    doc: Delete and replace queued tab separator
    inputBinding:
      position: 101
      prefix: -deq
  - id: dev
    type:
      - 'null'
      - boolean
    doc: Deviation
    inputBinding:
      position: 101
      prefix: -dev
  - id: differs_from
    type:
      - 'null'
      - string
    doc: Object values must differ
    inputBinding:
      position: 101
      prefix: -differs-from
  - id: div
    type:
      - 'null'
      - boolean
    doc: Quotient
    inputBinding:
      position: 101
      prefix: -div
  - id: doi
    type:
      - 'null'
      - boolean
    doc: Add https://doi.org/ prefix, URL encode
    inputBinding:
      position: 101
      prefix: -doi
  - id: element
    type:
      - 'null'
      - type: array
        items: string
    doc: Print all items that match tag name
    inputBinding:
      position: 101
      prefix: -element
  - id: elg
    type:
      - 'null'
      - string
    doc: Epilogue to print after instance
    inputBinding:
      position: 101
      prefix: -elg
  - id: else
    type:
      - 'null'
      - boolean
    doc: Execute if conditional test failed
    inputBinding:
      position: 101
      prefix: -else
  - id: enc
    type:
      - 'null'
      - boolean
    doc: Encase instance in XML object
    inputBinding:
      position: 101
      prefix: -enc
  - id: encode
    type:
      - 'null'
      - boolean
    doc: XML-encode <, >, &, ", and '
    inputBinding:
      position: 101
      prefix: -encode
  - id: end
    type:
      - 'null'
      - string
    doc: End contents with "</" + object name + ">"
    inputBinding:
      position: 101
      prefix: -end
  - id: ends_with
    type:
      - 'null'
      - string
    doc: Substring must be at end
    inputBinding:
      position: 101
      prefix: -ends-with
  - id: eq
    type:
      - 'null'
      - int
    doc: Equal to
    inputBinding:
      position: 101
      prefix: -eq
  - id: equals
    type:
      - 'null'
      - string
    doc: String must match exactly
    inputBinding:
      position: 101
      prefix: -equals
  - id: even
    type:
      - 'null'
      - boolean
    doc: Only print value of even items
    inputBinding:
      position: 101
      prefix: -even
  - id: even_element
    type:
      - 'null'
      - string
    doc: Only print value of even items
    inputBinding:
      position: 101
      prefix: -even
  - id: examples
    type:
      - 'null'
      - boolean
    doc: Examples of EDirect and xtract usage
    inputBinding:
      position: 101
      prefix: -examples
  - id: excludes
    type:
      - 'null'
      - string
    doc: Substring must be absent
    inputBinding:
      position: 101
      prefix: -excludes
  - id: exp
    type:
      - 'null'
      - string
    doc: Replacement pattern
    inputBinding:
      position: 101
      prefix: -exp
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Split sequence into blocks of 70 uppercase letters
    inputBinding:
      position: 101
      prefix: -fasta
  - id: first
    type:
      - 'null'
      - boolean
    doc: Only print value of first item
    inputBinding:
      position: 101
      prefix: -first
  - id: first_element
    type:
      - 'null'
      - string
    doc: Only print value of first item
    inputBinding:
      position: 101
      prefix: -first
  - id: format
    type:
      - 'null'
      - string
    doc: '[copy|compact|flush|indent|expand]'
    inputBinding:
      position: 101
      prefix: -format
  - id: fwd
    type:
      - 'null'
      - string
    doc: Foreword to print before subset
    inputBinding:
      position: 101
      prefix: -fwd
  - id: ge
    type:
      - 'null'
      - int
    doc: Greater than or equal to
    inputBinding:
      position: 101
      prefix: -ge
  - id: geo
    type:
      - 'null'
      - boolean
    doc: Geometric Mean
    inputBinding:
      position: 101
      prefix: -geo
  - id: group
    type:
      - 'null'
      - string
    doc: Use of different argument names allows command-line control of nested 
      looping
    inputBinding:
      position: 101
      prefix: -group
  - id: gt
    type:
      - 'null'
      - int
    doc: Greater than
    inputBinding:
      position: 101
      prefix: -gt
  - id: hd
    type:
      - 'null'
      - boolean
    doc: Print before each record
    inputBinding:
      position: 101
      prefix: -hd
  - id: head
    type:
      - 'null'
      - boolean
    doc: Print before everything else
    inputBinding:
      position: 101
      prefix: -head
  - id: hex
    type:
      - 'null'
      - boolean
    doc: Hexadecimal
    inputBinding:
      position: 101
      prefix: -hex
  - id: hgvs
    type:
      - 'null'
      - boolean
    doc: Convert sequence variation format to XML
    inputBinding:
      position: 101
      prefix: -hgvs
  - id: histogram
    type:
      - 'null'
      - boolean
    doc: Collects data for sort-uniq-count on entire set of records
    inputBinding:
      position: 101
      prefix: -histogram
  - id: hrm
    type:
      - 'null'
      - boolean
    doc: Harmonic Mean
    inputBinding:
      position: 101
      prefix: -hrm
  - id: if
    type:
      - 'null'
      - string
    doc: Element [@attribute] required
    inputBinding:
      position: 101
      prefix: -if
  - id: in
    type:
      - 'null'
      - File
    doc: File of identifiers to use for selection
    inputBinding:
      position: 101
      prefix: -in
  - id: inc
    type:
      - 'null'
      - boolean
    doc: Increment
    inputBinding:
      position: 101
      prefix: -inc
  - id: includes
    type:
      - 'null'
      - string
    doc: Substring must match at word boundaries
    inputBinding:
      position: 101
      prefix: -includes
  - id: indexer
    type:
      - 'null'
      - boolean
    doc: Positional index using -wrp for field name
    inputBinding:
      position: 101
      prefix: -indexer
  - id: initials
    type:
      - 'null'
      - boolean
    doc: Parse initials from forename or given name
    inputBinding:
      position: 101
      prefix: -initials
  - id: input
    type:
      - 'null'
      - File
    doc: Read XML from file instead of stdin
    inputBinding:
      position: 101
      prefix: -input
  - id: insd
    type:
      - 'null'
      - boolean
    doc: Generate INSDSeq extraction commands
    inputBinding:
      position: 101
      prefix: -insd
  - id: insdx
    type:
      - 'null'
      - boolean
    doc: Process -insd output table into XML
    inputBinding:
      position: 101
      prefix: -insdx
  - id: is_after
    type:
      - 'null'
      - string
    doc: First string > second string
    inputBinding:
      position: 101
      prefix: -is-after
  - id: is_before
    type:
      - 'null'
      - string
    doc: First string < second string
    inputBinding:
      position: 101
      prefix: -is-before
  - id: is_equal_to
    type:
      - 'null'
      - string
    doc: Object values must match
    inputBinding:
      position: 101
      prefix: -is-equal-to
  - id: is_not
    type:
      - 'null'
      - string
    doc: String must not match
    inputBinding:
      position: 101
      prefix: -is-not
  - id: is_within
    type:
      - 'null'
      - string
    doc: String must be present
    inputBinding:
      position: 101
      prefix: -is-within
  - id: journal
    type:
      - 'null'
      - boolean
    doc: Journal capitalization and punctuation cleanup
    inputBinding:
      position: 101
      prefix: -journal
  - id: last
    type:
      - 'null'
      - boolean
    doc: Only print value of last item
    inputBinding:
      position: 101
      prefix: -last
  - id: last_element
    type:
      - 'null'
      - string
    doc: Only print value of last item
    inputBinding:
      position: 101
      prefix: -last
  - id: lbl
    type:
      - 'null'
      - string
    doc: Insert arbitrary text
    inputBinding:
      position: 101
      prefix: -lbl
  - id: le
    type:
      - 'null'
      - int
    doc: Less than or equal to
    inputBinding:
      position: 101
      prefix: -le
  - id: len
    type:
      - 'null'
      - boolean
    doc: Length
    inputBinding:
      position: 101
      prefix: -len
  - id: letters
    type:
      - 'null'
      - boolean
    doc: Separate individual letters
    inputBinding:
      position: 101
      prefix: -letters
  - id: lg2
    type:
      - 'null'
      - boolean
    doc: Logarithm Base 2
    inputBinding:
      position: 101
      prefix: -lg2
  - id: lge
    type:
      - 'null'
      - boolean
    doc: Natural Logarithm
    inputBinding:
      position: 101
      prefix: -lge
  - id: log
    type:
      - 'null'
      - boolean
    doc: Logarithm Base 10
    inputBinding:
      position: 101
      prefix: -log
  - id: lower
    type:
      - 'null'
      - boolean
    doc: Convert text to lower-case
    inputBinding:
      position: 101
      prefix: -lower
  - id: lt
    type:
      - 'null'
      - int
    doc: Less than
    inputBinding:
      position: 101
      prefix: -lt
  - id: matches
    type:
      - 'null'
      - string
    doc: Matches without commas, semicolons, or accents
    inputBinding:
      position: 101
      prefix: -matches
  - id: max
    type:
      - 'null'
      - boolean
    doc: Maximum
    inputBinding:
      position: 101
      prefix: -max
  - id: med
    type:
      - 'null'
      - boolean
    doc: Median
    inputBinding:
      position: 101
      prefix: -med
  - id: mimics
    type:
      - 'null'
      - string
    doc: Containment test after converting punctuation to space
    inputBinding:
      position: 101
      prefix: -mimics
  - id: min
    type:
      - 'null'
      - boolean
    doc: Minimum
    inputBinding:
      position: 101
      prefix: -min
  - id: mirror
    type:
      - 'null'
      - boolean
    doc: Reverse order of letters
    inputBinding:
      position: 101
      prefix: -mirror
  - id: mixed
    type:
      - 'null'
      - boolean
    doc: Allow mixed content XML
    inputBinding:
      position: 101
      prefix: -mixed
  - id: mod
    type:
      - 'null'
      - boolean
    doc: Remainder
    inputBinding:
      position: 101
      prefix: -mod
  - id: molwt
    type:
      - 'null'
      - boolean
    doc: Calculate molecular weight of peptide
    inputBinding:
      position: 101
      prefix: -molwt
  - id: molwt_f
    type:
      - 'null'
      - boolean
    doc: Keep initial M residue as formyl-methionine
    inputBinding:
      position: 101
      prefix: -molwt-f
  - id: molwt_m
    type:
      - 'null'
      - boolean
    doc: Molecular weight retaining initial methionine
    inputBinding:
      position: 101
      prefix: -molwt-m
  - id: month
    type:
      - 'null'
      - boolean
    doc: Match first month name, return as integer
    inputBinding:
      position: 101
      prefix: -month
  - id: mul
    type:
      - 'null'
      - boolean
    doc: Product
    inputBinding:
      position: 101
      prefix: -mul
  - id: ncbi2na
    type:
      - 'null'
      - boolean
    doc: Expand ncbi2na to iupac
    inputBinding:
      position: 101
      prefix: -ncbi2na
  - id: ncbi4na
    type:
      - 'null'
      - boolean
    doc: Expand ncbi4na to iupac
    inputBinding:
      position: 101
      prefix: -ncbi4na
  - id: ne
    type:
      - 'null'
      - int
    doc: Not equal to
    inputBinding:
      position: 101
      prefix: -ne
  - id: nucleic
    type:
      - 'null'
      - boolean
    doc: Subrange determines forward or revcomp
    inputBinding:
      position: 101
      prefix: -nucleic
  - id: num
    type:
      - 'null'
      - boolean
    doc: Count
    inputBinding:
      position: 101
      prefix: -num
  - id: numeric
    type:
      - 'null'
      - boolean
    doc: Only accept items that are entirely digits
    inputBinding:
      position: 101
      prefix: -numeric
  - id: oct
    type:
      - 'null'
      - boolean
    doc: Octal
    inputBinding:
      position: 101
      prefix: -oct
  - id: odd
    type:
      - 'null'
      - boolean
    doc: Only print value of odd items
    inputBinding:
      position: 101
      prefix: -odd
  - id: odd_element
    type:
      - 'null'
      - string
    doc: Only print value of odd items
    inputBinding:
      position: 101
      prefix: -odd
  - id: or
    type:
      - 'null'
      - boolean
    doc: Any passing test suffices
    inputBinding:
      position: 101
      prefix: -or
  - id: order
    type:
      - 'null'
      - boolean
    doc: Rearrange words in sorted order
    inputBinding:
      position: 101
      prefix: -order
  - id: outline
    type:
      - 'null'
      - boolean
    doc: Display outline of XML structure
    inputBinding:
      position: 101
      prefix: -outline
  - id: pad
    type:
      - 'null'
      - string
    doc: 0-Pad to 8 digits
    inputBinding:
      position: 101
      prefix: -pad
  - id: page
    type:
      - 'null'
      - boolean
    doc: Get digits (and letters) of first page number
    inputBinding:
      position: 101
      prefix: -page
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: Adjacent informative words
    inputBinding:
      position: 101
      prefix: -pairs
  - id: path
    type:
      - 'null'
      - type: array
        items: string
    doc: Explore by list of adjacent object names
    inputBinding:
      position: 101
      prefix: -path
  - id: pattern
    type:
      - 'null'
      - string
    doc: Name of record within set
    inputBinding:
      position: 101
      prefix: -pattern
  - id: pentamers
    type:
      - 'null'
      - boolean
    doc: Sliding window of pentamers
    inputBinding:
      position: 101
      prefix: -pentamers
  - id: pept
    type:
      - 'null'
      - boolean
    doc: Split amino acid runs at *, -, x, or X
    inputBinding:
      position: 101
      prefix: -pept
  - id: pfc
    type:
      - 'null'
      - boolean
    doc: Preface combines -clr and -pfx
    inputBinding:
      position: 101
      prefix: -pfc
  - id: pfx
    type:
      - 'null'
      - string
    doc: Prefix to print before group
    inputBinding:
      position: 101
      prefix: -pfx
  - id: pkg
    type:
      - 'null'
      - boolean
    doc: Package subset in XML object
    inputBinding:
      position: 101
      prefix: -pkg
  - id: plain
    type:
      - 'null'
      - boolean
    doc: Remove embedded mixed-content markup tags
    inputBinding:
      position: 101
      prefix: -plain
  - id: plg
    type:
      - 'null'
      - string
    doc: Prologue to print before instance
    inputBinding:
      position: 101
      prefix: -plg
  - id: position
    type:
      - 'null'
      - string
    doc: '[first|last|outer|inner|even|odd|all]'
    inputBinding:
      position: 101
      prefix: -position
  - id: prose
    type:
      - 'null'
      - boolean
    doc: Text conversion to ASCII
    inputBinding:
      position: 101
      prefix: -prose
  - id: rec
    type:
      - 'null'
      - string
    doc: XML tag for each record
    inputBinding:
      position: 101
      prefix: -rec
  - id: reg
    type:
      - 'null'
      - string
    doc: Target expression
    inputBinding:
      position: 101
      prefix: -reg
  - id: replace
    type:
      - 'null'
      - boolean
    doc: Substitute text using regular expressions
    inputBinding:
      position: 101
      prefix: -replace
  - id: resembles
    type:
      - 'null'
      - string
    doc: Requires all words, but in any order
    inputBinding:
      position: 101
      prefix: -resembles
  - id: ret
    type:
      - 'null'
      - string
    doc: Override line break between patterns
    inputBinding:
      position: 101
      prefix: -ret
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: Reverse complement nucleotide sequence
    inputBinding:
      position: 101
      prefix: -revcomp
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse words in string
    inputBinding:
      position: 101
      prefix: -reverse
  - id: rms
    type:
      - 'null'
      - boolean
    doc: Root Mean Square
    inputBinding:
      position: 101
      prefix: -rms
  - id: rst
    type:
      - 'null'
      - boolean
    doc: Reset -sep through -elg
    inputBinding:
      position: 101
      prefix: -rst
  - id: select
    type:
      - 'null'
      - string
    doc: Select record subset by conditions
    inputBinding:
      position: 101
      prefix: -select
  - id: self
    type:
      - 'null'
      - boolean
    doc: Allow detection of empty self-closing tags
    inputBinding:
      position: 101
      prefix: -self
  - id: sep
    type:
      - 'null'
      - string
    doc: Separator between group members
    inputBinding:
      position: 101
      prefix: -sep
  - id: set
    type:
      - 'null'
      - string
    doc: XML tag for entire set
    inputBinding:
      position: 101
      prefix: -set
  - id: sfx
    type:
      - 'null'
      - string
    doc: Suffix to print after group
    inputBinding:
      position: 101
      prefix: -sfx
  - id: simple
    type:
      - 'null'
      - boolean
    doc: Normalize accented letters, spell Greek letters
    inputBinding:
      position: 101
      prefix: -simple
  - id: slf
    type:
      - 'null'
      - boolean
    doc: Self-close with " />"
    inputBinding:
      position: 101
      prefix: -slf
  - id: sort
    type:
      - 'null'
      - string
    doc: Element to use as sort key
    inputBinding:
      position: 101
      prefix: -sort
  - id: sort_fwd
    type:
      - 'null'
      - boolean
    doc: Alias of original -sort
    inputBinding:
      position: 101
      prefix: -sort-fwd
  - id: sort_rev
    type:
      - 'null'
      - boolean
    doc: Sort records in reverse order
    inputBinding:
      position: 101
      prefix: -sort-rev
  - id: split
    type:
      - 'null'
      - boolean
    doc: Split using -with for delimiter
    inputBinding:
      position: 101
      prefix: -split
  - id: sqt
    type:
      - 'null'
      - boolean
    doc: Square Root
    inputBinding:
      position: 101
      prefix: -sqt
  - id: starts_with
    type:
      - 'null'
      - string
    doc: Substring must be at beginning
    inputBinding:
      position: 101
      prefix: -starts-with
  - id: stops
    type:
      - 'null'
      - boolean
    doc: Retain stop words in selected phrases
    inputBinding:
      position: 101
      prefix: -stops
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Remove HTML and MathML tags
    inputBinding:
      position: 101
      prefix: -strict
  - id: sub
    type:
      - 'null'
      - boolean
    doc: Difference
    inputBinding:
      position: 101
      prefix: -sub
  - id: subset
    type:
      - 'null'
      - string
    doc: Use of different argument names allows command-line control of nested 
      looping
    inputBinding:
      position: 101
      prefix: -subset
  - id: sum
    type:
      - 'null'
      - boolean
    doc: Sum
    inputBinding:
      position: 101
      prefix: -sum
  - id: synopsis
    type:
      - 'null'
      - boolean
    doc: Display individual XML paths
    inputBinding:
      position: 101
      prefix: -synopsis
  - id: tab
    type:
      - 'null'
      - string
    doc: Replace tab character between fields
    inputBinding:
      position: 101
      prefix: -tab
  - id: tag
    type:
      - 'null'
      - boolean
    doc: Start with "<" + object name
    inputBinding:
      position: 101
      prefix: -tag
  - id: tail
    type:
      - 'null'
      - boolean
    doc: Print after everything else
    inputBinding:
      position: 101
      prefix: -tail
  - id: terms
    type:
      - 'null'
      - boolean
    doc: Partition text at spaces
    inputBinding:
      position: 101
      prefix: -terms
  - id: test
    type:
      - 'null'
      - boolean
    doc: Check field for visible combining accent and invisible Unicode
    inputBinding:
      position: 101
      prefix: -test
  - id: title
    type:
      - 'null'
      - boolean
    doc: Capitalize initial letters of words
    inputBinding:
      position: 101
      prefix: -title
  - id: tl
    type:
      - 'null'
      - boolean
    doc: Print after each record
    inputBinding:
      position: 101
      prefix: -tl
  - id: transform
    type:
      - 'null'
      - File
    doc: File of substitutions for -translate
    inputBinding:
      position: 101
      prefix: -transform
  - id: translate
    type:
      - 'null'
      - boolean
    doc: Substitute values with -transform table
    inputBinding:
      position: 101
      prefix: -translate
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Remove extra spaces and leading zeros
    inputBinding:
      position: 101
      prefix: -trim
  - id: ucsc_based
    type:
      - 'null'
      - boolean
    doc: Half-Open
    inputBinding:
      position: 101
      prefix: -ucsc-based
  - id: unix
    type:
      - 'null'
      - boolean
    doc: Common Unix command arguments
    inputBinding:
      position: 101
      prefix: -unix
  - id: unless
    type:
      - 'null'
      - string
    doc: Skip if element matches
    inputBinding:
      position: 101
      prefix: -unless
  - id: upper
    type:
      - 'null'
      - boolean
    doc: Convert text to upper-case
    inputBinding:
      position: 101
      prefix: -upper
  - id: verify
    type:
      - 'null'
      - boolean
    doc: Report XML data integrity problems
    inputBinding:
      position: 101
      prefix: -verify
  - id: wct
    type:
      - 'null'
      - boolean
    doc: Count number of -words in a string
    inputBinding:
      position: 101
      prefix: -wct
  - id: words
    type:
      - 'null'
      - boolean
    doc: Split at punctuation marks
    inputBinding:
      position: 101
      prefix: -words
  - id: wrp
    type:
      - 'null'
      - boolean
    doc: Wrap elements in XML object
    inputBinding:
      position: 101
      prefix: -wrp
  - id: year
    type:
      - 'null'
      - boolean
    doc: Extract first 4-digit year from string
    inputBinding:
      position: 101
      prefix: -year
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct_xtract.out
