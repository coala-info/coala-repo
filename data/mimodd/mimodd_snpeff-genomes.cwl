cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimodd
label: mimodd_snpeff-genomes
doc: "Configure MiModD to specify the location of an existing SnpEff installation
  for use by MiModD.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: snpeff_path
    type:
      - 'null'
      - Directory
    doc: Specify the location of an existing SnpEff installation for use by 
      MiModD.
    inputBinding:
      position: 101
      prefix: --snpeff
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
stdout: mimodd_snpeff-genomes.out
