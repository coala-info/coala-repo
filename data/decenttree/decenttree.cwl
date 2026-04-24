cwlVersion: v1.2
class: CommandLineTool
baseCommand: decenttree
label: decenttree
doc: "v1.0.0 for Linux 64-bit\nBased on algorithms (UPGMA, NJ, BIONJ) proposed by
  Sokal & Michener [1958],\nSaitou & Nei [1987], Gascuel [1997] and [2009]\nIncorporating
  (in NJ-R and BIONJ-R) techniques proposed by Simonson, Mailund, and Pedersen [2011]\n\
  Developed by Olivier Gascuel [2009], Hoa Sien Cuong [2009], James Barbetti [2020-22]\n\
  \nTool homepage: https://github.com/iqtree/decenttree"
inputs:
  - id: alphabet
    type:
      - 'null'
      - string
    doc: are the characters for each site
    inputBinding:
      position: 101
      prefix: -alphabet
  - id: c
    type:
      - 'null'
      - int
    doc: is a compression level between 1 and 9 (default 5)
    inputBinding:
      position: 101
      prefix: -c
  - id: f
    type:
      - 'null'
      - int
    doc: is a precision (default 6)
    inputBinding:
      position: 101
      prefix: -f
  - id: fasta
    type:
      - 'null'
      - File
    doc: "is the path of a .fasta format file specifying an alignment\nof genetic
      sequences (file may be in .gz format)"
    inputBinding:
      position: 101
      prefix: -fasta
  - id: gz
    type:
      - 'null'
      - boolean
    doc: enable gzip compression for output files
    inputBinding:
      position: 101
      prefix: -gz
  - id: in
    type:
      - 'null'
      - File
    doc: is the path of a distance matrix file (which may be in .gz format)
    inputBinding:
      position: 101
      prefix: -in
  - id: name_replace
    type:
      - 'null'
      - string
    doc: "is a list of characters to replace them with e.g. \"_\"\n(may be shorter
      than [strippped]; if so first character is the default."
    inputBinding:
      position: 101
      prefix: -name-replace
  - id: no_banner
    type:
      - 'null'
      - boolean
    doc: suppress the initial banner
    inputBinding:
      position: 101
      prefix: -no-banner
  - id: no_matrix
    type:
      - 'null'
      - boolean
    doc: suppress distance matrix output
    inputBinding:
      position: 101
      prefix: -no-matrix
  - id: not_dna
    type:
      - 'null'
      - boolean
    doc: indicates number of states to be determined from input (if -fasta 
      supplied).
    inputBinding:
      position: 101
      prefix: -not-dna
  - id: nt
    type:
      - 'null'
      - int
    doc: is the number of threads, which should be between 1 and the number of 
      CPUs.
    inputBinding:
      position: 101
      prefix: -nt
  - id: num
    type:
      - 'null'
      - boolean
    doc: indicates sequence names will be replaced with A1, A2, ... in outputs.
    inputBinding:
      position: 101
      prefix: -num
  - id: out_format
    type:
      - 'null'
      - string
    doc: "is the shape of a distance matrix output\n(square for square, upper or lower
      for triangular)"
    inputBinding:
      position: 101
      prefix: -out-format
  - id: phylip
    type:
      - 'null'
      - File
    doc: "is the path of a .phy format file specifying an alignment\nof genetic sequences
      (file may be in .gz format)"
    inputBinding:
      position: 101
      prefix: -phylip
  - id: q
    type:
      - 'null'
      - boolean
    doc: asks for quiet (less progress reporting).
    inputBinding:
      position: 101
      prefix: -q
  - id: strip_name
    type:
      - 'null'
      - string
    doc: is a list of characters to replace in taxon names, e.g. " /"
    inputBinding:
      position: 101
      prefix: -strip-name
  - id: t
    type:
      - 'null'
      - string
    doc: "is one of the following, supported, distance matrix algorithms:\nAUCTION:
      Auction Joining\nBENCHMARK: Benchmark\nBIONJ: BIONJ (Gascuel, Cong [2009])\n\
      BIONJ-R: Rapid BIONJ (Saitou, Nei [1987], Gascuel [2009], Simonson Mailund Pedersen
      [2011])\nBIONJ-V: Vectorized BIONJ (Gascuel, Cong [2009])\nBIONJ2009: The reference
      (2009) version of BIONJ (with OMP parallelization)\nNJ: Neighbour Joining (Saitou,
      Nei [1987])\nNJ-R: Rapid Neighbour Joining (Simonsen, Mailund, Pedersen [2011])\n\
      NJ-R-D: Double precision Rapid Neighbour Joining\nNJ-R-V: Rapid Neighbour Joining
      (Vectorized) (Simonsen, Mailund, Pedersen [2011])\nNJ-V: Vectorized Neighbour
      Joining (Saitou, Nei [1987])\nONJ-R: Rapid Neighbour Joining (a rival version)
      (Simonsen, Mailund, Pedersen [2011])\nONJ-R-V: Rapid Neighbour Joining (a rival
      version) (Simonsen, Mailund, Pedersen [2011]) (Vectorized)\nRapidNJ: Rapid Neighbour
      Joining (Simonsen, Mailund, Pedersen [2011])\nUNJ: Unweighted Neighbour Joining
      (Gascel [1997])"
    inputBinding:
      position: 101
      prefix: -t
  - id: truncate_name_at
    type:
      - 'null'
      - int
    doc: number of characters to truncate taxon names at
    inputBinding:
      position: 101
      prefix: -truncate-name-at
  - id: uncorrected
    type:
      - 'null'
      - boolean
    doc: turns off Jukes-Cantor distance correction (only relevant if -fasta 
      supplied).
    inputBinding:
      position: 101
      prefix: -uncorrected
  - id: unknown
    type:
      - 'null'
      - string
    doc: are the characters that indicate a site has an unknown character.
    inputBinding:
      position: 101
      prefix: -unknown
outputs:
  - id: msa_out
    type:
      - 'null'
      - File
    doc: "is the path of a .msa format file, to which the input\nalignment is to be
      written (in .msa format)."
    outputBinding:
      glob: $(inputs.msa_out)
  - id: dist_out
    type:
      - 'null'
      - File
    doc: "is the path, of a file, into which the distance matrix is to be written\n\
      (possibly in a .gz format)"
    outputBinding:
      glob: $(inputs.dist_out)
  - id: out
    type:
      - 'null'
      - File
    doc: is the path to write the newick tree file to (if it ends in .gz it will
      be compressed)
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decenttree:1.0.0--h3f9e6b0_0
