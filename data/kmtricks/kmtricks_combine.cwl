cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmtricks
  - combine
label: kmtricks_combine
doc: "Combine kmtricks's matrices (support kmer/hash matrices).\n\nTool homepage:
  https://github.com/tlemane/kmtricks"
inputs:
  - id: cpr
    type:
      - 'null'
      - boolean
    doc: compress output.
    inputBinding:
      position: 101
      prefix: --cpr
  - id: fof
    type: File
    doc: input fof, one kmtricks run per line.
    inputBinding:
      position: 101
      prefix: --fof
  - id: run_dirs
    type:
      type: array
      items: Directory
    doc: kmtricks run directories named in the input fof; staged next to it so the names resolve.
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - string
    doc: verbosity level [debug|info|warning|error].
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: output directory.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fof)
      - |
        ${
          return inputs.run_dirs.map(function(d) { return {"entry": d, "writable": true}; });
        }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
    dockerOutputDirectory: /kmtricks_work
