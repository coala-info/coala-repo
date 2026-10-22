cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tigmint_molecule_paf.py
label: tigmint_tigmint_molecule_paf.py
doc: "Group linked reads simulated from long reads into molecules. Read a PAF file and output a BED file.\n\nTool homepage: https://github.com/bcgsc/tigmint"
inputs:
  - id: paf
    type: File
    doc: "Input PAF file, - for stdin"
    inputBinding:
      position: 20
  - id: output
    type:
      - 'null'
      - string
    doc: "Output molecule BED file [stdout]"
    inputBinding:
      position: 1
      prefix: --output
  - id: dist
    type:
      - 'null'
      - int
    doc: "Maximum distance between reads in the same molecule [50000]"
    inputBinding:
      position: 2
      prefix: --dist
  - id: reads
    type:
      - 'null'
      - int
    doc: "Minimum number of reads per molecule (duplicates filtered out) [4]"
    inputBinding:
      position: 3
      prefix: --reads
  - id: size
    type:
      - 'null'
      - int
    doc: "Minimum molecule size [2000]"
    inputBinding:
      position: 4
      prefix: --size
  - id: params
    type:
      - 'null'
      - File
    doc: "Parameter file from tigmint_estimate_dist.py"
    inputBinding:
      position: 5
      prefix: --params
  - id: mapq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality [0]"
    inputBinding:
      position: 6
      prefix: --mapq
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Molecule BED file written with --output"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Molecule BED written to standard output when --output is not used
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
stdout: tigmint_molecule_paf.out
