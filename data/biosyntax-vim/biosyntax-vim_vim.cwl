cwlVersion: v1.2
class: CommandLineTool
baseCommand: vim
label: biosyntax-vim_vim
doc: "VIM - Vi IMproved, a text editor\n\nTool homepage: https://github.com/bioSyntax/bioSyntax-vim"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to edit
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosyntax-vim:v1.0.0b-1-deb_cv1
stdout: biosyntax-vim_vim.out
