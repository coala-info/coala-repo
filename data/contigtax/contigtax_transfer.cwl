cwlVersion: v1.2
class: CommandLineTool
baseCommand: contigtax transfer
label: contigtax_transfer
doc: "Assigns taxonomy to contigs based on ORF taxonomy and GFF file.\n\nTool homepage:
  https://github.com/NBISweden/contigtax"
inputs:
  - id: orf_taxonomy
    type: File
    doc: Taxonomy assigned to ORFs (ORF ids in first column)
    inputBinding:
      position: 1
  - id: gff
    type: File
    doc: GFF or file with contig id in first column and ORF id in second column
    inputBinding:
      position: 2
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Size of chunks sent to process pool. For large input files using a 
      large chunksize can make the job complete much faster than using the 
      default value of 1.
    inputBinding:
      position: 103
      prefix: --chunksize
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cpus to use when transferring taxonomy to contigs
    inputBinding:
      position: 103
      prefix: --cpus
  - id: ignore_unc_rank
    type:
      - 'null'
      - string
    doc: Ignore ORFs unclassified at <rank>
    inputBinding:
      position: 103
      prefix: --ignore_unc_rank
outputs:
  - id: contig_taxonomy
    type: File
    doc: Output file with assigned taxonomy for contigs
    outputBinding:
      glob: '*.out'
  - id: orf_tax_out
    type:
      - 'null'
      - File
    doc: Also transfer taxonomy back to ORFs and output to file
    outputBinding:
      glob: $(inputs.orf_tax_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
