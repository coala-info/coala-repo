cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_screen_probes_for_dupes
label: phyluce_phyluce_assembly_screen_probes_for_dupes
doc: "Screen a lastz file of self-to-self matches for dupes\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: lastz
    type: File
    doc: "The lastz input"
    inputBinding:
      position: 1
      prefix: --lastz
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_screen_probes_for_dupes.out
