# Performance budgets

Enforced by benchmarks in CI where possible.

| Metric | Budget |
|---|---|
| Panel visible after hotkey | ≤ 50 ms |
| Keystroke to filtered list (10k items) | ≤ 8 ms |
| AutoFill credentials ready, warm | ≤ 150 ms |
| Unlock done to index ready | ≤ 150 ms |
| Apply incremental sync (100 changed items) | ≤ 200 ms, off the main thread |
| Idle memory / CPU | < 80 MB / ~0% |
