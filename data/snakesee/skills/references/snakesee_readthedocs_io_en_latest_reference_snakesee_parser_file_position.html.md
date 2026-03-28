[ ]
[ ]

[Skip to content](#snakesee.parser.file_position)

snakesee

file\_position

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
      * [ ]

        file\_position

        [file\_position](file_position.html)

        Table of contents
        + [file\_position](#snakesee.parser.file_position)
        + [Classes](#snakesee.parser.file_position-classes)

          - [LogFilePosition](#snakesee.parser.file_position.LogFilePosition)

            * [Attributes](#snakesee.parser.file_position.LogFilePosition-attributes)

              + [offset](#snakesee.parser.file_position.LogFilePosition.offset)
            * [Functions](#snakesee.parser.file_position.LogFilePosition-functions)

              + [\_\_init\_\_](#snakesee.parser.file_position.LogFilePosition.__init__)
              + [check\_rotation](#snakesee.parser.file_position.LogFilePosition.check_rotation)
              + [clamp\_to\_size](#snakesee.parser.file_position.LogFilePosition.clamp_to_size)
              + [reset](#snakesee.parser.file_position.LogFilePosition.reset)
      * [job\_tracker](job_tracker.html)
      * [line\_parser](line_parser.html)
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

* [file\_position](#snakesee.parser.file_position)
* [Classes](#snakesee.parser.file_position-classes)

  + [LogFilePosition](#snakesee.parser.file_position.LogFilePosition)

    - [Attributes](#snakesee.parser.file_position.LogFilePosition-attributes)

      * [offset](#snakesee.parser.file_position.LogFilePosition.offset)
    - [Functions](#snakesee.parser.file_position.LogFilePosition-functions)

      * [\_\_init\_\_](#snakesee.parser.file_position.LogFilePosition.__init__)
      * [check\_rotation](#snakesee.parser.file_position.LogFilePosition.check_rotation)
      * [clamp\_to\_size](#snakesee.parser.file_position.LogFilePosition.clamp_to_size)
      * [reset](#snakesee.parser.file_position.LogFilePosition.reset)

# file\_position

File position tracking with rotation detection.

## Classes[¶](#snakesee.parser.file_position-classes "Permanent link")

### LogFilePosition [¶](#snakesee.parser.file_position.LogFilePosition "Permanent link")

Tracks file position and detects log rotation/truncation.

Handles common scenarios like log file rotation (inode change)
and file truncation (size decrease).

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `path` |  | Path to the file being tracked. |

Source code in `snakesee/parser/file_position.py`

|  |  |
| --- | --- |
| ``` 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 ``` | ``` class LogFilePosition:     """Tracks file position and detects log rotation/truncation.      Handles common scenarios like log file rotation (inode change)     and file truncation (size decrease).      Attributes:         path: Path to the file being tracked.     """      __slots__ = ("path", "_offset", "_inode")      def __init__(self, path: Path) -> None:         """Initialize position tracker.          Args:             path: Path to the file to track.         """         self.path = path         self._offset: int = 0         self._inode: int | None = None      @property     def offset(self) -> int:         """Current read position in the file."""         return self._offset      @offset.setter     def offset(self, value: int) -> None:         """Set the current read position."""         self._offset = value      def check_rotation(self) -> bool:         """Check if the file has been rotated or truncated.          Detects rotation by checking for inode change or file truncation         (current size less than last known position).          Returns:             True if the file was rotated and position was reset.         """         try:             stat = self.path.stat()             current_inode = stat.st_ino             current_size = stat.st_size              if self._inode is not None and (                 current_inode != self._inode or current_size < self._offset             ):                 self.reset()                 return True              self._inode = current_inode             return False         except FileNotFoundError:             return False         except OSError:             return False      def reset(self) -> None:         """Reset position to start of file."""         self._offset = 0         self._inode = None      def clamp_to_size(self, file_size: int) -> None:         """Clamp offset to file bounds.          Args:             file_size: Current file size (must be non-negative).         """         if file_size < 0:             file_size = 0         self._offset = min(self._offset, file_size) ``` |

#### Attributes[¶](#snakesee.parser.file_position.LogFilePosition-attributes "Permanent link")

##### offset `property` `writable` [¶](#snakesee.parser.file_position.LogFilePosition.offset "Permanent link")

```
offset: int
```

Current read position in the file.

#### Functions[¶](#snakesee.parser.file_position.LogFilePosition-functions "Permanent link")

##### \_\_init\_\_ [¶](#snakesee.parser.file_position.LogFilePosition.__init__ "Permanent link")

```
__init__(path: Path) -> None
```

Initialize position tracker.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `path` | `Path` | Path to the file to track. | *required* |

Source code in `snakesee/parser/file_position.py`

|  |  |
| --- | --- |
| ``` 18 19 20 21 22 23 24 25 26 ``` | ``` def __init__(self, path: Path) -> None:     """Initialize position tracker.      Args:         path: Path to the file to track.     """     self.path = path     self._offset: int = 0     self._inode: int | None = None ``` |

##### check\_rotation [¶](#snakesee.parser.file_position.LogFilePosition.check_rotation "Permanent link")

```
check_rotation() -> bool
```

Check if the file has been rotated or truncated.

Detects rotation by checking for inode change or file truncation
(current size less than last known position).

Returns:

| Type | Description |
| --- | --- |
| `bool` | True if the file was rotated and position was reset. |

Source code in `snakesee/parser/file_position.py`

|  |  |
| --- | --- |
| ``` 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 ``` | ``` def check_rotation(self) -> bool:     """Check if the file has been rotated or truncated.      Detects rotation by checking for inode change or file truncation     (current size less than last known position).      Returns:         True if the file was rotated and position was reset.     """     try:         stat = self.path.stat()         current_inode = stat.st_ino         current_size = stat.st_size          if self._inode is not None and (             current_inode != self._inode or current_size < self._offset         ):             self.reset()             return True          self._inode = current_inode         return False     except FileNotFoundError:         return False     except OSError:         return False ``` |

##### clamp\_to\_size [¶](#snakesee.parser.file_position.LogFilePosition.clamp_to_size "Permanent link")

```
clamp_to_size(file_size: int) -> None
```

Clamp offset to file bounds.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `file_size` | `int` | Current file size (must be non-negative). | *required* |

Source code in `snakesee/parser/file_position.py`

|  |  |
| --- | --- |
| ``` 70 71 72 73 74 75 76 77 78 ``` | ``` def clamp_to_size(self, file_size: int) -> None:     """Clamp offset to file bounds.      Args:         file_size: Current file size (must be non-negative).     """     if file_size < 0:         file_size = 0     self._offset = min(self._offset, file_size) ``` |

##### reset [¶](#snakesee.parser.file_position.LogFilePosition.reset "Permanent link")

```
reset() -> None
```

Reset position to start of file.

Source code in `snakesee/parser/file_position.py`

|  |  |
| --- | --- |
| ``` 65 66 67 68 ``` | ``` def reset(self) -> None:     """Reset position to start of file."""     self._offset = 0     self._inode = None ``` |

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)