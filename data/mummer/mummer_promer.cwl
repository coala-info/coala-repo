cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - promer
label: mummer_promer
doc: "PROmer generates amino acid alignments between two multi-FASTA DNA input files. The DNA input is translated into all 6 reading frames in order to generate the output, but the output coordinates reference the original DNA input.\n\nTool homepage: https://github.com/mummer4/mummer"
requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
    dockerOutputDirectory: /data
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference)
      - $(inputs.query)
inputs:
  - id: mum
    type:
      - 'null'
      - boolean
    doc: "Use anchor matches that are unique in both the reference and query"
    inputBinding:
      position: 1
      prefix: "--mum"
  - id: mumcand
    type:
      - 'null'
      - boolean
    doc: "Same as --mumreference"
    inputBinding:
      position: 1
      prefix: "--mumcand"
  - id: mumreference
    type:
      - 'null'
      - boolean
    doc: "Use anchor matches that are unique in the reference but not necessarily unique in the query (default behavior)"
    inputBinding:
      position: 1
      prefix: "--mumreference"
  - id: maxmatch
    type:
      - 'null'
      - boolean
    doc: "Use all anchor matches regardless of their uniqueness"
    inputBinding:
      position: 1
      prefix: "--maxmatch"
  - id: breaklen
    type:
      - 'null'
      - int
    doc: "Set the distance an alignment extension will attempt to extend poor scoring regions before giving up, measured in amino acids (default 60)"
    inputBinding:
      position: 1
      prefix: "-b"
  - id: mincluster
    type:
      - 'null'
      - int
    doc: "Sets the minimum length of a cluster of matches, measured in amino acids (default 20)"
    inputBinding:
      position: 1
      prefix: "-c"
  - id: delta
    type:
      - 'null'
      - boolean
    doc: "Toggle the creation of the delta file (default --delta)"
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--delta" : "--nodelta"))'
  - id: depend
    type:
      - 'null'
      - boolean
    doc: "Print the dependency information and exit"
    inputBinding:
      position: 1
      prefix: "--depend"
  - id: diagfactor
    type:
      - 'null'
      - float
    doc: "Set the clustering diagonal difference separation factor (default .11)"
    inputBinding:
      position: 1
      prefix: "-d"
  - id: extend
    type:
      - 'null'
      - boolean
    doc: "Toggle the cluster extension step (default --extend)"
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--extend" : "--noextend"))'
  - id: maxgap
    type:
      - 'null'
      - int
    doc: "Set the maximum gap between two adjacent matches in a cluster, measured in amino acids (default 30)"
    inputBinding:
      position: 1
      prefix: "-g"
  - id: minmatch
    type:
      - 'null'
      - int
    doc: "Set the minimum length of a single match, measured in amino acids (default 6)"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: masklen
    type:
      - 'null'
      - int
    doc: "Set the maximum bookend masking length, measured in amino acids (default 8)"
    inputBinding:
      position: 1
      prefix: "-m"
  - id: coords
    type:
      - 'null'
      - boolean
    doc: "Automatically generate the original PROmer1.1 .coords output file using the show-coords program"
    inputBinding:
      position: 1
      prefix: "--coords"
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: "Toggle alignment score optimization, i.e. if an alignment extension reaches the end of a sequence, it will backtrack to optimize the alignment score instead of terminating the alignment at the end of the sequence (default --optimize)"
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--optimize" : "--nooptimize"))'
  - id: prefix
    type: string
    default: out
    doc: "Set the prefix of the output files (default out)"
    inputBinding:
      position: 1
      prefix: "-p"
  - id: matrix
    type:
      - 'null'
      - int
    doc: "Set the alignment matrix number to 1 [BLOSUM 45], 2 [BLOSUM 62] or 3 [BLOSUM 80] (default 2)"
    inputBinding:
      position: 1
      prefix: "-x"
  - id: reference
    type: File
    doc: "Set the input reference multi-FASTA DNA file. It is staged in the working directory /data so the delta file records the stable path /data/<name>."
    inputBinding:
      position: 100
      valueFrom: $(self.basename)
  - id: query
    type: File
    doc: "Set the input query multi-FASTA DNA file. It is staged in the working directory /data so the delta file records the stable path /data/<name>."
    inputBinding:
      position: 101
      valueFrom: $(self.basename)
outputs:
  - id: delta_out
    type:
      - 'null'
      - File
    doc: "Delta alignment file of the amino acid alignments; read by the show-* utilities"
    outputBinding:
      glob: "$(inputs.prefix).delta"
  - id: coords_out
    type:
      - 'null'
      - File
    doc: "Original PROmer1.1 coords file (only with --coords)"
    outputBinding:
      glob: "$(inputs.prefix).coords"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
stderr: mummer_promer.log
