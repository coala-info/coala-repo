cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polap
  - annotate
label: polap_annotate
doc: "Annotate a Flye genome assembly (contigger edges) in a polap output folder with mitochondrial\
  \ and plastid genes.\n\nTool homepage: https://github.com/goshng/polap"
inputs:
  - id: outdir
    type: Directory
    doc: Polap output folder holding the Flye genome assembly <inum>; it is updated in place.
    inputBinding:
      position: 101
      prefix: -o
      valueFrom: $(self.basename)
  - id: inum
    type:
      - 'null'
      - int
    doc: Index of the source assembly (folder <outdir>/<inum>); default 0.
    inputBinding:
      position: 101
      prefix: -i
  - id: contigger
    type:
      - 'null'
      - boolean
    doc: Annotate the contigger edges (default on).
    inputBinding:
      position: 101
      prefix: --contigger
  - id: no_contigger
    type:
      - 'null'
      - boolean
    doc: Do not use the contigger edges (not implemented yet).
    inputBinding:
      position: 101
      prefix: --no-contigger
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (log).
  - id: outdir_out
    type: Directory
    doc: Output folder with all polap results.
    outputBinding:
      glob: $(inputs.outdir.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.outdir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
stdout: polap_annotate.out
