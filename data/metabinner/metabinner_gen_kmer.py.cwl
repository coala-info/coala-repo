cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabinner_gen_kmer.py
label: metabinner_gen_kmer.py
doc: "The provided text does not contain help information or usage instructions for
  metabinner_gen_kmer.py. It contains container runtime logs and a fatal error indicating
  'no space left on device' during a SIF image build.\n\nTool homepage: https://github.com/ziyewang/MetaBinner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
stdout: metabinner_gen_kmer.py.out
