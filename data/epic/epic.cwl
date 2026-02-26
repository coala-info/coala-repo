cwlVersion: v1.2
class: CommandLineTool
baseCommand: epic
label: epic
doc: "Diffuse domain ChIP-Seq caller based on SICER. (Visit github.com/endrebak/epic
  for examples and help.)\n\nTool homepage: http://github.com/endrebak/epic"
inputs:
  - id: treatment
    type:
      type: array
      items: File
    doc: Treatment (pull-down) file(s) in (b/gzipped) bed/bedpe format.
    inputBinding:
      position: 1
  - id: control
    type:
      type: array
      items: File
    doc: Control (input) file(s) in (b/gzipped) bed/bedpe format.
    inputBinding:
      position: 2
  - id: bed
    type:
      - 'null'
      - File
    doc: A summary bed file of all regions for display in the UCSC genome 
      browser or downstream analyses with e.g. bedtools. The score field is 
      log2(#ChIP/#Input) * 100 capped at a 1000.
    inputBinding:
      position: 103
      prefix: --bed
  - id: bigwig
    type:
      - 'null'
      - Directory
    doc: For each file, store a bigwig of both enriched and non-enriched regions
      to folder <BIGWIG>. Requires different basenames for each file.
    inputBinding:
      position: 103
      prefix: --bigwig
  - id: chip_bigwig
    type:
      - 'null'
      - File
    doc: Store an RPKM-normalized summed bigwig for all ChIP files in file 
      <CHIP-BIGWIG>.
    inputBinding:
      position: 103
      prefix: --chip-bigwig
  - id: chromsizes
    type:
      - 'null'
      - File
    doc: 'Set the chromosome lengths yourself in a file with two columns: chromosome
      names and sizes. Useful to analyze custom genomes, assemblies or simulated data.
      Only chromosomes included in the file will be analyzed.'
    inputBinding:
      position: 103
      prefix: --chromsizes
  - id: effective_genome_fraction
    type:
      - 'null'
      - float
    doc: Use a different effective genome fraction than the one included in 
      epic. The default value depends on the genome and readlength, but is a 
      number between 0 and 1.
    inputBinding:
      position: 103
      prefix: --effective-genome-fraction
  - id: false_discovery_rate_cutoff
    type:
      - 'null'
      - float
    doc: Remove all islands with an FDR below cutoff.
    default: 0.05
    inputBinding:
      position: 103
      prefix: --false-discovery-rate-cutoff
  - id: fragment_size
    type:
      - 'null'
      - int
    doc: (Single end reads only) Size of the sequenced fragment. The center of 
      the the fragment will be taken as half the fragment size.
    default: 150
    inputBinding:
      position: 103
      prefix: --fragment-size
  - id: gaps_allowed
    type:
      - 'null'
      - int
    doc: This number is multiplied by the window size to determine the gap size.
      Must be an integer.
    default: 3
    inputBinding:
      position: 103
      prefix: --gaps-allowed
  - id: genome
    type:
      - 'null'
      - string
    doc: Which genome to analyze. If --chromsizes flag is given, --genome is not
      required.
    default: hg19
    inputBinding:
      position: 103
      prefix: --genome
  - id: individual_log2fc_bigwigs
    type:
      - 'null'
      - Directory
    doc: For each file, store a bigwig of the log2fc of ChIP/(Sum Input) to 
      folder <INDIVIDUAL-LOG2FC-BIGWIGS>. Requires different basenames for each 
      file.
    inputBinding:
      position: 103
      prefix: --individual-log2fc-bigwigs
  - id: input_bigwig
    type:
      - 'null'
      - File
    doc: Store an RPKM-normalized summed bigwig for all Input files in file 
      <INPUT-BIGWIG>.
    inputBinding:
      position: 103
      prefix: --input-bigwig
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: Keep reads mapping to the same position on the same strand within a 
      library. Default is to remove all but the first duplicate.
    inputBinding:
      position: 103
      prefix: --keep-duplicates
  - id: log
    type:
      - 'null'
      - File
    doc: File to write log messages to.
    inputBinding:
      position: 103
      prefix: --log
  - id: log2fc_bigwig
    type:
      - 'null'
      - File
    doc: Store an log2(ChIP/Input) bigwig in file <LOG2FC-BIGWIG>. (Both ChIP 
      and Input are RPKM-normalized before dividing.)
    inputBinding:
      position: 103
      prefix: --log2fc-bigwig
  - id: number_cores
    type:
      - 'null'
      - int
    doc: Number of cpus to use. Can use at most one per chromosome.
    default: 1
    inputBinding:
      position: 103
      prefix: --number-cores
  - id: store_matrix
    type:
      - 'null'
      - File
    doc: Store the matrix of counts per bin for ChIP and input to gzipped file 
      <STORE_MATRIX>.
    inputBinding:
      position: 103
      prefix: --store-matrix
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of the windows to scan the genome. WINDOW_SIZE is the smallest 
      possible island.
    default: 200
    inputBinding:
      position: 103
      prefix: --window-size
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: File to write results to. By default sent to stdout.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epic:0.2.12--py35h24bf2e0_1
