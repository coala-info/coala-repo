cwlVersion: v1.2
class: CommandLineTool
baseCommand: subcontig
label: strainr2_subcontig
doc: "subcontig splits input genomes into smaller parts and save to .subcontig files\n\nTool homepage: https://github.com/BisanzLab/StrainR2"
inputs:
  - id: genomes_dir
    type: Directory
    doc: path to the directory for all community genomes
    inputBinding:
      position: 101
      prefix: -i
  - id: outdir
    type: string
    doc: path to your output directory
    inputBinding:
      position: 102
      prefix: -o
  - id: max_subcontig_size
    type:
      - 'null'
      - int
    doc: maximum subcontig size (overrides default use of smallest N50)
    inputBinding:
      position: 103
      prefix: -s
  - id: exclude_size
    type:
      - 'null'
      - int
    doc: exclude subcontig size (minimum subcontig size)
    inputBinding:
      position: 104
      prefix: -e
outputs:
  - id: outdir_dir
    type: Directory
    doc: output directory with Subcontigs and excludedSubcontigs
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: "$({class: 'Directory', basename: inputs.outdir, listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainr2:2.3.0--r44h577a1d6_0
