cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastaIndex
label: fastaindex_FastaIndex
doc: "FastA index (.fai) handler compatible with samtools faidx. The .fai is extended
  with 4 columns storing counts for A, C, G & T for each sequence.\n\nTool homepage:
  https://github.com/lpryszcz/FastaIndex"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_file)
        writable: true
inputs:
  - id: fasta_file
    type: File
    doc: FASTA file. It is staged writable so that the index (.fai) is written
      next to it.
    inputBinding:
      position: 1
      prefix: --fasta
      valueFrom: $(self.basename)
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 2
      prefix: --verbose
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: contig(s) or contig region(s) to output (returns reverse complement if
      end larger than start)
    inputBinding:
      position: 3
      prefix: --regions
  - id: n_value
    type:
      - 'null'
      - int
    doc: calculate NXX and exit ie N50
    inputBinding:
      position: 2
      prefix: -N
  - id: l_value
    type:
      - 'null'
      - int
    doc: calculate LXX and exit ie L50
    inputBinding:
      position: 2
      prefix: -L
  - id: stats
    type:
      - 'null'
      - boolean
    doc: return FastA stats aka fasta_stats
    inputBinding:
      position: 2
      prefix: --stats
  - id: output_stream_path
    type:
      - 'null'
      - string
    doc: "output stream\t [stdout]"
    inputBinding:
      position: 2
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_stream
    type:
      - 'null'
      - File
    doc: output stream
    outputBinding:
      glob: $(inputs.output_stream_path)
  - id: fasta_index
    type:
      - 'null'
      - File
    doc: The extended fasta index written next to the FASTA file.
    outputBinding:
      glob: '*.fai'
stdout: FastaIndex.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaindex:0.11c--py36_0
