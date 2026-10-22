cwlVersion: v1.2
class: CommandLineTool
baseCommand: convert_stacks.pl
label: stacks_convert_stacks.pl
doc: "Convert Stacks output files to the format of another Stacks version.

Tool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: stacks_path
    type: Directory
    doc: "path to the Stacks output files"
    inputBinding:
      position: 101
      prefix: -p
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "turn on debug output"
    inputBinding:
      position: 101
      prefix: -d
  - id: output_path
    type: string
    doc: "path to output the converted Stacks files"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_dir
    type: Directory
    doc: Converted Stacks files
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.output_path) { l.push({"entryname": inputs.output_path, "entry": {"class": "Directory", "listing": []}, "writable": true}); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_convert_stacks.pl.out
