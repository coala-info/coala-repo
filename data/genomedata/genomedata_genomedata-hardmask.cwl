cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-hardmask
label: genomedata_genomedata-hardmask
doc: "Permanently mask TRACKNAME(s) from a genomedata archive with MASKFILE using an optional filter operator.\n\nTool homepage: http://genomedata.hoffmanlab.org"
inputs:
  - id: maskfile
    type: File
    doc: input mask file
    inputBinding:
      position: 1
  - id: gdarchive
    type: Directory
    doc: "genomedata archive (directory mode). It is copied to the working directory and modified there."
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: trackname
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Track(s) to be filtered (default: all)'
    inputBinding:
      position: 101
      prefix: --trackname
  - id: hardmask
    type:
      - 'null'
      - string
    doc: 'Specify a comparison operation on a value to mask out (e.g. "lt0.5" will mask all values less than 0.5). See the bash comparison operators for the two letter operations (default: all values masked)'
    inputBinding:
      position: 101
      prefix: --hardmask
  - id: no_close
    type:
      - 'null'
      - boolean
    doc: Do not close the genomedata archive after masking
    inputBinding:
      position: 101
      prefix: --no-close
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Do not perform any masking. Useful with verbosity set to see what regions would be filtered
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print status updates and diagnostic messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: archive
    type: Directory
    doc: The modified Genomedata archive
    outputBinding:
      glob: $(inputs.gdarchive.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.gdarchive)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-hardmask.out
