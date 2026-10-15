cwlVersion: v1.2
class: CommandLineTool
baseCommand: proot
label: proot
doc: "chroot, mount --bind, and binfmt_misc without privilege/setup.\n\nTool homepage: https://proot-me.github.io/"
inputs:
  - id: rootfs
    type:
      - 'null'
      - Directory
    doc: "Use path as the new guest root file-system, default is /."
    inputBinding:
      position: 1
      prefix: -r
  - id: alias_R
    type:
      - 'null'
      - Directory
    doc: "Alias: -r path + a couple of recommended -b."
    inputBinding:
      position: 1
      prefix: -R
  - id: alias_S
    type:
      - 'null'
      - Directory
    doc: "Alias: -0 -r path + a couple of recommended -b."
    inputBinding:
      position: 1
      prefix: -S
  - id: root_id
    type:
      - 'null'
      - boolean
    doc: "Make current user appear as \"root\" and fake its privileges."
    inputBinding:
      position: 1
      prefix: '-0'
  - id: change_id
    type:
      - 'null'
      - string
    doc: "Make current user and group appear as string \"uid:gid\"."
    inputBinding:
      position: 1
      prefix: -i
  - id: kernel_release
    type:
      - 'null'
      - string
    doc: "Make current kernel appear as kernel release string."
    inputBinding:
      position: 1
      prefix: -k
  - id: qemu
    type:
      - 'null'
      - string
    doc: "Execute guest programs through QEMU as specified by command."
    inputBinding:
      position: 1
      prefix: -q
  - id: cwd
    type:
      - 'null'
      - string
    doc: "Set the initial working directory to path (inside the guest)."
    inputBinding:
      position: 1
      prefix: -w
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Set the level of debug information to value."
    inputBinding:
      position: 1
      prefix: -v
  - id: command
    type:
      - 'null'
      - string[]
    doc: "Command to run inside the guest, with its arguments. Defaults to a shell."
    inputBinding:
      position: 100
  - id: bind
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -b
    doc: Make the content of path accessible in the guest rootfs (host_path or host_path:guest_location).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the guest command
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proot:5.1.0--0
stdout: proot.out
