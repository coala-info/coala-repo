---
name: lightning
description: PyTorch Lightning is a high-level framework designed to decouple the "science" of deep learning (model architecture and loss functions) from the "engineering" (training loops, hardware distribution, and checkpointing).
homepage: https://github.com/Lightning-AI/pytorch-lightning
---

# lightning

## Overview
PyTorch Lightning is a high-level framework designed to decouple the "science" of deep learning (model architecture and loss functions) from the "engineering" (training loops, hardware distribution, and checkpointing). By wrapping standard PyTorch code in a structured `LightningModule`, you can scale models from a single CPU to thousands of GPUs with minimal code changes. It automates repetitive tasks like manual zero-grad calls, backward passes, and optimizer steps while maintaining full flexibility for expert-level control.

## Core Implementation Pattern

To use Lightning, you must organize your PyTorch code into a `LightningModule`.

### 1. Define the LightningModule
The `LightningModule` is a subclass of `torch.nn.Module` that groups the model architecture, training logic, and optimizer configuration.

```python
import lightning as L
import torch
import torch.nn.functional as F

class LitModel(L.LightningModule):
    def __init__(self, model):
        super().__init__()
        self.model = model

    def forward(self, x):
        # Use for inference/prediction
        return self.model(x)

    def training_step(self, batch, batch_idx):
        # The complete training loop logic
        x, y = batch
        y_hat = self(x)
        loss = F.cross_entropy(y_hat, y)
        self.log("train_loss", loss) # Automatic logging
        return loss

    def configure_optimizers(self):
        return torch.optim.Adam(self.parameters(), lr=0.02)
```

### 2. Execute Training with the Trainer
The `Trainer` automates the engineering details.

```python
from torch.utils.data import DataLoader

# Setup data and model
train_loader = DataLoader(my_dataset)
model = LitModel(my_nn_module)

# Initialize trainer and fit
trainer = L.Trainer(max_epochs=10)
trainer.fit(model, train_loader)
```

## Hardware Scaling and Performance

One of Lightning's primary strengths is the ability to change hardware configurations via `Trainer` flags without modifying the model code.

### Multi-GPU and Distributed Training
- **Single GPU:** `L.Trainer(accelerator="gpu", devices=1)`
- **Multi-GPU (DDP):** `L.Trainer(accelerator="gpu", devices=8)`
- **Multi-Node:** `L.Trainer(accelerator="gpu", devices=8, num_nodes=32)`
- **TPU Support:** `L.Trainer(accelerator="tpu", devices=8)`

### Precision and Optimization
- **16-bit Mixed Precision:** Use `L.Trainer(precision="16-mixed")` to reduce memory footprint and increase speed on compatible GPUs.
- **Gradient Accumulation:** `L.Trainer(accumulate_grad_batches=4)` to simulate larger batch sizes.

## Expert Tips and Best Practices

- **Logging:** Use `self.log()` inside `training_step` or `validation_step`. Set `prog_bar=True` to see metrics in the terminal progress bar.
- **Data Management:** For complex data pipelines, use `L.LightningDataModule` to encapsulate training, validation, and test dataloaders in a single reusable class.
- **Inference:** For production inference, use the `forward` method. For research-related evaluation, use `validation_step` and `test_step`.
- **Reproducibility:** Use `L.seed_everything(42)` to ensure deterministic behavior across PyTorch, Numpy, and Python random modules.
- **Checkpointing:** Lightning automatically saves checkpoints in the `lightning_logs/` directory. You can resume training using `trainer.fit(model, ckpt_path="path/to/checkpoint.ckpt")`.

## Reference documentation
- [PyTorch Lightning Main Repository](./references/github_com_Lightning-AI_pytorch-lightning.md)
- [Lightning Documentation Structure](./references/github_com_Lightning-AI_pytorch-lightning_tree_master_docs.md)