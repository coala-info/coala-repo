cwlVersion: v1.2
class: CommandLineTool
baseCommand: ionquant
label: ionquant
doc: "IonQuant: label-free and isobaric quantification of MS data using the PSM tables
  of Philosopher/MSFragger. A licence key must be passed with the --key argument; you
  can obtain it by agreeing to the terms at https://msfragger.arsci.com/ionquant/.\n\nTool
  homepage: https://github.com/Nesvilab/IonQuant"
inputs:
  - id: key
    type: string
    doc: License key
    inputBinding:
      position: 101
      prefix: --key
  - id: specdir
    type:
      - 'null'
      - type: array
        items: Directory
        inputBinding:
          prefix: --specdir
    doc: "Directory containing the spectral files (d/mzml/mzxml/raw/quantindex). One --specdir indicates one spectral directory and can have multiple --specdir."
    inputBinding:
      position: 101
  - id: perform_ms1quant
    type:
      - 'null'
      - int
    doc: "Perform MS1 quantification. 0 = no, 1 = yes. Default - 1"
    inputBinding:
      position: 101
      prefix: --perform-ms1quant
  - id: perform_isoquant
    type:
      - 'null'
      - int
    doc: "Perform isobaric labeling quantification. 0 = no, 1 = yes. Default - 0"
    inputBinding:
      position: 101
      prefix: --perform-isoquant
  - id: isotol
    type:
      - 'null'
      - float
    doc: "MS2 tolerance in ppm. Default - 10"
    inputBinding:
      position: 101
      prefix: --isotol
  - id: isolevel
    type:
      - 'null'
      - int
    doc: "Isobaric quantification level. 2 = MS2, 3 = MS3. Default - 2"
    inputBinding:
      position: 101
      prefix: --isolevel
  - id: isotype
    type:
      - 'null'
      - string
    doc: "Isobaric quantification type. Case insensitive. Support iTRAQ-4, iTRAQ-8, TMT-0, TMT-2, TMT-6, TMT-10, TMT-11, TMT-16, TMT-18, TMT-35, sCLIP-6, iBT-16, DiLeu-12, DiLeu-1, DeAla-13. Default - TMT-10"
    inputBinding:
      position: 101
      prefix: --isotype
  - id: annotation
    type:
      - 'null'
      - string
    doc: "Annotation file info for the isobaric quantification. Format - <path to psm.tsv>=<path to annotation file>. One --annotation indicates one annotation file and can have multiple --annotation. Default - <blank>"
    inputBinding:
      position: 101
      prefix: --annotation
  - id: site_reports
    type:
      - 'null'
      - int
    doc: "Generate site reports. 0 = no, 1 = yes. The psm.tsv need to have the modification localization modification columns. Default - 1"
    inputBinding:
      position: 101
      prefix: --site-reports
  - id: msstats
    type:
      - 'null'
      - int
    doc: "Generate MSstats input files. 0 = no, 1 = yes. Default - 0"
    inputBinding:
      position: 101
      prefix: --msstats
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. 0 = all logical cores. Default - 0"
    inputBinding:
      position: 101
      prefix: --threads
  - id: mztol
    type:
      - 'null'
      - float
    doc: "MS1 tolerance in PPM. Default - 10.0"
    inputBinding:
      position: 101
      prefix: --mztol
  - id: imtol
    type:
      - 'null'
      - float
    doc: "1/K0 tolerance. Default - 0.05"
    inputBinding:
      position: 101
      prefix: --imtol
  - id: rttol
    type:
      - 'null'
      - float
    doc: "Retention time tolerance. Unit - min. Default - 0.4"
    inputBinding:
      position: 101
      prefix: --rttol
  - id: psm
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --psm
    doc: "Path to Philosopher's psm.tsv. One --psm indicates one psm.tsv and can have multiple --psm."
    inputBinding:
      position: 101
  - id: multidir
    type:
      - 'null'
      - string
    doc: "Output directory for the multi-experimental result. Optional. Default - <blank>"
    inputBinding:
      position: 101
      prefix: --multidir
  - id: normalization
    type:
      - 'null'
      - int
    doc: "Normalize the intensities across all runs. Default - 1"
    inputBinding:
      position: 101
      prefix: --normalization
  - id: minisotopes
    type:
      - 'null'
      - int
    doc: "Minimum isotopes required in feature extraction. Default - 2"
    inputBinding:
      position: 101
      prefix: --minisotopes
  - id: minscans
    type:
      - 'null'
      - int
    doc: "Minimum MS1 scans required in feature extraction. Default - 3"
    inputBinding:
      position: 101
      prefix: --minscans
  - id: minions
    type:
      - 'null'
      - int
    doc: "Minimum ions required in quantifying proteins. Only for MaxLFQ intensity. Default - 1"
    inputBinding:
      position: 101
      prefix: --minions
  - id: excludemods
    type:
      - 'null'
      - string
    doc: "Excluded modifications in quantifying peptide sequences and proteins. Format - <amino acid><mass>;... Default - <blank>"
    inputBinding:
      position: 101
      prefix: --excludemods
  - id: maxlfq
    type:
      - 'null'
      - int
    doc: "Calculate MaxLFQ intensity. 0 = no, 1 = yes. Default - 1"
    inputBinding:
      position: 101
      prefix: --maxlfq
  - id: ibaq
    type:
      - 'null'
      - int
    doc: "[experimental] Calculate iBAQ intensity. The iBAQ intensity is normalized by the protein length, not the number of theoretical peptides. 0 = no, 1 = yes. Default - 0"
    inputBinding:
      position: 101
      prefix: --ibaq
  - id: minexps
    type:
      - 'null'
      - int
    doc: "Minimum experiments in picking an ion for quantifying proteins. Only for intensity, not for MaxLFQ intensity. Default - 1"
    inputBinding:
      position: 101
      prefix: --minexps
  - id: minfreq
    type:
      - 'null'
      - float
    doc: "Minimum required frequency of an ion being selected for protein quantification. Only for intensity, not for MaxLFQ intensity. Default - 0"
    inputBinding:
      position: 101
      prefix: --minfreq
  - id: tp
    type:
      - 'null'
      - int
    doc: "Number of ions used in quantifying each protein. If 0, using all ions. For intensity, not for MaxLFQ intensity. Default - 0"
    inputBinding:
      position: 101
      prefix: --tp
  - id: mbr
    type:
      - 'null'
      - int
    doc: "Perform match-between-runs. Default - 0"
    inputBinding:
      position: 101
      prefix: --mbr
  - id: mbrrttol
    type:
      - 'null'
      - float
    doc: "Retention time tolerance used in match-between-runs. Unit - min. Default - 1.0"
    inputBinding:
      position: 101
      prefix: --mbrrttol
  - id: mbrimtol
    type:
      - 'null'
      - float
    doc: "1/K0 tolerance used in match-between-runs. Default - 0.05"
    inputBinding:
      position: 101
      prefix: --mbrimtol
  - id: mbrtoprun
    type:
      - 'null'
      - int
    doc: "Maximum number of donor runs for each acceptor run. Default - 10"
    inputBinding:
      position: 101
      prefix: --mbrtoprun
  - id: mbrmincorr
    type:
      - 'null'
      - float
    doc: "Minimum correlation coefficient between a donor run and its acceptor run. Default - 0"
    inputBinding:
      position: 101
      prefix: --mbrmincorr
  - id: ionmobility
    type:
      - 'null'
      - int
    doc: "The data has ion mobility information or not (for conventional LC-MS data). Default - 0"
    inputBinding:
      position: 101
      prefix: --ionmobility
  - id: ionfdr
    type:
      - 'null'
      - float
    doc: "Transferred ion false discovery rate threshold. Default - 0.01"
    inputBinding:
      position: 101
      prefix: --ionfdr
  - id: peptidefdr
    type:
      - 'null'
      - float
    doc: "Transferred peptide false discovery rate threshold. Default - 1"
    inputBinding:
      position: 101
      prefix: --peptidefdr
  - id: proteinfdr
    type:
      - 'null'
      - float
    doc: "Transferred protein false discovery rate threshold. Default - 1"
    inputBinding:
      position: 101
      prefix: --proteinfdr
  - id: light
    type:
      - 'null'
      - string
    doc: "Light labelling mass. Format - <amino acids><mass>;<amino acids><mass>;... Optional. Default - <blank>"
    inputBinding:
      position: 101
      prefix: --light
  - id: medium
    type:
      - 'null'
      - string
    doc: "Medium labelling mass. Format - <amino acids><mass>;<amino acids><mass>;... Optional. Default - <blank>"
    inputBinding:
      position: 101
      prefix: --medium
  - id: heavy
    type:
      - 'null'
      - string
    doc: "Heavy labelling mass. Format - <amino acids><mass>;<amino acids><mass>;... Optional. Default - <blank>"
    inputBinding:
      position: 101
      prefix: --heavy
  - id: formula
    type:
      - 'null'
      - string
    doc: "List the formula of the modifications used in the data. Required if want to perform isotope-labeling quantification. Format - <chemical composition>;<chemical composition>... example - C(2)H(2)O;HO(3)P;2H(4)C(2). Default - <blank>"
    inputBinding:
      position: 101
      prefix: --formula
  - id: requantify
    type:
      - 'null'
      - int
    doc: "Re-quantify unidentified feature based on identified feature. Only activate when --light, --medium, or --heavy is not empty. Default - 1"
    inputBinding:
      position: 101
      prefix: --requantify
  - id: writeindex
    type:
      - 'null'
      - int
    doc: "Write indexed file on disk for further usage. 0 = no, 1 = yes. Default - 0"
    inputBinding:
      position: 101
      prefix: --writeindex
  - id: locprob
    type:
      - 'null'
      - float
    doc: "Localization probability threshold. Default - 0"
    inputBinding:
      position: 101
      prefix: --locprob
  - id: filelist
    type:
      - 'null'
      - File
    doc: "A file containing flags. Default - <blank>"
    inputBinding:
      position: 101
      prefix: --filelist
  - id: uniqueness
    type:
      - 'null'
      - int
    doc: "Peptide-protein uniqueness. 0 = unique+razor, 1 = unique only, 2 = all. Default - 0"
    inputBinding:
      position: 101
      prefix: --uniqueness
  - id: intensitymode
    type:
      - 'null'
      - int
    doc: "The mode to calculate the ion intensity. 0 = apex, 1 = area. Default - 0"
    inputBinding:
      position: 101
      prefix: --intensitymode
  - id: modlist
    type:
      - 'null'
      - File
    doc: "A file lists modification masses. Those masses are used to remove the mass discrepancy due to rounding errors. Default - <blank>"
    inputBinding:
      position: 101
      prefix: --modlist
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: multi_experiment_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for the multi-experiment results (only if multidir is given)
    outputBinding:
      glob: $(inputs.multidir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ionquant:1.11.9--py311hdfd78af_0
stdout: ionquant.out
