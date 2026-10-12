cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pecat.pl
  - correct
label: pecat_correct
doc: "Correct raw long reads (PECAT read correction step).

Tool homepage: https://github.com/lemene/PECAT"
inputs:
  - id: cfg_fname
    type: File
    doc: Configuration file (key=value lines, e.g. project=, reads=, genome_size=, threads=); made by pecat_config
    loadContents: true
    inputBinding:
      position: 1
  - id: reads_files
    type:
      type: array
      items: File
    doc: Raw read files named by the reads= entry of the configuration file; staged next to the project folder
outputs:
  - id: project
    type: Directory
    doc: Project folder written by the step (named by project= in the configuration file)
    outputBinding:
      glob: $(inputs.cfg_fname.contents.match(/^project=(.*)$/m)[1].trim())
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reads_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pecat:0.0.3--hdb21b49_2
