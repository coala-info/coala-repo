cwlVersion: v1.2
class: CommandLineTool
baseCommand: wkhtmltopdf
label: wkhtmltopdf_wkhtmltoimage
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container build process (Singularity/Apptainer)
  that failed to fetch the wkhtmltopdf image.\n\nTool homepage: https://github.com/wkhtmltopdf/wkhtmltopdf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wkhtmltopdf:0.12.3--0
stdout: wkhtmltopdf_wkhtmltoimage.out
