cwlVersion: v1.2
class: CommandLineTool
baseCommand: HAPmaker
label: merquryfk_HAPmaker
doc: "Makes maternal and paternal hap-mer tables from parent and child k-mer tables (HAPmaker of MerquryFK)\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        function add(f, parts) {
          if (!f) { return; }
          l.push({entryname: f.basename, entry: f});
          (parts || []).forEach(function (p) {
            var n = p.basename.split('.').pop();
            l.push({entryname: '.' + f.basename + '.' + n, entry: p});
          });
        }
        add(inputs.mat, inputs.mat_parts);
        add(inputs.pat, inputs.pat_parts);
        add(inputs.child, inputs.child_parts);
        return l;
      }
inputs:
  - id: mat
    type: File
    doc: "Maternal k-mer table (<mat>.ktab)"
    inputBinding:
      position: 1
  - id: mat_parts
    type: File[]
    doc: Hidden part files of the table (.<name>.ktab.1, .<name>.ktab.2, ...) written beside the table
  - id: pat
    type: File
    doc: "Paternal k-mer table (<pat>.ktab)"
    inputBinding:
      position: 2
  - id: pat_parts
    type: File[]
    doc: Hidden part files of the table (.<name>.ktab.1, .<name>.ktab.2, ...) written beside the table
  - id: child
    type: File
    doc: "Child k-mer table (<child>.ktab)"
    inputBinding:
      position: 3
  - id: child_parts
    type: File[]
    doc: Hidden part files of the table (.<name>.ktab.1, .<name>.ktab.2, ...) written beside the table
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output to stderr"
    inputBinding:
      position: 100
      prefix: -v
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads to use"
    inputBinding:
      position: 100
      prefix: -T
      separate: false
outputs:
  - id: hap_ktabs
    type: File[]
    doc: "Hap-mer tables <mat>.hap.ktab and <pat>.hap.ktab"
    outputBinding:
      glob: '*.hap.ktab'
  - id: hap_ktab_parts
    type: File[]
    doc: "Hidden part files of the hap-mer tables"
    outputBinding:
      glob: '.*.hap.ktab.*'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
