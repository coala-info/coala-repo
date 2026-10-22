cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svdb
  - --merge
label: svdb_merge
doc: "Merge similar structural variants within or between VCF files (stdout is the
  merged VCF)\n\nTool homepage: https://github.com/J35P312/SVDB"
inputs:
  - id: vcf
    type:
      type: array
      items: File
    doc: Input vcf files, all input vcf files will be merged into one. Use the
      --priority flag to prioritize the callers/vcf files.
  - id: vcf_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: One caller tag per input vcf (same order). Each tag is appended to its
      vcf as file.vcf:tag, as needed by --priority.
  - id: priority
    type:
      - 'null'
      - string
    doc: "Prioritise the input files, using the following format --vcf
      caller1.vcf:2 caller2.vcf:1 --priority: 1,2."
    inputBinding:
      position: 101
      prefix: --priority
  - id: bnd_distance
    type:
      - 'null'
      - int
    doc: The maximum distance between two similar precise breakpoints (default =
      2000).
    inputBinding:
      position: 101
      prefix: --bnd_distance
  - id: ins_distance
    type:
      - 'null'
      - int
    doc: The maximum distance to merge two insertions (default = 50).
    inputBinding:
      position: 101
      prefix: --ins_distance
  - id: overlap
    type:
      - 'null'
      - float
    doc: The overlap required to merge two events (0 means anything that
      touches will be merged, 1 means that two events must be identical to be
      merged), default = 0.95.
    inputBinding:
      position: 101
      prefix: --overlap
  - id: notag
    type:
      - 'null'
      - boolean
    doc: Do not add the the VARID and set entries to the info field.
    inputBinding:
      position: 101
      prefix: --notag
  - id: no_intra
    type:
      - 'null'
      - boolean
    doc: No merging of variants within the same vcf.
    inputBinding:
      position: 101
      prefix: --no_intra
  - id: no_var
    type:
      - 'null'
      - boolean
    doc: Variants of different type will be merged.
    inputBinding:
      position: 101
      prefix: --no_var
  - id: pass_only
    type:
      - 'null'
      - boolean
    doc: Merge only variants labeled PASS.
    inputBinding:
      position: 101
      prefix: --pass_only
  - id: same_order
    type:
      - 'null'
      - boolean
    doc: Across all input vcf files, the order of the sample columns are the
      same.
    inputBinding:
      position: 101
      prefix: --same_order
arguments:
  - position: 101
    valueFrom: |
      ${
        var out = ["--vcf"];
        for (var i = 0; i < inputs.vcf.length; i++) {
          out.push(inputs.vcf[i].path + (inputs.vcf_tags ? ":" + inputs.vcf_tags[i] : ""));
        }
        return out;
      }
outputs:
  - id: merged_vcf
    type: stdout
    doc: Merged VCF written to standard output.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdb:2.8.4--py311h7c5c6c8_0
stdout: svdb_merge.vcf
