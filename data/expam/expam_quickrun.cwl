cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - quickrun
label: expam_quickrun
doc: "Initialise, set parameters and start building db (assumes sequences all lie in the same folder).\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: db_name
    type: string
    doc: "Name of the new database directory (-db)."
    inputBinding:
      position: 1
      prefix: -db
  - id: directories
    type:
      type: array
      items: Directory
      inputBinding:
        prefix: -d
        valueFrom: $(self.basename)
    doc: "Directories of sequence files (-d)."
  - id: phylogeny
    type: File
    doc: "Newick file of the reference phylogeny (-p). It is staged in the work directory."
    inputBinding:
      position: 101
      prefix: -p
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
  - id: group
    type:
      - 'null'
      - string
    doc: "Name of the sequence group the command applies to (--group)."
    inputBinding:
      position: 101
      prefix: --group
  - id: first
    type:
      - 'null'
      - int
    doc: "Add first n genomes in folder."
    inputBinding:
      position: 101
      prefix: --first
outputs:
  - id: database_out
    type:
      - 'null'
      - Directory
    doc: "The new, built database directory"
    outputBinding:
      glob: $(inputs.db_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.directories)
        writable: true
      - entry: $(inputs.phylogeny)
        writable: true
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: expam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
