cwlVersion: v1.2
class: CommandLineTool
baseCommand: IsoDetect
label: massiveqc_IsoDetect
doc: "Outlier filtering of the quality features that MassiveQC wrote to the results
  directory (writes results/result.csv).\n\nTool homepage: https://github.com/shimw6828/MassiveQC"
inputs:
  - id: input
    type: File
    doc: Input file, containing two columns srx and srr
    inputBinding:
      position: 101
      prefix: --input
  - id: outdir
    type: Directory
    doc: Path to result output directory of main process (the MassiveQC MultiQC
      output folder). Staged writable and returned.
    inputBinding:
      position: 101
      prefix: --outdir
      valueFrom: $(self.basename)
outputs:
  - id: result_dir
    type: Directory
    doc: The result directory with the IsoDetect results
    outputBinding:
      glob: $(inputs.outdir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.outdir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
