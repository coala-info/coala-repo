cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nucmer
label: mummer_nucmer
doc: "NUCmer generates nucleotide alignments between two multi-FASTA input files. The out.delta output file lists the distance between insertions and deletions that produce maximal scoring alignments between each sequence. The show-* utilities know how to read this format.\n\nTool homepage: https://github.com/mummer4/mummer"
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
    doc: "Set the distance an alignment extension will attempt to extend poor scoring regions before giving up (default 200)"
    inputBinding:
      position: 1
      prefix: "-b"
  - id: banded
    type:
      - 'null'
      - boolean
    doc: "Enforce absolute banding of dynamic programming matrix based on diagdiff parameter EXPERIMENTAL (default no)"
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--banded" : "--nobanded"))'
  - id: mincluster
    type:
      - 'null'
      - int
    doc: "Sets the minimum length of a cluster of matches (default 65)"
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
  - id: diagdiff
    type:
      - 'null'
      - int
    doc: "Set the maximum diagonal difference between two adjacent anchors in a cluster (default 5)"
    inputBinding:
      position: 1
      prefix: "-D"
  - id: diagfactor
    type:
      - 'null'
      - float
    doc: "Set the maximum diagonal difference between two adjacent anchors in a cluster as a differential fraction of the gap length (default 0.12)"
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
  - id: forward
    type:
      - 'null'
      - boolean
    doc: "Use only the forward strand of the Query sequences"
    inputBinding:
      position: 1
      prefix: "--forward"
  - id: maxgap
    type:
      - 'null'
      - int
    doc: "Set the maximum gap between two adjacent matches in a cluster (default 90)"
    inputBinding:
      position: 1
      prefix: "-g"
  - id: minmatch
    type:
      - 'null'
      - int
    doc: "Set the minimum length of a single match (default 20)"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: coords
    type:
      - 'null'
      - boolean
    doc: "Automatically generate the original NUCmer1.1 coords output file using the show-coords program"
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
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: "Use only the reverse complement of the Query sequences"
    inputBinding:
      position: 1
      prefix: "--reverse"
  - id: simplify
    type:
      - 'null'
      - boolean
    doc: "Simplify alignments by removing shadowed clusters. Turn this option off if aligning a sequence to itself to look for repeats (default --simplify)"
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--simplify" : "--nosimplify"))'
  - id: reference
    type: File
    doc: "Set the input reference multi-FASTA filename. It is staged in the working directory /data so the delta file records the stable path /data/<name>, which show-snps and show-aligns can read again."
    inputBinding:
      position: 100
      valueFrom: $(self.basename)
  - id: query
    type: File
    doc: "Set the input query multi-FASTA filename. It is staged in the working directory /data so the delta file records the stable path /data/<name>."
    inputBinding:
      position: 101
      valueFrom: $(self.basename)
outputs:
  - id: delta_out
    type:
      - 'null'
      - File
    doc: "Delta alignment file (lists the distances between insertions and deletions that produce maximal scoring alignments); read by the show-* utilities"
    outputBinding:
      glob: "$(inputs.prefix).delta"
  - id: coords_out
    type:
      - 'null'
      - File
    doc: "Original NUCmer1.1 coords file (only with --coords)"
    outputBinding:
      glob: "$(inputs.prefix).coords"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
stderr: mummer_nucmer.log
