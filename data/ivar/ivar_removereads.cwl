cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ivar
  - removereads
label: ivar_removereads
doc: "This step is used only for amplicon-based sequencing.\n\nTool homepage: https://andersen-lab.github.io/ivar/html/"
inputs:
  - id: input_trimmed_bam
    type: File
    doc: Input BAM file  trimmed with ‘ivar trim’. Must be sorted which can be 
      done using `samtools sort`.
    inputBinding:
      position: 101
      prefix: -i
  - id: prefix
    type: string
    doc: Prefix for the output filtered BAM file
    inputBinding:
      position: 101
      prefix: -p
  - id: primer_indices_file
    type: File
    doc: Text file with primer indices separated by spaces. This is the output 
      of `getmasked` command.
    inputBinding:
      position: 101
      prefix: -t
  - id: primers_bed
    type: File
    doc: BED file with primer sequences and positions.
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix
    outputBinding:
      glob: $(inputs.prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
stdout: ivar_removereads.out
