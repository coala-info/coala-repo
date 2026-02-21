cwlVersion: v1.2
class: CommandLineTool
baseCommand: cp
label: coreutils_cp
doc: "Copy SOURCE to DEST, or multiple SOURCE(s) to DIRECTORY.\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: source
    type:
      type: array
      items: File
    doc: Source file(s) or directory(s) to copy
    inputBinding:
      position: 1
  - id: archive
    type:
      - 'null'
      - boolean
    doc: same as -dR --preserve=all
    inputBinding:
      position: 102
      prefix: --archive
  - id: attributes_only
    type:
      - 'null'
      - boolean
    doc: don't copy the file data, just the attributes
    inputBinding:
      position: 102
      prefix: --attributes-only
  - id: backup
    type:
      - 'null'
      - boolean
    doc: like --backup but does not accept an argument
    inputBinding:
      position: 102
      prefix: -b
  - id: backup_control
    type:
      - 'null'
      - string
    doc: make a backup of each existing destination file; accepts CONTROL
    inputBinding:
      position: 102
      prefix: --backup
  - id: context
    type:
      - 'null'
      - string
    doc: set the SELinux or SMACK security context to CTX
    inputBinding:
      position: 102
      prefix: --context
  - id: context_default
    type:
      - 'null'
      - boolean
    doc: set SELinux security context of destination file to default type
    inputBinding:
      position: 102
      prefix: -Z
  - id: copy_contents
    type:
      - 'null'
      - boolean
    doc: copy contents of special files when recursive
    inputBinding:
      position: 102
      prefix: --copy-contents
  - id: debug
    type:
      - 'null'
      - boolean
    doc: explain how a file is copied. Implies -v
    inputBinding:
      position: 102
      prefix: --debug
  - id: dereference
    type:
      - 'null'
      - boolean
    doc: always follow symbolic links in SOURCE
    inputBinding:
      position: 102
      prefix: --dereference
  - id: follow_command_line_links
    type:
      - 'null'
      - boolean
    doc: follow command-line symbolic links in SOURCE
    inputBinding:
      position: 102
      prefix: -H
  - id: force
    type:
      - 'null'
      - boolean
    doc: if an existing destination file cannot be opened, remove it and try again
    inputBinding:
      position: 102
      prefix: --force
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: prompt before overwrite
    inputBinding:
      position: 102
      prefix: --interactive
  - id: keep_directory_symlink
    type:
      - 'null'
      - boolean
    doc: follow existing symlinks to directories
    inputBinding:
      position: 102
      prefix: --keep-directory-symlink
  - id: link
    type:
      - 'null'
      - boolean
    doc: hard link files instead of copying
    inputBinding:
      position: 102
      prefix: --link
  - id: no_clobber
    type:
      - 'null'
      - boolean
    doc: (deprecated) silently skip existing files
    inputBinding:
      position: 102
      prefix: --no-clobber
  - id: no_dereference
    type:
      - 'null'
      - boolean
    doc: never follow symbolic links in SOURCE
    inputBinding:
      position: 102
      prefix: --no-dereference
  - id: no_dereference_preserve_links
    type:
      - 'null'
      - boolean
    doc: same as --no-dereference --preserve=links
    inputBinding:
      position: 102
      prefix: -d
  - id: no_preserve
    type:
      - 'null'
      - string
    doc: don't preserve the specified attributes (ATTR_LIST)
    inputBinding:
      position: 102
      prefix: --no-preserve
  - id: no_target_directory
    type:
      - 'null'
      - boolean
    doc: treat DEST as a normal file
    inputBinding:
      position: 102
      prefix: --no-target-directory
  - id: one_file_system
    type:
      - 'null'
      - boolean
    doc: stay on this file system
    inputBinding:
      position: 102
      prefix: --one-file-system
  - id: parents
    type:
      - 'null'
      - boolean
    doc: use full source file name under DIRECTORY
    inputBinding:
      position: 102
      prefix: --parents
  - id: preserve
    type:
      - 'null'
      - string
    doc: preserve the specified attributes (ATTR_LIST)
    inputBinding:
      position: 102
      prefix: --preserve
  - id: preserve_default
    type:
      - 'null'
      - boolean
    doc: same as --preserve=mode,ownership,timestamps
    inputBinding:
      position: 102
      prefix: -p
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: copy directories recursively
    inputBinding:
      position: 102
      prefix: --recursive
  - id: reflink
    type:
      - 'null'
      - string
    doc: control clone/CoW copies (always, auto, never)
    inputBinding:
      position: 102
      prefix: --reflink
  - id: remove_destination
    type:
      - 'null'
      - boolean
    doc: remove each existing destination file before attempting to open it
    inputBinding:
      position: 102
      prefix: --remove-destination
  - id: sparse
    type:
      - 'null'
      - string
    doc: control creation of sparse files (auto, always, never)
    inputBinding:
      position: 102
      prefix: --sparse
  - id: strip_trailing_slashes
    type:
      - 'null'
      - boolean
    doc: remove any trailing slashes from each SOURCE argument
    inputBinding:
      position: 102
      prefix: --strip-trailing-slashes
  - id: suffix
    type:
      - 'null'
      - string
    doc: override the usual backup suffix
    inputBinding:
      position: 102
      prefix: --suffix
  - id: symbolic_link
    type:
      - 'null'
      - boolean
    doc: make symbolic links instead of copying
    inputBinding:
      position: 102
      prefix: --symbolic-link
  - id: update
    type:
      - 'null'
      - string
    doc: control which existing files are updated (all, none, none-fail, older)
    inputBinding:
      position: 102
      prefix: --update
  - id: update_older
    type:
      - 'null'
      - boolean
    doc: equivalent to --update=older
    inputBinding:
      position: 102
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: explain what is being done
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: dest
    type:
      - 'null'
      - File
    doc: Destination file or directory
    outputBinding:
      glob: '*.out'
  - id: target_directory
    type:
      - 'null'
      - Directory
    doc: copy all SOURCE arguments into DIRECTORY
    outputBinding:
      glob: $(inputs.target_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
