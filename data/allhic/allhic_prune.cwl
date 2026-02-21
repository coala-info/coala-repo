cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - allhic
  - prune
label: allhic_prune
doc: "Prune inter-allelic links from contig pairing data to enable allele-separated
  assemblies. It removes Hi-C links between contigs identified as allelic and filters
  links to keep only the single-best edge when multiple contigs link to the same allelic
  group.\n\nTool homepage: https://github.com/tanghaibao/allhic"
inputs:
  - id: alleles_table
    type: File
    doc: File containing tab-separated columns of contigs that are considered allelic,
      or output from purge-haplotigs.
    inputBinding:
      position: 1
  - id: pairs_file
    type: File
    doc: The pairs.txt file which is the output of the 'extract' command.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allhic:0.9.14--he881be0_0
stdout: allhic_prune.out
