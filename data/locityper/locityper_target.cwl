cwlVersion: v1.2
class: CommandLineTool
baseCommand: locityper_target
label: locityper_target
doc: "Adds target locus/loci to the database.\n\nTool homepage: https://github.com/tprodanov/locityper"
inputs:
  - id: database
    type: Directory
    doc: Output database directory.
    inputBinding:
      position: 101
      prefix: --database
  - id: expand
    type:
      - 'null'
      - type: array
        items: int
    doc: If needed, expand locus coordinates by <= INT bp [20k 50k 200k]. 
      Boundaries are checked one by one until the locus does not overlap any 
      long pangenomic bubbles.
    inputBinding:
      position: 101
      prefix: --expand
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force rewrite output directory.
    inputBinding:
      position: 101
      prefix: --force
  - id: genome
    type:
      - 'null'
      - string
    doc: 'Name of the reference haplotype [default: tries to guess].'
    inputBinding:
      position: 101
      prefix: --genome
  - id: ignore_overl
    type:
      - 'null'
      - boolean
    doc: 'Ignore overlapping variants. Default: fail with error. Of several overlapping
      variants only the first one is used.'
    inputBinding:
      position: 101
      prefix: --ignore-overl
  - id: jellyfish_executable
    type:
      - 'null'
      - string
    doc: Jellyfish executable [jellyfish].
    inputBinding:
      position: 101
      prefix: --jellyfish
  - id: jf_counts
    type: File
    doc: Jellyfish k-mer counts (see documentation).
    inputBinding:
      position: 101
      prefix: --jf-counts
  - id: leave_out
    type:
      - 'null'
      - type: array
        items: string
    doc: Leave out sequences with specified names.
    inputBinding:
      position: 101
      prefix: --leave-out
  - id: loci
    type:
      - 'null'
      - type: array
        items: File
    doc: 'BED file with loci coordinates. Fourth column: locus name. If VCF (-v) was
      not provided, fifth column is required with the path to locus alleles.'
    inputBinding:
      position: 101
      prefix: --loci
  - id: locus
    type:
      - 'null'
      - type: array
        items: string
    doc: Locus name and coordinates. If VCF (-v) was not provided, FASTA with 
      locus alleles is required as a third argument.
    inputBinding:
      position: 101
      prefix: --locus
  - id: minimizer
    type:
      - 'null'
      - type: array
        items: int
    doc: (k,w)-minimizers for sequence divergence calculation [15 15].
      - 15
      - 15
    inputBinding:
      position: 101
      prefix: --minimizer
  - id: reference
    type: File
    doc: Reference FASTA file.
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [8].
    inputBinding:
      position: 101
      prefix: --threads
  - id: unknown
    type:
      - 'null'
      - float
    doc: Allow this fraction of unknown nucleotides per allele [0.0001] 
      (relative to the allele length). Variants that have no known variation in 
      the input VCF pangenome are ignored.
    inputBinding:
      position: 101
      prefix: --unknown
  - id: variants
    type:
      - 'null'
      - File
    doc: Input VCF file, encoding variation across pangenome samples.
    inputBinding:
      position: 101
      prefix: --variants
  - id: window
    type:
      - 'null'
      - int
    doc: Select best locus boundary based on k-mer frequencies in moving windows
      of size INT bp [500].
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
stdout: locityper_target.out
