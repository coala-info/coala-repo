cwlVersion: v1.2
class: CommandLineTool
baseCommand: csv2rdf
label: rdfextras_csv2rdf
doc: "Reads csv files from stdin or given files. Creates a URI from the columns
  given to -i, or automatically by numbering if none is given. Outputs RDFS labels
  from the columns given to -l. Outputs one RDF triple per column in each row. Output
  is in n3 format.\n\nTool homepage: https://github.com/RDFLib/rdfextras"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: CSV files to read (stdin if none)
    inputBinding:
      position: 200
  - id: instance_base
    type: string
    doc: instance base URI (-b)
    inputBinding:
      position: 1
      prefix: --base
  - id: property_base
    type: string
    doc: property base URI (--propbase crashes in this version, so -p is used)
    inputBinding:
      position: 2
      prefix: -p
  - id: classname
    type:
      - 'null'
      - string
    doc: adds a type triple with the given classname (-c)
    inputBinding:
      position: 3
      prefix: --class
  - id: identity_columns
    type:
      - 'null'
      - string
    doc: "identity column(s) to build the URI from, a Python expression: an index
      such as 0 or a tuple such as (0,1) (-i)"
    inputBinding:
      position: 4
      prefix: --ident
  - id: label_columns
    type:
      - 'null'
      - string
    doc: "columns for RDFS labels, a Python expression: a tuple such as (1,) or
      (1,2) (-l)"
    inputBinding:
      position: 5
      prefix: --label
  - id: skip_lines
    type:
      - 'null'
      - int
    doc: skips N lines at the start (-s)
    inputBinding:
      position: 6
      prefix: --skip
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiter to use for CSV parsing (-d)
    inputBinding:
      position: 7
      prefix: --delim
  - id: define_class
    type:
      - 'null'
      - boolean
    doc: the class is defined as rdfs:Class (-C; needs classname)
    inputBinding:
      position: 8
      prefix: --defineclass
  - id: config_file
    type:
      - 'null'
      - File
    doc: ini file with a section csv2rdf holding the long options (-f)
    inputBinding:
      position: 9
      prefix: -f
  - id: col_specs
    type:
      - 'null'
      - type: array
        items: string
    doc: "(the command-line --colN option crashes in this version; use config_file
      instead) column conversions as N:spec, for example 2:float() or 3:int(); each item
      becomes --colN spec. Conversions: float(), int(), split(sep, [more]), uri(base,
      [class]), date(format)"
  - id: prop_specs
    type:
      - 'null'
      - type: array
        items: string
    doc: "(the command-line --propN option crashes in this version; use config_file
      instead) specific properties as N:uri, for example 0:http://xmlns.com/foaf/0.1/name;
      each item becomes --propN uri"
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: write the n3 output to this file instead of stdout (-o)
    inputBinding:
      position: 10
      prefix: --out
arguments:
  - position: 11
    valueFrom: |
      ${
        var r = [];
        (inputs.col_specs || []).forEach(function(s) {
          var i = s.indexOf(":");
          r.push("--col" + s.substring(0, i));
          r.push(s.substring(i + 1));
        });
        (inputs.prop_specs || []).forEach(function(s) {
          var i = s.indexOf(":");
          r.push("--prop" + s.substring(0, i));
          r.push(s.substring(i + 1));
        });
        return r;
      }
outputs:
  - id: stdout
    type: stdout
    doc: n3 output when no output file is given
  - id: output_file
    type:
      - 'null'
      - File
    doc: n3 output file
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
stdout: rdfextras_csv2rdf.out
