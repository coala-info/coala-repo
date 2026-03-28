[ ]
[ ]

[Skip to content](#snakesee.parser.line_parser)

snakesee

line\_parser

Initializing search

[GitHub](https://github.com/nh13/snakesee "Go to repository")

snakesee

[GitHub](https://github.com/nh13/snakesee "Go to repository")

* [snakesee](../../../index.html)
* [Snakesee Architecture](../../../architecture.html)
* [Installation](../../../installation.html)
* [Usage](../../../usage.html)
* [x]

  Reference

  Reference
  + [x]

    [snakesee](../index.html)

    snakesee
    - [cli](../cli.html)
    - [constants](../constants.html)
    - [ ]

      [estimation](../estimation/index.html)

      estimation
      * [data\_loader](../estimation/data_loader.html)
      * [estimator](../estimation/estimator.html)
      * [pending\_inferrer](../estimation/pending_inferrer.html)
      * [rule\_matcher](../estimation/rule_matcher.html)
    - [estimator](../estimator.html)
    - [events](../events.html)
    - [exceptions](../exceptions.html)
    - [formatting](../formatting.html)
    - [log\_handler\_script](../log_handler_script.html)
    - [logging](../logging.html)
    - [models](../models.html)
    - [parameter\_validation](../parameter_validation.html)
    - [x]

      [parser](index.html)

      parser
      * [core](core.html)
      * [failure\_tracker](failure_tracker.html)
      * [file\_position](file_position.html)
      * [job\_tracker](job_tracker.html)
      * [ ]

        line\_parser

        [line\_parser](line_parser.html)

        Table of contents
        + [line\_parser](#snakesee.parser.line_parser)
        + [Classes](#snakesee.parser.line_parser-classes)

          - [LogLineParser](#snakesee.parser.line_parser.LogLineParser)

            * [Functions](#snakesee.parser.line_parser.LogLineParser-functions)

              + [flush\_pending\_error](#snakesee.parser.line_parser.LogLineParser.flush_pending_error)
              + [parse\_line](#snakesee.parser.line_parser.LogLineParser.parse_line)
              + [reset](#snakesee.parser.line_parser.LogLineParser.reset)
          - [ParseEvent](#snakesee.parser.line_parser.ParseEvent)
          - [ParseEventType](#snakesee.parser.line_parser.ParseEventType)
          - [ParsingContext](#snakesee.parser.line_parser.ParsingContext)

            * [Functions](#snakesee.parser.line_parser.ParsingContext-functions)

              + [get\_pending\_error](#snakesee.parser.line_parser.ParsingContext.get_pending_error)
              + [has\_pending\_error](#snakesee.parser.line_parser.ParsingContext.has_pending_error)
              + [reset\_for\_new\_rule](#snakesee.parser.line_parser.ParsingContext.reset_for_new_rule)
              + [start\_error\_block](#snakesee.parser.line_parser.ParsingContext.start_error_block)
      * [log\_reader](log_reader.html)
      * [metadata](metadata.html)
      * [patterns](patterns.html)
      * [stats](stats.html)
      * [utils](utils.html)
    - [ ]

      [plugins](../plugins/index.html)

      plugins
      * [base](../plugins/base.html)
      * [bwa](../plugins/bwa.html)
      * [discovery](../plugins/discovery.html)
      * [fastp](../plugins/fastp.html)
      * [fgbio](../plugins/fgbio.html)
      * [loader](../plugins/loader.html)
      * [registry](../plugins/registry.html)
      * [samtools](../plugins/samtools.html)
      * [star](../plugins/star.html)
    - [profile](../profile.html)
    - [ ]

      [state](../state/index.html)

      state
      * [clock](../state/clock.html)
      * [config](../state/config.html)
      * [job\_registry](../state/job_registry.html)
      * [paths](../state/paths.html)
      * [rule\_registry](../state/rule_registry.html)
      * [workflow\_state](../state/workflow_state.html)
    - [state\_comparison](../state_comparison.html)
    - [ ]

      [tui](../tui/index.html)

      tui
      * [monitor](../tui/monitor.html)
    - [types](../types.html)
    - [utils](../utils.html)
    - [validation](../validation.html)
    - [variance](../variance.html)

Table of contents

* [line\_parser](#snakesee.parser.line_parser)
* [Classes](#snakesee.parser.line_parser-classes)

  + [LogLineParser](#snakesee.parser.line_parser.LogLineParser)

    - [Functions](#snakesee.parser.line_parser.LogLineParser-functions)

      * [flush\_pending\_error](#snakesee.parser.line_parser.LogLineParser.flush_pending_error)
      * [parse\_line](#snakesee.parser.line_parser.LogLineParser.parse_line)
      * [reset](#snakesee.parser.line_parser.LogLineParser.reset)
  + [ParseEvent](#snakesee.parser.line_parser.ParseEvent)
  + [ParseEventType](#snakesee.parser.line_parser.ParseEventType)
  + [ParsingContext](#snakesee.parser.line_parser.ParsingContext)

    - [Functions](#snakesee.parser.line_parser.ParsingContext-functions)

      * [get\_pending\_error](#snakesee.parser.line_parser.ParsingContext.get_pending_error)
      * [has\_pending\_error](#snakesee.parser.line_parser.ParsingContext.has_pending_error)
      * [reset\_for\_new\_rule](#snakesee.parser.line_parser.ParsingContext.reset_for_new_rule)
      * [start\_error\_block](#snakesee.parser.line_parser.ParsingContext.start_error_block)

# line\_parser

Log line parsing with context tracking.

## Classes[¶](#snakesee.parser.line_parser-classes "Permanent link")

### LogLineParser `dataclass` [¶](#snakesee.parser.line_parser.LogLineParser "Permanent link")

Parses individual Snakemake log lines.

Maintains parsing context across lines to handle multi-line
log entries where information spans multiple lines.

Source code in `snakesee/parser/line_parser.py`

|  |  |
| --- | --- |
| ``` 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 ``` | ``` @dataclass class LogLineParser:     """Parses individual Snakemake log lines.      Maintains parsing context across lines to handle multi-line     log entries where information spans multiple lines.     """      context: ParsingContext = field(default_factory=ParsingContext)      def parse_line(self, line: str) -> list[ParseEvent]:         """Parse a single log line and return structured events.          Uses fast-path prefix checks to skip expensive regex operations         for lines that can't possibly match.          Updates internal context as needed for multi-line entries.         May return multiple events when a pending error needs to be flushed.          Args:             line: Log line to parse.          Returns:             List of ParseEvents (may be empty, one, or two events).         """         line = line.rstrip("\n\r")         events: list[ParseEvent] = []          # Fast path: empty lines         if not line:             return events          first_char = line[0]          # Timestamp lines start with '[' - this ends error blocks         if first_char == "[":             if match := TIMESTAMP_PATTERN.match(line):                 # Flush any pending error before emitting timestamp                 if pending := self.context.get_pending_error():                     events.append(pending)                 timestamp = _parse_timestamp(match.group(1))                 self.context.timestamp = timestamp                 events.append(ParseEvent(ParseEventType.TIMESTAMP, {"timestamp": timestamp}))             return events          # Indented lines (properties) start with space/tab         if first_char in (" ", "\t"):             event = self._parse_indented_line(line)             if event:                 events.append(event)             return events          # Rule start: "rule X:" or "localrule X:" - this ends error blocks         if first_char == "r" and line.startswith("rule "):             if match := RULE_START_PATTERN.match(line):                 # Flush any pending error before emitting rule start                 if pending := self.context.get_pending_error():                     events.append(pending)                 rule = match.group(1)                 self.context.reset_for_new_rule(rule)                 events.append(ParseEvent(ParseEventType.RULE_START, {"rule": rule}))             return events          if first_char == "l" and line.startswith("localrule "):             if match := RULE_START_PATTERN.match(line):                 # Flush any pending error before emitting rule start                 if pending := self.context.get_pending_error():                     events.append(pending)                 rule = match.group(1)                 self.context.reset_for_new_rule(rule)                 events.append(ParseEvent(ParseEventType.RULE_START, {"rule": rule}))             return events          # Finished job: "Finished job X" or "Finished jobid: X"         if first_char == "F" and line.startswith("Finished "):             if match := FINISHED_JOB_PATTERN.search(line):                 jobid = match.group(1)                 events.append(                     ParseEvent(                         ParseEventType.JOB_FINISHED,                         {"jobid": jobid, "timestamp": self.context.timestamp},                     )                 )             return events          # Error detection: "Error in rule X:" - starts a pending error block         if first_char == "E" and line.startswith("Error in rule "):             if match := ERROR_IN_RULE_PATTERN.search(line):                 # Flush any previous pending error before starting new one                 if pending := self.context.get_pending_error():                     events.append(pending)                 rule = match.group(1)                 # Start pending error - we'll capture jobid/log from subsequent lines                 self.context.start_error_block(rule)             return events          # Progress line: "X of Y steps (Z%) done" - check with substring first         if "steps" in line and "done" in line:             if match := PROGRESS_PATTERN.search(line):                 completed = int(match.group(1))                 total = int(match.group(2))                 events.append(                     ParseEvent(ParseEventType.PROGRESS, {"completed": completed, "total": total})                 )          return events      def flush_pending_error(self) -> ParseEvent | None:         """Flush any pending error event.          Call this at end of file or when needing to ensure all errors are emitted.          Returns:             ParseEvent for the pending error, or None if no pending error.         """         return self.context.get_pending_error()      def _parse_indented_line(self, line: str) -> ParseEvent | None:         """Parse indented property lines (wildcards, threads, log, jobid).          Args:             line: Indented log line starting with space/tab.          Returns:             ParseEvent if line contains a recognized property, None otherwise.         """         stripped = line.lstrip()          # Check each property type by prefix (faster than regex)         if stripped.startswith("wildcards:"):             value = stripped[10:].strip()  # len('wildcards:') = 10             wildcards = _parse_wildcards(value)             self.context.wildcards = wildcards             # Also update error context if in error block             if self.context.has_pending_error():                 self.context.error_wildcards = wildcards             return ParseEvent(                 ParseEventType.WILDCARDS,                 {"wildcards": wildcards, "jobid": self.context.jobid},             )          if stripped.startswith("threads:"):             value = stripped[8:].strip()  # len('threads:') = 8             threads = _parse_positive_int(value, "threads")             if threads is not None:                 self.context.threads = threads                 # Also update error context if in error block                 if self.context.has_pending_error():                     self.context.error_threads = threads                 return ParseEvent(                     ParseEventType.THREADS,                     {"threads": threads, "jobid": self.context.jobid},                 )             return None          if stripped.startswith("log:"):             log_path = stripped[4:].strip()  # len('log:') = 4             self.context.log_path = log_path             # Also update error context if in error block             if self.context.has_pending_error():                 self.context.error_log_path = log_path             return ParseEvent(                 ParseEventType.LOG_PATH,                 {"log_path": log_path, "jobid": self.context.jobid},             )          if stripped.startswith("jobid:"):             jobid = stripped[6:].strip()  # len('jobid:') = 6             self.context.jobid = jobid             # Also update error context if in error block             if self.context.has_pending_error():                 self.context.error_jobid = jobid             return ParseEvent(                 ParseEventType.JOBID,                 {                     "jobid": jobid,                     "rule": self.context.rule,                     "wildcards": self.context.wildcards,                     "threads": self.context.threads,                     "timestamp": self.context.timestamp,                     "log_path": self.context.log_path,                 },             )          return None      def reset(self) -> None:         """Reset parsing context."""         self.context = ParsingContext() ``` |

#### Functions[¶](#snakesee.parser.line_parser.LogLineParser-functions "Permanent link")

##### flush\_pending\_error [¶](#snakesee.parser.line_parser.LogLineParser.flush_pending_error "Permanent link")

```
flush_pending_error() -> ParseEvent | None
```

Flush any pending error event.

Call this at end of file or when needing to ensure all errors are emitted.

Returns:

| Type | Description |
| --- | --- |
| `[ParseEvent](index.html#snakesee.parser.line_parser.ParseEvent "ParseEvent (snakesee.parser.line_parser.ParseEvent)") | None` | ParseEvent for the pending error, or None if no pending error. |

Source code in `snakesee/parser/line_parser.py`

|  |  |
| --- | --- |
| ``` 243 244 245 246 247 248 249 250 251 ``` | ``` def flush_pending_error(self) -> ParseEvent | None:     """Flush any pending error event.      Call this at end of file or when needing to ensure all errors are emitted.      Returns:         ParseEvent for the pending error, or None if no pending error.     """     return self.context.get_pending_error() ``` |

##### parse\_lin