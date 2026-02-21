cwlVersion: v1.2
class: CommandLineTool
baseCommand: pigz
label: pigz_unpigz
doc: "pigz does what gzip does, but spreads the work over multiple processors and
  cores when compressing. It will compress files in place, adding the suffix '.gz'.\n
  \nTool homepage: https://github.com/madler/pigz"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to compress or decompress
    inputBinding:
      position: 1
  - id: alias
    type:
      - 'null'
      - string
    doc: Use xxx as the name for any --zip entry from stdin
    inputBinding:
      position: 102
      prefix: --alias
  - id: best
    type:
      - 'null'
      - boolean
    doc: Compression level 9
    inputBinding:
      position: 102
      prefix: --best
  - id: blocksize
    type:
      - 'null'
      - string
    doc: Set compression block size to mmmK
    default: 128K
    inputBinding:
      position: 102
      prefix: --blocksize
  - id: comment
    type:
      - 'null'
      - string
    doc: Put comment ccc in the gzip or zip header
    inputBinding:
      position: 102
      prefix: --comment
  - id: compression_level
    type:
      - 'null'
      - boolean
    doc: Compression level (0-9, -11)
    inputBinding:
      position: 102
      prefix: '-0'
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Decompress the compressed input
    inputBinding:
      position: 102
      prefix: --decompress
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Compression level 1
    inputBinding:
      position: 102
      prefix: --fast
  - id: first
    type:
      - 'null'
      - boolean
    doc: Do iterations first, before block split for -11
    inputBinding:
      position: 102
      prefix: --first
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite, compress .gz, links, and to terminal
    inputBinding:
      position: 102
      prefix: --force
  - id: huffman
    type:
      - 'null'
      - boolean
    doc: Use only Huffman coding for compression
    inputBinding:
      position: 102
      prefix: --huffman
  - id: independent
    type:
      - 'null'
      - boolean
    doc: Compress blocks independently for damage recovery
    inputBinding:
      position: 102
      prefix: --independent
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of iterations for -11 optimization
    inputBinding:
      position: 102
      prefix: --iterations
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Do not delete original file after processing
    inputBinding:
      position: 102
      prefix: --keep
  - id: license
    type:
      - 'null'
      - boolean
    doc: Display the pigz license and quit
    inputBinding:
      position: 102
      prefix: --license
  - id: list
    type:
      - 'null'
      - boolean
    doc: List the contents of the compressed input
    inputBinding:
      position: 102
      prefix: --list
  - id: maxsplits
    type:
      - 'null'
      - int
    doc: Maximum number of split blocks for -11
    inputBinding:
      position: 102
      prefix: --maxsplits
  - id: name_flag
    type:
      - 'null'
      - boolean
    doc: Store or restore file name and mod time
    inputBinding:
      position: 102
      prefix: --name
  - id: no_name
    type:
      - 'null'
      - boolean
    doc: Do not store or restore file name or mod time
    inputBinding:
      position: 102
      prefix: --no-name
  - id: no_time
    type:
      - 'null'
      - boolean
    doc: Do not store or restore mod time
    inputBinding:
      position: 102
      prefix: --no-time
  - id: oneblock
    type:
      - 'null'
      - boolean
    doc: Do not split into smaller blocks for -11
    inputBinding:
      position: 102
      prefix: --oneblock
  - id: processes
    type:
      - 'null'
      - int
    doc: Allow up to n compression threads
    inputBinding:
      position: 102
      prefix: --processes
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Print no messages, even on error
    inputBinding:
      position: 102
      prefix: --quiet
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Process the contents of all subdirectories
    inputBinding:
      position: 102
      prefix: --recursive
  - id: rle
    type:
      - 'null'
      - boolean
    doc: Use run-length encoding for compression
    inputBinding:
      position: 102
      prefix: --rle
  - id: rsyncable
    type:
      - 'null'
      - boolean
    doc: Input-determined block locations for rsync
    inputBinding:
      position: 102
      prefix: --rsyncable
  - id: suffix
    type:
      - 'null'
      - string
    doc: Use suffix .sss instead of .gz (for compression)
    default: .gz
    inputBinding:
      position: 102
      prefix: --suffix
  - id: synchronous
    type:
      - 'null'
      - boolean
    doc: Force output file write to permanent storage
    inputBinding:
      position: 102
      prefix: --synchronous
  - id: test
    type:
      - 'null'
      - boolean
    doc: Test the integrity of the compressed input
    inputBinding:
      position: 102
      prefix: --test
  - id: time
    type:
      - 'null'
      - boolean
    doc: Store or restore mod time
    inputBinding:
      position: 102
      prefix: --time
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Provide more verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: zip
    type:
      - 'null'
      - boolean
    doc: Compress to PKWare zip (.zip) single entry format
    inputBinding:
      position: 102
      prefix: --zip
  - id: zlib
    type:
      - 'null'
      - boolean
    doc: Compress to zlib (.zz) instead of gzip format
    inputBinding:
      position: 102
      prefix: --zlib
outputs:
  - id: stdout
    type:
      - 'null'
      - File
    doc: Write all processed output to stdout (won't delete)
    outputBinding:
      glob: $(inputs.stdout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pigz:2.8
