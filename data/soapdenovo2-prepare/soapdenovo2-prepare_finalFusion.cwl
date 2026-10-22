cwlVersion: v1.2
class: CommandLineTool
baseCommand: finalFusion
label: soapdenovo2-prepare_finalFusion
doc: "SOAPdenovo2 mapping and scaffolding module (finalFusion): data preparation,
  mapping, bundling and scaffolding modes.\n\nTool homepage: https://github.com/aquaskyline/SOAPdenovo2"
inputs:
  - id: library_file
    type:
      - 'null'
      - File
    doc: Library file.
    inputBinding:
      position: 101
      prefix: -s
  - id: library_read_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Read files named in the library file (staged next to it so the names
      resolve)
  - id: prefix
    type: string
    doc: Prefix of input files.
    inputBinding:
      position: 101
      prefix: -g
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads.
    inputBinding:
      position: 101
      prefix: -p
  - id: data_prepare
    type:
      - 'null'
      - boolean
    doc: Enable data prepare mode.
    inputBinding:
      position: 101
      prefix: -D
  - id: kmer
    type:
      - 'null'
      - int
    doc: Kmer.
    inputBinding:
      position: 101
      prefix: -K
  - id: input_contig
    type:
      - 'null'
      - File
    doc: Input contig file (cannot be named prefix.contig).
    inputBinding:
      position: 101
      prefix: -c
  - id: mapping
    type:
      - 'null'
      - boolean
    doc: Enable mapping mode.
    inputBinding:
      position: 101
      prefix: -M
  - id: bundling
    type:
      - 'null'
      - boolean
    doc: Enable bundling mode.
    inputBinding:
      position: 101
      prefix: -B
  - id: weight_threshold
    type:
      - 'null'
      - int
    doc: Weight threshold for outputting bundle file (default 3).
    inputBinding:
      position: 101
      prefix: -u
  - id: potential_analysis
    type:
      - 'null'
      - boolean
    doc: Enable potential analysis mode.
    inputBinding:
      position: 101
      prefix: -O
  - id: scaffolding
    type:
      - 'null'
      - boolean
    doc: Enable scaffolding mode.
    inputBinding:
      position: 101
      prefix: -S
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Threshold for minimum length of contig (default K+2).
    inputBinding:
      position: 101
      prefix: -L
  - id: subgraph_overlap
    type:
      - 'null'
      - float
    doc: Overlap percent threshold for a subgraph (default 0.075).
    inputBinding:
      position: 101
      prefix: -P
  - id: pe_overlap
    type:
      - 'null'
      - float
    doc: Overlap percent threshold for a PE (default 0.2).
    inputBinding:
      position: 101
      prefix: -t
  - id: transitive_overlap_length
    type:
      - 'null'
      - int
    doc: Overlap length threshold for remove transitive connect (default 20).
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix
    outputBinding:
      glob: $(inputs.prefix)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.library_read_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapdenovo2-prepare:2.0--h577a1d6_9
stdout: soapdenovo2-prepare_finalFusion.out
