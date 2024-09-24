# Curated Helm Charts for Kubernetes

A curated list of helm charts. Every chart is located in a separate folder and has the configuration parameters located in `values.yaml` file.

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:
```bash
$ helm repo add lara-staking https://Lara-staking.github.io/helm-charts/
```
If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
lara-staking` to see the charts.

To install the <chart-name> chart:

    helm install my-<chart-name> lara-staking/<chart-name>

To uninstall the chart:

    helm delete my-<chart-name>