cwlVersion: v1.2
class: CommandLineTool
baseCommand: islandpath
label: islandpath
doc: "IslandPath-DIMOB: predict genomic islands from a GenBank file.\n\nTool homepage:
  https://github.com/brinkmanlab/islandpath"
inputs:
  - id: genome_gbk
    type: File
    doc: Input genome GenBank file
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: Output file for genomic island information
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outputfile_txt
    type: File
    doc: Genomic island predictions (tab-delimited)
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome_gbk)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/islandpath:1.0.6--hdfd78af_0
stdout: islandpath.out
