cwlVersion: v1.2
class: CommandLineTool
baseCommand: ampliconsplitter.py
label: ampliconsplitter_ampliconsplitter.py
doc: "AmpliconSplitter separates sequencing reads based on reference amplicons.\n\n
  Tool homepage: https://github.com/RolandFaure/AmpliconSplitter"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: fastq
    type: File
    doc: Sequencing reads fastq or fasta
    inputBinding:
      position: 101
      prefix: --fastq
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of output folder if it exists
    inputBinding:
      position: 101
      prefix: --force
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: Turn on the low-memory mode (at the expense of speed)
    inputBinding:
      position: 101
      prefix: --low-memory
  - id: min_read_quality
    type:
      - 'null'
      - int
    doc: If reads have an average quality below this threshold, filter out (fastq
      input only)
    inputBinding:
      position: 101
      prefix: --min-read-quality
  - id: no_clean
    type:
      - 'null'
      - boolean
    doc: Don't clean the temporary files
    inputBinding:
      position: 101
      prefix: --no_clean
  - id: path_to_medaka
    type:
      - 'null'
      - File
    doc: Path to the executable medaka
    inputBinding:
      position: 101
      prefix: --path_to_medaka
  - id: path_to_python
    type:
      - 'null'
      - File
    doc: Path to python
    inputBinding:
      position: 101
      prefix: --path_to_python
  - id: path_to_raven
    type:
      - 'null'
      - File
    doc: Path to raven
    inputBinding:
      position: 101
      prefix: --path_to_raven
  - id: polisher
    type:
      - 'null'
      - string
    doc: '{racon, medaka} medaka is more accurate but much slower'
    inputBinding:
      position: 101
      prefix: --polisher
  - id: ref
    type: File
    doc: Reference amplicon(s) to separate in several amplicon(s)
    inputBinding:
      position: 101
      prefix: --ref
  - id: rescue_snps
    type:
      - 'null'
      - float
    doc: Consider automatically as true all SNPs shared by proportion u of the reads
    inputBinding:
      position: 101
      prefix: --rescue_snps
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume from a previous run
    inputBinding:
      position: 101
      prefix: --resume
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ampliconsplitter:1.9.22--h9948957_0
