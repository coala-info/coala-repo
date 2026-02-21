cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer_kc-py1.py
label: kmer_kc-py1.py
doc: "K-mer analysis tool (Note: The provided text contains system error messages
  regarding container image conversion and disk space, rather than actual command-line
  help documentation.)\n\nTool homepage: https://github.com/lh3/kmer-cnt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kmer:v020150903r2013-6-deb_cv1
stdout: kmer_kc-py1.py.out
