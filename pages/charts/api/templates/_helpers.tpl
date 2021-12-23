{{- define "api.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "api.getdbserviceurl" -}}
{{- list "jdbc:mysql://" .Values.global.mysql_svc_name "/" .Values.dbname | join "" | quote -}}
{{- end -}}