cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_utilities_replace_many_links
label: phyluce_phyluce_utilities_replace_many_links
doc: "Replace a part of the target path in many symlinks and write the updated symlinks to a new directory\n\nThe wrapper replaces each new symlink by a copy of its target, because the targets exist only inside the container.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: "${ return {class: 'Directory', listing: []}; }"
        writable: true
      - "${ return inputs.target_dirs ? inputs.target_dirs : []; }"
arguments:
  - position: 100
    shellQuote: false
    valueFrom: "&& for l in $(inputs.outdir)/*; do if [ -L \"$l\" ]; then t=`readlink \"$l\"`; rm \"$l\"; cp \"$t\" \"$l\"; fi; done"
inputs:
  - id: indir
    type: Directory
    doc: "The directory containing the links to rename"
    inputBinding:
      position: 1
      prefix: --indir
  - id: oldpath
    type: string
    doc: "The text you want to replace in the oldpath (include '/')"
    inputBinding:
      position: 1
      prefix: --oldpath
  - id: newpath
    type: string
    doc: "The text you want to use as a replacement in the newpath (include '/')"
    inputBinding:
      position: 1
      prefix: --newpath
  - id: outdir
    type: string
    doc: "The output directory to hold updated symlinks. The tool needs it to exist, so it is created before the run."
    inputBinding:
      position: 1
      prefix: --outdir
  - id: target_dirs
    type:
      - 'null'
      - {"type": "array", "items": "Directory"}
    doc: "Directories that hold the new link targets. They are staged in the working directory, so use their names in --newpath."
outputs:
  - id: output_dir
    type: Directory
    doc: "The directory holding the copies of the new link targets"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
