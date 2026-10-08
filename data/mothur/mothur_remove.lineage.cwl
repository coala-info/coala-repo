cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_remove.lineage
doc: "Removes sequences or OTUs that belong to given taxa from a taxonomy or constaxonomy file and related files.\n\nThe remove.lineage command reads a taxonomy or constaxonomy file and any of the following file types: fasta, name, group, count, list, shared or alignreport file. The constaxonomy can only be used with a shared or list file.\nIt outputs a file containing only the sequences or OTUS from the taxonomy file that are not from the taxon you requested to be removed.\nThe remove.lineage command parameters are taxon, fasta, name, group, count, list, shared, taxonomy, alignreport, label and dups.  You must provide taxonomy or constaxonomy unless you have a valid current taxonomy file.\nThe dups parameter allows you to add the entire line from a name file if you add any name from the line. default=false. \nThe taxon parameter allows you to select the taxons you would like to remove, and is required.\nYou may enter your taxons with confidence scores, doing so will remove only those sequences that belong to the taxonomy and whose cofidence scores fall below the scores you give.\nIf they belong to the taxonomy and have confidences above those you provide the sequence will not be removed.\nThe label parameter is used to analyze specific labels in your input. \nThe remove.lineage command should be in the following format: remove.lineage(taxonomy=yourTaxonomyFile, taxon=yourTaxons).\nExample remove.lineage(taxonomy=amazon.silva.taxonomy, taxon=Bacteria;Firmicutes;Bacilli;Lactobacillales;).\nNote: If you are running mothur in script mode you must wrap the taxon in ' characters so mothur will ignore the ; in the taxon.\nExample remove.lineage(taxonomy=amazon.silva.taxonomy, taxon='Bacteria;Firmicutes;Bacilli;Lactobacillales;').\n\nThe valid parameters are: fasta, name, count, group, list, shared, taxonomy, constaxonomy, alignreport, label, taxon, dups, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.taxonomy ? inputs.taxonomy : [])"
      - "$(inputs.constaxonomy ? inputs.constaxonomy : [])"
      - "$(inputs.fasta ? inputs.fasta : [])"
      - "$(inputs.name ? inputs.name : [])"
      - "$(inputs.group ? inputs.group : [])"
      - "$(inputs.count ? inputs.count : [])"
      - "$(inputs.list ? inputs.list : [])"
      - "$(inputs.shared ? inputs.shared : [])"
      - "$(inputs.alignreport ? inputs.alignreport : [])"
inputs:
  - id: taxon
    type: string
    doc: "Taxa to remove, e.g. Bacteria;Firmicutes; (optionally with confidence scores) (mothur parameter taxon=)"
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: "Sequence taxonomy file (taxonomy or constaxonomy is required) (mothur parameter taxonomy=)"
  - id: constaxonomy
    type:
      - 'null'
      - File
    doc: "Consensus taxonomy file (use with list or shared) (mothur parameter constaxonomy=)"
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Fasta file (mothur parameter fasta=)"
  - id: name
    type:
      - 'null'
      - File
    doc: "Names file (mothur parameter name=)"
  - id: group
    type:
      - 'null'
      - File
    doc: "Group file (mothur parameter group=)"
  - id: count
    type:
      - 'null'
      - File
    doc: "Count table (mothur parameter count=)"
  - id: list
    type:
      - 'null'
      - File
    doc: "OTU list file (mothur parameter list=)"
  - id: shared
    type:
      - 'null'
      - File
    doc: "Shared file (mothur parameter shared=)"
  - id: alignreport
    type:
      - 'null'
      - File
    doc: "Align report file (mothur parameter alignreport=)"
  - id: label
    type:
      - 'null'
      - string
    doc: "Labels to analyze (mothur parameter label=)"
  - id: dups
    type:
      - 'null'
      - boolean
    doc: "Remove the entire line of a name file if any name is removed (default false) (mothur parameter dups=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["taxon", "taxon"], ["taxonomy", "taxonomy"], ["constaxonomy", "constaxonomy"], ["fasta", "fasta"], ["name", "name"], ["group", "group"], ["count", "count"], ["list", "list"], ["shared", "shared"], ["alignreport", "alignreport"], ["label", "label"], ["dups", "dups"], ["seed", "seed"]];
        var opts = [];
        params.forEach(function (p) {
          var v = inputs[p[0]];
          if (v === null || v === undefined) { return; }
          if (Array.isArray(v)) { v = v.map(function (f) { return f.basename; }).join('-'); }
          else if (typeof v === 'object') { v = v.basename; }
          else if (typeof v === 'boolean') { v = v ? 'T' : 'F'; }
          if (p[1] === 'taxon') { v = "'" + v + "'"; }
          opts.push(p[1] + '=' + v);
        });
        opts.push('outputdir=' + runtime.outdir + '/');
        return '#remove.lineage(' + opts.join(', ') + ')';
      }
outputs:
  - id: taxonomy_out
    type:
      - 'null'
      - File
    doc: "Picked taxonomy"
    outputBinding:
      glob: "$(inputs.taxonomy ? inputs.taxonomy.nameroot + '.pick' + inputs.taxonomy.nameext : [])"
  - id: constaxonomy_out
    type:
      - 'null'
      - File
    doc: "Picked constaxonomy"
    outputBinding:
      glob: "$(inputs.constaxonomy ? inputs.constaxonomy.nameroot + '.pick' + inputs.constaxonomy.nameext : [])"
  - id: fasta_out
    type:
      - 'null'
      - File
    doc: "Picked fasta"
    outputBinding:
      glob: "$(inputs.fasta ? inputs.fasta.nameroot + '.pick' + inputs.fasta.nameext : [])"
  - id: name_out
    type:
      - 'null'
      - File
    doc: "Picked names"
    outputBinding:
      glob: "$(inputs.name ? inputs.name.nameroot + '.pick' + inputs.name.nameext : [])"
  - id: group_out
    type:
      - 'null'
      - File
    doc: "Picked groups"
    outputBinding:
      glob: "$(inputs.group ? inputs.group.nameroot + '.pick' + inputs.group.nameext : [])"
  - id: count_out
    type:
      - 'null'
      - File
    doc: "Picked count table"
    outputBinding:
      glob: "$(inputs.count ? inputs.count.nameroot + '.pick' + inputs.count.nameext : [])"
  - id: list_out
    type:
      type: array
      items: File
    doc: "Picked list files"
    outputBinding:
      glob: "$(inputs.list ? inputs.list.nameroot + '.*.pick' + inputs.list.nameext : [])"
  - id: shared_out
    type:
      type: array
      items: File
    doc: "Picked shared files"
    outputBinding:
      glob: "$(inputs.shared ? inputs.shared.nameroot + '.*.pick' + inputs.shared.nameext : [])"
  - id: alignreport_out
    type:
      - 'null'
      - File
    doc: "Picked align report"
    outputBinding:
      glob: "$(inputs.alignreport ? inputs.alignreport.nameroot + '.pick' + inputs.alignreport.nameext : [])"
  - id: logfile
    type:
      - 'null'
      - File
    doc: mothur log file
    outputBinding:
      glob: mothur.*.logfile
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
stdout: mothur_remove.lineage.out
