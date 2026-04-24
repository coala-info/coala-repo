cwlVersion: v1.2
class: CommandLineTool
baseCommand: kodoja_search.py
label: kodoja_kodoja_search.py
doc: "Kodoja Search is a tool intended to identify viral sequences\nin a FASTQ/FASTA
  sequencing run by matching them against both Kraken and\nKaiju databases.\n\nTool
  homepage: https://github.com/abaizan/kodoja/"
inputs:
  - id: data_format
    type:
      - 'null'
      - string
    doc: Sequence data format (default fastq)
    inputBinding:
      position: 101
      prefix: --data_format
  - id: host_subset
    type:
      - 'null'
      - string
    doc: Subset sequences with this tax id from results
    inputBinding:
      position: 101
      prefix: --host_subset
  - id: kaiju_db
    type: Directory
    doc: Kaiju database path, required
    inputBinding:
      position: 101
      prefix: --kaiju_db
  - id: kaiju_minlen
    type:
      - 'null'
      - int
    doc: Kaju minimum length
    inputBinding:
      position: 101
      prefix: --kaiju_minlen
  - id: kaiju_mismatch
    type:
      - 'null'
      - int
    doc: Kaju allowed mismatches
    inputBinding:
      position: 101
      prefix: --kaiju_mismatch
  - id: kaiju_score
    type:
      - 'null'
      - float
    doc: Kaju alignment score
    inputBinding:
      position: 101
      prefix: --kaiju_score
  - id: kraken_db
    type: Directory
    doc: Kraken database path, required
    inputBinding:
      position: 101
      prefix: --kraken_db
  - id: kraken_preload
    type:
      - 'null'
      - boolean
    doc: Kraken preload database
    inputBinding:
      position: 101
      prefix: --kraken_preload
  - id: kraken_quick
    type:
      - 'null'
      - int
    doc: Number of minium hits by Kraken
    inputBinding:
      position: 101
      prefix: --kraken_quick
  - id: output_dir
    type: Directory
    doc: Output directory path, required
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: read1
    type: File
    doc: Read 1 file path, required
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: Read 2 file path
    inputBinding:
      position: 101
      prefix: --read2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (default 1)
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim_adapt
    type:
      - 'null'
      - File
    doc: Illumina adapter sequence file
    inputBinding:
      position: 101
      prefix: --trim_adapt
  - id: trim_minlen
    type:
      - 'null'
      - int
    doc: Trimmomatic minimum length
    inputBinding:
      position: 101
      prefix: --trim_minlen
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kodoja:0.0.10--0
stdout: kodoja_kodoja_search.py.out
