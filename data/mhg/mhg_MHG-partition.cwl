cwlVersion: v1.2
class: CommandLineTool
baseCommand: MHG-partition
label: mhg_MHG-partition
doc: "Partition and generate modules (maximal homologous groups) from a folder of blastn XML queries.\n\
  \nTool homepage: https://github.com/NakhlehLab/Maximal-Homologous-Groups"
inputs:
  - id: query
    type: Directory
    doc: Input folder for module partition storing all blastn queries in xml format.
    inputBinding:
      position: 101
      prefix: -q
      valueFrom: $(self.path)/
  - id: output
    type: string
    doc: File containing the final partitioned modules, each line represents a module containing different
      blocks.
    inputBinding:
      position: 101
      prefix: -o
  - id: threshold
    type:
      - 'null'
      - float
    doc: Bitscore threshold for determining true homology.
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: mhg_file
    type: File
    doc: Final partitioned modules, one per line.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhg:1.1.0--hdfd78af_0
