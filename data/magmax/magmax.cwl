cwlVersion: v1.2
class: CommandLineTool
baseCommand: magmax
label: magmax
doc: "A tool to MAXimize the yield of Metagenome-Assembled Genomes (MAGs) through
  bin merging and resssembly.\n\nTool homepage: https://github.com/soedinglab/MAGmax"
inputs:
  - id: alignedfrac
    type:
      - 'null'
      - float
    doc: Mininum aligned fraction of (both reference and query) genomes covered 
      in the ANI calculation
    inputBinding:
      position: 101
      prefix: --alignedfrac
  - id: ani
    type:
      - 'null'
      - float
    doc: ANI for clustering bins (%)
    inputBinding:
      position: 101
      prefix: --ani
  - id: anifile
    type:
      - 'null'
      - File
    doc: 'ANI file produced by skani using command: skani triangle <bindir> -E -o
      <anifile>'
    inputBinding:
      position: 101
      prefix: --anifile
  - id: assembler
    type:
      - 'null'
      - string
    doc: Assembler choice for reassembly step (spades|megahit), spades is 
      recommended
    inputBinding:
      position: 101
      prefix: --assembler
  - id: bindir
    type: Directory
    doc: Directory containing fasta files of bins
    inputBinding:
      position: 101
      prefix: --bindir
  - id: completeness
    type:
      - 'null'
      - float
    doc: Minimum completeness of bins (%)
    inputBinding:
      position: 101
      prefix: --completeness
  - id: format
    type:
      - 'null'
      - string
    doc: Bin file extension
    inputBinding:
      position: 101
      prefix: --format
  - id: mapdir
    type:
      - 'null'
      - Directory
    doc: Directory containing mapids files
    inputBinding:
      position: 101
      prefix: --mapdir
  - id: no_reassembly
    type:
      - 'null'
      - boolean
    doc: Perform dereplication without bin merging and reassembly
    inputBinding:
      position: 101
      prefix: --no-reassembly
  - id: purity
    type:
      - 'null'
      - float
    doc: Mininum purity (1- contamination) of bins (%)
    inputBinding:
      position: 101
      prefix: --purity
  - id: qual
    type:
      - 'null'
      - File
    doc: Quality file produced by CheckM2 (quality_report.tsv)
    inputBinding:
      position: 101
      prefix: --qual
  - id: readdir
    type:
      - 'null'
      - Directory
    doc: Directory containing read files
    inputBinding:
      position: 101
      prefix: --readdir
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: Select representatives based on high connectivity. Bin merging and 
      reassembly steps are disabled
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: split
    type:
      - 'null'
      - boolean
    doc: Split clusters into sample-wise bins before processing
    inputBinding:
      position: 101
      prefix: --split
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory of output
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magmax:1.3.0--ha6fb395_0
