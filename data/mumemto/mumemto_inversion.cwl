cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mumemto, inversion]
label: mumemto_inversion
doc: "Detect inversions from MUMs. Optionally checks if inversions are flanked by scaffold breaks when AGP files are provided.\n\nTool homepage: https://github.com/vikshiv/mumemto"
inputs:
  - id: mums
    type: File
    doc: "Path to the *.mums file from mumemto"
    inputBinding:
      position: 100
      prefix: --mums
      valueFrom: "$(self.basename)"
  - id: agp_filelist
    type:
      - 'null'
      - File
    doc: "Filelist with the path to one AGP file per line, in the order of the mumemto filelist or lengths file; the first sequence is the reference"
    inputBinding:
      position: 100
      prefix: --agp-filelist
  - id: filelist
    type:
      - 'null'
      - File
    doc: "Filelist for sequence names (default: lengths file)"
    inputBinding:
      position: 100
      prefix: --filelist
  - id: chr
    type:
      - 'null'
      - string
    doc: Chromosome number (required with --agp-filelist)
    inputBinding:
      position: 100
      prefix: --chr
  - id: margin
    type:
      - 'null'
      - int
    doc: "Proximity margin for scaffold break detection (default: within 1% of the inversion length)"
    inputBinding:
      position: 100
      prefix: --margin
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum inversion length to detect
    inputBinding:
      position: 100
      prefix: --max-length
  - id: max_block_gap_len
    type:
      - 'null'
      - int
    doc: "Maximum break between collinear MUMs within a collinear block (default: 1000)"
    inputBinding:
      position: 100
      prefix: --max-block-gap-len
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print progress updates
    inputBinding:
      position: 100
      prefix: --verbose
  - id: lengths
    type: File
    doc: "Lengths file of the run (staged next to the mums file under the same name stem, as the tool expects)"
outputs:
  - id: stdout
    type: stdout
    doc: Inversions (standard output)
  - id: log
    type: stderr
    doc: Progress messages (standard error)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.mums)
      - entry: $(inputs.lengths)
        entryname: $(inputs.mums.nameroot).lengths
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
stdout: mumemto_inversion.out
stderr: mumemto_inversion.err
