cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_chimera.check
doc: "Reads a fasta file and reference file and outputs potentially chimeric sequences (CHIMERA_CHECK algorithm).\n\nThe chimera.check command reads a fastafile and referencefile and outputs potentially chimeric sequences.\nThis command was created using the algorithms described in CHIMERA_CHECK version 2.7 written by Niels Larsen. \nThe chimera.check command parameters are fasta, reference, processors, ksize, increment, svg and name.\nThe fasta parameter allows you to enter the fasta file containing your potentially chimeric sequences, and is required unless you have a valid current fasta file. \nThe reference parameter allows you to enter a reference file containing known non-chimeric sequences, and is required. \nThe increment parameter allows you to specify how far you move each window while finding chimeric sequences, default is 10.\nThe ksize parameter allows you to input kmersize, default is 7. \nThe svg parameter allows you to specify whether or not you would like a svg file outputted for each query sequence, default is False.\nThe name parameter allows you to enter a file containing names of sequences you would like .svg files for.\nThe chimera.check command should be in the following format: \nchimera.check(fasta=yourFastaFile, reference=yourTemplateFile, processors=yourProcessors, ksize=yourKmerSize) \nExample: chimera.check(fasta=AD.fasta, reference=core_set_aligned,imputed.fasta, processors=4, ksize=8) \n\nThe valid parameters are: reference, fasta, name, svg, increment, ksize, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.fasta ? inputs.fasta : [])"
      - "$(inputs.reference ? inputs.reference : [])"
      - "$(inputs.name ? inputs.name : [])"
inputs:
  - id: fasta
    type: File
    doc: "Fasta file with potentially chimeric sequences (mothur parameter fasta=)"
  - id: reference
    type: File
    doc: "Reference file of known non-chimeric sequences (mothur parameter reference=)"
  - id: name
    type:
      - 'null'
      - File
    doc: "File with names of sequences you want .svg files for (mothur parameter name=)"
  - id: svg
    type:
      - 'null'
      - boolean
    doc: "Output an svg file for each query sequence (default false) (mothur parameter svg=)"
  - id: increment
    type:
      - 'null'
      - int
    doc: "How far to move each window while finding chimeric sequences (default 10) (mothur parameter increment=)"
  - id: ksize
    type:
      - 'null'
      - int
    doc: "Kmer size (default 7) (mothur parameter ksize=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["fasta", "fasta"], ["reference", "reference"], ["name", "name"], ["svg", "svg"], ["increment", "increment"], ["ksize", "ksize"], ["seed", "seed"]];
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
        return '#chimera.check(' + opts.join(', ') + ')';
      }
outputs:
  - id: chimeras
    type: File
    doc: "Chimera report"
    outputBinding:
      glob: "*.chimeracheck.chimeras"
  - id: svg_files
    type:
      type: array
      items: File
    doc: "SVG image per query sequence"
    outputBinding:
      glob: "*.chimeracheck.svg"
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
stdout: mothur_chimera.check.out
