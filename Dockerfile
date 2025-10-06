# syntax=docker/dockerfile:1

# ---- Base Python ----
FROM python:3.11-slim

# System deps (build tools + libgomp for sklearn wheels) and tini for signal handling
RUN apt-get update && apt-get install -y --no-install-recommends     build-essential libgomp1 tini ca-certificates &&     rm -rf /var/lib/apt/lists/*

# Set workdir
WORKDIR /app

# Leverage docker layer caching
COPY requirements.txt /app/requirements.txt
RUN python -m pip install --upgrade pip &&     pip install --no-cache-dir -r /app/requirements.txt &&     pip install --no-cache-dir jupyter papermill==2.5.0

# Copy project files (not data)
COPY SIXT_Bike_Sharing_Solution.ipynb /app/SIXT_Bike_Sharing_Solution.ipynb
COPY README.md /app/README.md

# Helpful defaults
ENV PYTHONDONTWRITEBYTECODE=1     PYTHONUNBUFFERED=1

# Proper signal handling
ENTRYPOINT ["/usr/bin/tini", "--"]

# Default: run Jupyter Notebook (dev mode)
CMD ["jupyter", "notebook", "--NotebookApp.token=", "--NotebookApp.password=", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
EXPOSE 8888
