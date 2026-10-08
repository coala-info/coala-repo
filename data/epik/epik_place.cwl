cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - epik.py
  - place
label: epik_place
doc: "Places .fasta files using the input IPK database.\n\nTool homepage: https://github.com/phylo42/epik"
inputs:
  - id: database
    type: File
    doc: Input database.
    inputBinding:
      position: 1
      prefix: --database
  - id: states
    type: string
    doc: 'States used in analysis: nucl or amino.'
    inputBinding:
      position: 1
      prefix: --states
  - id: omega
    type:
      - 'null'
      - float
    doc: User omega value, determines the score threshold.
    inputBinding:
      position: 1
      prefix: --omega
  - id: mu
    type:
      - 'null'
      - float
    doc: The proportion of the database to keep.
    inputBinding:
      position: 1
      prefix: --mu
  - id: outputdir
    type: string
    doc: Output directory.
    inputBinding:
      position: 1
      prefix: --outputdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used.
    inputBinding:
      position: 1
      prefix: --threads
  - id: max_ram
    type:
      - 'null'
      - string
    doc: Approximate RAM limit to use. Database may not be fully loaded
    inputBinding:
      position: 1
      prefix: --max-ram
  - id: input_file
    type:
      type: array
      items: File
    doc: Query FASTA file(s) to place
    inputBinding:
      position: 2
outputs:
  - id: outputdir_out
    type: Directory
    doc: Output directory with the placement results
    outputBinding:
      glob: $(inputs.outputdir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.outputdir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epik:0.2.0--h077b44d_2
stdout: epik_place.out
