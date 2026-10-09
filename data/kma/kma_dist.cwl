cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kma
  - dist
label: kma_dist
doc: "kma dist calculates distances between templates from a kma index\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kma"
inputs:
  - id: db_files
    type:
      type: array
      items: File
    doc: "Files of the indexed template database (*.comp.b, *.length.b, *.name, *.seq.b, and *.index.b when present), staged in the working directory so that the prefix can name them"
  - id: template_db
    type: string
    doc: "Template DB (prefix of the staged db_files)"
    inputBinding:
      position: 1
      prefix: -t_db
  - id: output_name
    type: ['null', string]
    doc: "Output file (default DB)"
    inputBinding:
      position: 1
      prefix: -o
  - id: output_flags
    type: ['null', int]
    doc: "Output flags (default 1)"
    inputBinding:
      position: 1
      prefix: -f
  - id: distance_method
    type: ['null', int]
    doc: "Distance method (default 1)"
    inputBinding:
      position: 1
      prefix: -d
  - id: matrix_on_disk
    type: ['null', boolean]
    doc: "Allocate matrix on the disk"
    inputBinding:
      position: 1
      prefix: -m
  - id: temp_dir
    type: ['null', string]
    doc: "Set directory for temporary files"
    inputBinding:
      position: 1
      prefix: -tmp
  - id: threads
    type: ['null', int]
    doc: "Number of threads (default 1)"
    inputBinding:
      position: 1
      prefix: -t
outputs:
  - id: dist_files
    type:
      type: array
      items: File
    doc: "Distance output files"
    outputBinding:
      glob: ["$(inputs.output_name)*", "$(inputs.template_db).dist*"]
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.db_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
stdout: kma_dist.txt
