cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tigmint_molecule.py
label: tigmint_tigmint_molecule.py
doc: "Group linked reads into molecules. Read a SAM/BAM file and output a TSV file. The SAM/BAM file must be sorted by BX tag and then by position.\n\nTool homepage: https://github.com/bcgsc/tigmint"
inputs:
  - id: bam
    type: File
    doc: "Input BAM file sorted by BX tag then position, - for stdin"
    inputBinding:
      position: 20
  - id: output
    type:
      - 'null'
      - string
    doc: "Output TSV file [stdout]"
    inputBinding:
      position: 1
      prefix: --output
  - id: out_bam
    type:
      - 'null'
      - string
    doc: "Output BAM file with MI tags (optional)"
    inputBinding:
      position: 2
      prefix: --out-bam
  - id: bed
    type:
      - 'null'
      - boolean
    doc: "Output in BED format [default]"
    inputBinding:
      position: 3
      prefix: --bed
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: "Output in TSV format"
    inputBinding:
      position: 4
      prefix: --tsv
  - id: dist
    type:
      - 'null'
      - int
    doc: "Maximum distance between reads in the same molecule [50000]"
    inputBinding:
      position: 5
      prefix: --dist
  - id: reads
    type:
      - 'null'
      - int
    doc: "Minimum number of reads per molecule (duplicates are filtered out) [4]"
    inputBinding:
      position: 6
      prefix: --reads
  - id: mapq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality [0]"
    inputBinding:
      position: 7
      prefix: --mapq
  - id: as_ratio
    type:
      - 'null'
      - float
    doc: "Minimum ratio of alignment score (AS) over read length [0.65]"
    inputBinding:
      position: 8
      prefix: --as-ratio
  - id: nm
    type:
      - 'null'
      - int
    doc: "Maximum number of mismatches (NM) [5]"
    inputBinding:
      position: 9
      prefix: --nm
  - id: size
    type:
      - 'null'
      - int
    doc: "Minimum molecule size [2000]"
    inputBinding:
      position: 10
      prefix: --size
  - id: params
    type:
      - 'null'
      - File
    doc: "Parameter file from tigmint_estimate_dist.py"
    inputBinding:
      position: 11
      prefix: --params
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Molecule extents file written with --output"
    outputBinding:
      glob: $(inputs.output)
  - id: output_bam
    type:
      - 'null'
      - File
    doc: "BAM file with MI tags written with --out-bam"
    outputBinding:
      glob: $(inputs.out_bam)
  - id: stdout
    type: stdout
    doc: Molecule extents written to standard output when --output is not used
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
stdout: tigmint_molecule.out
