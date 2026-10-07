cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - eigs-trans
label: cooltools_eigs-trans
doc: "Perform eigen value decomposition on a cooler matrix to calculate compartment
  signal by finding the eigenvector that correlates best with the phasing track.\n\
  \nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: cool_path
    type: File
    doc: the paths to a .cool file with a balanced Hi-C map. Use the '::' syntax
      to specify a group path in a multicooler file.
    inputBinding:
      position: 1
  - id: bigwig
    type:
      - 'null'
      - boolean
    doc: Also save compartment track (E1) as a bigWig file with the name 
      out_prefix.contact_type.bw
    inputBinding:
      position: 102
      prefix: --bigwig
  - id: clr_weight_name
    type:
      - 'null'
      - string
    doc: Use balancing weight with this name. Using raw unbalanced data is not 
      supported for saddles.
    inputBinding:
      position: 102
      prefix: --clr-weight-name
  - id: n_eigs
    type:
      - 'null'
      - int
    doc: Number of eigenvectors to compute.
    inputBinding:
      position: 102
      prefix: --n-eigs
  - id: out_prefix
    type: string
    doc: Save compartment track as a BED-like file. Eigenvectors and 
      corresponding eigenvalues are stored in out_prefix.contact_type.vecs.tsv 
      and out_prefix.contact_type.lam.txt
    inputBinding:
      position: 102
      prefix: --out-prefix
  - id: phasing_track
    type:
      - 'null'
      - File
    doc: Phasing track for orienting and ranking eigenvectors (BedGraph-like 
      file with columns chrom, start, end and the track value).
    inputBinding:
      position: 102
      prefix: --phasing-track
      valueFrom: "$(inputs.phasing_track_column ? self.path + '::' + inputs.phasing_track_column\
        \ : self.path)"
  - id: phasing_track_column
    type:
      - 'null'
      - string
    doc: Name of the track value column in the phasing track (passed as 
      /path/to/track::track_value_column_name). Default is the 4th column.
  - id: regions
    type:
      - 'null'
      - File
    doc: Path to a BED file which defines which regions of the chromosomes to 
      use (only implemented for cis contacts). Note that '--regions' is the 
      deprecated name of the option. Use '--view' instead.
    inputBinding:
      position: 102
      prefix: --regions
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: view
    type:
      - 'null'
      - File
    doc: Path to a BED file which defines which regions of the chromosomes to 
      use (only implemented for cis contacts). Note that '--regions' is the 
      deprecated name of the option. Use '--view' instead.
    inputBinding:
      position: 102
      prefix: --view
outputs:
  - id: eigenvectors
    type: File
    doc: Eigenvectors per bin (out_prefix.trans.vecs.tsv).
    outputBinding:
      glob: $(inputs.out_prefix).trans.vecs.tsv
  - id: eigenvalues
    type: File
    doc: Eigenvalues (out_prefix.trans.lam.txt).
    outputBinding:
      glob: $(inputs.out_prefix).trans.lam.txt
  - id: bigwig_track
    type:
      - 'null'
      - File
    doc: Compartment track (E1) as bigWig (out_prefix.trans.bw), with --bigwig.
    outputBinding:
      glob: $(inputs.out_prefix).trans.bw
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
