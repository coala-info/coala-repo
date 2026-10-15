cwlVersion: v1.2
class: CommandLineTool
baseCommand: prince
label: prince
doc: "Prince Options.\n\nTool homepage: https://github.com/WGS-TB/PythonPrince"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.reads ? inputs.reads : [])'
inputs:
  - id: boost_output
    type:
      - 'null'
      - string
    doc: "output file for training data / training data used to predict copy numbers for queries"
    inputBinding:
      position: 1
      prefix: -bo
  - id: target_output
    type:
      - 'null'
      - string
    doc: "output file for query copy number predictions"
    inputBinding:
      position: 1
      prefix: -to
  - id: templates
    type:
      - 'null'
      - File
    doc: "VNTR templates (FASTA). Default is for M.TB"
    inputBinding:
      position: 1
      prefix: -tmp
  - id: target_file
    type:
      - 'null'
      - File
    doc: "target genome names in a text file (read file names or prefixes, relative to the working directory)"
    inputBinding:
      position: 1
      prefix: -tf
  - id: boosting_file
    type:
      - 'null'
      - File
    doc: "training genome file names in a text file (each line: name and copy number)"
    inputBinding:
      position: 1
      prefix: -bf
  - id: k
    type:
      - 'null'
      - int
    doc: "Kmer size used during read recruitment."
    inputBinding:
      position: 1
      prefix: -k
  - id: copynumber
    type:
      - 'null'
      - int
    doc: "Copy number for training genome."
    inputBinding:
      position: 1
      prefix: -cn
  - id: primers
    type:
      - 'null'
      - File
    doc: "Flanking sequences used in coverage adjustments (JSON)"
    inputBinding:
      position: 1
      prefix: -p
  - id: num_procs
    type:
      - 'null'
      - int
    doc: "Number of cores for parallel processing."
    inputBinding:
      position: 1
      prefix: -np
  - id: reads
    type:
      - 'null'
      - File[]
    doc: "Read files named in the target or training file; they are staged in the working directory"
outputs:
  - id: target_output_file
    type:
      - 'null'
      - File
    doc: query copy number predictions
    outputBinding:
      glob: $(inputs.target_output)
  - id: boost_output_file
    type:
      - 'null'
      - File
    doc: training data
    outputBinding:
      glob: $(inputs.boost_output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prince:2.3--py_0
stdout: prince.out
