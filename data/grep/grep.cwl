cwlVersion: v1.2
class: CommandLineTool
baseCommand: grep
label: grep
doc: "Search for PATTERNS in each FILE.\n\nTool homepage: https://www.gnu.org/software/grep/"
inputs:
  - id: patterns
    type: string
    doc: Patterns to search for. PATTERNS can contain multiple patterns 
      separated by newlines.
    inputBinding:
      position: 1
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to search in. When FILE is '-', read standard input. With no 
      FILE, read '.' if recursive, '-' otherwise.
    inputBinding:
      position: 2
  - id: after_context
    type:
      - 'null'
      - int
    doc: print NUM lines of trailing context
    inputBinding:
      position: 103
      prefix: --after-context
  - id: basic_regexp
    type:
      - 'null'
      - boolean
    doc: PATTERNS are basic regular expressions
    inputBinding:
      position: 103
      prefix: --basic-regexp
  - id: before_context
    type:
      - 'null'
      - int
    doc: print NUM lines of leading context
    inputBinding:
      position: 103
      prefix: --before-context
  - id: binary
    type:
      - 'null'
      - boolean
    doc: do not strip CR characters at EOL (MSDOS/Windows)
    inputBinding:
      position: 103
      prefix: --binary
  - id: binary_files
    type:
      - 'null'
      - string
    doc: assume that binary files are TYPE; TYPE is 'binary', 'text', or 
      'without-match'
    inputBinding:
      position: 103
      prefix: --binary-files
  - id: binary_files_without_match
    type:
      - 'null'
      - boolean
    doc: equivalent to --binary-files=without-match
    inputBinding:
      position: 103
      prefix: -I
  - id: byte_offset
    type:
      - 'null'
      - boolean
    doc: print the byte offset with output lines
    inputBinding:
      position: 103
      prefix: --byte-offset
  - id: color
    type:
      - 'null'
      - string
    doc: use markers to highlight the matching strings; WHEN is 'always', 
      'never', or 'auto'
    inputBinding:
      position: 103
      prefix: --color
  - id: colour
    type:
      - 'null'
      - string
    doc: use markers to highlight the matching strings; WHEN is 'always', 
      'never', or 'auto'
    inputBinding:
      position: 103
      prefix: --colour
  - id: context
    type:
      - 'null'
      - int
    doc: print NUM lines of output context
    inputBinding:
      position: 103
      prefix: --context
  - id: context_num
    type:
      - 'null'
      - int
    doc: same as --context=NUM
    inputBinding:
      position: 103
  - id: count
    type:
      - 'null'
      - boolean
    doc: print only a count of selected lines per FILE
    inputBinding:
      position: 103
      prefix: --count
  - id: dereference_recursive
    type:
      - 'null'
      - boolean
    doc: likewise, but follow all symlinks
    inputBinding:
      position: 103
      prefix: --dereference-recursive
  - id: devices
    type:
      - 'null'
      - string
    doc: how to handle devices, FIFOs and sockets; ACTION is 'read' or 'skip'
    inputBinding:
      position: 103
      prefix: --devices
  - id: directories
    type:
      - 'null'
      - string
    doc: how to handle directories; ACTION is 'read', 'recurse', or 'skip'
    inputBinding:
      position: 103
      prefix: --directories
  - id: exclude
    type:
      - 'null'
      - string
    doc: skip files that match GLOB
    inputBinding:
      position: 103
      prefix: --exclude
  - id: exclude_dir
    type:
      - 'null'
      - string
    doc: skip directories that match GLOB
    inputBinding:
      position: 103
      prefix: --exclude-dir
  - id: exclude_from
    type:
      - 'null'
      - File
    doc: skip files that match any file pattern from FILE
    inputBinding:
      position: 103
      prefix: --exclude-from
  - id: extended_regexp
    type:
      - 'null'
      - boolean
    doc: PATTERNS are extended regular expressions
    inputBinding:
      position: 103
      prefix: --extended-regexp
  - id: files_with_matches
    type:
      - 'null'
      - boolean
    doc: print only names of FILEs with selected lines
    inputBinding:
      position: 103
      prefix: --files-with-matches
  - id: files_without_match
    type:
      - 'null'
      - boolean
    doc: print only names of FILEs with no selected lines
    inputBinding:
      position: 103
      prefix: --files-without-match
  - id: fixed_strings
    type:
      - 'null'
      - boolean
    doc: PATTERNS are strings
    inputBinding:
      position: 103
      prefix: --fixed-strings
  - id: group_separator
    type:
      - 'null'
      - string
    doc: print SEP on line between matches with context
    inputBinding:
      position: 103
      prefix: --group-separator
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: ignore case distinctions in patterns and data
    inputBinding:
      position: 103
      prefix: --ignore-case
  - id: include
    type:
      - 'null'
      - string
    doc: search only files that match GLOB (a file pattern)
    inputBinding:
      position: 103
      prefix: --include
  - id: initial_tab
    type:
      - 'null'
      - boolean
    doc: make tabs line up (if needed)
    inputBinding:
      position: 103
      prefix: --initial-tab
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: select non-matching lines
    inputBinding:
      position: 103
      prefix: --invert-match
  - id: label
    type:
      - 'null'
      - string
    doc: use LABEL as the standard input file name prefix
    inputBinding:
      position: 103
      prefix: --label
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: flush output on every line
    inputBinding:
      position: 103
      prefix: --line-buffered
  - id: line_number
    type:
      - 'null'
      - boolean
    doc: print line number with output lines
    inputBinding:
      position: 103
      prefix: --line-number
  - id: line_regexp
    type:
      - 'null'
      - boolean
    doc: match only whole lines
    inputBinding:
      position: 103
      prefix: --line-regexp
  - id: max_count
    type:
      - 'null'
      - int
    doc: stop after NUM selected lines
    inputBinding:
      position: 103
      prefix: --max-count
  - id: no_filename
    type:
      - 'null'
      - boolean
    doc: suppress the file name prefix on output
    inputBinding:
      position: 103
      prefix: --no-filename
  - id: no_group_separator
    type:
      - 'null'
      - boolean
    doc: do not print separator for matches with context
    inputBinding:
      position: 103
      prefix: --no-group-separator
  - id: no_ignore_case
    type:
      - 'null'
      - boolean
    doc: do not ignore case distinctions (default)
    inputBinding:
      position: 103
      prefix: --no-ignore-case
  - id: no_messages
    type:
      - 'null'
      - boolean
    doc: suppress error messages
    inputBinding:
      position: 103
      prefix: --no-messages
  - id: null_data
    type:
      - 'null'
      - boolean
    doc: a data line ends in 0 byte, not newline
    inputBinding:
      position: 103
      prefix: --null-data
  - id: null_output
    type:
      - 'null'
      - boolean
    doc: print 0 byte after FILE name
    inputBinding:
      position: 103
      prefix: --null
  - id: only_matching
    type:
      - 'null'
      - boolean
    doc: show only nonempty parts of lines that match
    inputBinding:
      position: 103
      prefix: --only-matching
  - id: pattern_file
    type:
      - 'null'
      - File
    doc: take PATTERNS from FILE
    inputBinding:
      position: 103
      prefix: --file
  - id: perl_regexp
    type:
      - 'null'
      - boolean
    doc: PATTERNS are Perl regular expressions
    inputBinding:
      position: 103
      prefix: --perl-regexp
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress all normal output
    inputBinding:
      position: 103
      prefix: --quiet
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: like --directories=recurse
    inputBinding:
      position: 103
      prefix: --recursive
  - id: regexp
    type:
      - 'null'
      - type: array
        items: string
    doc: use PATTERNS for matching
    inputBinding:
      position: 103
      prefix: --regexp
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress all normal output
    inputBinding:
      position: 103
      prefix: --silent
  - id: text
    type:
      - 'null'
      - boolean
    doc: equivalent to --binary-files=text
    inputBinding:
      position: 103
      prefix: --text
  - id: with_filename
    type:
      - 'null'
      - boolean
    doc: print file name with output lines
    inputBinding:
      position: 103
      prefix: --with-filename
  - id: word_regexp
    type:
      - 'null'
      - boolean
    doc: match only whole words
    inputBinding:
      position: 103
      prefix: --word-regexp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: ubuntu:latest
stdout: grep.out
