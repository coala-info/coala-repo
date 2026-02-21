cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastme
label: fastme
doc: "FastME is a distance-based phylogeny reconstruction program. (Note: The provided
  text contains system error messages regarding container execution and does not include
  the tool's help documentation or usage instructions.)\n\nTool homepage: http://www.atgc-montpellier.fr/fastme/binaries.php"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastme:2.1.6.3--h7b50bb2_1
stdout: fastme.out
