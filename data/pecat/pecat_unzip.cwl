cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sh
  - -c
arguments:
  - position: 0
    valueFrom: |-
      P="$(inputs.cfg_fname.contents.match(/^project=(.*)$/m)[1].trim())"; sed -i "s#^.*/2-align/#$PWD/$P/2-align/#" "$P/2-align/overlaps.txt"; exec pecat.pl unzip "$1"
  - position: 0
    valueFrom: sh
label: pecat_unzip
doc: "Generate a diploid assembly (phasing, second assembly and polishing) from a PECAT haplotype-collapsed assembly.

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
  - id: project_dir
    type: Directory
    doc: Project folder written by pecat_assemble
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
      - entryname: $(inputs.cfg_fname.contents.match(/^project=(.*)$/m)[1].trim())
        entry: $(inputs.project_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pecat:0.0.3--hdb21b49_2
