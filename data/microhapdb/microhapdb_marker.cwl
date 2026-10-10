cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - microhapdb
  - marker
label: microhapdb_marker
doc: "Retrieve marker records by identifier or query\n\nTool homepage: https://github.com/bioforensics/MicroHapDB/"
inputs:
  - id: ae_pop
    type:
      - 'null'
      - string
    doc: 1000 Genomes population from which to report effective number of alleles in the Ae column; by
      default the Ae value averaged over all 26 1KGP populations.
    inputBinding:
      position: 101
      prefix: --ae-pop
  - id: panel
    type:
      - 'null'
      - File
    doc: File containing a list of marker names/identifiers, one per line.
    inputBinding:
      position: 101
      prefix: --panel
  - id: region
    type:
      - 'null'
      - string
    doc: Restrict results to the specified genomic region; format chrX:YYYY-ZZZZZ.
    inputBinding:
      position: 101
      prefix: --region
  - id: query
    type:
      - 'null'
      - string
    doc: Retrieve records using a Pandas-style query.
    inputBinding:
      position: 101
      prefix: --query
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format: table, detail, fasta or offsets (detail, fasta and offsets need the GRCh38 genome
      from microhapdb --download).'
    inputBinding:
      position: 101
      prefix: --format
  - id: columns
    type:
      - 'null'
      - string
    doc: String of column codes for tabular output; n=NumVars x=Extent c=Chrom s=Start e=End p=Positions
      q=Positions37 r=RSIDs a=Ae; default nxcsea.
    inputBinding:
      position: 101
      prefix: --columns
  - id: delta
    type:
      - 'null'
      - int
    doc: Extend D nucleotides beyond the marker extent when computing target sequence boundaries (default
      10).
    inputBinding:
      position: 101
      prefix: --delta
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of the target sequence (default 80).
    inputBinding:
      position: 101
      prefix: --min-length
  - id: extend_mode
    type:
      - 'null'
      - string
    doc: 'How the target sequence is extended to the minimum length: 5, 3 or symmetric (default).'
    inputBinding:
      position: 101
      prefix: --extend-mode
  - id: notrunc
    type:
      - 'null'
      - boolean
    doc: Disable truncation of tabular results.
    inputBinding:
      position: 101
      prefix: --notrunc
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more marker identifiers.
    inputBinding:
      position: 201
outputs:
  - id: result
    type: stdout
    doc: Marker records (standard output).
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
stdout: microhapdb_marker.out
