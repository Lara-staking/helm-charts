{{/*
Expand the name of the chart.
*/}}
{{- define "lara-indexer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lara-indexer.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "lara-indexer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lara-indexer.labels" -}}
helm.sh/chart: {{ include "lara-indexer.chart" . }}
{{ include "lara-indexer.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lara-indexer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lara-indexer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lara-indexer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lara-indexer.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Indexer args
*/}}
{{- define "lara-indexer.args" -}}
- -data_dir
- {{ .Values.indexer.dataDir }}
- -blockchain_ws
- {{ .Values.indexer.blockchainWs }}
- -chain_id
- {{ .Values.indexer.chainId | quote }}
- -yield_saving_interval
- {{ .Values.indexer.yieldSavingInterval | quote }}
- -validators_yield_saving_interval
- {{ .Values.indexer.validatorsYieldSavingInterval | quote }}
- -signing_key
- $(PRIVATE_KEY)
- -oracle_address
- {{ .Values.indexer.oracleAddress }}
- -lara_address
- {{ .Values.indexer.laraAddress }}
- -graphQLEndpoint
- {{ .Values.indexer.graphQLEndpoint }}
- -sync_queue_limit
- '1'
- -general_block_time
- {{ .Values.indexer.generalBlockTime | quote }}
{{- end }}