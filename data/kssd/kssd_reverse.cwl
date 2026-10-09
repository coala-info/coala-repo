cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kssd
  - reverse
label: kssd_reverse
doc: "Reverse kssd sketches to k-mer sets.\n\nTool homepage: https://github.com/yhg926/public_kssd"
inputs:
  - id: co_dir
    type: Directory
    doc: "Sketch directory (co dir)"
    inputBinding:
      position: 200
  - id: byreads
    type:
      - 'null'
      - boolean
    doc: "recover k-mer from sketched reads"
    inputBinding:
      position: 102
      prefix: --byreads
  - id: shuf_file
    type:
      - 'null'
      - File
    doc: "provide .shuf file"
    inputBinding:
      position: 102
      prefix: --shufFile
  - id: threads
    type:
      - 'null'
      - int
    doc: "threads num"
    inputBinding:
      position: 102
      prefix: --threads
  - id: outdir_path
    type: string
    doc: "path for recovered k-mer files (created before the run)"
    inputBinding:
      position: 103
      prefix: --outdir
outputs:
  - id: outdir
    type: Directory
    doc: "Recovered k-mer files"
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: stdout_out
    type: stdout
    doc: "Standard output"
stdout: kssd_reverse.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.outdir_path, listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kssd:2.21--h577a1d6_3
