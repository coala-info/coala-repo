cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pauvre
  - browser
label: pauvre_browser
doc: "A tool for plotting genomic tracks and reference sequences.\n\nTool homepage:
  https://github.com/conchoecia/gloTK"
inputs:
  - id: chromosome_id
    type:
      - 'null'
      - string
    doc: The fasta sequence to observe. Use the header name of the fasta file without
      the '>' character
    inputBinding:
      position: 101
      prefix: --chromosomeid
  - id: dpi
    type:
      - 'null'
      - int
    doc: Change the dpi from the default 600 if you need it higher
    inputBinding:
      position: 101
      prefix: --dpi
  - id: file_format
    type:
      - 'null'
      - type: array
        items: string
    doc: Which output format would you like? Def.=png
    inputBinding:
      position: 101
      prefix: --fileform
  - id: no_timestamp
    type:
      - 'null'
      - boolean
    doc: Turn off time stamps in the filename output.
    inputBinding:
      position: 101
      prefix: --no_timestamp
  - id: plot_commands
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Write strings here to select what to plot. The format for each track is:
      <type>:<path>:<style>:<options> To plot the reference, the format is: ref:<style>:<options>
      Surround each track string with double quotes and a space between subsequent
      strings. "bam:mybam.bam:depth" "ref:colorful"'
    inputBinding:
      position: 101
      prefix: --plot_commands
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ratio
    type:
      - 'null'
      - type: array
        items: float
    doc: 'Enter the dimensions (arbitrary units) to plot the figure. For example a
      figure that is seven times wider than tall is: --ratio 7 1'
    inputBinding:
      position: 101
      prefix: --ratio
  - id: reference
    type:
      - 'null'
      - File
    doc: The reference fasta file.
    inputBinding:
      position: 101
      prefix: --reference
  - id: start
    type:
      - 'null'
      - int
    doc: The start position to observe on the fasta file. Uses 1-based indexing.
    inputBinding:
      position: 101
      prefix: --start
  - id: stop
    type:
      - 'null'
      - int
    doc: The stop position to observe on the fasta file. Uses 1-based indexing.
    inputBinding:
      position: 101
      prefix: --stop
  - id: transparent
    type:
      - 'null'
      - boolean
    doc: Specify this option if you DON'T want a transparent background. Default is
      on.
    inputBinding:
      position: 101
      prefix: --transparent
outputs:
  - id: output_base_name
    type:
      - 'null'
      - File
    doc: Specify a base name for the output file( s). The input file base name is
      the default.
    outputBinding:
      glob: $(inputs.output_base_name)
  - id: path
    type:
      - 'null'
      - File
    doc: Set an explicit filepath for the output. Only do this if you have selected
      one output type.
    outputBinding:
      glob: $(inputs.path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pauvre:0.1924--py_0
