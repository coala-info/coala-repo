cwlVersion: v1.2
class: CommandLineTool
baseCommand: remove_short_seqs
label: cct_remove_short_seqs
doc: "Removes GenBank files that are shorter than the specified length from the provided
  directory.\n\nTool homepage: https://github.com/paulstothard/cgview_comparison_tool"
inputs:
  - id: input
    type: Directory
    doc: Input directory of GenBank files with .gbk extensions.
    inputBinding:
      position: 1
      prefix: -i
      valueFrom: $(self.basename)
  - id: length
    type: int
    doc: Remove GenBank files that describe sequences shorter than this length.
    inputBinding:
      position: 2
      prefix: -l
outputs:
  - id: output_dir
    type: Directory
    doc: The input directory with the shorter GenBank files removed
    outputBinding:
      glob: $(inputs.input.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cct:v20170919dfsg-1-deb_cv1
