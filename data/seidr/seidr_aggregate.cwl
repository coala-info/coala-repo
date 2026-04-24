cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seidr
  - aggregate
label: seidr_aggregate
doc: "Aggregate multiple SeidrFiles.\n\nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 101
      prefix: --force
  - id: in_file
    type:
      type: array
      items: File
    doc: Input files
    inputBinding:
      position: 101
      prefix: --in-file
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep directionality information
    inputBinding:
      position: 101
      prefix: --keep
  - id: method
    type:
      - 'null'
      - string
    doc: Method to aggregate networks [top1, top2, borda, irp]
    inputBinding:
      position: 101
      prefix: --method
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Directory to store temporary data
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of OpenMP threads for parallel sorting
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
