cwlVersion: v1.2
class: CommandLineTool
baseCommand: file
label: qcli_append_file
doc: "Determine type of FILEs.\n\nTool homepage: https://github.com/xyOz-dev/LogiQCLI"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to examine
    inputBinding:
      position: 1
  - id: apple
    type:
      - 'null'
      - boolean
    doc: output the Apple CREATOR/TYPE
    inputBinding:
      position: 102
      prefix: --apple
  - id: brief
    type:
      - 'null'
      - boolean
    doc: do not prepend filenames to output lines
    inputBinding:
      position: 102
      prefix: --brief
  - id: checking_printout
    type:
      - 'null'
      - boolean
    doc: print the parsed form of the magic file, use in conjunction with -m to 
      debug a new magic file before installing it
    inputBinding:
      position: 102
      prefix: --checking-printout
  - id: compile
    type:
      - 'null'
      - boolean
    doc: compile file specified by -m
    inputBinding:
      position: 102
      prefix: --compile
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print debugging messages
    inputBinding:
      position: 102
      prefix: --debug
  - id: dereference
    type:
      - 'null'
      - boolean
    doc: follow symlinks (default if POSIXLY_CORRECT is set)
    inputBinding:
      position: 102
      prefix: --dereference
  - id: exclude
    type:
      - 'null'
      - string
    doc: 'exclude TEST from the list of test to be performed for file. Valid tests
      are: apptype, ascii, cdf, compress, elf, encoding, soft, tar, json, text, tokens'
    inputBinding:
      position: 102
      prefix: --exclude
  - id: extension
    type:
      - 'null'
      - boolean
    doc: output a slash-separated list of extensions
    inputBinding:
      position: 102
      prefix: --extension
  - id: files_from
    type:
      - 'null'
      - File
    doc: read the filenames to be examined from FILE
    inputBinding:
      position: 102
      prefix: --files-from
  - id: keep_going
    type:
      - 'null'
      - boolean
    doc: don't stop at the first match
    inputBinding:
      position: 102
      prefix: --keep-going
  - id: list
    type:
      - 'null'
      - boolean
    doc: list magic strength
    inputBinding:
      position: 102
      prefix: --list
  - id: magic_file
    type:
      - 'null'
      - string
    doc: use LIST as a colon-separated list of magic number files
    inputBinding:
      position: 102
      prefix: --magic-file
  - id: mime
    type:
      - 'null'
      - boolean
    doc: output MIME type strings (--mime-type and --mime-encoding)
    inputBinding:
      position: 102
      prefix: --mime
  - id: mime_encoding
    type:
      - 'null'
      - boolean
    doc: output the MIME encoding
    inputBinding:
      position: 102
      prefix: --mime-encoding
  - id: mime_type
    type:
      - 'null'
      - boolean
    doc: output the MIME type
    inputBinding:
      position: 102
      prefix: --mime-type
  - id: no_buffer
    type:
      - 'null'
      - boolean
    doc: do not buffer output
    inputBinding:
      position: 102
      prefix: --no-buffer
  - id: no_dereference
    type:
      - 'null'
      - boolean
    doc: don't follow symlinks (default if POSIXLY_CORRECT is not set) (default)
    inputBinding:
      position: 102
      prefix: --no-dereference
  - id: no_pad
    type:
      - 'null'
      - boolean
    doc: do not pad output
    inputBinding:
      position: 102
      prefix: --no-pad
  - id: parameter
    type:
      - 'null'
      - string
    doc: "set file engine parameter limits\nindir        15 recursion limit for indirection\n\
      name         30 use limit for name/use magic\nelf_notes   256 max ELF notes
      processed\nelf_phnum   128 max ELF prog sections processed\nelf_shnum 32768
      max ELF sections processed"
    inputBinding:
      position: 102
      prefix: --parameter
  - id: preserve_date
    type:
      - 'null'
      - boolean
    doc: preserve access times on files
    inputBinding:
      position: 102
      prefix: --preserve-date
  - id: print0
    type:
      - 'null'
      - boolean
    doc: terminate filenames with ASCII NUL
    inputBinding:
      position: 102
      prefix: --print0
  - id: raw
    type:
      - 'null'
      - boolean
    doc: don't translate unprintable chars to \ooo
    inputBinding:
      position: 102
      prefix: --raw
  - id: separator
    type:
      - 'null'
      - string
    doc: use string as separator instead of `:'
    inputBinding:
      position: 102
      prefix: --separator
  - id: special_files
    type:
      - 'null'
      - boolean
    doc: treat special (block/char devices) files as ordinary ones
    inputBinding:
      position: 102
      prefix: --special-files
  - id: uncompress
    type:
      - 'null'
      - boolean
    doc: try to look inside compressed files
    inputBinding:
      position: 102
      prefix: --uncompress
  - id: uncompress_noreport
    type:
      - 'null'
      - boolean
    doc: only print the contents of compressed files
    inputBinding:
      position: 102
      prefix: --uncompress-noreport
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qcli:v0.1.1-3-deb-py2_cv1
stdout: qcli_append_file.out
