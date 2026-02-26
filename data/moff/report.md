# moff CWL Generation Report

## moff_moff_all.py

### Tool Description
moFF match between run and apex module input parameter

### Metadata
- **Docker Image**: quay.io/biocontainers/moff:2.0.3--4
- **Homepage**: https://github.com/compomics/moFF
- **Package**: https://anaconda.org/channels/bioconda/packages/moff/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/moff/overview
- **Total Downloads**: 33.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/compomics/moFF
- **Stars**: N/A
### Original Help Text
```text
No module named 'brainpy._c.composition'
usage: moff_all.py [-h] [--loc_in LOC_IN]
                   [--tsv_list [TSV_LIST [TSV_LIST ...]]]
                   [--raw_list [RAW_LIST [RAW_LIST ...]]] [--sample SAMPLE]
                   [--ext EXT] [--log_label LOG_LABEL] [--w_filt W_FILT]
                   [--out_flag] [--w_comb] [--tol TOL]
                   [--xic_length XIC_LENGTH] [--rt_peak_win RT_PEAK_WIN]
                   [--rt_peak_win_match RT_PEAK_WIN_MATCH]
                   [--raw_repo RAW_REPO] [--loc_out LOC_OUT]
                   [--rt_feat_file RT_FEAT_FILE] [--peptide_summary]
                   [--tag_pepsum TAG_PEPSUM] [--match_filter]
                   [--ptm_file PTM_FILE]
                   [--quantile_thr_filtering QUANTILE_THR_FILTERING]
                   [--sample_size SAMPLE_SIZE] [--mbr MBR] [--cpu CPU_NUM]

moFF match between run and apex module input parameter

optional arguments:
  -h, --help            show this help message and exit
  --loc_in LOC_IN       specify the folder of the input MS2 peptide list files
  --tsv_list [TSV_LIST [TSV_LIST ...]]
                        specify the mzid file as a list
  --raw_list [RAW_LIST [RAW_LIST ...]]
                        specify the raw file as a list
  --sample SAMPLE       specify witch replicated to use for mbr reg_exp are
                        valid
  --ext EXT             specify the file extentention of the input like.
                        Default value: txt
  --log_label LOG_LABEL
                        a label name to use for the log file. Default value:
                        moFF
  --w_filt W_FILT       width value of the filter k * mean(Dist_Malahobis).
                        Default value: 2
  --out_flag            if set, outliers for rt time allignment are filtered.
                        Default value: True
  --w_comb              if set, RT model combination is weighted using traing
                        model errors: Default value: False
  --tol TOL             specify the tollerance parameter in ppm. Default
                        value: 10
  --xic_length XIC_LENGTH
                        specify rt window for xic (minutes). Default value: 3
  --rt_peak_win RT_PEAK_WIN
                        specify the time windows for the peak (minutes).
                        Default value: 1
  --rt_peak_win_match RT_PEAK_WIN_MATCH
                        specify the time windows for the matched peptide peak
                        (minutes). Default value: 1.2
  --raw_repo RAW_REPO   specify the raw file repository
  --loc_out LOC_OUT     specify the folder output
  --rt_feat_file RT_FEAT_FILE
                        specify the file that contains the features to use in
                        the match-between-run RT prediction
  --peptide_summary     if set, export a peptide intesity summary tab-delited
                        file. Default value: False
  --tag_pepsum TAG_PEPSUM
                        a tag text used for peptide summary file name
                        (peptide_summary_intensity_ + tag + .tab ). Default
                        value: moFF_run
  --match_filter        If set, filtering on the matched peak is activated.
                        Default value: False
  --ptm_file PTM_FILE   name of json ptm file. default file ptm_setting.json
  --quantile_thr_filtering QUANTILE_THR_FILTERING
                        quantile value used to compute the filtering threshold
                        for the matched peak .Default value: 0.75
  --sample_size SAMPLE_SIZE
                        percentage of MS2 peptide used to estimated the
                        threshold. Default value: 0.20
  --mbr MBR             select the moFF workflow: on to run mbr + apex , off
                        to run only apex, only to run obnly mbr. Default
                        value: on
  --cpu CPU_NUM         number of cpu. as default value it will detect
                        automaticaly the CPU number in your machine.
```

