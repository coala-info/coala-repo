cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_chimera.ccode
doc: "Reads a fasta file and reference file and outputs potentially chimeric sequences (Ccode algorithm).\n\nThe chimera.ccode command reads a fastafile and referencefile and outputs potentially chimeric sequences.\nThis command was created using the algorithms described in the 'Evaluating putative chimeric sequences from PCR-amplified products' paper by Juan M. Gonzalez, Johannes Zimmerman and Cesareo Saiz-Jimenez.\nThe chimera.ccode command parameters are fasta, reference, filter, mask, processors, window and numwanted.\nThe fasta parameter allows you to enter the fasta file containing your potentially chimeric sequences, and is required unless you have a valid current fasta file. \nThe reference parameter allows you to enter a reference file containing known non-chimeric sequences, and is required. \nThe filter parameter allows you to specify if you would like to apply a vertical and 50% soft filter. \nThe mask parameter allows you to specify a file containing one sequence you wish to use as a mask for the your sequences. \nThe window parameter allows you to specify the window size for searching for chimeras. \nThe numwanted parameter allows you to specify how many sequences you would each query sequence compared with.\nThe removechimeras parameter allows you to indicate you would like to automatically remove the sequences that are flagged as chimeric. Default=t.\nThe chimera.ccode command should be in the following format: \nchimera.ccode(fasta=yourFastaFile, reference=yourTemplate) \nExample: chimera.ccode(fasta=AD.align, reference=core_set_aligned.imputed.fasta) \n\nThe valid parameters are: reference, fasta, filter, window, numwanted, mask, removechimeras, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.fasta ? inputs.fasta : [])"
      - "$(inputs.reference ? inputs.reference : [])"
      - "$(inputs.mask ? inputs.mask : [])"
inputs:
  - id: fasta
    type: File
    doc: "Aligned fasta file with potentially chimeric sequences (mothur parameter fasta=)"
  - id: reference
    type: File
    doc: "Aligned reference file of known non-chimeric sequences (mothur parameter reference=)"
  - id: filter
    type:
      - 'null'
      - boolean
    doc: "Apply a vertical and 50% soft filter (mothur parameter filter=)"
  - id: mask
    type:
      - 'null'
      - File
    doc: "File containing one sequence to use as a mask (mothur parameter mask=)"
  - id: window
    type:
      - 'null'
      - int
    doc: "Window size for searching for chimeras (mothur parameter window=)"
  - id: numwanted
    type:
      - 'null'
      - int
    doc: "Number of sequences each query sequence is compared with (mothur parameter numwanted=)"
  - id: removechimeras
    type:
      - 'null'
      - boolean
    doc: "Automatically remove the sequences flagged as chimeric (default true) (mothur parameter removechimeras=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["fasta", "fasta"], ["reference", "reference"], ["filter", "filter"], ["mask", "mask"], ["window", "window"], ["numwanted", "numwanted"], ["removechimeras", "removechimeras"], ["seed", "seed"]];
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
        return '#chimera.ccode(' + opts.join(', ') + ')';
      }
outputs:
  - id: chimeras
    type: File
    doc: "Chimera report"
    outputBinding:
      glob: "*.ccode.chimeras"
  - id: accnos
    type:
      - 'null'
      - File
    doc: "Names of sequences flagged as chimeric"
    outputBinding:
      glob: "*.ccode.accnos"
  - id: mapinfo
    type:
      - 'null'
      - File
    doc: "Map of filtered alignment positions"
    outputBinding:
      glob: "*.mapinfo"
  - id: fasta_out
    type:
      - 'null'
      - File
    doc: "Fasta file with chimeras removed"
    outputBinding:
      glob: "*.ccode.fasta"
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
stdout: mothur_chimera.ccode.out
