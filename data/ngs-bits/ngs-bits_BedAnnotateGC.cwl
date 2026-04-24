cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedAnnotateGC
label: ngs-bits_BedAnnotateGC
doc: "Annotates GC content fraction to regions in a BED file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: clear
    type:
      - 'null'
      - boolean
    doc: Clear all annotations present in the input file.
    inputBinding:
      position: 101
      prefix: -clear
  - id: extend
    type:
      - 'null'
      - int
    doc: Bases to extend around the input region for calculating the GC content.
    inputBinding:
      position: 101
      prefix: -extend
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input BED file. If unset, reads from STDIN.
    inputBinding:
      position: 101
      prefix: -in
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file. If unset, 'reference_genome' from the 
      'settings.ini' file is used.
    inputBinding:
      position: 101
      prefix: -ref
  - id: settings_override_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
