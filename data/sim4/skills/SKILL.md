---
name: sim4
description: Sim4Rec is a specialized framework built on PySpark for simulating the lifecycle of a recommender system.
homepage: https://github.com/sb-ai-lab/Sim4Rec
---

# sim4

## Overview
Sim4Rec is a specialized framework built on PySpark for simulating the lifecycle of a recommender system. It allows you to move beyond static offline evaluation by creating dynamic environments where models interact with simulated users. The tool provides modules for data generation, user response modeling (e.g., Bernoulli or Noise responses), and iterative log updating, making it ideal for testing how recommendation algorithms adapt to changing data over time.

## Core Workflow Patterns

### 1. Environment Initialization
To start a simulation, you must define the schema for your interaction logs and initialize the data generators for users and items.
- **Schema Definition**: Use `pyspark.sql.types` to define a strict `LOG_SCHEMA` (typically including `user_idx`, `item_idx`, `relevance`, and `response`).
- **Data Generators**: Use `RealDataGenerator` to wrap existing datasets. Always call `.fit()` on your baseline data before attempting to `.generate()` or `.sample_users()`.

### 2. Modeling User Responses
Sim4Rec uses a pipeline approach to simulate user feedback.
- **Response Functions**: Combine multiple stages using `pyspark.ml.PipelineModel`. A common pattern is to use a `NoiseResponse` to generate a latent score followed by a `BernoulliResponse` to convert that score into a binary interaction (click/no-click).
- **Action Models**: These pipelines are passed to `sim.sample_responses` to generate the "ground truth" for the recommendations made by your model.

### 3. The Iterative Simulation Loop
The power of Sim4Rec lies in the iterative loop. Follow this sequence for each time step:
1. **Sample Users**: Use `sim.sample_users(fraction)` to select a subset of the population for the current iteration.
2. **Predict**: Generate recommendations using your model's `.predict()` method.
3. **Simulate Feedback**: Pass the recommendations and the response pipeline to `sim.sample_responses()`.
4. **Update Log**: Use `sim.update_log()` to append the new interactions to the simulator's history.
5. **Refit**: Retrain your recommendation model on the updated `sim.log`.

## Expert Tips and Best Practices

- **Spark Persistence**: Simulations are computationally expensive. Always `.cache()` the DataFrames for `users`, `recs`, and `true_resp` inside the loop, and call `.unpersist()` at the end of each iteration to manage memory.
- **Filtering Seen Items**: When calling `model.predict()`, set `filter_seen_items=True` to ensure the simulator doesn't recommend items the user has already interacted with in the `sim.log`.
- **Metric Tracking**: Use the `EvaluateMetrics` class to track performance (like `areaUnderROC`) at every iteration. Store these in a list to visualize the model's learning curve over the simulation's duration.
- **Synthetic Data Caution**: While Sim4Rec provides wrappers for synthetic data (like SDV), these are primarily for non-production testing. For realistic evaluations, prefer fitting `RealDataGenerator` on actual historical traffic.

## Reference documentation
- [Sim4Rec Main README](./references/github_com_sb-ai-lab_Sim4Rec.md)