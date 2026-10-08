cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - match
label: gimmemotifs-minimal_match
doc: "Find motif matches in database\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: dbfile
    type:
      - 'null'
      - File
    doc: "File with pfms to match against (default: gimme.vertebrate.v5.0.pfm)"
    inputBinding:
      position: 1
      prefix: -d
  - id: number
    type:
      - 'null'
      - int
    doc: "Number of matches to return (default 1)"
    inputBinding:
      position: 1
      prefix: -n
  - id: report
    type:
      - 'null'
      - string
    doc: "Output file with graphical report (png, svg, ps, pdf)"
    inputBinding:
      position: 1
      prefix: -o
  - id: pfmfile
    type: File
    doc: "File with pfms"
    inputBinding:
      position: 100
  - id: output_name
    type: string
    doc: "Name of the file that receives the matches (standard output)"
    default: match_result.txt
outputs:
  - id: output
    type: File
    doc: "Motif matches"
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
stdout: $(inputs.output_name)
