cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mapad
  - index
label: mapad_index
doc: 'Indexes a genome file


  Tool homepage: https://github.com/mpieva/mapAD'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
inputs:
  - id: port
    type:
      - 'null'
      - int
    doc: TCP port to communicate over
    inputBinding:
      position: 101
      prefix: --port
  - id: reference
    type: File
    doc: FASTA file containing the genome to be indexed; copied into the job directory
      because the index files are written beside it
    inputBinding:
      position: 101
      prefix: --reference
      valueFrom: $(self.basename)
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads. If 0, mapAD will select the number of threads
      automatically.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
        inputBinding:
          prefix: -v
    doc: Sets the level of verbosity
    inputBinding:
      position: 101
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written beside the FASTA (.tbw, .tle, .toc, .tpi, .trt, .tsa)
    outputBinding:
      glob: $(inputs.reference.basename).t*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapad:0.45.0--ha96b9cd_1
stdout: mapad_index.out
