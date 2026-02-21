cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-mzmltomzlite
label: proteomiqon-mzmltomzlite_proteomiqon
doc: "A tool for converting mzML files to the mzLite format. (Note: The provided help
  text contains system logs and build errors rather than command-line usage information;
  therefore, specific arguments could not be extracted from the source text.)\n\n
  Tool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-mzmltomzlite:0.0.8--hdfd78af_0
stdout: proteomiqon-mzmltomzlite_proteomiqon.out
