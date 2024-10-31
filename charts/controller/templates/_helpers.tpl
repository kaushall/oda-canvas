{{/*
Expand the name of the chart.
*/}}
{{- define "controller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "controller.fullname" -}}
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
{{- define "controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "controller.labels" -}}
helm.sh/chart: {{ include "controller.chart" . }}
{{ include "controller.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "controller.selectorLabels" -}}
app.kubernetes.io/name: {{ include "controller.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "controller.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "controller.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
build the full compcon docker image name from image + version + prereleaseSuffix
*/}}
{{- define "controller.compconDockerimage" -}}
  {{- .Values.deployment.compconImage -}}:{{- .Values.deployment.compconVersion -}}
  {{- if .Values.deployment.compconPrereleaseSuffix -}}
    -{{- .Values.deployment.compconPrereleaseSuffix -}}
  {{- end -}}
{{- end -}}


{{/*
build the full idconfop docker image name from image + version + prereleaseSuffix
*/}}
{{- define "controller.idconfopDockerimage" -}}
  {{- .Values.deployment.idconfopImage -}}:{{- .Values.deployment.idconfopVersion -}}
  {{- if .Values.deployment.idconfopPrereleaseSuffix -}}
    -{{- .Values.deployment.idconfopPrereleaseSuffix -}}
  {{- end -}}
{{- end -}}


{{/*
overwrite compcon imagePullSecret with "Always" if prereleaseSuffix is set
*/}}
{{- define "controller.compconImagePullPolicy" -}}
  {{- if .Values.deployment.compconPrereleaseSuffix -}}
    Always
  {{- else -}}
    {{- .Values.deployment.compconImagePullPolicy -}}
  {{- end -}}
{{- end -}}


{{/*
overwrite idconfop imagePullSecret with "Always" if prereleaseSuffix is set
*/}}
{{- define "controller.idconfopImagePullPolicy" -}}
  {{- if .Values.deployment.idconfopPrereleaseSuffix -}}
    Always
  {{- else -}}
    {{- .Values.deployment.idconfopImagePullPolicy -}}
  {{- end -}}
{{- end -}}
