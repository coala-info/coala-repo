cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PGDSpider2-cli
label: pgdspider_PGDSpider2-cli
doc: "PGDSpider is a data conversion tool for population genetic and genomics
  programs. It converts between formats such as PGD, ARLEQUIN, BAM, BAPS, BCF,
  EIGENSOFT, FASTA, FASTQ, FSTAT, GENEPOP, MEGA, MIGRATE, NEXUS, PED, PHYLIP,
  SAM, STRUCTURE and VCF.\n\nTool homepage:
  http://www.cmpg.unibe.ch/software/PGDSpider/"
inputs:
  - id: input_file
    type: File
    doc: The input file for the conversion (mandatory).
    inputBinding:
      position: 1
      prefix: -inputfile
  - id: input_format
    type:
      - 'null'
      - string
    doc: Format of the input file. Mandatory if not defined in the answer (SPID)
      file. For example PGD, ARLEQUIN, BAM, BAPS, BATWING, BCF, CONVERT,
      EIGENSOFT, FASTA, FASTQ, FSTAT, GDA, GENELAND, GENEPOP, GENETIX, HGDP,
      HGDP_CEPH, IMMANC, IM, IMA2, MAF, MEGA, MIGRATE, MSA, NEWHYBRIDS, NEXUS,
      ONESAMP, PED, PHYLIP, SAM, STRUCTURE, VCF, XMFA.
    inputBinding:
      position: 2
      prefix: -inputformat
  - id: output_file
    type: string
    doc: Name of the output file for the conversion (mandatory).
    inputBinding:
      position: 3
      prefix: -outputfile
  - id: output_format
    type:
      - 'null'
      - string
    doc: Format of the output file. Mandatory if not defined in the answer
      (SPID) file. For example PGD, ARLEQUIN, BAM, BAMOVA, BAPS, BATWING,
      BAYENV, BCF, EIGENSOFT, FASTA, FASTQ, FDIST2, FSTAT, GDA, GENELAND,
      GENEPOP, GENETIX, GESTE_BAYE_SCAN, IMMANC, IM, IMA2, KML, MEGA, MIGRATE,
      MSA, MSVAR, NEWHYBRIDS, NEXUS, ONESAMP, PED, PHYLIP, SAM, STRUCTURAMA,
      STRUCTURE, VCF, XMFA.
    inputBinding:
      position: 4
      prefix: -outputformat
  - id: spid_file
    type: File
    doc: SPID file containing preanswered conversion questions (mandatory).
    inputBinding:
      position: 5
      prefix: -spid
outputs:
  - id: converted_file
    type: File
    doc: The converted output file.
    outputBinding:
      glob: $(inputs.output_file)
  - id: log_file
    type:
      - 'null'
      - File
    doc: PGDSpider log file written to the working directory.
    outputBinding:
      glob: PGDSpider-cli.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgdspider:2.1.1.5--hdfd78af_1
