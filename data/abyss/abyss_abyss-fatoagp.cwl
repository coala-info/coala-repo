cwlVersion: v1.2
class: CommandLineTool
label: abyss_abyss-fatoagp
doc: "Convert a FASTA file of scaffolds to a FASTA file of contigs (split at runs of N) and an AGP file describing how the contigs make the scaffolds. Written from the script source: the tool prints no help.\n\nTool homepage: https://github.com/bcgsc/abyss"
baseCommand: [abyss-fatoagp]
hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/abyss:2.3.10--hf316886_2
inputs:
  scaffolds:
    type: File
    doc: "Scaffolds (FASTA, one line per sequence as ABySS writes them)."
    inputBinding: {position: 10}
  contigs_output:
    type: string?
    doc: "Write the contigs (scaftigs) to this FASTA file (-f)."
    inputBinding: {prefix: -f, position: 1}
  min_scaffold_length:
    type: int?
    doc: "Scaffolds shorter than this are excluded (-s) [200]."
    inputBinding: {prefix: -s, position: 1}
  min_contig_length:
    type: int?
    doc: "Scaftigs shorter than this are masked with N (-S) [50]."
    inputBinding: {prefix: -S, position: 1}
outputs:
  agp:
    type: stdout
    doc: "AGP file."
  contigs:
    type: File?
    doc: "Contigs FASTA (with -f)."
    outputBinding: {glob: $(inputs.contigs_output)}
stdout: $(inputs.scaffolds.nameroot).agp
