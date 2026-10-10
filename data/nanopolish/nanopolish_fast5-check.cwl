cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanopolish
  - fast5-check
label: nanopolish_fast5-check
doc: "Check whether the fast5 files are indexed correctly and readable by nanopolish\n\
  \nTool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: reads
    type: File
    secondaryFiles:
      - .index
      - .index.fai
      - .index.gzi
      - .index.readdb
    doc: file containing the basecalled reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: raw_ont_signal_directory
    type:
      type: array
      items: Directory
    doc: Directories with the raw ONT signal (fast5) files that were given to
      nanopolish index. They are staged in the working directory under the
      same names, so the relative fast5 paths stored in the reads index
      (.index.readdb) resolve.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.raw_ont_signal_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
stdout: nanopolish_fast5-check.out
