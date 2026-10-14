cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phava
  - create
label: phava_create
doc: "Create in silico flipped versions of invertons\n\nTool homepage: https://github.com/patrickwest/PhaVa"
inputs:
  - id: dir_name
    type: string
    doc: "Name of the work directory where data and output are stored (use the same one for all PhaVa operations); created when it does not exist yet"
    inputBinding:
      position: 1
      prefix: --dir
  - id: prior_dir
    type:
      - 'null'
      - Directory
    doc: "Work directory written by an earlier PhaVa step (staged writable under the name given in dir_name)"
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 2
      prefix: --cpus
  - id: log
    type:
      - 'null'
      - boolean
    doc: "Should the logging info be output to stdout? Otherwise it is written to PhaVa.log"
    inputBinding:
      position: 3
      prefix: --log
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Name of input assembly file to be searched"
    inputBinding:
      position: 20
      prefix: --fasta
  - id: irs
    type:
      - 'null'
      - File
    doc: "Table of identified invertable repeats (eg. if locate command was never run)"
    inputBinding:
      position: 21
      prefix: --irs
  - id: flank_size
    type:
      - 'null'
      - int
    doc: "Size flanking size to include on either side of invertable regions (in bps)"
    inputBinding:
      position: 10
      prefix: --flankSize
  - id: genes
    type:
      - 'null'
      - File
    doc: "List of gene features in ncbi genbank format, for detecting gene/inverton overlaps"
    inputBinding:
      position: 11
      prefix: --genes
  - id: genes_format
    type:
      - 'null'
      - string
    doc: "File format of the list of gene features (gff or gbff); gff must be in prodigal gff format"
    inputBinding:
      position: 12
      prefix: --genesFormat
  - id: mock_genome
    type:
      - 'null'
      - boolean
    doc: "Create a mock genome where all putative IRs are flipped to opposite of the reference orientation"
    inputBinding:
      position: 13
      prefix: --mockGenome
  - id: mock_number
    type:
      - 'null'
      - int
    doc: "If creating a mockGenome, the number of invertons to invert; 0 inverts all predicted inverton locations"
    inputBinding:
      position: 14
      prefix: --mockNumber
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: work_dir
    type: Directory
    doc: Work directory with the PhaVa data, intermediate files and results
    outputBinding:
      glob: $(inputs.dir_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.dir_name)
        entry: '${ return inputs.prior_dir ? inputs.prior_dir : {"class": "Directory", "basename": inputs.dir_name, "listing": []}; }'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava_create.out
