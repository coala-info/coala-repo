cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_format_nexus_files_for_raxml]
label: phyluce_phyluce_align_format_nexus_files_for_raxml
doc: "Convert individual nexus files to concatenated phylip format.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing alignments to concatenate (NEXUS-ONLY)."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The output folder for the concatenated phylip data."
    inputBinding:
      position: 2
      prefix: --output
  - id: nexus
    type: ['null', boolean]
    doc: "Export as NEXUS format."
    inputBinding:
      position: 3
      prefix: --nexus
  - id: charsets
    type: ['null', boolean]
    doc: "Add charsets to phylip file."
    inputBinding:
      position: 4
      prefix: --charsets
  - id: verbosity
    type: ['null', string]
    doc: "The logging level to use (INFO, WARN, CRITICAL)."
    inputBinding:
      position: 5
      prefix: --verbosity
  - id: log_path
    type: ['null', string]
    doc: "The path to an existing directory to hold logs."
    inputBinding:
      position: 6
      prefix: --log-path
outputs:
  - id: output_dir
    type: Directory
    doc: "Folder holding the concatenated alignment (and the charsets file if requested)."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
