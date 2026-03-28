[ ]
[ ]

[Skip to content](#capcruncher.api.storage)

CapCruncher Documentation

storage

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
      * [pileup](../pileup/)
      * [plotting](../plotting/)
      * [statistics](../statistics/)
      * [ ]

        storage

        [storage](./)

        Table of contents
        + [storage](#capcruncher.api.storage)
        + [CoolerBinner](#capcruncher.api.storage.CoolerBinner)

          - [fragment\_to\_genomic\_mapping](#capcruncher.api.storage.CoolerBinner.fragment_to_genomic_mapping)
          - [fragment\_to\_genomic\_table](#capcruncher.api.storage.CoolerBinner.fragment_to_genomic_table)
          - [pixels](#capcruncher.api.storage.CoolerBinner.pixels)
          - [viewpoint\_bins](#capcruncher.api.storage.CoolerBinner.viewpoint_bins)
        + [Viewpoint](#capcruncher.api.storage.Viewpoint)

          - [coords](#capcruncher.api.storage.Viewpoint.coords)
          - [bins](#capcruncher.api.storage.Viewpoint.bins)
          - [bins\_cis](#capcruncher.api.storage.Viewpoint.bins_cis)
          - [from\_bed](#capcruncher.api.storage.Viewpoint.from_bed)
        + [create\_cooler\_cc](#capcruncher.api.storage.create_cooler_cc)
        + [get\_merged\_cooler\_metadata](#capcruncher.api.storage.get_merged_cooler_metadata)
        + [link\_common\_cooler\_tables](#capcruncher.api.storage.link_common_cooler_tables)
        + [merge\_coolers](#capcruncher.api.storage.merge_coolers)

Table of contents

* [storage](#capcruncher.api.storage)
* [CoolerBinner](#capcruncher.api.storage.CoolerBinner)

  + [fragment\_to\_genomic\_mapping](#capcruncher.api.storage.CoolerBinner.fragment_to_genomic_mapping)
  + [fragment\_to\_genomic\_table](#capcruncher.api.storage.CoolerBinner.fragment_to_genomic_table)
  + [pixels](#capcruncher.api.storage.CoolerBinner.pixels)
  + [viewpoint\_bins](#capcruncher.api.storage.CoolerBinner.viewpoint_bins)
* [Viewpoint](#capcruncher.api.storage.Viewpoint)

  + [coords](#capcruncher.api.storage.Viewpoint.coords)
  + [bins](#capcruncher.api.storage.Viewpoint.bins)
  + [bins\_cis](#capcruncher.api.storage.Viewpoint.bins_cis)
  + [from\_bed](#capcruncher.api.storage.Viewpoint.from_bed)
* [create\_cooler\_cc](#capcruncher.api.storage.create_cooler_cc)
* [get\_merged\_cooler\_metadata](#capcruncher.api.storage.get_merged_cooler_metadata)
* [link\_common\_cooler\_tables](#capcruncher.api.storage.link_common_cooler_tables)
* [merge\_coolers](#capcruncher.api.storage.merge_coolers)

# storage

## `CoolerBinner` [¶](#capcruncher.api.storage.CoolerBinner "Permanent link")

Source code in `capcruncher/api/storage.py`

|  |  |
| --- | --- |
| ``` 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 ``` | ``` class CoolerBinner:     def __init__(         self,         cooler_group: os.PathLike,         binsize: int = None,         method: Union[Literal["overlap"], Literal["midpoint"]] = "midpoint",         minimum_overlap: float = 0.51,         n_cis_interaction_correction: bool = True,         n_rf_per_bin_correction: bool = True,         scale_factor: int = 1_000_000,         assay: Literal["capture", "tri", "tiled"] = "capture",     ) -> None:         self.cooler_group = cooler_group         self.binsize = binsize         self.method = method         self.minimum_overlap = minimum_overlap          if isinstance(cooler_group, str):             self.cooler = cooler.Cooler(cooler_group)         elif isinstance(cooler_group, cooler.Cooler):             self.cooler = cooler_group         else:             raise ValueError(                 "cooler_group must be a path to a cooler file or a cooler object"             )          self.n_cis_interactions = self.cooler.info["metadata"]["n_cis_interactions"]         self.n_cis_interaction_correction = n_cis_interaction_correction         self.n_restriction_fragment_correction = n_rf_per_bin_correction         self.scale_factor = scale_factor         self.assay = assay      @functools.cached_property     def genomic_bins(self) -> pr.PyRanges:         return (             cooler.binnify(binsize=self.binsize, chromsizes=self.cooler.chromsizes)             .sort_values(by=["chrom", "start", "end"])             .assign(                 genomic_bin_id=lambda df: df.reset_index(drop=True)                 .index.to_series()                 .values             )             .rename(columns={"chrom": "Chromosome", "start": "Start", "end": "End"})             .pipe(pr.PyRanges)         )      @functools.cached_property     def fragment_bins(self):         return (             self.cooler.bins()[:]             .rename(                 columns={                     "chrom": "Chromosome",                     "start": "Start",                     "end": "End",                     "name": "fragment_id",                 }             )             .pipe(pr.PyRanges)         )      @functools.cached_property     def fragment_to_genomic_table(self) -> pr.PyRanges:         """         Translate genomic bins to fragment bins         """          fragment_bins = self.fragment_bins          if self.method == "midpoint":             fragment_bins = (                 fragment_bins.as_df()                 .assign(                     Start=lambda df: df["Start"] + (df["End"] - df["Start"]) / 2,                     End=lambda df: df["Start"] + 1,                 )                 .pipe(pr.PyRanges)             )          pr_fragment_to_bins = self.genomic_bins.join(             fragment_bins, strandedness=0, how=None, report_overlap=True         )          if self.method == "overlap":             pr_fragment_to_bins = pr_fragment_to_bins[                 pr_fragment_to_bins["Overlap"] >= self.minimum_overlap             ]          # Add number of fragments per bin         pr_fragment_to_bins = pr_fragment_to_bins.assign(             "n_fragments_per_bin",             lambda df: df.groupby("genomic_bin_id")["fragment_id"].transform("nunique"),         )          return pr_fragment_to_bins      @functools.cached_property     def fragment_to_genomic_mapping(self) -> Dict[int, int]:         """         Translate genomic bins to fragment bins         """         fragment_to_bins_mapping = (             self.fragment_to_genomic_table.as_df()             .set_index("fragment_id")["genomic_bin_id"]             .to_dict()         )         return fragment_to_bins_mapping      @functools.cached_property     def pixels(self) -> pd.DataFrame:         """         Translate fragment pixels to genomic pixels         """          fragment_to_bins_mapping = self.fragment_to_genomic_mapping          pixels = self.cooler.pixels()[:].assign(             genomic_bin1_id=lambda df: df["bin1_id"].map(fragment_to_bins_mapping),             genomic_bin2_id=lambda df: df["bin2_id"].map(fragment_to_bins_mapping),         )          # Sum the counts of pixels that map to the same genomic bins         pixels = (             pixels.groupby(["genomic_bin1_id", "genomic_bin2_id"])             .agg(                 count=("count", "sum"),             )             .reset_index()         )          # Normalize pixels if specified         if self.n_restriction_fragment_correction:             n_fragments_per_bin = (                 self.fragment_to_genomic_table.as_df()                 .set_index("genomic_bin_id")["n_fragments_per_bin"]                 .to_dict()             )             pixels = pixels.assign(                 n_fragments_per_bin1=lambda df: df["genomic_bin1_id"].map(                     n_fragments_per_bin                 ),                 n_fragments_per_bin2=lambda df: df["genomic_bin2_id"].map(                     n_fragments_per_bin                 ),                 n_fragments_per_bin_correction=lambda df: (                     df["n_fragments_per_bin1"] + df["n_fragments_per_bin2"]                 ),                 count_n_rf_norm=lambda df: df["count"]                 / df["n_fragments_per_bin_correction"],             )          if self.n_cis_interaction_correction:             pixels = pixels.assign(                 count_n_cis_norm=lambda df: (df["count"] / self.n_cis_interactions)                 * self.scale_factor,             )          if self.n_cis_interaction_correction and self.n_restriction_fragment_correction:             pixels = pixels.assign(                 count_n_cis_rf_norm=lambda df: (                     pixels["count_n_rf_norm"] / self.n_cis_interactions                 )                 * self.scale_factor             )          return pixels      @functools.cached_property     def viewpoint_bins(self) -> List[int]:         """         Return list of viewpoint bins         """          pr_viewpoint = pr.from_dict(             dict(                 zip(                     ["Chromosome", "Start", "End"],                     [                         [                             x,                         ]                         for x in re.split(                             ":|-", self.cooler.info["metadata"]["viewpoint_coords"][0]                         )                     ],                 )             )         )          return pr_viewpoint.join(self.genomic_bins).df["genomic_bin_id"].to_list()      def to_cooler(self, store: os.PathLike):         metadata = {**self.cooler.info["metadata"]}         metadata["viewpoint_bins"] = [int(x) for x in self.viewpoint_bins]         metadata["n_interactions_total"] = int(self.cooler.pixels()[:]["count"].sum())         cooler_fn = f"{store}::/{metadata['viewpoint_name']}/resolutions/{self.binsize}"          pixels = (             self.pixels.drop(                 columns=[                     "bin1_id",                     "bin2_id",                     "n_fragments_per_bin1",                     "n_fragments_per_bin2",                     "n_fragments_per_bin_correction",                 ],                 errors="ignore",             )             .rename(                 columns={"genomic_bin1_id": "bin1_id", "genomic_bin2_id": "bin2_id"}             )             .loc[:, lambda df: ["bin1_id", "bin2_id", "count", *df.columns[3:]]]             .sort_values(by=["bin1_id", "bin2_id"])         )          bins = (             self.genomic_bins.df.rename(                 columns={"Chromosome": "chrom", "Start": "start", "End": "end"}             )             .sort_values("genomic_bin_id")             .assign(bin_id=lambda df: df["genomic_bin_id"])             .set_index("genomic_bin_id")         )          cooler.create_cooler(             cooler_fn,             bins=bins,             pixels=pixels,             metadata=metadata,             mode="w" if not os.path.exists(store) else "a",             columns=pixels.columns[2:],             dtypes=dict(zip(pixels.columns[2:], ["float32"] * len(pixels.columns[2:]))),             ensure_sorted=True,             ordered=True,         )          return cooler_fn ``` |

### `fragment_to_genomic_mapping` `cached` `property` [¶](#capcruncher.api.storage.CoolerBinner.fragment_to_genomic_mapping "Permanent link")

Translate genomic bins to fragment bins

### `fragment_to_genomic_table` `cached` `property` [¶](#capcruncher.api.storage.CoolerBinner.fragment_to_genomic_table "Permanent link")

Translate genomic bins to fragment bins

### `pixels` `cached` `property` [¶](#capcruncher.api.storage.CoolerBinner.pixels "Permanent link")

Translate fragment pixels to genomic pixels

### `viewpoint_bins` `cached` `property` [¶](#capcruncher.api.storage.CoolerBinner.viewpoint_bins "Permanent link")

Return list of viewpoint bins

## `Viewpoint` [¶](#capcruncher.api.storage.Viewpoint "Permanent link")

Source code in `capcruncher/api/storage.py`

|  |  |
| --- | --- |
| ```  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 ``` | ``` class Viewpoint:     def __init__(         self, coordinates: pr.PyRanges, assay: Literal["capture", "tri", "tiled"]     ) -> None:         self.coordinates = coordinates         self.assay = assay      @classmethod     def from_bed(         cls, bed: str, viewpoint: str, assay: Literal["capture", "tri", "tiled"]     ):         """         Creates a viewpoint object from a bed file.          Args:             bed (str): Path to bed file containing viewpoint coordinates.             viewpoint (str): Name of viewpoint to extract from bed file.          Raises:             IndexError: Oligo name cannot be found within viewpoints.          Returns:             Viewpoint: Viewpoint object.         """         gr_viewpoints = pr.read_bed(bed)         df_viewpoints = gr_viewpoints.as_df()          df_viewpoints = df_viewpoints.loc[             lambda df: df["Name"].str.contains(f"{viewpoint}$")         ]          if df_viewpoints.empty:             raise IndexError(                 f"Oligo name cannot be found within viewpoints: {viewpoint}"             )          return Viewpoint(df_viewpoints.pipe(pr.PyRanges), assay=assay)      def bins(self, bins: pr.PyRanges):         """         Returns the bins that overlap with the viewpoint.          Args:             bins (pr.PyRanges): PyRanges object containing all bins.          Returns:             pr.PyRanges: PyRanges object contain