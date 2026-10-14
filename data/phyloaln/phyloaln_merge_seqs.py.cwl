cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - merge_seqs.py
label: phyloaln_merge_seqs.py
doc: "Merge the result directories of several PhyloAln runs into one directory.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: output_dir
    type: string
    doc: "output directory of the merged results"
    inputBinding:
      position: 1
  - id: phyloaln_dirs
    type:
      type: array
      items: Directory
    doc: "PhyloAln output directories to merge (at least two)"
    inputBinding:
      position: 2
outputs:
  - id: merged_dir
    type:
      - 'null'
      - Directory
    doc: "Merged results"
    outputBinding:
      glob: "$(inputs.output_dir)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
stdout: phyloaln_merge_seqs.py.out
