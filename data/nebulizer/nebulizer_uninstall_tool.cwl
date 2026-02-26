cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - uninstall_tool
label: nebulizer_uninstall_tool
doc: "Uninstall previously installed tool.\n\nUninstalls the specified tool which
  was previously installed from\nREPOSITORY into GALAXY, where REPOSITORY can be as
  one of:\n\n- full URL (without revision) e.g.\nhttps://toolshed.g2.bx.psu.edu/view/devteam/fastqc\n\
  \n- OWNER/TOOLNAME combination e.g. devteam/fastqc (toolshed is assumed to\nbe main
  Galaxy toolshed)\n\n- [ TOOLSHED ] OWNER TOOLNAME e.g. https://toolshed.g2.bx.psu.edu
  devteam\nfastqc\n\nThe tool must already be present in GALAXY; a revision must be
  specified\nif more than one revision is installed (use '*' to match all revisions).\n\
  \nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: Galaxy instance to uninstall from
    inputBinding:
      position: 1
  - id: repositories
    type:
      type: array
      items: string
    doc: Repository/tool to uninstall
    inputBinding:
      position: 2
  - id: remove_from_disk
    type:
      - 'null'
      - boolean
    doc: "remove the uninstalled tool from disk (otherwise tool is\njust deactivated)."
    inputBinding:
      position: 103
      prefix: --remove_from_disk
  - id: yes
    type:
      - 'null'
      - boolean
    doc: don't ask for confirmation of uninstallation.
    inputBinding:
      position: 103
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_uninstall_tool.out
