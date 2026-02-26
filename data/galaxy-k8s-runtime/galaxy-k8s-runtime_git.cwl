cwlVersion: v1.2
class: CommandLineTool
baseCommand: git
label: galaxy-k8s-runtime_git
doc: "The most commonly used git commands are:\n\nTool homepage: https://github.com/phnmnl/container-galaxy-k8s-runtime"
inputs:
  - id: command
    type: string
    doc: The git command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the git command
    inputBinding:
      position: 2
  - id: git_dir
    type:
      - 'null'
      - Directory
    doc: Set the SMARTEST path to the Git repository
    inputBinding:
      position: 103
      prefix: --git-dir
  - id: namespace
    type:
      - 'null'
      - string
    doc: Use and record a namespace for the references
    inputBinding:
      position: 103
      prefix: --namespace
  - id: work_tree
    type:
      - 'null'
      - Directory
    doc: Set the top level of the work tree
    inputBinding:
      position: 103
      prefix: --work-tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      biocontainers/galaxy-k8s-runtime:phenomenal-v17.09-pheno-lr_cv1.6.175
stdout: galaxy-k8s-runtime_git.out
