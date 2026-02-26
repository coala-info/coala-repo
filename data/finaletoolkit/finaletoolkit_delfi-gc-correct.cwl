cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit-delfi-gc-correct
label: finaletoolkit_delfi-gc-correct
doc: "Performs gc-correction on raw delfi data. This command is deprecated and will
  be removed in a future version of FinaleToolkit. The delfi command has gc correction
  on by default.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: BED file containing raw DELFI data. Raw DELFI data should only have 
      columns for "contig", "start", "stop", "arm", "short", "long", "gc", 
      "num_frags", "ratio".
    inputBinding:
      position: 1
  - id: header_lines
    type:
      - 'null'
      - int
    doc: Number of header lines in BED.
    inputBinding:
      position: 102
      prefix: --header-lines
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode to display detailed processing information.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: BED to print GC-corrected DELFI fractions. If "-", will write to 
      stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
