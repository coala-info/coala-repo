cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyani_genbank_get_genomes_by_taxon.py
label: pyani_genbank_get_genomes_by_taxon.py
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be a log of a failed container execution/build process.\n\n
  Tool homepage: https://github.com/widdowquinn/pyani"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
stdout: pyani_genbank_get_genomes_by_taxon.py.out
