cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioconda-repodata-patches
label: bioconda-repodata-patches
doc: "A tool for managing or applying patches to Bioconda repodata. (Note: The provided
  text contains system error logs rather than help documentation, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/bioconda/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/bioconda-repodata-patches:20251216--py314hdfd78af_0
stdout: bioconda-repodata-patches.out
