[ ]
[ ]

[Skip to content](#capcruncher.api.deduplicate)

CapCruncher Documentation

deduplicate

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
      * [ ]

        deduplicate

        [deduplicate](./)

        Table of contents
        + [deduplicate](#capcruncher.api.deduplicate)
        + [ReadDeduplicationParserProcess](#capcruncher.api.deduplicate.ReadDeduplicationParserProcess)

          - [\_\_init\_\_](#capcruncher.api.deduplicate.ReadDeduplicationParserProcess.__init__)
          - [run](#capcruncher.api.deduplicate.ReadDeduplicationParserProcess.run)
        + [ReadDuplicateRemovalProcess](#capcruncher.api.deduplicate.ReadDuplicateRemovalProcess)

          - [\_\_init\_\_](#capcruncher.api.deduplicate.ReadDuplicateRemovalProcess.__init__)
          - [run](#capcruncher.api.deduplicate.ReadDuplicateRemovalProcess.run)
      * [filter](../filter/)
      * [io](../io/)
      * [pileup](../pileup/)
      * [plotting](../plotting/)
      * [statistics](../statistics/)
      * [storage](../storage/)

Table of contents

* [deduplicate](#capcruncher.api.deduplicate)
* [ReadDeduplicationParserProcess](#capcruncher.api.deduplicate.ReadDeduplicationParserProcess)

  + [\_\_init\_\_](#capcruncher.api.deduplicate.ReadDeduplicationParserProcess.__init__)
  + [run](#capcruncher.api.deduplicate.ReadDeduplicationParserProcess.run)
* [ReadDuplicateRemovalProcess](#capcruncher.api.deduplicate.ReadDuplicateRemovalProcess)

  + [\_\_init\_\_](#capcruncher.api.deduplicate.ReadDuplicateRemovalProcess.__init__)
  + [run](#capcruncher.api.deduplicate.ReadDuplicateRemovalProcess.run)

# deduplicate

## `ReadDeduplicationParserProcess` [¶](#capcruncher.api.deduplicate.ReadDeduplicationParserProcess "Permanent link")

Bases: `Process`

Process subclass for parsing fastq file(s) into a hashed {id:sequence} json format.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `inq` |  | Input read queue |
| `outq` |  | Output read queue (Not currently used) |
| `hash_seed` |  | Seed for xxhash64 algorithm to ensure consistency |
| `save_hash_dict_path` |  | Path to save hashed dictionary |

Source code in `capcruncher/api/deduplicate.py`

|  |  |
| --- | --- |
| ``` 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 ``` | ``` class ReadDeduplicationParserProcess(Process):     """     Process subclass for parsing fastq file(s) into a hashed {id:sequence} json format.      Attributes:      inq: Input read queue      outq: Output read queue (Not currently used)      hash_seed: Seed for xxhash64 algorithm to ensure consistency      save_hash_dict_path: Path to save hashed dictionary     """      def __init__(         self,         inq: multiprocessing.Queue,         hash_seed: int = 42,         output_path: os.PathLike = "parsed.json",     ):         """         Args:          inq (multiprocessing.SimpleQueue): Input queue for fastq reads.          outq (multiprocessing.SimpleQueue): Output queue for processed reads.                                              Only used if part of a pipeline          hash_seed (int, optional): Seed to use for hashing. Defaults to 42.          output_path (os.PathLike, optional): Path to save hashed reads.         """          self.inq = inq         self.hash_seed = hash_seed         self.output_path = output_path          super(ReadDeduplicationParserProcess, self).__init__()      def run(self):         """Processes fastq reads from multiple files and generates a hashed json dict.          Dictionary is hashed and in the format {(read  1 name + read 2 name): (s1 + s2)}          Output path is specified by save_hashed_dict_path.          """          hash_seed = self.hash_seed         hash_function = functools.partial(xxhash.xxh64_intdigest, seed=hash_seed)         records = dict()          while True:              try:                 reads = self.inq.get(block=True, timeout=0.01)                  if reads:                      for read_set in reads:                         hash_sequence = hash_function(                             "".join([r.sequence for r in read_set])                         )                         hash_id = hash_function("".join([r.name for r in read_set]))                         records[hash_id] = hash_sequence                  else:                     break              except queue.Empty:                 continue          output_format = get_file_type(self.output_path)         save_dict(records, self.output_path, output_format) ``` |

### `__init__(inq, hash_seed=42, output_path='parsed.json')` [¶](#capcruncher.api.deduplicate.ReadDeduplicationParserProcess.__init__ "Permanent link")

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `inq` | `SimpleQueue` | Input queue for fastq reads. | *required* |
| `outq` | `SimpleQueue` | Output queue for processed reads. Only used if part of a pipeline | *required* |
| `hash_seed` | `int` | Seed to use for hashing. Defaults to 42. | `42` |
| `output_path` | `PathLike` | Path to save hashed reads. | `'parsed.json'` |

Source code in `capcruncher/api/deduplicate.py`

|  |  |
| --- | --- |
| ``` 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 ``` | ``` def __init__(     self,     inq: multiprocessing.Queue,     hash_seed: int = 42,     output_path: os.PathLike = "parsed.json", ):     """     Args:      inq (multiprocessing.SimpleQueue): Input queue for fastq reads.      outq (multiprocessing.SimpleQueue): Output queue for processed reads.                                          Only used if part of a pipeline      hash_seed (int, optional): Seed to use for hashing. Defaults to 42.      output_path (os.PathLike, optional): Path to save hashed reads.     """      self.inq = inq     self.hash_seed = hash_seed     self.output_path = output_path      super(ReadDeduplicationParserProcess, self).__init__() ``` |

### `run()` [¶](#capcruncher.api.deduplicate.ReadDeduplicationParserProcess.run "Permanent link")

Processes fastq reads from multiple files and generates a hashed json dict.

Dictionary is hashed and in the format {(read 1 name + read 2 name): (s1 + s2)}

Output path is specified by save\_hashed\_dict\_path.

Source code in `capcruncher/api/deduplicate.py`

|  |  |
| --- | --- |
| ``` 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 ``` | ``` def run(self):     """Processes fastq reads from multiple files and generates a hashed json dict.      Dictionary is hashed and in the format {(read  1 name + read 2 name): (s1 + s2)}      Output path is specified by save_hashed_dict_path.      """      hash_seed = self.hash_seed     hash_function = functools.partial(xxhash.xxh64_intdigest, seed=hash_seed)     records = dict()      while True:          try:             reads = self.inq.get(block=True, timeout=0.01)              if reads:                  for read_set in reads:                     hash_sequence = hash_function(                         "".join([r.sequence for r in read_set])                     )                     hash_id = hash_function("".join([r.name for r in read_set]))                     records[hash_id] = hash_sequence              else:                 break          except queue.Empty:             continue      output_format = get_file_type(self.output_path)     save_dict(records, self.output_path, output_format) ``` |

## `ReadDuplicateRemovalProcess` [¶](#capcruncher.api.deduplicate.ReadDuplicateRemovalProcess "Permanent link")

Bases: `Process`

Process subclass for parsing fastq file(s) and removing identified duplicates.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `inq` |  | Input read queue |
| `outq` |  | Output queue for deduplicated reads. |
| `duplicated_ids` |  | Concatenated read ids to remove from input fastq files. |
| `statq` |  | Output queue for statistics. |
| `reads_total` |  | Number of fastq reads processed. |
| `reads_unique` |  | Number of non-duplicated reads output. |
| `hash_seed` |  | Seed for xxhash algorithm. Same as ReadDuplicationParserProcess. |

Source code in `capcruncher/api/deduplicate.py`

|  |  |
| --- | --- |
| ```  90  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 ``` | ``` class ReadDuplicateRemovalProcess(Process):     """     Process subclass for parsing fastq file(s) and removing identified duplicates.      Attributes:      inq: Input read queue      outq: Output queue for deduplicated reads.      duplicated_ids: Concatenated read ids to remove from input fastq files.      statq: Output queue for statistics.      reads_total: Number of fastq reads processed.      reads_unique: Number of non-duplicated reads output.      hash_seed: Seed for xxhash algorithm. Same as ReadDuplicationParserProcess.     """      def __init__(         self,         inq: multiprocessing.Queue,         outq: multiprocessing.Queue,         stats_tx: multiprocessing.Pipe,         duplicated_ids: set,         hash_seed: int = 42,         hash_read_name: bool = True,     ):         """         Args:          inq (multiprocessing.SimpleQueue): Input queue for reads to be deduplicated.          outq (multiprocessing.SimpleQueue): Output queue for deduplicated reads.          duplicated_ids (set): Hashed read ids to be removed if encountered.          statq (multiprocessing.Queue, optional): Output queue for statistics.          hash_seed (int, optional): Seed for xxhash algorithm. Defaults to 42.         """          self.inq = inq         self.outq = outq         self.hash_seed = hash_seed         self.duplicated_ids = duplicated_ids          # Misc         self.hash_read_name = hash_read_name          # Stats         self.stats_tx = stats_tx         self.reads_total = 0         self.reads_unique = 0          super(ReadDuplicateRemovalProcess, self).__init__()      def run(self):          """Performs read deduplication based on sequence.          Unique reads are placed on outq and deduplication stats are placed on statq.          """          hash_seed = self.hash_seed         hash_read_name = self.hash_read_name         hash_function = functools.partial(xxhash.xxh64_intdigest, seed=hash_seed)         duplicated_ids = self.duplicated_ids         reads_unique = list()          while True:              try:                 reads = self.inq.get(block=True, timeout=0.01)                  if reads:                     for read_glob in reads:                          hash_id = hash_function("".join([r.name for r in read_glob]))                          if hash_id not in duplicated_ids:                             if hash_read_name:                                 for r in read_glob:                                     r.name = str(hash_function(r.name))                              reads_unique.append(read_glob)                      self.reads_total += len(reads)                     self.reads_unique += len(reads_unique)                     self.outq.put(reads_unique.copy())                     reads_unique.clear()                  else:                     break              except queue.Empty:                 continue          stats = RemovalStatistics(             self.reads_total, self.reads_unique, self.reads_total - self.reads_unique         )         self.stats_tx.send(stats) ``` |

### `__init__(inq, outq, stats_tx, duplicated_ids, hash_seed=42, hash_read_name=True)` [¶](#capcruncher.api.deduplicate.ReadDuplicateRemovalProcess.__init__ "Permanent link")

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `inq` | `SimpleQueue` | Input queue for reads to be deduplicated. | *required* |
| `outq` | `SimpleQueue` | Output queue for deduplicated reads. | *required* |
| `duplicated_ids` | `set` | Hashed read ids to be removed if encountered. | *required* |
| `statq` | `Queue` | Output queue for statistics. | *required* |
| `hash_seed` | `int` | Seed for xxhash algorithm. Defaults to 42. | `42` |

Source code in `capcruncher/api/deduplicate.py`

|  |  |
| --- | --- |
| ``` 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 ``` | ``` def __init__(     self,     inq: multiprocessing.Queue,     outq: multiprocessing.Queue,     stats_tx: multiprocessing.Pipe,     duplicated_ids: set,     hash_seed: int = 42,     hash_read_name: bool = True, ):     """     Args:      inq (multiprocessing.SimpleQueue): Input queue for reads to be deduplicated.      outq (multiprocessing.SimpleQueue): Output queue for deduplicated reads.      duplicated_ids (set): Hashed read ids to be removed if encountered.      statq (multiprocessing.Queue, optional): Output queue for statistics.      hash_seed (int, optional): Seed for xxhash algorithm. Defaults to 42.     """      self.inq = inq     self.outq = outq     self.hash_seed = hash_seed     self.duplicated_ids = duplicated_ids      # Misc     self.hash_read_name = hash_read_name      # Stats     self.stats_tx = stats_tx     self.reads_total = 0     self.reads_unique = 0      super(ReadDuplicateRemovalProcess, self).__init__() ``` |

### `run()` [¶](#capcruncher.api.deduplicate.ReadDuplicateRemovalProcess.run "Permanent link")

Performs read deduplication based on sequence.

Unique reads are placed on outq and deduplication stats are placed on statq.

Source code in `capcruncher/api/deduplicate.py`

|  |  |
| --- | --- |
| ``` 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 ``` | ``` def run(self):      """Performs read deduplication based on sequence.      Unique reads are placed on outq and deduplication stats are placed on statq.      """      hash_seed = self.hash_seed     hash_read_name = self.hash_read_name     hash_function = functools.partial(xxhash.xxh64_intdigest, seed=hash_seed)     duplicated_ids = self.duplicated_ids     reads_unique = list()      while True:          try:             r