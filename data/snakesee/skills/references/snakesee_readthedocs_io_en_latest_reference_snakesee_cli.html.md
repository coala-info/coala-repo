[ ]
[ ]

[Skip to content](#snakesee.cli)

snakesee

cli

Initializing search

[GitHub](https://github.com/nh13/snakesee "Go to repository")

snakesee

[GitHub](https://github.com/nh13/snakesee "Go to repository")

* [snakesee](../../index.html)
* [Snakesee Architecture](../../architecture.html)
* [Installation](../../installation.html)
* [Usage](../../usage.html)
* [x]

  Reference

  Reference
  + [x]

    [snakesee](index.html)

    snakesee
    - [ ]

      cli

      [cli](cli.html)

      Table of contents
      * [cli](#snakesee.cli)
      * [Classes](#snakesee.cli-classes)
      * [Functions](#snakesee.cli-functions)

        + [log\_handler\_path](#snakesee.cli.log_handler_path)
        + [main](#snakesee.cli.main)
        + [profile\_export](#snakesee.cli.profile_export)
        + [profile\_show](#snakesee.cli.profile_show)
        + [status](#snakesee.cli.status)
        + [watch](#snakesee.cli.watch)
    - [constants](constants.html)
    - [ ]

      [estimation](estimation/index.html)

      estimation
      * [data\_loader](estimation/data_loader.html)
      * [estimator](estimation/estimator.html)
      * [pending\_inferrer](estimation/pending_inferrer.html)
      * [rule\_matcher](estimation/rule_matcher.html)
    - [estimator](estimator.html)
    - [events](events.html)
    - [exceptions](exceptions.html)
    - [formatting](formatting.html)
    - [log\_handler\_script](log_handler_script.html)
    - [logging](logging.html)
    - [models](models.html)
    - [parameter\_validation](parameter_validation.html)
    - [ ]

      [parser](parser/index.html)

      parser
      * [core](parser/core.html)
      * [failure\_tracker](parser/failure_tracker.html)
      * [file\_position](parser/file_position.html)
      * [job\_tracker](parser/job_tracker.html)
      * [line\_parser](parser/line_parser.html)
      * [log\_reader](parser/log_reader.html)
      * [metadata](parser/metadata.html)
      * [patterns](parser/patterns.html)
      * [stats](parser/stats.html)
      * [utils](parser/utils.html)
    - [ ]

      [plugins](plugins/index.html)

      plugins
      * [base](plugins/base.html)
      * [bwa](plugins/bwa.html)
      * [discovery](plugins/discovery.html)
      * [fastp](plugins/fastp.html)
      * [fgbio](plugins/fgbio.html)
      * [loader](plugins/loader.html)
      * [registry](plugins/registry.html)
      * [samtools](plugins/samtools.html)
      * [star](plugins/star.html)
    - [profile](profile.html)
    - [ ]

      [state](state/index.html)

      state
      * [clock](state/clock.html)
      * [config](state/config.html)
      * [job\_registry](state/job_registry.html)
      * [paths](state/paths.html)
      * [rule\_registry](state/rule_registry.html)
      * [workflow\_state](state/workflow_state.html)
    - [state\_comparison](state_comparison.html)
    - [ ]

      [tui](tui/index.html)

      tui
      * [monitor](tui/monitor.html)
    - [types](types.html)
    - [utils](utils.html)
    - [validation](validation.html)
    - [variance](variance.html)

Table of contents

* [cli](#snakesee.cli)
* [Classes](#snakesee.cli-classes)
* [Functions](#snakesee.cli-functions)

  + [log\_handler\_path](#snakesee.cli.log_handler_path)
  + [main](#snakesee.cli.main)
  + [profile\_export](#snakesee.cli.profile_export)
  + [profile\_show](#snakesee.cli.profile_show)
  + [status](#snakesee.cli.status)
  + [watch](#snakesee.cli.watch)

# cli

Command-line interface for Snakemake workflow monitoring.

## Classes[¶](#snakesee.cli-classes "Permanent link")

## Functions[¶](#snakesee.cli-functions "Permanent link")

### log\_handler\_path [¶](#snakesee.cli.log_handler_path "Permanent link")

```
log_handler_path() -> None
```

Print the path to the log handler script for Snakemake 8.x.

Use with: snakemake --log-handler-script $(snakesee log-handler-path) --cores 4

This enables real-time job tracking without requiring Snakemake 9+.

Source code in `snakesee/cli.py`

|  |  |
| --- | --- |
| ``` 319 320 321 322 323 324 325 326 327 328 329 ``` | ``` def log_handler_path() -> None:     """     Print the path to the log handler script for Snakemake 8.x.      Use with: snakemake --log-handler-script $(snakesee log-handler-path) --cores 4      This enables real-time job tracking without requiring Snakemake 9+.     """     from snakesee import LOG_HANDLER_SCRIPT      print(LOG_HANDLER_SCRIPT) ``` |

### main [¶](#snakesee.cli.main "Permanent link")

```
main() -> None
```

Entry point for the snakesee CLI.

Source code in `snakesee/cli.py`

|  |  |
| --- | --- |
| ``` 332 333 334 335 336 337 338 339 340 341 342 343 ``` | ``` def main() -> None:     """Entry point for the snakesee CLI."""     defopt.run(         {             "watch": watch,             "status": status,             "profile-export": profile_export,             "profile-show": profile_show,             "log-handler-path": log_handler_path,         },         no_negated_flags=True,     ) ``` |

### profile\_export [¶](#snakesee.cli.profile_export "Permanent link")

```
profile_export(workflow_dir: Path = Path('.'), *, output: Path | None = None, merge: bool = False) -> None
```

Export timing profile from workflow metadata.

Creates a portable JSON file containing historical timing data that can
be shared across machines or used to bootstrap estimates for new runs.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `workflow_dir` | `Path` | Path to workflow directory containing .snakemake/. | `Path('.')` |
| `output` | `Path | None` | Output file path. Defaults to .snakesee-profile.json in workflow\_dir. | `None` |
| `merge` | `bool` | If output file exists, merge with existing data instead of replacing. | `False` |

Source code in `snakesee/cli.py`

|  |  |
| --- | --- |
| ``` 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 ``` | ``` def profile_export(     workflow_dir: Path = Path("."),     *,     output: Path | None = None,     merge: bool = False, ) -> None:     """     Export timing profile from workflow metadata.      Creates a portable JSON file containing historical timing data that can     be shared across machines or used to bootstrap estimates for new runs.      Args:         workflow_dir: Path to workflow directory containing .snakemake/.         output: Output file path. Defaults to .snakesee-profile.json in workflow_dir.         merge: If output file exists, merge with existing data instead of replacing.     """     try:         workflow_dir = _validate_workflow_dir(workflow_dir)     except WorkflowNotFoundError as e:         _handle_workflow_error(e)     console = Console()      metadata_dir = workflow_dir / ".snakemake" / "metadata"     if not metadata_dir.exists():         console.print("[red]Error:[/red] No metadata directory found")         sys.exit(1)      output_path = output or (workflow_dir / DEFAULT_PROFILE_NAME)      try:         exported = export_profile_from_metadata(             metadata_dir=metadata_dir,             output_path=output_path,             merge_existing=merge,         )          rule_count = len(exported.rules)         total_samples = sum(rp.sample_count for rp in exported.rules.values())          console.print(f"[green]Profile exported:[/green] {output_path}")         console.print(f"  Rules: {rule_count}")         console.print(f"  Total samples: {total_samples}")          if merge and output_path.exists():             console.print("  [dim](merged with existing profile)[/dim]")      except InvalidProfileError as e:         console.print(f"[red]Error:[/red] {e.message}")         sys.exit(1)     except OSError as e:         console.print(f"[red]Error:[/red] Failed to export profile: {e}")         sys.exit(1) ``` |

### profile\_show [¶](#snakesee.cli.profile_show "Permanent link")

```
profile_show(profile_path: Path) -> None
```

Display contents of a timing profile.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `profile_path` | `Path` | Path to the profile file. | *required* |

Source code in `snakesee/cli.py`

|  |  |
| --- | --- |
| ``` 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 ``` | ``` def profile_show(     profile_path: Path, ) -> None:     """     Display contents of a timing profile.      Args:         profile_path: Path to the profile file.     """     console = Console()      try:         loaded = load_profile(profile_path)          console.print(f"[bold]Profile:[/bold] {profile_path}")         console.print(f"  Version: {loaded.version}")         console.print(f"  Created: {loaded.created}")         console.print(f"  Updated: {loaded.updated}")         if loaded.machine:             console.print(f"  Machine: {loaded.machine}")         console.print()          console.print("[bold]Rules:[/bold]")         for name, rp in sorted(loaded.rules.items()):             console.print(                 f"  {name}: "                 f"n={rp.sample_count}, "                 f"mean={format_duration(rp.mean_duration)}, "                 f"std={format_duration(rp.std_dev)}, "                 f"range={format_duration(rp.min_duration)}-{format_duration(rp.max_duration)}"             )      except ProfileNotFoundError:         console.print(f"[red]Error:[/red] Profile not found: {profile_path}")         sys.exit(1)     except InvalidProfileError as e:         console.print(f"[red]Error:[/red] {e.message}")         sys.exit(1) ``` |

### status [¶](#snakesee.cli.status "Permanent link")

```
status(workflow_dir: Path = Path('.'), *, no_estimate: bool = False, profile: Path | None = None) -> None
```

Show a one-time status snapshot (non-interactive).

Useful for scripting or quick checks.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `workflow_dir` | `Path` | Path to workflow directory containing .snakemake/. | `Path('.')` |
| `no_estimate` | `bool` | Disable time estimation from historical data. | `False` |
| `profile` | `Path | None` | Optional path to a timing profile for bootstrapping estimates. | `None` |

Source code in `snakesee/cli.py`

|  |  |
| --- | --- |
| ``` 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 ``` | ``` def status(     workflow_dir: Path = Path("."),     *,     no_estimate: bool = False,     profile: Path | None = None, ) -> None:     """     Show a one-time status snapshot (non-interactive).      Useful for scripting or quick checks.      Args:         workflow_dir: Path to workflow directory containing .snakemake/.         no_estimate: Disable time estimation from historical data.         profile: Optional path to a timing profile for bootstrapping estimates.     """     try:         workflow_dir = _validate_workflow_dir(workflow_dir)     except WorkflowNotFoundError as e:         _handle_workflow_error(e)     console = Console()      # Parse workflow state     progress = parse_workflow_state(workflow_dir)      # Status indicator     status_colors = {         WorkflowStatus.RUNNING: "green",         WorkflowStatus.COMPLETED: "blue",         WorkflowStatus.FAILED: "red",         WorkflowStatus.INCOMPLETE: "yellow",         WorkflowStatus.UNKNOWN: "yellow",     }     status_color = status_colors.get(progress.status, "white")     console.print(f"Status: [{status_color}]{progress.status.value.upper()}[/{status_color}]")      # Progress     console.print(         f"Progress: {progress.completed_jobs}/{progress.total_jobs} "         f"({progress.percent_complete:.1f}%)"     )      # Elapsed time     if progress.elapsed_seconds is not None:         console.print(f"Elapsed: {format_duration(progress.elapsed_seconds)}")      # Running jobs     if progress.running_jobs:         console.print(f"Running: {len(progress.running_jobs)} jobs")      # Incomplete jobs (jobs that were in progress when workflow was interrupted)     if progress.incomplete_jobs_list:         count = len(progress.incomplete_jobs_list)         console.print(f"[yellow]Incomplete: {count} job(s) were in progress[/yellow]")         for job in progress.incomplete_jobs_list[:5]:  # Show up to 5             if job.output_file:                 try:                     rel_path = job.output_file.relative_to(workflow_dir)                     console.print(f"  [dim]- {rel_path}[/dim]")                 except ValueError:                     console.print(f"  [dim]- {job.output_file}[/dim]")         if len(progress.incomplete_jobs_list) > 5:             console.print(f"  [dim]... and {len(progress.incomplete_jobs_list) - 5} more[/dim]")      # Time estimation     if not no_estimate:         estimator = TimeEstimator()         snakemake_dir = workflow_dir / ".snakemake"         metadata_dir = snakemake_dir / "metadata"          # Load from profile if specified or auto-discover         profile_path = profile or find_profile(workflow_dir)         if profile_path is not None and profile_path.exists():             try:                 loaded_profile = load_profile(profile_path)                 estimator.rule_stats = loaded_profile.to_rule_stats()             except (ProfileNotFoundError, InvalidProfileError) as e:                 # Log the error for debugging, but fall back to metadata silently                 logger.debug("Failed to load profile %s: %s", profile_path, e)          # Merge with live metadata (live data takes precedence for recent runs)         if metadata_dir.exists():             estimator.load_from_metadata(metadata_dir)          estimate = estimator.estimate_remaining(progress)         console.print(f"ETA: {estimate.format_eta()}")      # Log file     if progress.log_file is not None:         console.print(f"Log: {progress.log_file}") ``` |

### watch [¶](#snakesee.cli.watch "Permanent link")

```
watch(workflow_dir: Path = Path('.'), *, refresh: float = 2.0, no_estimate: bool = False, profile: Path | None = None, wildcard_timing: bool = True, weighting_strategy: Literal['index', 'time'] = 'index', half_life_logs: int = 10, half_life_days: float = 7.0) -> None
```

Watch a Snakemake workflow in real-time with a TUI dashboard.

Passively monitors the .snakemake/ directory without requiring
special flags when running snakemake. Press 'q' to quit the TUI.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `workflow_dir` | `Path` | Path to workflow directory containing .snakemake/. | `Path('.')` |
| `refresh` | `float` | Refresh interval in seconds (0.5 to 60.0). | `2.0` |
| `no_estimate` | `bool` | Disable time