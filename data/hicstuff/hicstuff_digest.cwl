cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicstuff
  - digest
label: hicstuff_digest
doc: 'Digests a fasta file into fragments based on a restriction enzyme or a fixed
  chunk size. Generates two output files into the target directory named "info_contigs.txt"
  and "fragments_list.txt"


  Tool homepage: https://github.com/koszullab/hicstuff'
inputs:
  - id: fasta
    type: File
    doc: Fasta file to be digested
    inputBinding:
      position: 1
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Specify if the genome is circular.
    inputBinding:
      position: 102
      prefix: --circular
  - id: enzyme
    type:
      - 'null'
      - type: array
        items: string
    doc: A restriction enzyme or an integer representing fixed chunk sizes (in bp).
      Multiple comma-separated enzymes can be given.
    inputBinding:
      position: 102
      prefix: --enzyme
      itemSeparator: ','
  - id: figdir
    type:
      - 'null'
      - string
    doc: Path to directory of the output figure (created before the run). By default,
      the figure is only shown but not saved.
    inputBinding:
      position: 102
      prefix: --figdir
  - id: force
    type:
      - 'null'
      - boolean
    doc: Write even if the output file already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: outdir
    type:
      - 'null'
      - string
    doc: Directory where the fragments and contigs files will be written. Defaults
      to current directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Show a histogram of fragment length distribution after digestion.
    inputBinding:
      position: 102
      prefix: --plot
  - id: size
    type:
      - 'null'
      - int
    doc: Minimum size threshold to keep fragments.
    inputBinding:
      position: 102
      prefix: --size
outputs:
  - id: fragments_list
    type: File
    doc: Information about restriction fragments (or chunks).
    outputBinding:
      glob: '${ return (inputs.outdir ? inputs.outdir + ''/'' : '''') + ''fragments_list.txt'';
        }'
  - id: info_contigs
    type: File
    doc: Information about contigs or chromosomes.
    outputBinding:
      glob: '${ return (inputs.outdir ? inputs.outdir + ''/'' : '''') + ''info_contigs.txt'';
        }'
  - id: figure_dir
    type:
      - 'null'
      - Directory
    doc: Figure directory (set with figdir).
    outputBinding:
      glob: $(inputs.figdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ return inputs.figdir ? {entryname: inputs.figdir, writable: true, entry:
        {class: ''Directory'', basename: inputs.figdir, listing: []}} : null; }'
