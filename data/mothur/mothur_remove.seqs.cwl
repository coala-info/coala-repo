cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_remove.seqs
doc: "Removes the sequences listed in an accnos file from fasta, name, group, count, list, taxonomy, quality, fastq, contigsreport or alignreport files.\n\nThe remove.seqs command reads an .accnos file and at least one of the following file types: fasta, name, group, count, list, taxonomy, quality, fastq, contigsreport or alignreport file.\nIt outputs a file containing the sequences NOT in the .accnos file.\nThe remove.seqs command parameters are accnos, fasta, name, group, count, list, taxonomy, qfile, alignreport, contigsreport, fastq and dups.  You must provide accnos and at least one of the file parameters.\nThe format parameter is used to indicate whether your sequences are sanger, solexa, illumina1.8+ or illumina, default=illumina1.8+.\nThe dups parameter allows you to remove the entire line from a name file if you remove any name from the line. default=true. \nThe remove.seqs command should be in the following format: remove.seqs(accnos=yourAccnos, fasta=yourFasta).\nExample remove.seqs(accnos=amazon.accnos, fasta=amazon.fasta).\n\nThe valid parameters are: fastq, fasta, name, count, group, list, taxonomy, alignreport, contigsreport, qfile, accnos, dups, seed, format, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.accnos ? inputs.accnos : [])"
      - "$(inputs.fasta ? inputs.fasta : [])"
      - "$(inputs.fastq ? inputs.fastq : [])"
      - "$(inputs.name ? inputs.name : [])"
      - "$(inputs.count ? inputs.count : [])"
      - "$(inputs.group ? inputs.group : [])"
      - "$(inputs.list ? inputs.list : [])"
      - "$(inputs.taxonomy ? inputs.taxonomy : [])"
      - "$(inputs.qfile ? inputs.qfile : [])"
      - "$(inputs.alignreport ? inputs.alignreport : [])"
      - "$(inputs.contigsreport ? inputs.contigsreport : [])"
inputs:
  - id: accnos
    type: File
    doc: "Accnos file of sequence names to remove (mothur parameter accnos=)"
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Fasta file (mothur parameter fasta=)"
  - id: fastq
    type:
      - 'null'
      - File
    doc: "FASTQ file (mothur parameter fastq=)"
  - id: name
    type:
      - 'null'
      - File
    doc: "Names file (mothur parameter name=)"
  - id: count
    type:
      - 'null'
      - File
    doc: "Count table (mothur parameter count=)"
  - id: group
    type:
      - 'null'
      - File
    doc: "Group file (mothur parameter group=)"
  - id: list
    type:
      - 'null'
      - File
    doc: "OTU list file (mothur parameter list=)"
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: "Taxonomy file (mothur parameter taxonomy=)"
  - id: qfile
    type:
      - 'null'
      - File
    doc: "Quality file (mothur parameter qfile=)"
  - id: alignreport
    type:
      - 'null'
      - File
    doc: "Align report file (mothur parameter alignreport=)"
  - id: contigsreport
    type:
      - 'null'
      - File
    doc: "Contigs report file (mothur parameter contigsreport=)"
  - id: format
    type:
      - 'null'
      - string
    doc: "FASTQ quality encoding: sanger, solexa, illumina1.8+ or illumina (default illumina1.8+) (mothur parameter format=)"
  - id: dups
    type:
      - 'null'
      - boolean
    doc: "Remove the entire line of a name file if any name is removed (default true) (mothur parameter dups=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["accnos", "accnos"], ["fasta", "fasta"], ["fastq", "fastq"], ["name", "name"], ["count", "count"], ["group", "group"], ["list", "list"], ["taxonomy", "taxonomy"], ["qfile", "qfile"], ["alignreport", "alignreport"], ["contigsreport", "contigsreport"], ["format", "format"], ["dups", "dups"], ["seed", "seed"]];
        var opts = [];
        params.forEach(function (p) {
          var v = inputs[p[0]];
          if (v === null || v === undefined) { return; }
          if (Array.isArray(v)) { v = v.map(function (f) { return f.basename; }).join('-'); }
          else if (typeof v === 'object') { v = v.basename; }
          else if (typeof v === 'boolean') { v = v ? 'T' : 'F'; }
          opts.push(p[1] + '=' + v);
        });
        opts.push('outputdir=' + runtime.outdir + '/');
        return '#remove.seqs(' + opts.join(', ') + ')';
      }
outputs:
  - id: fasta_out
    type:
      - 'null'
      - File
    doc: "Picked fasta"
    outputBinding:
      glob: "$(inputs.fasta ? inputs.fasta.nameroot + '.pick' + inputs.fasta.nameext : [])"
  - id: fastq_out
    type:
      - 'null'
      - File
    doc: "Picked fastq"
    outputBinding:
      glob: "$(inputs.fastq ? inputs.fastq.nameroot + '.pick' + inputs.fastq.nameext : [])"
  - id: name_out
    type:
      - 'null'
      - File
    doc: "Picked names"
    outputBinding:
      glob: "$(inputs.name ? inputs.name.nameroot + '.pick' + inputs.name.nameext : [])"
  - id: count_out
    type:
      - 'null'
      - File
    doc: "Picked count table"
    outputBinding:
      glob: "$(inputs.count ? inputs.count.nameroot + '.pick' + inputs.count.nameext : [])"
  - id: group_out
    type:
      - 'null'
      - File
    doc: "Picked groups"
    outputBinding:
      glob: "$(inputs.group ? inputs.group.nameroot + '.pick' + inputs.group.nameext : [])"
  - id: list_out
    type:
      - 'null'
      - File
    doc: "Picked list"
    outputBinding:
      glob: "$(inputs.list ? inputs.list.nameroot + '.pick' + inputs.list.nameext : [])"
  - id: taxonomy_out
    type:
      - 'null'
      - File
    doc: "Picked taxonomy"
    outputBinding:
      glob: "$(inputs.taxonomy ? inputs.taxonomy.nameroot + '.pick' + inputs.taxonomy.nameext : [])"
  - id: qfile_out
    type:
      - 'null'
      - File
    doc: "Picked quality file"
    outputBinding:
      glob: "$(inputs.qfile ? inputs.qfile.nameroot + '.pick' + inputs.qfile.nameext : [])"
  - id: alignreport_out
    type:
      - 'null'
      - File
    doc: "Picked align report"
    outputBinding:
      glob: "$(inputs.alignreport ? inputs.alignreport.nameroot + '.pick' + inputs.alignreport.nameext : [])"
  - id: contigsreport_out
    type:
      - 'null'
      - File
    doc: "Picked contigs report"
    outputBinding:
      glob: "$(inputs.contigsreport ? inputs.contigsreport.nameroot + '.pick' + inputs.contigsreport.nameext : [])"
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
stdout: mothur_remove.seqs.out
