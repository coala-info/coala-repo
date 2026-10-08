cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - set
label: expam_set
doc: "Set database build parameters.\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: database
    type: Directory
    doc: "Expam database directory (-db). It is staged writable in the work directory and returned as an output."
    inputBinding:
      position: 1
      prefix: -db
      valueFrom: $(self.basename)
  - id: kmer
    type:
      - 'null'
      - int
    doc: "Length of mer used for analysis."
    inputBinding:
      position: 101
      prefix: -k
  - id: n_processes
    type:
      - 'null'
      - int
    doc: "Number of CPUs to use for processing."
    inputBinding:
      position: 101
      prefix: -n
  - id: sketch
    type:
      - 'null'
      - int
    doc: "Sketch size for mash."
    inputBinding:
      position: 101
      prefix: -s
  - id: pile
    type:
      - 'null'
      - int
    doc: "Number of genomes to pile at a time (or inf)."
    inputBinding:
      position: 101
      prefix: -y
  - id: phylogeny
    type:
      - 'null'
      - string
    doc: "Newick file of the reference phylogeny (-p). Use a path relative to the database directory (for example phylogeny/expam_outtree.nwk) so the database can be moved."
    inputBinding:
      position: 101
      prefix: -p
  - id: group
    type:
      - 'null'
      - string
    doc: "With a group name, k and the sketch size are set for that group only (--group)."
    inputBinding:
      position: 101
      prefix: --group
outputs:
  - id: database_out
    type:
      - 'null'
      - Directory
    doc: "The database directory after the command ran"
    outputBinding:
      glob: $(inputs.database.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
