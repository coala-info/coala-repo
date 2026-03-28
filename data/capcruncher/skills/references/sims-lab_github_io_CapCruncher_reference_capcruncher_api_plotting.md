[ ]
[ ]

[Skip to content](#capcruncher.api.plotting)

CapCruncher Documentation

plotting

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
      * [ ]

        plotting

        [plotting](./)

        Table of contents
        + [plotting](#capcruncher.api.plotting)
        + [CCBigWigCollection](#capcruncher.api.plotting.CCBigWigCollection)
        + [CCFigure](#capcruncher.api.plotting.CCFigure)

          - [add\_track](#capcruncher.api.plotting.CCFigure.add_track)
          - [add\_tracks](#capcruncher.api.plotting.CCFigure.add_tracks)
          - [from\_frame](#capcruncher.api.plotting.CCFigure.from_frame)
          - [from\_toml](#capcruncher.api.plotting.CCFigure.from_toml)
          - [plot](#capcruncher.api.plotting.CCFigure.plot)
          - [save](#capcruncher.api.plotting.CCFigure.save)
          - [to\_toml](#capcruncher.api.plotting.CCFigure.to_toml)
        + [CCTrack](#capcruncher.api.plotting.CCTrack)
      * [statistics](../statistics/)
      * [storage](../storage/)

Table of contents

* [plotting](#capcruncher.api.plotting)
* [CCBigWigCollection](#capcruncher.api.plotting.CCBigWigCollection)
* [CCFigure](#capcruncher.api.plotting.CCFigure)

  + [add\_track](#capcruncher.api.plotting.CCFigure.add_track)
  + [add\_tracks](#capcruncher.api.plotting.CCFigure.add_tracks)
  + [from\_frame](#capcruncher.api.plotting.CCFigure.from_frame)
  + [from\_toml](#capcruncher.api.plotting.CCFigure.from_toml)
  + [plot](#capcruncher.api.plotting.CCFigure.plot)
  + [save](#capcruncher.api.plotting.CCFigure.save)
  + [to\_toml](#capcruncher.api.plotting.CCFigure.to_toml)
* [CCTrack](#capcruncher.api.plotting.CCTrack)

# plotting

## `CCBigWigCollection` [¶](#capcruncher.api.plotting.CCBigWigCollection "Permanent link")

Bases: `Track`

Source code in `capcruncher/api/plotting.py`

|  |  |
| --- | --- |
| ``` 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 ``` | ``` class CCBigWigCollection(Track):     DEFAULT_PROPERTIES = {         "style": "line",         "fmt": "-",         "line_width": 2.0,         "size": 10,         "color": "#a6cee3",         "threshold_color": "#ff9c9c",         "threshold": "inf",         "cmap": "bwr",         "orientation": None,         "data_range_style": "y-axis",         "min_value": "auto",         "max_value": "auto",     }      def __init__(self, file: list, exclusions: str = None, **kwargs):         self.file_names = file         self.exclusions = exclusions         self.bws = [cb.BigWig(str(fn)) for fn in file]         self.properties = {"files": self.file_names}         self.properties.update(CCBigWigCollection.DEFAULT_PROPERTIES.copy())         self.properties.update(kwargs)         self.properties["name"] = f"BigWigCollection.{self.properties.get('title')}"         super(CCBigWigCollection, self).__init__(**self.properties)          self.coverages = []          # load features from global feature stack         features_stack = get_feature_stack()         for features in features_stack:             self.properties.update(features.properties)          # load coverages from global coverages stack         coverage_stack = get_coverage_stack()         for coverage in coverage_stack:             self.coverages.append(coverage)      def _correct_genomic_range(self, gr: cb.GenomeRange, bw: cb.BigWig):         """         Corrects the genomic range to use the same chromosome style as the BigWig file.         """          import re          bw_chromosomes = list(bw.bw.chromsizes())          if re.match(r'^chr.*', bw_chromosomes[0]) and not re.match(r'^chr.*', gr.chrom):             gr.chrom = f"chr{gr.chrom}"         elif not re.match(r'^chr.*', bw_chromosomes[0]) and re.match(r'^chr.*', gr.chrom):             gr.chrom = gr.chrom[3:]          return gr       def fetch_data(self, gr, **kwargs):         datasets = []         for bw in self.bws:             gr = self._correct_genomic_range(gr, bw)             bw_data = bw.fetch_intervals(gr.chrom, gr.start, gr.end)             bw_data = bw_data.set_index(["chrom", "start", "end"])             bw_data = bw_data.rename(columns={"value": os.path.basename(bw.properties["file"])})             datasets.append(bw_data)          df = datasets[0].join(datasets[1:])         df_summary = df.assign(mean=df.mean(axis=1), sem=df.sem(axis=1)).reset_index()          intervals_to_bp = []         for interval in df_summary.itertuples():             interval_len = interval.end - interval.start              interval_positions = np.arange(interval_len) + interval.start             scores_mean = np.repeat(interval.mean, interval_len)             scores_sem = np.repeat(interval.sem, interval_len)              intervals_to_bp.append(                 np.vstack([interval_positions, scores_mean, scores_sem]).T             )          df_intervals = pd.DataFrame(             np.concatenate(intervals_to_bp), columns=["bp", "mean", "sem"]         )          if self.exclusions:             df_intervals = pd.concat(                 [df_intervals, self.fetch_exluded_regions(gr)]             ).sort_values("bp")          if self.properties.get("smooth_window"):             from scipy.signal import savgol_filter              df_intervals["mean_smoothed"] = savgol_filter(                 df_intervals["mean"],                 window_length=self.properties.get("smooth_window", 1001),                 polyorder=self.properties.get("polyorder", 1),             )          return df_intervals      def fetch_exluded_regions(self, gr):         excluded_tabix = BedTool(self.exclusions).tabix(force=True)         df_excluded = excluded_tabix.tabix_intervals(             f"{gr.chrom}:{gr.start}-{gr.end}"         ).to_dataframe()          intervals_to_bp = []         for interval in df_excluded.itertuples():             interval_len = interval.end - interval.start              interval_positions = np.arange(interval_len) + interval.start             scores_nan = np.repeat(np.nan, interval_len)             intervals_to_bp.append(interval_positions)          df_intervals = pd.Series(np.concatenate(intervals_to_bp)).to_frame("bp")         df_intervals["mean"] = np.nan         df_intervals["sem"] = np.nan          return df_intervals      def plot(self, ax, gr, **kwargs):         data = self.fetch_data(gr, **kwargs)          line_width = self.properties.get("line_width", 1)         color = self.properties.get("color", "blue")         alpha = self.properties.get("alpha", 0.2)         downsample = self.properties.get("downsample", 0)          if downsample:             rows = np.arange(0, data.shape[0], downsample)             data = data.iloc[rows]          if self.properties.get("smooth_window"):             scores = data["mean_smoothed"]         else:             scores = data["mean"]          ax.fill_between(             data["bp"],             scores - data["sem"],             scores + data["sem"],             alpha=alpha,             color=color,             zorder=0,         )          ax.plot(             data["bp"],             scores,             color=color,             zorder=1,         )          min_val = self.properties.get("min_value")         max_val = self.properties.get("max_value")          ymin = round(scores.min()) if min_val == "auto" else min_val         ymax = round(scores.max() + data["sem"].max()) if max_val == "auto" else max_val          ax.set_xlim(gr.start, gr.end)         ax.set_ylim(ymin, ymax)          self.plot_data_range(ax, ymin, ymax, self.properties["data_range_style"], gr)         self.plot_label()      def plot_data_range(self, ax, ymin, ymax, data_range_style, gr: cb.GenomeRange):         if data_range_style == "text":             self.plot_text_range(ax, ymin, ymax, gr)         else:  # 'y-axis' style             try:                 y_ax = self.y_ax                 self.plot_yaxis_range(ax, y_ax)             except AttributeError:                 self.plot_data_range(ax, ymin, ymax, "text", gr)      def plot_yaxis_range(self, plot_axis, y_ax):         # """         # Plot the scale of the y axis with respect to the plot_axis         # plot something that looks like this:         # ymax ┐         #      │         #      │         # ymin ┘         # Parameters         # ----------         # plot_axis : matplotlib.axes.Axes         #     Main plot axis.         # y_ax : matplotlib.axes.Axes         #     Axis to use to plot the scale         # """          if (             "show_data_range" in self.properties             and self.properties["show_data_range"] == "no"         ):             return          def value_to_str(value):             if value % 1 == 0:                 return str(int(value))             else:                 return f"{value:.4f}" if value < 0.01 else f"{value:.2f}"          ymin, ymax = plot_axis.get_ylim()          ymax_str = value_to_str(ymax)         ymin_str = value_to_str(ymin)         x_pos = [0, 0.5, 0.5, 0]         y_pos = [0.01, 0.01, 0.99, 0.99]         y_ax.plot(x_pos, y_pos, color="black", linewidth=1, transform=y_ax.transAxes)         y_ax.text(             -0.2,             -0.01,             ymin_str,             verticalalignment="bottom",             horizontalalignment="right",             transform=y_ax.transAxes,         )         y_ax.text(             -0.2,             1,             ymax_str,             verticalalignment="top",             horizontalalignment="right",             transform=y_ax.transAxes,         )         y_ax.patch.set_visible(False)      def plot_text_range(self, ax, ymin, ymax, gr: cb.GenomeRange):         ydelta = ymax - ymin          # set min max         def format_lim(lim):             return int(lim) if float(lim) % 1 == 0 else f"{lim:.2f}"          ymax_print = format_lim(ymax)         ymin_print = format_lim(ymin)         small_x = 0.01 * gr.length         # by default show the data range         ax.text(             gr.start - small_x,             ymax - ydelta * 0.2,             f"[ {ymin_print} ~ {ymax_print} ]",             horizontalalignment="left",             verticalalignment="top",         ) ``` |

## `CCFigure` [¶](#capcruncher.api.plotting.CCFigure "Permanent link")

Generates a figure from a list of tracks

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `tracks` | `List[[CCTrack](#capcruncher.api.plotting.CCTrack "CCTrack (capcruncher.api.plotting.CCTrack)")]` | List of tracks to plot. Defaults to None. | `None` |
| `auto_spacing` | `bool` | Automatically add a spacer track between each track. Defaults to False. | `False` |
| `**kwargs` |  | Additional arguments to pass to the figure | `{}` |

Source code in `capcruncher/api/plotting.py`

|  |  |
| --- | --- |
| ``` 1048 1049 1050 1051 1052 1053 1054 1055 1056 1057 1058 1059 1060 1061 1062 1063 1064 1065 1066 1067 1068 1069 1070 1071 1072 1073 1074 1075 1076 1077 1078 1079 1080 1081 1082 1083 1084 1085 1086 1087 1088 1089 1090 1091 1092 1093 1094 1095 1096 1097 1098 1099 1100 1101 1102 1103 1104 1105 1106 1107 1108 1109 1110 1111 1112 1113 1114 1115 1116 1117 1118 1119 1120 1121 1122 1123 1124 1125 1126 1127 1128 1129 1130 1131 1132 1133 1134 1135 1136 1137 1138 1139 1140 1141 1142 1143 1144 1145 1146 1147 1148 1149 1150 1151 1152 1153 1154 1155 1156 1157 1158 1159 1160 1161 1162 1163 1164 1165 1166 1167 1168 1169 1170 1171 1172 1173 1174 1175 1176 1177 1178 1179 1180 1181 1182 1183 1184 1185 1186 1187 1188 1189 1190 1191 1192 1193 1194 1195 1196 1197 1198 1199 1200 1201 1202 1203 1204 1205 1206 1207 1208 1209 1210 1211 1212 1213 1214 1215 1216 1217 1218 1219 1220 1221 1222 1223 ``` | ``` class CCFigure:     """     Generates a figure from a list of tracks      Args:         tracks (List[CCTrack], optional): List of tracks to plot. Defaults to None.         auto_spacing (bool, optional): Automatically add a spacer track between each track. Defaults to False.         **kwargs: Additional arguments to pass to the figure     """      def __init__(         self, tracks: List[CCTrack] = None, auto_spacing: bool = False, **kwargs     ) -> None:         self.frame = cb.Frame()         self.auto_spacing = auto_spacing         self.properties = dict()         self.properties.update(kwargs)          if tracks:             self.tracks = set(tracks)             self.add_tracks(tracks)         else:             self.tracks = set()      def add_track(self, track: CCTrack) -> None:         """         Add a track to the figure          Args:             track (CCTrack): Track to add         """         self.tracks.add(track)         self.frame.add_track(track.get_track())      def add_tracks(self, tracks: List[CCTrack]) -> None:         """         Add a list of tracks to the figure          Args:             tracks (List[CCTrack]): List of tracks to add         """         for track in tracks:             if self.auto_spacing:                 spacer = CCTrack(None, file_type="spacer")                 self.add_track(spacer.get_track())              self.add_track(track)      def plot(         self,         gr: Union[str, GenomeRange],         gr2: Union[str, GenomeRange] = None,         show: bool = True,         **kwargs,     ) -> None:         """         Plot the figure          Args:             gr (Union[str, GenomeRange]): GenomeRange to plot             gr2 (Union[str, GenomeRange], optional): Second GenomeRange to plot. Defaults to None.             show (bool, optional): Show the figure. Defaults to T