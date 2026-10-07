cwlVersion: v1.2
class: CommandLineTool
baseCommand: fetch_all_refseq_bacterial_genomes
label: cct_fetch_all_refseq_bacterial_genomes
doc: "Downloads all bacterial RefSeq sequences form NCBI in GenBank format. The --min
  and --max options can be used to restrict the size of the returned sequences.\n\n  Tool homepage: https://github.com/paulstothard/cgview_comparison_tool"
inputs:
  - id: min
    type:
      - 'null'
      - int
    doc: Records with a sequence length shorter than this value will be ignored.
    inputBinding:
      position: 2
      prefix: -m
  - id: max
    type:
      - 'null'
      - int
    doc: Records with a sequence length longer than this value will be ignored.
    inputBinding:
      position: 2
      prefix: -x
  - id: output
    type: string
    doc: The output directory to download the GenBank file(s) into.
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the downloaded GenBank files
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cct:v20170919dfsg-1-deb_cv1
