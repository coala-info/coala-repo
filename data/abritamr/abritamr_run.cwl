cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - abritamr
  - run
label: abritamr_run
doc: "Run AMR detection using abritamr and amrfinderplus\n\nTool homepage: https://github.com/MDU-PHL/abritamr"
inputs:
  - id: amrfinder_db
    type:
      - 'null'
      - Directory
    doc: Path to amrfinder DB to use
      /usr/local/lib/python3.14/site-packages/abritamr/db/amrfinderplus/data/2024-07-22.1
    inputBinding:
      position: 101
      prefix: --amrfinder_db
  - id: contigs
    type:
      - 'null'
      - File
    doc: Tab-delimited file with sample ID as column 1 and path to assemblies as
      column 2 OR path to a contig file (used if only doing a single sample - 
      should provide value for -pfx).
    inputBinding:
      position: 101
      prefix: --contigs
  - id: identity
    type:
      - 'null'
      - float
    doc: Set the minimum identity of matches with amrfinder (0 - 1.0). Defaults 
      to amrfinder preset, which is 0.9 unless a curated threshold is present 
      for the gene.
    inputBinding:
      position: 101
      prefix: --identity
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of AMR finder jobs to run in parallel.
    inputBinding:
      position: 101
      prefix: --jobs
  - id: prefix
    type:
      - 'null'
      - string
    doc: If running on a single sample, please provide a prefix for output 
      directory
    inputBinding:
      position: 101
      prefix: --prefix
  - id: species
    type:
      - 'null'
      - string
    doc: Set if you would like to use point mutations, please provide a valid 
      species. Valid options include Acinetobacter_baumannii, 
      Burkholderia_cepacia, etc.
    inputBinding:
      position: 101
      prefix: --species
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abritamr:1.0.20--pyh5707d69_0
stdout: abritamr_run.out
