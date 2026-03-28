[ ]
[ ]

[Skip to content](#capcruncher.api.io)

CapCruncher Documentation

io

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
      * [ ]

        io

        [io](./)

        Table of contents
        + [io](#capcruncher.api.io)
        + [FastqReaderProcess](#capcruncher.api.io.FastqReaderProcess)

          - [run](#capcruncher.api.io.FastqReaderProcess.run)
        + [bam\_to\_parquet](#capcruncher.api.io.bam_to_parquet)
        + [parse\_alignment](#capcruncher.api.io.parse_alignment)
        + [parse\_bam](#capcruncher.api.io.parse_bam)
      * [pileup](../pileup/)
      * [plotting](../plotting/)
      * [statistics](../statistics/)
      * [storage](../storage/)

Table of contents

* [io](#capcruncher.api.io)
* [FastqReaderProcess](#capcruncher.api.io.FastqReaderProcess)

  + [run](#capcruncher.api.io.FastqReaderProcess.run)
* [bam\_to\_parquet](#capcruncher.api.io.bam_to_parquet)
* [parse\_alignment](#capcruncher.api.io.parse_alignment)
* [parse\_bam](#capcruncher.api.io.parse_bam)

# io

## `FastqReaderProcess` [¶](#capcruncher.api.io.FastqReaderProcess "Permanent link")

Bases: `Process`

Reads fastq file(s) in chunks and places them on a queue.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `input_file` |  | Input fastq files. |
| `outq` |  | Output queue for chunked reads/read pairs. |
| `statq` |  | (Not currently used) Queue for read statistics if required. |
| `read_buffer` |  | Number of reads to process before placing them on outq |
| `read_counter` |  | (Not currently used) Can be used to sync between multiple readers. |
| `n_subproceses` |  | Number of processes running concurrently. Used to make sure enough termination signals are used. |

Source code in `capcruncher/api/io.py`

|  |  |
| --- | --- |
| ``` 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 ``` | ``` class FastqReaderProcess(multiprocessing.Process):     """Reads fastq file(s) in chunks and places them on a queue.      Attributes:      input_file: Input fastq files.      outq: Output queue for chunked reads/read pairs.      statq: (Not currently used) Queue for read statistics if required.      read_buffer: Number of reads to process before placing them on outq      read_counter: (Not currently used) Can be used to sync between multiple readers.      n_subproceses: Number of processes running concurrently. Used to make sure enough termination signals are used.      """      def __init__(         self,         input_files: Union[str, list],         outq: multiprocessing.Queue,         read_buffer: int = 100000,     ) -> None:         # Input variables         self.input_files = input_files         self._multifile = self._is_multifile(input_files)          if self._multifile:             self._input_files_pysam = [FastxFile(f) for f in self.input_files]         else:             self._input_files_pysam = [                 FastxFile(self.input_files),             ]          # Multiprocessing variables         self.outq = outq          # Reader variables         self.read_buffer = read_buffer          super(FastqReaderProcess, self).__init__()      def _is_multifile(self, files):         if not isinstance(files, (str, pathlib.Path)):             return True         elif isinstance(files, (list, tuple)) and len(files > 1):             return True         else:             return False      def run(self):         """Performs reading and chunking of fastq file(s)."""          try:             buffer = []             rc = 0             for read_counter, read in enumerate(zip(*self._input_files_pysam)):                 # print(f"read_counter: {read_counter}, read: {read}, read_buffer: {self.read_buffer}")                 buffer.append(read)                 if read_counter % self.read_buffer == 0 and not read_counter == 0:                     self.outq.put(buffer.copy())                     buffer.clear()                     logger.info(f"{read_counter} reads parsed (batch)")                     rc = read_counter                 else:                     rc = read_counter              self.outq.put(buffer)  # Deal with remainder             self.outq.put_nowait(None)  # Poison pill to terminate queue             logger.info(f"{rc} reads parsed (final)")          except Exception as e:             logger.info(f"Reader failed with exception: {e}")             raise          finally:             for fh in self._input_files_pysam:                 fh.close() ``` |

### `run()` [¶](#capcruncher.api.io.FastqReaderProcess.run "Permanent link")

Performs reading and chunking of fastq file(s).

Source code in `capcruncher/api/io.py`

|  |  |
| --- | --- |
| ``` 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 ``` | ``` def run(self):     """Performs reading and chunking of fastq file(s)."""      try:         buffer = []         rc = 0         for read_counter, read in enumerate(zip(*self._input_files_pysam)):             # print(f"read_counter: {read_counter}, read: {read}, read_buffer: {self.read_buffer}")             buffer.append(read)             if read_counter % self.read_buffer == 0 and not read_counter == 0:                 self.outq.put(buffer.copy())                 buffer.clear()                 logger.info(f"{read_counter} reads parsed (batch)")                 rc = read_counter             else:                 rc = read_counter          self.outq.put(buffer)  # Deal with remainder         self.outq.put_nowait(None)  # Poison pill to terminate queue         logger.info(f"{rc} reads parsed (final)")      except Exception as e:         logger.info(f"Reader failed with exception: {e}")         raise      finally:         for fh in self._input_files_pysam:             fh.close() ``` |

## `bam_to_parquet(bam, output)` [¶](#capcruncher.api.io.bam_to_parquet "Permanent link")

Converts bam file to parquet file.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `bam` | `Union[str, Path]` | Path to bam file. | *required* |
| `output` | `Union[str, Path]` | Path to output parquet file. | *required* |

Source code in `capcruncher/api/io.py`

|  |  |
| --- | --- |
| ``` 359 360 361 362 363 364 365 366 367 368 369 370 371 372 ``` | ``` def bam_to_parquet(     bam: Union[str, pathlib.Path], output: Union[str, pathlib.Path] ) -> Union[str, pathlib.Path]:     """Converts bam file to parquet file.      Args:      bam: Path to bam file.      output: Path to output parquet file.      """     df_bam = parse_bam(bam)     df_bam.to_parquet(output)      return output ``` |

## `parse_alignment(aln)` [¶](#capcruncher.api.io.parse_alignment "Permanent link")

Parses reads from a bam file into a list.

Extracts

-read name
-parent reads
-flashed status
-slice number
-mapped status
-multimapping status
-chromosome number (e.g. chr10)
-start (e.g. 1000)
-end (e.g. 2000)
-coords e.g. (chr10:1000-2000)

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `aln` | `AlignmentFile` | pysam.AlignmentFile. | *required* |

Returns:
list: Containing the attributes extracted.

Source code in `capcruncher/api/io.py`

|  |  |
| --- | --- |
| ``` 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 ``` | ``` def parse_alignment(aln: pysam.AlignmentFile) -> CCAlignment:     """Parses reads from a bam file into a list.      Extracts:      -read name      -parent reads      -flashed status      -slice number      -mapped status      -multimapping status      -chromosome number (e.g. chr10)      -start (e.g. 1000)      -end (e.g. 2000)      -coords e.g. (chr10:1000-2000)       Args:      aln: pysam.AlignmentFile.     Returns:      list: Containing the attributes extracted.      """      import numpy as np      slice_name = aln.query_name     parent_read, pe, slice_number, uid = slice_name.split("|")     parent_id = xxhash.xxh3_64_intdigest(parent_read, seed=42)     slice_id = xxhash.xxh3_64_intdigest(slice_name, seed=42)     ref_name = aln.reference_name     ref_start = aln.reference_start     ref_end = aln.reference_end     # Check if read mapped     if aln.is_unmapped:         mapped = 0         multimapped = 0         ref_name = ""         ref_start = 0         ref_end = 0         coords = ""     else:         mapped = 1         coords = f"{ref_name}:{ref_start}-{ref_end}"         # Check if multimapped         if aln.is_secondary:             multimapped = 1         else:             multimapped = 0      return CCAlignment(         slice_id=slice_id,         slice_name=slice_name,         parent_id=parent_id,         parent_read=parent_read,         pe=pe.lower(),         slice=int(slice_number),         uid=int(uid),         mapped=mapped,         multimapped=multimapped,         chrom=ref_name,         start=int(ref_start),         end=int(ref_end),         coordinates=coords,     ) ``` |

## `parse_bam(bam)` [¶](#capcruncher.api.io.parse_bam "Permanent link")

Uses parse\_alignment function convert bam file to a dataframe.

Extracts

-'slice\_name'
-'parent\_read'
-'pe'
-'slice'
-'mapped'
-'multimapped'
-'chrom'
-'start'
-'end'
-'coordinates'

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `bam` | `Union[str, Path]` | Path to bam file. | *required* |

Returns:

| Type | Description |
| --- | --- |
| `DataFrame` | pd.Dataframe: DataFrame with the columns listed above. |

Source code in `capcruncher/api/io.py`

|  |  |
| --- | --- |
| ``` 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 ``` | ``` def parse_bam(bam: Union[str, pathlib.Path]) -> pd.DataFrame:     """Uses parse_alignment function convert bam file to a dataframe.      Extracts:      -'slice_name'      -'parent_read'      -'pe'      -'slice'      -'mapped'      -'multimapped'      -'chrom'      -'start'      -'end'      -'coordinates'      Args:         bam: Path to bam file.      Returns:      pd.Dataframe: DataFrame with the columns listed above.      """      import numpy as np      # Load reads into dataframe     logger.info("Parsing BAM file")     df_bam = pd.DataFrame(         [             parse_alignment(aln)             for aln in pysam.AlignmentFile(bam, "rb").fetch(until_eof=True)         ],     )     df_bam["bam"] = os.path.basename(bam)      # Perform dtype conversions     logger.info("Converting dtypes")     df_bam["chrom"] = df_bam["chrom"].astype("category")     pe_category = pd.CategoricalDtype(["flashed", "pe"])     df_bam["pe"] = df_bam["pe"].astype(         pe_category     )  # Only the one type present so need to include both     df_bam["coordinates"] = df_bam["coordinates"].astype("category")     df_bam["parent_read"] = df_bam["parent_read"].astype("category")     df_bam["slice"] = df_bam["slice"].astype(np.int8)     df_bam["uid"] = df_bam["uid"].astype(np.int8)     df_bam["multimapped"] = df_bam["multimapped"].astype(bool)     df_bam["mapped"] = df_bam["mapped"].astype(bool)     df_bam["bam"] = df_bam["bam"].astype("category")      logger.info("Finished parsing BAM file")     return df_bam ``` |

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)