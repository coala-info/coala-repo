cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbintk prepare
label: gbintk_prepare
doc: "Format the initial binning result from an existing binning tool\n\nTool homepage:
  https://github.com/metagentools/gbintk"
inputs:
  - id: assembler
    type: string
    doc: name of the assembler used (SPAdes, MEGAHIT or Flye)
    inputBinding:
      position: 101
      prefix: --assembler
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiter for input/output results. Supports a comma and a tab.
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for the output file
    inputBinding:
      position: 101
      prefix: --prefix
  - id: resfolder
    type: Directory
    doc: path to the folder containing FASTA files for individual bins
    inputBinding:
      position: 101
      prefix: --resfolder
outputs:
  - id: output
    type: Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbintk:1.0.3--py310h9ee0642_0
