# Dockerizing the Bike Sharing Project

## Build the image
```bash
docker build -t bike-sharing:latest .
```

## Option A — Dev (run Jupyter Notebook)
This starts a Jupyter server on port 8888. Your current folder is mounted into the container so edits persist.
```bash
docker run --rm -it -p 8888:8888 -v "$PWD":/app bike-sharing:latest
```
Then open: http://localhost:8888

> The notebook tries to auto-download `day.csv` if it’s missing and the container has internet. Otherwise, place `day.csv` in the project root (mounted into `/app`).

## Option B — Batch (execute notebook headlessly with Papermill)
This will run the solution notebook and create `out.ipynb` plus `pred_last30.csv` in your current folder.
```bash
docker run --rm -v "$PWD":/app bike-sharing:latest   papermill SIXT_Bike_Sharing_Solution.ipynb out.ipynb
```

## Using Docker Compose
```bash
# Build and launch Jupyter
docker compose up --build lab

# Execute the notebook to produce out.ipynb/pred_last30.csv
docker compose run --rm batch
```
