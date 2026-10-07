cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - demultiplexer2
  - demultiplex
label: demultiplexer2_demultiplex
doc: "Demultiplexes sequencing reads based on primer and tagging schemes.\n\nTool
  homepage: https://github.com/DominikBuchner/demultiplexer2"
inputs:
  - id: primerset_path
    type: File
    doc: Path to the primerset to be used for demultiplexing.
    inputBinding:
      position: 101
      prefix: --primerset_path
  - id: tagging_scheme_path
    type: File
    doc: Path to the tagging scheme to be used for demultiplexing.
    inputBinding:
      position: 101
      prefix: --tagging_scheme_path
  - id: output_dir_path
    type: string
    inputBinding:
      position: 102
      prefix: --output_dir
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the input read files, staged into the working directory
      so that relative paths in the tagging scheme resolve.
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to write the demultiplexed files to.
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [{"class": "Directory", "basename": inputs.output_dir_path, "listing": [], "writable": true}];
        if (inputs.data_dir) { l.push(inputs.data_dir); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplexer2:1.1.6--pyhdfd78af_0
