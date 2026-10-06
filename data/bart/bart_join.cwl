cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, join]
requirements:
  - class: InlineJavascriptRequirement
label: bart_join
doc: "Join input files along {dimensions}. All other dimensions must have the same
  size.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dimension
    type: int
    doc: The dimension to join along
    inputBinding:
      position: 10
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files to join
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.map(function(f) { return f.path.replace(/\.cfl$/, ''); 
        }))
  - id: output_file_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 12
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append - only works for cfl files!
    inputBinding:
      position: 1
      prefix: -a
outputs:
  - id: output_file
    type: File
    doc: Output file name
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_file_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
