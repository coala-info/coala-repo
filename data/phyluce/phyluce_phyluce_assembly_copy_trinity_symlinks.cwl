cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_copy_trinity_symlinks
label: phyluce_phyluce_assembly_copy_trinity_symlinks
doc: "Copy symlinks from trinity assemblies to a new folder\n\nThe wrapper replaces each new symlink by a copy of its target, because the targets exist only inside the container.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
requirements:
  - class: ShellCommandRequirement
arguments:
  - position: 100
    shellQuote: false
    valueFrom: "&& for l in $(inputs.output)/*; do if [ -L \"$l\" ]; then t=`readlink -f \"$l\"`; rm \"$l\"; cp \"$t\" \"$l\"; fi; done"
inputs:
  - id: assembly_symlinks
    type: Directory
    doc: "The location of the trinity symlinks (trinity-assemblies/contigs)"
    inputBinding:
      position: 1
      prefix: --assembly-symlinks
  - id: conf
    type: File
    doc: "The configuration file to use (the tool needs it, although the help lists it as optional)"
    inputBinding:
      position: 1
      prefix: --conf
  - id: output
    type: string
    doc: "The output folder (the tool needs it, although the help lists it as optional)"
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "The output folder holding the copied contigs (the wrapper replaces each symlink the tool makes by a copy of its target, because the targets exist only inside the container)"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
