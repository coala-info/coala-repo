cwlVersion: v1.2
class: CommandLineTool
baseCommand: juicebox_assembly_purger.py
label: juicebox_scripts_juicebox_assembly_purger.py
doc: "Removes the given contigs from a Juicebox assembly file.\n\nTool homepage: https://github.com/phasegenomics/juicebox_scripts"
inputs:
  - id: exclude_contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of contigs to exclude
    inputBinding:
      position: 5
      prefix: --exclude_contigs
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: Path to file of contigs to exclude (with contig names in first whitespace-delimited column, one per line)
    inputBinding:
      position: 3
      prefix: --exclude_file
  - id: logging
    type:
      - 'null'
      - string
    doc: "Set logging level, verbose or silent (Default: verbose)"
    inputBinding:
      position: 4
      prefix: --logging
  - id: input_assembly
    type: File
    doc: Input Juicebox assembly file
    inputBinding:
      position: 1
  - id: output_assembly
    type: string
    doc: Output assembly file name
    inputBinding:
      position: 2
outputs:
  - id: assembly_output
    type: File
    doc: Filtered assembly file written to the path given in output_assembly
    outputBinding:
      glob: $(inputs.output_assembly)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
