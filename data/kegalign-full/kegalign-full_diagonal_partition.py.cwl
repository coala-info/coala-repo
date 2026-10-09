cwlVersion: v1.2
class: CommandLineTool
baseCommand: diagonal_partition.py
label: kegalign-full_diagonal_partition.py
doc: "Diagonal partitioning for segment files output by KegAlign. Reads one lastz\
  \ command line that KegAlign printed, splits the segment file named by its\
  \ --segments= word into chunks of at most max_segments lines, and prints one\
  \ lastz command per chunk. Set max_segments to 0 to skip partitioning, or -1 to\
  \ estimate the best value.\n\nTool homepage: https://github.com/galaxyproject/KegAlign"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.segments_file)
        writable: true
inputs:
  - id: max_segments
    type: int
    doc: Maximum number of segment lines per chunk (0 = no partitioning, -1 = estimate).
    inputBinding:
      position: 1
  - id: lastz_command
    type:
      type: array
      items: string
    doc: Words of the lastz command printed by KegAlign (must contain --segments=<file>,
      --output=<file>, --strand=<plus|minus>, and end with the error file name).
    inputBinding:
      position: 2
  - id: segments_file
    type: File
    doc: Segment file named in the --segments= word of the lastz command. It is
      staged under its own name in the working directory.
outputs:
  - id: lastz_commands
    type: stdout
    doc: One lastz command line per chunk.
  - id: split_segments
    type:
      type: array
      items: File
    doc: Chunked segment files written by the tool.
    outputBinding:
      glob: '*.split*.segments'
stdout: kegalign-full_diagonal_partition.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
