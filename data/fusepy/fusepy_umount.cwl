cwlVersion: v1.2
class: CommandLineTool
baseCommand: umount
label: fusepy_umount
doc: "Unmount file systems\n\nTool homepage: http://github.com/terencehonles/fusepy"
inputs:
  - id: filesystem_or_directory
    type: string
    doc: FILESYSTEM or DIRECTORY to unmount
    inputBinding:
      position: 1
  - id: dont_free_loop_device
    type:
      - 'null'
      - boolean
    doc: Don't free loop device even if it has been used
    inputBinding:
      position: 102
      prefix: -D
  - id: force_umount
    type:
      - 'null'
      - boolean
    doc: Force umount (i.e., unreachable NFS server)
    inputBinding:
      position: 102
      prefix: -f
  - id: lazy_umount
    type:
      - 'null'
      - boolean
    doc: Lazy umount (detach filesystem)
    inputBinding:
      position: 102
      prefix: -l
  - id: remount_read_only
    type:
      - 'null'
      - boolean
    doc: Try to remount devices as read-only if mount is busy
    inputBinding:
      position: 102
      prefix: -r
  - id: unmount_all
    type:
      - 'null'
      - boolean
    doc: Unmount all file systems
    inputBinding:
      position: 102
      prefix: -a
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusepy:2.0.4--py36_0
stdout: fusepy_umount.out
