[ ]
[ ]

[Skip to content](#capcruncher.api.pileup)

CapCruncher Documentation

pileup

Initializing search

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

CapCruncher Documentation

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

* [Home](../../../..)
* [Installation](../../../../installation/)
* [Pipeline](../../../../pipeline/)
* [Cluster Setup](../../../../cluster_config/)
* [Hints and Tips](../../../../tips/)
* [Plotting CapCruncher output](../../../../plotting/)
* [CLI Reference](../../../../cli/)
* [x]

  API Reference

  API Reference
  + [x]

    capcruncher

    capcruncher
    - [x]

      api

      api
      * [annotate](../annotate/)
      * [deduplicate](../deduplicate/)
      * [filter](../filter/)
      * [io](../io/)
      * [ ]

        pileup

        [pileup](./)

        Table of contents
        + [pileup](#capcruncher.api.pileup)
        + [CoolerBedGraph](#capcruncher.api.pileup.CoolerBedGraph)

          - [reporters](#capcruncher.api.pileup.CoolerBedGraph.reporters)
          - [\_\_init\_\_](#capcruncher.api.pileup.CoolerBedGraph.__init__)
      * [plotting](../plotting/)
      * [statistics](../statistics/)
      * [storage](../storage/)

Table of contents

* [pileup](#capcruncher.api.pileup)
* [CoolerBedGraph](#capcruncher.api.pileup.CoolerBedGraph)

  + [reporters](#capcruncher.api.pileup.CoolerBedGraph.reporters)
  + [\_\_init\_\_](#capcruncher.api.pileup.CoolerBedGraph.__init__)

# pileup

## `CoolerBedGraph` [¶](#capcruncher.api.pileup.CoolerBedGraph "Permanent link")

Generates a bedgraph file from a cooler file created by interactions-store.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `cooler` | `Cooler` | Cooler file to use for bedgraph production |
| `capture_name` | `str` | Name of capture probe being processed. |
| `sparse` | `bool` | Only output bins with interactions. |
| `only_cis` | `bool` | Only output cis interactions. |

Source code in `capcruncher/api/pileup.py`

|  |  |
| --- | --- |
| ```  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 ``` | ``` class CoolerBedGraph:     """Generates a bedgraph file from a cooler file created by interactions-store.      Attributes:      cooler (cooler.Cooler): Cooler file to use for bedgraph production      capture_name (str): Name of capture probe being processed.      sparse (bool): Only output bins with interactions.      only_cis (bool): Only output cis interactions.      """      def __init__(         self,         uri: str,         sparse: bool = True,         only_cis: bool = False,         region_to_limit: str = None,     ):         """         Args:             uri (str): Path to cooler group in hdf5 file.             sparse (bool, optional): Only output non-zero bins. Defaults to True.         """         self._sparse = sparse         self._only_cis = only_cis          logger.info(f"Reading {uri}")         self._cooler = cooler.Cooler(uri)         self.viewpoint_name = self._cooler.info["metadata"]["viewpoint_name"]         self._viewpoint_bins = self._cooler.info["metadata"]["viewpoint_bins"]          if len(self._viewpoint_bins) > 1:             self.multiple_viewpoint_bins = True             logger.warning(                 f"Viewpoint {self.viewpoint_name} has multiple bins! {self._viewpoint_bins}. Proceed with caution!"             )         else:             self.multiple_viewpoint_bins = False          self.viewpoint_chroms = self._cooler.info["metadata"]["viewpoint_chrom"]         self.n_cis_interactions = self._cooler.info["metadata"]["n_cis_interactions"]         logger.info(f"Processing {self.viewpoint_name}")          if only_cis:             pixels = []             bins = []             for chrom in self.viewpoint_chroms:                 _bins = self._cooler.bins().fetch(chrom)                 viewpoint_chrom_bins = self._bins["name"]                 _pixels = (                     self._cooler.pixels()                     .fetch(self.viewpoint_chroms)                     .query(                         "(bin1_id in @viewpoint_chrom_bins) and (bin2_id in @viewpoint_chrom_bins)"                     )                 )                 _bins = self._cooler.bins().fetch(chrom)                  pixels.append(_pixels)                 bins.append(_bins)              self._pixels = pd.concat(pixels)             self._bins = pd.concat(bins)          elif region_to_limit:             self._pixels = self._cooler.pixels().fetch(region_to_limit)             self._bins = self._cooler.bins().fetch(region_to_limit)          else:             self._pixels = self._cooler.pixels()[:]             # TODO: Avoid this if possible as reading all bins into memory             self._bins = self._cooler.bins()[:]          # Ensure name column is present         self._bins = (             self._bins.assign(name=lambda df: df.index)             if "name" not in self._bins.columns             else self._bins         )         self._reporters = None      def _get_reporters(self):         logger.info("Extracting reporters")         concat_ids = pd.concat([self._pixels["bin1_id"], self._pixels["bin2_id"]])         concat_ids_filt = concat_ids.loc[lambda ser: ser.isin(self._viewpoint_bins)]         pixels = self._pixels.loc[concat_ids_filt.index]          df_interactions = pd.DataFrame()         df_interactions["capture"] = np.where(             pixels["bin1_id"].isin(self._viewpoint_bins),             pixels["bin1_id"],             pixels["bin2_id"],         )          df_interactions["reporter"] = np.where(             pixels["bin1_id"].isin(self._viewpoint_bins),             pixels["bin2_id"],             pixels["bin1_id"],         )          df_interactions["count"] = pixels["count"].values          return df_interactions.sort_values(["capture", "reporter"]).reset_index(             drop=True         )      def extract_bedgraph(         self, normalisation: Literal["raw", "n_cis", "region"] = "raw", **norm_kwargs     ) -> pd.DataFrame:         logger.info("Generating bedgraph")         df_bdg = (             self._bins.merge(                 self.reporters,                 left_on="name",                 right_on="reporter",                 how="inner" if self._sparse else "outer",             )[["chrom", "start", "end", "count"]]             .assign(count=lambda df: df["count"].fillna(0))             .sort_values(["chrom", "start"])         )          # TODO: This is a hack to deal with multiple bins for a viewpoint         if self.multiple_viewpoint_bins:             gr_bdg = pr.PyRanges(                 df_bdg.rename(                     columns={"chrom": "Chromosome", "start": "Start", "end": "End"}                 )             )              df_bdg = (                 gr_bdg.cluster()                 .df.groupby("Cluster")                 .agg(                     {                         "count": "sum",                         "Start": "min",                         "End": "max",                         "Chromosome": "first",                     }                 )                 .reset_index()                 .rename(                     columns={"Start": "start", "End": "end", "Chromosome": "chrom"}                 )[["chrom", "start", "end", "count"]]             )          if not normalisation == "raw":             logger.info("Normalising bedgraph")             self._normalise_bedgraph(df_bdg, method=normalisation, **norm_kwargs)          return df_bdg      @property     def reporters(self) -> pd.DataFrame:         """Interactions with capture fragments/bins.          Returns:          pd.DataFrame: DataFrame containing just bins interacting with the capture probe.         """          if self._reporters is not None:             return self._reporters         else:             self._reporters = self._get_reporters()             return self._reporters      def _normalise_bedgraph(         self, bedgraph, scale_factor=1e6, method: str = "n_cis", region: str = None     ) -> pd.DataFrame:         """Normalises the bedgraph (in place).          Uses the number of cis interactions to normalise the bedgraph counts.          Args:          scale_factor (int, optional): Scaling factor for normalisation. Defaults to 1e6.          Returns:          pd.DataFrame: Normalised bedgraph formatted DataFrame         """          if method == "raw":             pass         elif method == "n_cis":             self._normalise_by_n_cis(bedgraph, scale_factor)         elif method == "region":             self._normalise_by_regions(bedgraph, scale_factor, region)      def _normalise_by_n_cis(self, bedgraph, scale_factor: float):         bedgraph["count"] = (bedgraph["count"] / self.n_cis_interactions) * scale_factor      def _normalise_by_regions(self, bedgraph, scale_factor: float, regions: str):         if not is_valid_bed(regions):             raise ValueError(                 "A valid bed file is required for region based normalisation"             )          df_viewpoint_norm_regions = pd.read_csv(             regions, sep="\t", names=["chrom", "start", "end", "name"]         )         df_viewpoint_norm_regions = df_viewpoint_norm_regions.loc[             lambda df: df["name"].str.contains(self.viewpoint_name)         ]          counts_in_regions = []         for region in df_viewpoint_norm_regions.itertuples():             counts_in_regions.append(                 bedgraph.query(                     "(chrom == @region.chrom) and (start >= @region.start) and (start <= @region.end)"                 )             )          df_counts_in_regions = pd.concat(counts_in_regions)         total_counts_in_region = df_counts_in_regions["count"].sum()          bedgraph["count"] = (bedgraph["count"] / total_counts_in_region) * scale_factor      def to_pyranges(         self, normalisation: Literal["raw", "n_cis", "region"] = "raw", **norm_kwargs     ):         return pr.PyRanges(             self.extract_bedgraph(                 normalisation=normalisation, norm_kwargs=norm_kwargs             ).rename(columns={"chrom": "Chromosome", "start": "Start", "end": "End"})         ) ``` |

### `reporters` `property` [¶](#capcruncher.api.pileup.CoolerBedGraph.reporters "Permanent link")

Interactions with capture fragments/bins.

Returns:

| Type | Description |
| --- | --- |
| `DataFrame` | pd.DataFrame: DataFrame containing just bins interacting with the capture probe. |

### `__init__(uri, sparse=True, only_cis=False, region_to_limit=None)` [¶](#capcruncher.api.pileup.CoolerBedGraph.__init__ "Permanent link")

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `uri` | `str` | Path to cooler group in hdf5 file. | *required* |
| `sparse` | `bool` | Only output non-zero bins. Defaults to True. | `True` |

Source code in `capcruncher/api/pileup.py`

|  |  |
| --- | --- |
| ``` 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 ``` | ``` def __init__(     self,     uri: str,     sparse: bool = True,     only_cis: bool = False,     region_to_limit: str = None, ):     """     Args:         uri (str): Path to cooler group in hdf5 file.         sparse (bool, optional): Only output non-zero bins. Defaults to True.     """     self._sparse = sparse     self._only_cis = only_cis      logger.info(f"Reading {uri}")     self._cooler = cooler.Cooler(uri)     self.viewpoint_name = self._cooler.info["metadata"]["viewpoint_name"]     self._viewpoint_bins = self._cooler.info["metadata"]["viewpoint_bins"]      if len(self._viewpoint_bins) > 1:         self.multiple_viewpoint_bins = True         logger.warning(             f"Viewpoint {self.viewpoint_name} has multiple bins! {self._viewpoint_bins}. Proceed with caution!"         )     else:         self.multiple_viewpoint_bins = False      self.viewpoint_chroms = self._cooler.info["metadata"]["viewpoint_chrom"]     self.n_cis_interactions = self._cooler.info["metadata"]["n_cis_interactions"]     logger.info(f"Processing {self.viewpoint_name}")      if only_cis:         pixels = []         bins = []         for chrom in self.viewpoint_chroms:             _bins = self._cooler.bins().fetch(chrom)             viewpoint_chrom_bins = self._bins["name"]             _pixels = (                 self._cooler.pixels()                 .fetch(self.viewpoint_chroms)                 .query(                     "(bin1_id in @viewpoint_chrom_bins) and (bin2_id in @viewpoint_chrom_bins)"                 )             )             _bins = self._cooler.bins().fetch(chrom)              pixels.append(_pixels)             bins.append(_bins)          self._pixels = pd.concat(pixels)         self._bins = pd.concat(bins)      elif region_to_limit:         self._pixels = self._cooler.pixels().fetch(region_to_limit)         self._bins = self._cooler.bins().fetch(region_to_limit)      else:         self._pixels = self._cooler.pixels()[:]         # TODO: Avoid this if possible as reading all bins into memory         self._bins = self._cooler.bins()[:]      # Ensure name column is present     self._bins = (         self._bins.assign(name=lambda df: df.index)         if "name" not in self._bins.columns         else self._bins     )     self._reporters = None ``` |

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)