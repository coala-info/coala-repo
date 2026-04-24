cwlVersion: v1.2
class: CommandLineTool
baseCommand: moff_all.py
label: moff_moff_all.py
doc: "moFF match between run and apex module input parameter\n\nTool homepage: https://github.com/compomics/moFF"
inputs:
  - id: cpu_num
    type:
      - 'null'
      - int
    doc: number of cpu. as default value it will detect automaticaly the CPU 
      number in your machine.
    inputBinding:
      position: 101
      prefix: --cpu
  - id: ext
    type:
      - 'null'
      - string
    doc: specify the file extentention of the input like.
    inputBinding:
      position: 101
      prefix: --ext
  - id: loc_in
    type:
      - 'null'
      - Directory
    doc: specify the folder of the input MS2 peptide list files
    inputBinding:
      position: 101
      prefix: --loc_in
  - id: loc_out
    type:
      - 'null'
      - Directory
    doc: specify the folder output
    inputBinding:
      position: 101
      prefix: --loc_out
  - id: log_label
    type:
      - 'null'
      - string
    doc: a label name to use for the log file.
    inputBinding:
      position: 101
      prefix: --log_label
  - id: match_filter
    type:
      - 'null'
      - boolean
    doc: If set, filtering on the matched peak is activated.
    inputBinding:
      position: 101
      prefix: --match_filter
  - id: mbr
    type:
      - 'null'
      - string
    doc: 'select the moFF workflow: on to run mbr + apex , off to run only apex, only
      to run obnly mbr.'
    inputBinding:
      position: 101
      prefix: --mbr
  - id: out_flag
    type:
      - 'null'
      - boolean
    doc: if set, outliers for rt time allignment are filtered.
    inputBinding:
      position: 101
      prefix: --out_flag
  - id: peptide_summary
    type:
      - 'null'
      - boolean
    doc: if set, export a peptide intesity summary tab-delited file.
    inputBinding:
      position: 101
      prefix: --peptide_summary
  - id: ptm_file
    type:
      - 'null'
      - File
    doc: name of json ptm file. default file ptm_setting.json
    inputBinding:
      position: 101
      prefix: --ptm_file
  - id: quantile_thr_filtering
    type:
      - 'null'
      - float
    doc: quantile value used to compute the filtering threshold for the matched 
      peak .
    inputBinding:
      position: 101
      prefix: --quantile_thr_filtering
  - id: raw_list
    type:
      - 'null'
      - type: array
        items: File
    doc: specify the raw file as a list
    inputBinding:
      position: 101
      prefix: --raw_list
  - id: raw_repo
    type:
      - 'null'
      - Directory
    doc: specify the raw file repository
    inputBinding:
      position: 101
      prefix: --raw_repo
  - id: rt_feat_file
    type:
      - 'null'
      - File
    doc: specify the file that contains the features to use in the 
      match-between-run RT prediction
    inputBinding:
      position: 101
      prefix: --rt_feat_file
  - id: rt_peak_win
    type:
      - 'null'
      - float
    doc: specify the time windows for the peak (minutes).
    inputBinding:
      position: 101
      prefix: --rt_peak_win
  - id: rt_peak_win_match
    type:
      - 'null'
      - float
    doc: specify the time windows for the matched peptide peak (minutes).
    inputBinding:
      position: 101
      prefix: --rt_peak_win_match
  - id: sample
    type:
      - 'null'
      - string
    doc: specify witch replicated to use for mbr reg_exp are valid
    inputBinding:
      position: 101
      prefix: --sample
  - id: sample_size
    type:
      - 'null'
      - float
    doc: percentage of MS2 peptide used to estimated the threshold.
    inputBinding:
      position: 101
      prefix: --sample_size
  - id: tag_pepsum
    type:
      - 'null'
      - string
    doc: a tag text used for peptide summary file name 
      (peptide_summary_intensity_ + tag + .tab ).
    inputBinding:
      position: 101
      prefix: --tag_pepsum
  - id: tol
    type:
      - 'null'
      - int
    doc: specify the tollerance parameter in ppm.
    inputBinding:
      position: 101
      prefix: --tol
  - id: tsv_list
    type:
      - 'null'
      - type: array
        items: File
    doc: specify the mzid file as a list
    inputBinding:
      position: 101
      prefix: --tsv_list
  - id: w_comb
    type:
      - 'null'
      - boolean
    doc: 'if set, RT model combination is weighted using traing model errors:'
    inputBinding:
      position: 101
      prefix: --w_comb
  - id: w_filt
    type:
      - 'null'
      - float
    doc: width value of the filter k * mean(Dist_Malahobis).
    inputBinding:
      position: 101
      prefix: --w_filt
  - id: xic_length
    type:
      - 'null'
      - float
    doc: specify rt window for xic (minutes).
    inputBinding:
      position: 101
      prefix: --xic_length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moff:2.0.3--4
stdout: moff_moff_all.py.out
