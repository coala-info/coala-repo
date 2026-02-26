cwlVersion: v1.2
class: CommandLineTool
baseCommand: kodoja_build.py
label: kodoja_kodoja_build.py
doc: "Kodoja Build creates a database for use with Kodoja Search.\n\nTool homepage:
  https://github.com/abaizan/kodoja/"
inputs:
  - id: all_viruses
    type:
      - 'null'
      - boolean
    doc: Build databases with all viruses (not plant specific)
    inputBinding:
      position: 101
      prefix: --all_viruses
  - id: db_tag
    type:
      - 'null'
      - string
    doc: Suffix for databases
    inputBinding:
      position: 101
      prefix: --db_tag
  - id: download_parallel
    type:
      - 'null'
      - int
    doc: Parallel genome download
    default: 4
    inputBinding:
      position: 101
      prefix: --download_parallel
  - id: extra_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of extra files added to "extra" dir
    inputBinding:
      position: 101
      prefix: --extra_files
  - id: extra_taxids
    type:
      - 'null'
      - type: array
        items: string
    doc: List of taxID of extra files
    inputBinding:
      position: 101
      prefix: --extra_taxids
  - id: host_taxid
    type:
      - 'null'
      - string
    doc: Host tax ID
    inputBinding:
      position: 101
      prefix: --host_taxid
  - id: kraken_kmer
    type:
      - 'null'
      - int
    doc: Kraken kmer size
    default: 31
    inputBinding:
      position: 101
      prefix: --kraken_kmer
  - id: kraken_minimizer
    type:
      - 'null'
      - int
    doc: Kraken minimizer size
    default: 15
    inputBinding:
      position: 101
      prefix: --kraken_minimizer
  - id: kraken_tax
    type:
      - 'null'
      - Directory
    doc: Path to taxonomy directory
    inputBinding:
      position: 101
      prefix: --kraken_tax
  - id: no_download
    type:
      - 'null'
      - boolean
    doc: Genomes have already been downloaded
    inputBinding:
      position: 101
      prefix: --no_download
  - id: output_dir
    type: Directory
    doc: Output directory path, required
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kodoja:0.0.10--0
stdout: kodoja_kodoja_build.py.out
