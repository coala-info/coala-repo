cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - plugin
label: bcftools_plugin
doc: Run user defined plugin
inputs:
  - id: plugin_name
    type: string
    doc: Name of the plugin to run
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input VCF/BCF file
    inputBinding:
      position: 2
  - id: plugin_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options specific to the plugin
    inputBinding:
      position: 3
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude sites for which the expression is true
    inputBinding:
      position: 104
      prefix: --exclude
  - id: include
    type:
      - 'null'
      - string
    doc: Select sites for which the expression is true
    inputBinding:
      position: 104
      prefix: --include
  - id: list_plugins
    type:
      - 'null'
      - boolean
    doc: List available plugins
    inputBinding:
      position: 104
      prefix: --list-plugins
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 104
      prefix: --no-version
  - id: output
    type: string
    doc: Write output to a file
    inputBinding:
      position: 104
      prefix: --output
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level'
    inputBinding:
      position: 104
      prefix: --output-type
  - id: regions
    type:
      - 'null'
      - string
    doc: Restrict to comma-separated list of regions
    inputBinding:
      position: 104
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: Restrict to regions listed in a file
    inputBinding:
      position: 104
      prefix: --regions-file
  - id: regions_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    inputBinding:
      position: 104
      prefix: --regions-overlap
  - id: targets
    type:
      - 'null'
      - string
    doc: Similar to -r but streams rather than index-jumps
    inputBinding:
      position: 104
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: Similar to -R but streams rather than index-jumps
    inputBinding:
      position: 104
      prefix: --targets-file
  - id: targets_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    inputBinding:
      position: 104
      prefix: --targets-overlap
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multithreading with <int> worker threads
    inputBinding:
      position: 104
      prefix: --threads
  - id: write_index
    type:
      - 'null'
      - string
    doc: Automatically index the output files
    inputBinding:
      position: 104
      prefix: --write-index
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Write output to a file
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
s:url: https://github.com/samtools/bcftools
$namespaces:
  s: https://schema.org/
