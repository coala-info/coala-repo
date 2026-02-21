cwlVersion: v1.2
class: CommandLineTool
baseCommand: recon_reconftw.sh
label: recon_reconftw.sh
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log of a failed container image build or execution attempt.\n\n
  Tool homepage: https://github.com/six2dez/reconftw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recon:1.08--h7b50bb2_9
stdout: recon_reconftw.sh.out
