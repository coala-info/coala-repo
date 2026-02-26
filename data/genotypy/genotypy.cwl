cwlVersion: v1.2
class: CommandLineTool
baseCommand: genotypy
label: genotypy
doc: "Detect genomic barcodes from a given set of reads in a set of defined loci where
  those barcodes can be expected.\n\nTool homepage: https://gitbio.ens-lyon.fr/LBMC/yvertlab/vortex/plasticity_mutation/colony_rnaseq_bioinformatics/genotypy"
inputs:
  - id: custom
    type:
      - 'null'
      - type: array
        items: File
    doc: A custom config file to use genotypy on locus that are not pre-defined.
      Can be a single path, or a comma-separated list of file paths if there are
      multiple files.
    inputBinding:
      position: 101
      prefix: --custom
  - id: loci
    type:
      - 'null'
      - type: array
        items: string
    doc: 'A comma-separated list of loci to map reads on and search a genomic barcode.
      Must be in the following list of pre-defined loci: KAN.'
    inputBinding:
      position: 101
      prefix: --loci
  - id: reads
    type: File
    doc: Input reads that will be mapped on a reference locus. They should 
      correspond to a single sample.
    inputBinding:
      position: 101
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - int
    doc: Minimum reads threshold under which no predictions will be made.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store intermediate files like indexes or bam 
      files.
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory path
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genotypy:0.3.4--pyhdfd78af_0
