cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsync
label: rsync
doc: "rsync is a file transfer program capable of efficient remote update via a fast
  differencing algorithm.\n\nTool homepage: https://github.com/RsyncProject/rsync"
inputs:
  - id: source
    type:
      type: array
      items: string
    doc: Source file(s) or directorie(s)
    inputBinding:
      position: 1
  - id: destination
    type: string
    doc: Destination file, directory, or remote host
    inputBinding:
      position: 2
  - id: acls
    type:
      - 'null'
      - boolean
    doc: preserve ACLs (implies --perms)
    inputBinding:
      position: 103
      prefix: --acls
  - id: append
    type:
      - 'null'
      - boolean
    doc: append data onto shorter files
    inputBinding:
      position: 103
      prefix: --append
  - id: append_verify
    type:
      - 'null'
      - boolean
    doc: --append w/old data in file checksum
    inputBinding:
      position: 103
      prefix: --append-verify
  - id: archive
    type:
      - 'null'
      - boolean
    doc: archive mode is -rlptgoD (no -A,-X,-U,-N,-H)
    inputBinding:
      position: 103
      prefix: --archive
  - id: atimes
    type:
      - 'null'
      - boolean
    doc: preserve access (use) times
    inputBinding:
      position: 103
      prefix: --atimes
  - id: backup
    type:
      - 'null'
      - boolean
    doc: make backups (see --suffix & --backup-dir)
    inputBinding:
      position: 103
      prefix: --backup
  - id: backup_dir
    type:
      - 'null'
      - Directory
    doc: make backups into hierarchy based in DIR
    inputBinding:
      position: 103
      prefix: --backup-dir
  - id: block_size
    type:
      - 'null'
      - string
    doc: force a fixed checksum block-size
    inputBinding:
      position: 103
      prefix: --block-size
  - id: bwlimit
    type:
      - 'null'
      - string
    doc: limit socket I/O bandwidth
    inputBinding:
      position: 103
      prefix: --bwlimit
  - id: checksum
    type:
      - 'null'
      - boolean
    doc: skip based on checksum, not mod-time & size
    inputBinding:
      position: 103
      prefix: --checksum
  - id: checksum_choice
    type:
      - 'null'
      - string
    doc: choose the checksum algorithm
    inputBinding:
      position: 103
      prefix: --checksum-choice
  - id: chmod
    type:
      - 'null'
      - string
    doc: affect file and/or directory permissions
    inputBinding:
      position: 103
      prefix: --chmod
  - id: compare_dest
    type:
      - 'null'
      - Directory
    doc: also compare destination files relative to DIR
    inputBinding:
      position: 103
      prefix: --compare-dest
  - id: compress
    type:
      - 'null'
      - boolean
    doc: compress file data during the transfer
    inputBinding:
      position: 103
      prefix: --compress
  - id: copy_links
    type:
      - 'null'
      - boolean
    doc: transform symlink into referent file/dir
    inputBinding:
      position: 103
      prefix: --copy-links
  - id: crtimes
    type:
      - 'null'
      - boolean
    doc: preserve create times (newness)
    inputBinding:
      position: 103
      prefix: --crtimes
  - id: debug
    type:
      - 'null'
      - string
    doc: fine-grained debug verbosity
    inputBinding:
      position: 103
      prefix: --debug
  - id: delay_updates
    type:
      - 'null'
      - boolean
    doc: put all updated files into place at end
    inputBinding:
      position: 103
      prefix: --delay-updates
  - id: delete
    type:
      - 'null'
      - boolean
    doc: delete extraneous files from dest dirs
    inputBinding:
      position: 103
      prefix: --delete
  - id: devices
    type:
      - 'null'
      - boolean
    doc: preserve device files (super-user only)
    inputBinding:
      position: 103
      prefix: --devices
  - id: dirs
    type:
      - 'null'
      - boolean
    doc: transfer directories without recursing
    inputBinding:
      position: 103
      prefix: --dirs
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: perform a trial run with no changes made
    inputBinding:
      position: 103
      prefix: --dry-run
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: exclude files matching PATTERN
    inputBinding:
      position: 103
      prefix: --exclude
  - id: exclude_from
    type:
      - 'null'
      - File
    doc: read exclude patterns from FILE
    inputBinding:
      position: 103
      prefix: --exclude-from
  - id: executability
    type:
      - 'null'
      - boolean
    doc: preserve executability
    inputBinding:
      position: 103
      prefix: --executability
  - id: existing
    type:
      - 'null'
      - boolean
    doc: skip creating new files on receiver
    inputBinding:
      position: 103
      prefix: --existing
  - id: files_from
    type:
      - 'null'
      - File
    doc: read list of source-file names from FILE
    inputBinding:
      position: 103
      prefix: --files-from
  - id: force
    type:
      - 'null'
      - boolean
    doc: force deletion of dirs even if not empty
    inputBinding:
      position: 103
      prefix: --force
  - id: group
    type:
      - 'null'
      - boolean
    doc: preserve group
    inputBinding:
      position: 103
      prefix: --group
  - id: hard_links
    type:
      - 'null'
      - boolean
    doc: preserve hard links
    inputBinding:
      position: 103
      prefix: --hard-links
  - id: human_readable
    type:
      - 'null'
      - boolean
    doc: output numbers in a human-readable format
    inputBinding:
      position: 103
      prefix: --human-readable
  - id: ignore_existing
    type:
      - 'null'
      - boolean
    doc: skip updating files that exist on receiver
    inputBinding:
      position: 103
      prefix: --ignore-existing
  - id: ignore_times
    type:
      - 'null'
      - boolean
    doc: don't skip files that match size and time
    inputBinding:
      position: 103
      prefix: --ignore-times
  - id: include
    type:
      - 'null'
      - type: array
        items: string
    doc: don't exclude files matching PATTERN
    inputBinding:
      position: 103
      prefix: --include
  - id: info
    type:
      - 'null'
      - string
    doc: fine-grained informational verbosity
    inputBinding:
      position: 103
      prefix: --info
  - id: inplace
    type:
      - 'null'
      - boolean
    doc: update destination files in-place
    inputBinding:
      position: 103
      prefix: --inplace
  - id: ipv4
    type:
      - 'null'
      - boolean
    doc: prefer IPv4
    inputBinding:
      position: 103
      prefix: --ipv4
  - id: ipv6
    type:
      - 'null'
      - boolean
    doc: prefer IPv6
    inputBinding:
      position: 103
      prefix: --ipv6
  - id: itemize_changes
    type:
      - 'null'
      - boolean
    doc: output a change-summary for all updates
    inputBinding:
      position: 103
      prefix: --itemize-changes
  - id: link_dest
    type:
      - 'null'
      - Directory
    doc: hardlink to files in DIR when unchanged
    inputBinding:
      position: 103
      prefix: --link-dest
  - id: links
    type:
      - 'null'
      - boolean
    doc: copy symlinks as symlinks
    inputBinding:
      position: 103
      prefix: --links
  - id: max_delete
    type:
      - 'null'
      - int
    doc: don't delete more than NUM files
    inputBinding:
      position: 103
      prefix: --max-delete
  - id: max_size
    type:
      - 'null'
      - string
    doc: don't transfer any file larger than SIZE
    inputBinding:
      position: 103
      prefix: --max-size
  - id: min_size
    type:
      - 'null'
      - string
    doc: don't transfer any file smaller than SIZE
    inputBinding:
      position: 103
      prefix: --min-size
  - id: mkpath
    type:
      - 'null'
      - boolean
    doc: create destination's missing path components
    inputBinding:
      position: 103
      prefix: --mkpath
  - id: no_implied_dirs
    type:
      - 'null'
      - boolean
    doc: don't send implied dirs with --relative
    inputBinding:
      position: 103
      prefix: --no-implied-dirs
  - id: no_motd
    type:
      - 'null'
      - boolean
    doc: suppress daemon-mode MOTD
    inputBinding:
      position: 103
      prefix: --no-motd
  - id: numeric_ids
    type:
      - 'null'
      - boolean
    doc: don't map uid/gid values by user/group name
    inputBinding:
      position: 103
      prefix: --numeric-ids
  - id: omit_dir_times
    type:
      - 'null'
      - boolean
    doc: omit directories from --times
    inputBinding:
      position: 103
      prefix: --omit-dir-times
  - id: one_file_system
    type:
      - 'null'
      - boolean
    doc: don't cross filesystem boundaries
    inputBinding:
      position: 103
      prefix: --one-file-system
  - id: owner
    type:
      - 'null'
      - boolean
    doc: preserve owner (super-user only)
    inputBinding:
      position: 103
      prefix: --owner
  - id: partial
    type:
      - 'null'
      - boolean
    doc: keep partially transferred files
    inputBinding:
      position: 103
      prefix: --partial
  - id: partial_dir
    type:
      - 'null'
      - Directory
    doc: put a partially transferred file into DIR
    inputBinding:
      position: 103
      prefix: --partial-dir
  - id: perms
    type:
      - 'null'
      - boolean
    doc: preserve permissions
    inputBinding:
      position: 103
      prefix: --perms
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress during transfer
    inputBinding:
      position: 103
      prefix: --progress
  - id: prune_empty_dirs
    type:
      - 'null'
      - boolean
    doc: prune empty directory chains from file-list
    inputBinding:
      position: 103
      prefix: --prune-empty-dirs
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress non-error messages
    inputBinding:
      position: 103
      prefix: --quiet
  - id: read_batch
    type:
      - 'null'
      - File
    doc: read a batched update from FILE
    inputBinding:
      position: 103
      prefix: --read-batch
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: recurse into directories
    inputBinding:
      position: 103
      prefix: --recursive
  - id: relative
    type:
      - 'null'
      - boolean
    doc: use relative path names
    inputBinding:
      position: 103
      prefix: --relative
  - id: remove_source_files
    type:
      - 'null'
      - boolean
    doc: sender removes synchronized files (non-dir)
    inputBinding:
      position: 103
      prefix: --remove-source-files
  - id: rsh
    type:
      - 'null'
      - string
    doc: specify the remote shell to use
    inputBinding:
      position: 103
      prefix: --rsh
  - id: rsync_path
    type:
      - 'null'
      - string
    doc: specify the rsync to run on remote machine
    inputBinding:
      position: 103
      prefix: --rsync-path
  - id: size_only
    type:
      - 'null'
      - boolean
    doc: skip files that match in size
    inputBinding:
      position: 103
      prefix: --size-only
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: turn sequences of nulls into sparse blocks
    inputBinding:
      position: 103
      prefix: --sparse
  - id: specials
    type:
      - 'null'
      - boolean
    doc: preserve special files
    inputBinding:
      position: 103
      prefix: --specials
  - id: stats
    type:
      - 'null'
      - boolean
    doc: give some file-transfer stats
    inputBinding:
      position: 103
      prefix: --stats
  - id: stderr
    type:
      - 'null'
      - string
    doc: change stderr output mode (errors, all, or client)
    default: errors
    inputBinding:
      position: 103
      prefix: --stderr
  - id: suffix
    type:
      - 'null'
      - string
    doc: backup suffix (default ~ w/o --backup-dir)
    inputBinding:
      position: 103
      prefix: --suffix
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: create temporary files in directory DIR
    inputBinding:
      position: 103
      prefix: --temp-dir
  - id: timeout
    type:
      - 'null'
      - int
    doc: set I/O timeout in seconds
    inputBinding:
      position: 103
      prefix: --timeout
  - id: times
    type:
      - 'null'
      - boolean
    doc: preserve modification times
    inputBinding:
      position: 103
      prefix: --times
  - id: update
    type:
      - 'null'
      - boolean
    doc: skip files that are newer on the receiver
    inputBinding:
      position: 103
      prefix: --update
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: increase verbosity
    inputBinding:
      position: 103
      prefix: --verbose
  - id: whole_file
    type:
      - 'null'
      - boolean
    doc: copy files whole (w/o delta-xfer algorithm)
    inputBinding:
      position: 103
      prefix: --whole-file
  - id: xattrs
    type:
      - 'null'
      - boolean
    doc: preserve extended attributes
    inputBinding:
      position: 103
      prefix: --xattrs
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: log what we're doing to the specified FILE
    outputBinding:
      glob: $(inputs.log_file)
  - id: write_batch
    type:
      - 'null'
      - File
    doc: write a batched update to FILE
    outputBinding:
      glob: $(inputs.write_batch)
