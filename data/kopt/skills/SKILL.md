---
name: kopt
description: The `kopt` library provides a high-level wrapper around `hyperopt` specifically designed for Keras.
homepage: https://github.com/avsecz/keras-hyperopt
---

# kopt

## Overview
The `kopt` library provides a high-level wrapper around `hyperopt` specifically designed for Keras. It simplifies the process of defining search spaces, managing data splits, and checkpointing the best-performing models. It is particularly useful for transitioning from manual parameter tuning to automated, distributed optimization via MongoDB.

## Core Workflow

### 1. Define Data and Model Functions
`kopt` requires two specific functions to isolate the data loading from the model architecture:

- **Data Function**: Must return `(x_train, y_train), (x_val, y_val)` or `(x_train, y_train, extra_info), (x_val, y_val)`.
- **Model Function**: Must accept `train_data` as the first argument, followed by hyper-parameters, and return a **compiled** Keras model.

### 2. Configure the Objective (CompileFN)
The `CompileFN` class handles the boilerplate of training and evaluation.

```python
from kopt import CompileFN

objective = CompileFN(
    db_name="experiment_db",
    exp_name="trial_01",
    data_fn=data_func,
    model_fn=model_func,
    loss_metric="acc",       # Metric to monitor
    loss_metric_mode="max",  # "max" for accuracy, "min" for loss
    valid_split=0.2,         # Internal validation if data_fn doesn't provide it
    save_model='best',       # Automatically save the best weights
    save_dir="./models/"
)
```

### 3. Define Search Space
Use `hyperopt.hp` to define the ranges for your parameters. Structure the dictionary to match your function signatures.

```python
from hyperopt import hp
import numpy as np

hyper_params = {
    "model": {
        "lr": hp.loguniform("lr", np.log(1e-4), np.log(1e-2)),
        "units": hp.choice("units", [32, 64, 128]),
        "dropout": hp.uniform("dropout", 0, 0.5)
    },
    "fit": {
        "epochs": 10  # Passed to model.fit()
    }
}
```

### 4. Execution
Always run `test_fn` first to ensure the pipeline works on a small subset before starting the full search.

```python
from kopt import test_fn, KMongoTrials
from hyperopt import fmin, tpe, Trials

# 1. Debugging
test_fn(objective, hyper_params)

# 2. Sequential Run
trials = Trials()
best = fmin(objective, hyper_params, trials=trials, algo=tpe.suggest, max_evals=10)

# 3. Parallel Run (requires MongoDB)
# KMongoTrials extends hyperopt.MongoTrials for easier result retrieval
trials = KMongoTrials("experiment_db", "trial_01", ip="localhost", port=22334)
best = fmin(objective, hyper_params, trials=trials, algo=tpe.suggest, max_evals=100)
```

## Best Practices
- **Metric Consistency**: Ensure `loss_metric` matches the string used in `model.compile(metrics=[...])`.
- **Resource Management**: When using `KMongoTrials`, ensure the `mongodb` service is running and accessible before execution.
- **Checkpointing**: Use `save_model='best'` to avoid losing the optimal weights if the search process is interrupted.
- **NetworkX Compatibility**: If encountering installation errors related to `networkx`, pin the version: `pip install networkx==1.11`.

## Reference documentation
- [Kopt GitHub Repository](./references/github_com_Avsecz_kopt.md)