cwlVersion: v1.2
class: CommandLineTool
baseCommand: hops_malt-build
label: hops_malt-build
doc: "A tool from the HOPS (Heuristic Operations for Post-processing of DNA Snps)
  package, likely used for building MALT (Megan Alignment Tool) indices.\n\nTool homepage:
  https://github.com/rhuebler/HOPS/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hops:0.35--hdfd78af_2
stdout: hops_malt-build.out
