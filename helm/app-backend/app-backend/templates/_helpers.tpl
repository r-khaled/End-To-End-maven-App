{{- define "app-backend.name" -}}
app-backend
{{- end -}}

{{- define "app-backend.fullname" -}}
{{ .Release.Name }}-app-backend
{{- end -}}
