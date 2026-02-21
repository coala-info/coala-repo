cwlVersion: v1.2
class: CommandLineTool
baseCommand: git-lfs
label: git-lfs
doc: "Git Large File Storage (LFS) replaces large files with text pointers inside
  Git, while storing the file contents on a remote server.\n\nTool homepage: https://github.com/git-lfs/git-lfs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/git-lfs:1.5.2--0
stdout: git-lfs.out
