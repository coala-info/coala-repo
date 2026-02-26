cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkv contamination
label: checkv_contamination
doc: "Estimate host contamination for integrated proviruses\n\nTool homepage: https://bitbucket.org/berkeleylab/checkv"
inputs:
  - id: input
    type: File
    doc: Input nucleotide sequences in FASTA format (.gz, .bz2 and .xz files are
      supported)
    inputBinding:
      position: 1
  - id: output
    type: Directory
    doc: Output directory
    inputBinding:
      position: 2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress logging messages
    inputBinding:
      position: 103
      prefix: --quiet
  - id: reference_database_path
    type:
      - 'null'
      - Directory
    doc: Reference database path. By default the CHECKVDB environment variable 
      is used
    inputBinding:
      position: 103
      prefix: -d
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Overwrite existing intermediate files. By default CheckV continues 
      where program left off
    inputBinding:
      position: 103
      prefix: --restart
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for prodigal-gv and hmmsearch
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
stdout: checkv_contamination.out
