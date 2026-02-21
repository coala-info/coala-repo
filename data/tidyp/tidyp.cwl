cwlVersion: v1.2
class: CommandLineTool
baseCommand: tidyp
label: tidyp
doc: "tidyp is a utility to clean up and pretty print HTML, XHTML or XML. (Note: The
  provided text was a container execution error log and did not contain help documentation;
  arguments could not be extracted from the source text.)\n\nTool homepage: https://github.com/jbengler/tidyplots"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tidyp:1.04--h7b50bb2_9
stdout: tidyp.out
