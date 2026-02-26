cwlVersion: v1.2
class: CommandLineTool
baseCommand: proot
label: proot
doc: "chroot, mount --bind, and binfmt_misc without privilege/setup.\n\nTool homepage:
  https://github.com/termux/proot-distro"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: about
    type:
      - 'null'
      - boolean
    doc: Print version, copyright, license and contact, then exit.
    inputBinding:
      position: 102
      prefix: --about
  - id: alias_R
    type:
      - 'null'
      - Directory
    doc: 'Alias: -r *path* + a couple of recommended -b.'
    inputBinding:
      position: 102
      prefix: -R
  - id: alias_S
    type:
      - 'null'
      - Directory
    doc: 'Alias: -0 -r *path* + a couple of recommended -b.'
    inputBinding:
      position: 102
      prefix: -S
  - id: bind
    type:
      - 'null'
      - type: array
        items: string
    doc: Make the content of *path* accessible in the guest rootfs.
    inputBinding:
      position: 102
      prefix: --bind
  - id: change_id
    type:
      - 'null'
      - string
    doc: Make current user and group appear as *string* "uid:gid".
    inputBinding:
      position: 102
      prefix: --change-id
  - id: cwd
    type:
      - 'null'
      - Directory
    doc: Set the initial working directory to *path*.
    inputBinding:
      position: 102
      prefix: --cwd
  - id: kernel_release
    type:
      - 'null'
      - string
    doc: Make current kernel appear as kernel release *string*.
    inputBinding:
      position: 102
      prefix: --kernel-release
  - id: mount
    type:
      - 'null'
      - type: array
        items: string
    doc: Make the content of *path* accessible in the guest rootfs.
    inputBinding:
      position: 102
      prefix: --mount
  - id: pwd
    type:
      - 'null'
      - Directory
    doc: Set the initial working directory to *path*.
    inputBinding:
      position: 102
      prefix: --pwd
  - id: qemu
    type:
      - 'null'
      - string
    doc: Execute guest programs through QEMU as specified by *command*.
    inputBinding:
      position: 102
      prefix: --qemu
  - id: root_id
    type:
      - 'null'
      - boolean
    doc: Make current user appear as "root" and fake its privileges.
    inputBinding:
      position: 102
      prefix: --root-id
  - id: rootfs
    type:
      - 'null'
      - Directory
    doc: Use *path* as the new guest root file-system, default is /.
    inputBinding:
      position: 102
      prefix: --rootfs
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set the level of debug information to *value*.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proot:5.1.0--0
stdout: proot.out
