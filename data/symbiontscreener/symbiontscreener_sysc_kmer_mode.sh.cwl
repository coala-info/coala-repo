cwlVersion: v1.2
class: CommandLineTool
baseCommand: symbiontscreener_sysc_kmer_mode.sh
label: symbiontscreener_sysc_kmer_mode.sh
doc: "SymbiontScreener k-mer mode script. (Note: The provided text contains container
  runtime logs and error messages rather than tool help documentation, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/BGI-Qingdao/Symbiont-Screener"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener_sysc_kmer_mode.sh.out
